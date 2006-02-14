<?php
/*

APSHTTPUtils.inc.php
PHP web app utility functions
by Andrew Shearer 2001-2005

2005-06-22 ashearer  Added stripControlChars(), which html() and
    writeHiddenFormFields() [for field values] now call.
2005-06-17 ashearer  Added absPathToAbsURL() and makeSelfAbsURL(); restructured
    redirect functions to use the original relative URL form when forced
    to use JavaScript or meta refresh redirects, rather than the computed
    absolute form, for better behavior with reverse proxies. redirect() now
    accepts empty strings (plus an optional querystring) to represent the
    current page to help support this, though callers should still use
    selfRedirect. In case page output has already started as XHTML, JavaScript
    redirection of URLs containing ampersands is now XHTML-safe.
    Added getIntParam, getStrParam, getArrayParam; getParam now searches
    in GP order.
2005-01-14 ashearer  Updated comments.
2004-12-09 ashearer  Added makeSelfURL() function.
    Made getSelfFormAction() return a page-relative
    link for better behavior through reverse proxies.
2004-10-27 ashearer

=====
PUBLIC FUNCTIONS

Request Processing
    getParam($paramName, $default)
    getIntParam($paramName, $default)
    getStrParam($paramName, $default)
    getArrayParam($paramName, $default)

Redirection
    selfRedirectIfNecessary([$query])
    selfRedirect([$query])
    redirect($url)
    
Cookies
    setCookieIISBugWorkaround()

URLs
    getSelfFormAction()
    absPathToAbsURL($path)
    makeQueryString($data[, $override[, $prefix]])
    makeSelfURL()
    makeSelfAbsURL()

HTML Content
    writeHiddenFormFields($data[, $override])
    writeHiddenFormFieldsXHTML($data[, $override])
    html($text)
    stripControlChars($text)

Arrays
    arrayGet($array, $key[, $default])

=====
Global Variables

$g_APSHTTPUtils_noHTTPRedirects, internal global var,
    set by setCookieIISBugWorkaround(), read by redirect()

$debug,
    read by redirect()

*/

/* Request Processing Functions */

function getParam($paramName, $default = '') {
    /*
    Returns a named GET or POST parameter, or $default if not specified.
    The parameter could be either a string or an array.
    */
	if (isset($_GET[$paramName])) {
	    return $_GET[$paramName];
	}
	elseif (isset($_POST[$paramName])) {
	    return $_POST[$paramName];
	}
	else {
	    return $default;
	}
}

function getIntParam($paramName, $default = 0) {
    /*
    Returns a named GET or POST parameter as an integer, or $default if not
    specified. Protects against an array being submitted.
    */
	if (isset($_GET[$paramName])) {
	    return $_GET[$paramName];
	}
	elseif (isset($_POST[$paramName])) {
	    return $_POST[$paramName];
	}
	else {
	    return $default;
	}
    $value = getParam($paramName, $default);
    return is_array($value) ? $default : intval($value);
}

function getStrParam($paramName, $default = '') {
    /*
    Returns a named GET or POST parameter as a string, or $default if not
    specified. Protects against an array being submitted.
    */
    $value = getParam($paramName, $default);
    return is_array($value) ? $default : $value;
}

function getArrayParam($paramName, $default = array()) {
    /*
    Returns a named GET or POST array parameter, or $default if not
    specified. Requires that an array be submitted (so for a $paramName
    of 'depts', URL line could include ?depts[]=1&depts[]=2&depts[]=5).
    */
    $value = getParam($paramName, $default);
    return is_array($value) ? $value : $default;
}

/* Redirection Functions */

function selfRedirectIfNecessary($query = null) {
    /*
    Call this after possible POST argument handling. Performs a redirect
    to self in order to translate a POST to a GET, thus preserving the
    Refresh/Reload button. $query is either an array of key => value
    pairs, or a string (without leading question mark).
    */
    if ($_SERVER['REQUEST_METHOD'] != 'GET') {
        selfRedirect($query);
    }
}

function selfRedirect($query = null, $overrideQuery = null) {
    /*
    Call this after processing POST arguments. Performs a redirect to
    self in order to translate the POST to a GET, thus preserving the
    Refresh/Reload button. $query is either an array of key => value
    pairs, or a string (without leading question mark).
    */
    if (is_array($query) || $overrideQuery !== null) {
        $selfURL = makeQueryString($query, $overrideQuery, '?');
    }
    elseif (strlen($query)) {
        $selfURL = '?' . $query;
    }
    else {
        $selfURL = '';
    }
    redirect($selfURL);
}

function redirect($url) {
    /*
    Takes either a full or a site-relative URI (one starting with a
    slash), and causes the browser to perform an external redirect to
    it. Empty string or plain querystring (starting with '?') means
    current page. Falls back to JavaScript location.replace or a
    manually-clicked link if output has already been started or if IIS
    would lose cookies. Does not return to the caller.
    */
    
    global $debug, $g_APSHTTPUtils_noHTTPRedirects;
    
    // Try to make an absolute URL, since the HTTP RFC requires it for the
    // Location header. On the other hand, if we're forced to embed the URL in
    // the content, prefer a relative URL, since reverse proxies can generally
    // fix up only the Location header.
    
    $absURL = '';
    if ($url{0} == '/') {
        // Absolute path, starting with slash; make absolute URL by prepending
        // scheme and host
        $absURL = absPathToAbsURL($url);
    }
    elseif (!strlen($url) || $url{0} == '?') {
        // Redirect to self (empty URL), possibly with querystring
        $absURL = absPathToAbsURL($_SERVER['PHP_SELF']).$url;
        $url = getSelfFormAction().$url;
    }
    elseif (substr($url, 0, 7) == 'http://' || substr($url, 0, 8) == 'https://') {
        // Input is absolute URL
        $absURL = $url;
    }
    
    // IIS bug through v5.0 prevents CGIs from sending both cookies & a redirect
    // see http://support.microsoft.com/default.aspx?scid=http://support.microsoft.com:80/support/kb/articles/q176/1/13.asp&NoWebContent=1
    // Thus the $g_APSHTTPUtils_noHTTPRedirects global var.
    
    if (!empty($debug)) {
        echo('<p>Pause for debugging. Click to redirect to <a href="'
            .htmlspecialchars($url).'">'.htmlspecialchars($url).'</a>.</p>');
    }
    elseif (strlen($absURL) && !headers_sent()
        && empty($g_APSHTTPUtils_noHTTPRedirects)) {
        header('Location: '.$absURL);
    }
    else {
        // Can't use the Location header, because we've already sent output,
        // or the IIS bug will wipe out cookies, or the URL is a relative path.
        
        // First, send meta refresh, for non-JavaScript browsers. Leave a
        // 2-second delay so this won't act as a roadblock in the Back history.
        echo('<meta http-equiv="refresh" content="2;URL='
            .htmlspecialchars($url).'" />');
        
        // For JavaScript-capable browsers, send location.replace, so this page
        // won't appear in the Back history at all. CDATA makes embedded
        // ampersands XHTML-safe; HTML comments hide most of this from
        // pre-HTML-4 parsers.
        echo('<script language="JavaScript" type="text/javascript">'
            .'/*<![CDATA[ <!-- */ location.replace(\''.addslashes($url)
            .'\')/* --> ]]>*/</script>');
 
        // Fall back to plain link.
        echo('<p><a href="'.htmlspecialchars($url).'">Continue</a></p>');
    }
    exit;
}

/* Cookie handling function */

function setCookieIISBugWorkaround() {
    /*
    Work around an IIS bug if necessary. Always call this after calling
    setcookie(), if there's a chance of using an HTTP redirect later.
    The redirect() function sees the global variable this function sets.
    IIS bug through v5.0 prevents CGIs from sending both cookies & a
    redirect. See:
    http://support.microsoft.com/default.aspx?scid=http://support.microsoft.com:80/support/kb/articles/q176/1/13.asp&NoWebContent=1
    */
    
    global $g_APSHTTPUtils_noHTTPRedirects;
    // Check for GATEWAY_INTERFACE because it's not set under ISAPI or FCGI
    if (isset($_SERVER['GATEWAY_INTERFACE'])
        && isset($_SERVER['SERVER_SOFTWARE'])
        && substr($_SERVER['SERVER_SOFTWARE'], 0, 13) == 'Microsoft-IIS') {
        $g_APSHTTPUtils_noHTTPRedirects = true;
    }
}

/* URL functions */

function getSelfFormAction() {
    /*
    Return the relative path to self (without query arguments). For best
    compatibility with reverse proxies that change the site's apparent
    directory layout, we make the returned URL as relative as possible.
    That is, we only keep the last path component.
    */
    
	$path = $_SERVER['PHP_SELF'];
	$lastComponentStart = strrpos($path, '/');
	if ($lastComponentStart !== false) {
	   // keep trailing path component
	   $path = substr($path, $lastComponentStart + 1);
	}
	if (!strlen($path)) {
	   // Our URL ended with a slash (unusual case for PHP_SELF).
	   // We return the URL ".", referring to the default/index
	   // page for the current directory
	   $path = '.';
    }
	return $path;
}

function absPathToAbsURL($path) {
    /*
    Given an absolute path such as "/folder/doc.html", return an
    absolute URL like "http://example.org/folder.doc.html", detecting
    current page's use of http vs https as well as server name and port
    number.
    */
    
    assert($path{0} == '/');
    if ((!empty($_SERVER['SSL']) && $_SERVER['SSL'] != 'off')
        || !empty($_SERVER['SERVER_PORT_SECURE'])) {
        $prefix = 'https://';
    }
    else {
        $prefix = 'http://';
    }
    return $prefix.$_SERVER['SERVER_NAME'].$path;
}

function makeQueryString(&$data, $override = null, $prefix = '') {
    /*
    Return a querystring given an array (of values and/or arrays). The
    inverse of PHP's parse_str function. Pass '?' for $prefix to have a
    leading question mark prepended if there is any querystring content.
    */
    
    if ($override !== null) {
        $mergedData = array_merge($data, $override);
    }
    else {
        $mergedData = &$data;
    }
    $result = '';
    $delimiter = $prefix;
    foreach ($mergedData as $key => $valueOrArray) {
        if (is_array($valueOrArray)) {
            foreach ($valueOrArray as $value) {
                if ($value !== null) {
                    $result .= $delimiter . rawurlencode($key.'[]')
                                . '=' . rawurlencode($value);
                    $delimiter = '&';
                }
            }
        }
        elseif ($valueOrArray !== null) {
            $result .= $delimiter . rawurlencode($key)
                        . '=' . rawurlencode($valueOrArray);
            $delimiter = '&';
        }
    }
    return $result;
}

function makeSelfURL(&$query, $override = null) {
    /*
    Return a relative URL to the current page with the given query
    arguments. The link may be page-relative for better behavior through
    reverse proxies.
    
    $query is an array (of values and/or arrays), and $override is
    another array of values that override the ones in $query. Keys
    mapped to null are omitted entirely.
    */
    
    return getSelfFormAction().makeQueryString($query, $override, '?');
}

function makeSelfAbsURL(&$query, $override = null) {
    /*
    Return an absolute URL to the current page with the given query
    arguments, starting with 'http' or 'https'. Warning: Since it will
    include the current server name, the resulting URL may not work if
    there are downstream reverse proxies.
    
    $query is an array (of values and/or arrays), and $override is
    another array of values that override the ones in $query. Keys
    mapped to null are omitted entirely.
    */
    
    return absPathToFullURL($_SERVER['PHP_SELF'])
        .makeQueryString($query, $override, '?');
}

/* HTML content functions */

function writeHiddenFormFields(&$data, $override = null) {
    _writeHiddenFormFields($data, $override, false /*!$useXHTML*/);
}

function writeHiddenFormFieldsXHTML(&$data, $override = null) {
    _writeHiddenFormFields($data, $override, true /*$useXHTML*/);
}

function _writeHiddenFormFields(&$data, $override = null, $useXHTML = true) {
    $endQuoteEndTag = $useXHTML ? '" />' : '">';
    if ($override !== null) {
        $mergedData = array_merge($data, $override);
    }
    else {
        $mergedData = &$data;
    }
    foreach ($mergedData as $key => $valueOrArray) {
        if (is_array($valueOrArray)) {
            // multi-valued key; output each element of value array under
            // the key's name
            foreach ($valueOrArray as $value) {
                if ($value !== null) {
                    echo '<input type="hidden" name="'.htmlspecialchars($key)
                        .'[]" value="'.html($value).$endQuoteEndTag;
                }
            }
        }
        elseif ($valueOrArray !== null) {
            // single-valued key
            echo '<input type="hidden" name="'.htmlspecialchars($key)
                .'" value="'.html($valueOrArray).$endQuoteEndTag;
        }
    }
}

function html($text) {
    return htmlspecialchars(stripControlChars($text));
}

function stripControlChars($text) {
    // Remove control chars, including DEL and everything under ASCII 32
    // except for LF, CR, and tab. Control chars are illegal in HTML and XML,
    // even if entity-encoded. $text can be in 7-bit ASCII or a superset,
    // such as utf-8, windows-1252, or iso-8859-1. Benchmarking of various
    // implementations showed this one, using strtr, to be extremely fast--the
    // fastest by far. ashearer 2005-06-20.
    
    // Implementation: all control chars are replaced with NUL using the fast
    // strtr() function. In the common case, the result won't contain NUL, and
    // can be returned as-is. Otherwise, the NUL chars are first deleted using
    // str_replace().
    $invalidChars = "\001\002\003\004\005\006\007\010\013\014\016\017\020\021\022\023\024\025\026\027\030\031\032\033\034\035\036\037\177";
    $replacementChars = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
    $text = strtr($text, $invalidChars, $replacementChars);
    if (strpos($text, "\0") !== FALSE) {
        // String contains NUL--all control chars have been replaced with NUL now.
        // Delete NUL, and we're done.
        $text = str_replace("\0", '', $text);
    }
    return $text;
}

/* Array function */

function arrayGet(&$array, $key, $default = null) {
    return array_key_exists($key, $array) ? $array[$key] : $default;
}

?>
