<?php
//$xmlPath = "empty.xml";
//$xmlPath = "Narrtrips-fix.xml";
ini_set('display_errors', true);
ini_set('error_reporting', E_ALL);

class IOException extends Exception {}

$chapter = isset($_REQUEST['c']) ? $_REQUEST['c'] : '';
if ($chapter == 'boston') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
}
elseif ($chapter == 'bostonym') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
}
elseif ($chapter == 'worcester') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    //$xmlPath = "http://trips.outdoors.org/xml/Narrtrips.xml";
}
elseif ($chapter == 'worcesterym') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
}
else {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Narragansett&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
}

$format = isset($_REQUEST['output']) ? $_REQUEST['output'] : '';
if ($format == 'ics') {
    $xslPath = "amc-trips-to-ical.xsl";
    $contentType = 'text/calendar;charset=UTF-8';
}
else {
    $xslPath = "amc-trips-to-html-page.xsl";
    $contentType = 'text/html;charset=UTF-8';
}
$xsl = new XSLTProcessor();
$xsl->importStyleSheet(DOMDocument::load($xslPath));

header('Content-Type: '.$contentType);
$xml = new DOMDocument('1.0', 'windows-1252');
if (false) {
    $xml->encoding = 'windows-1252';
    $xml->load($xmlPath);
}
else {
    try {
        $data = getXMLData($xmlPath);
        if (!strlen($data)) {
            die('Sorry, trip information is not available, because the AMC web site trips.outdoors.org could not be contacted. Please try again later.');
        }
    }
    catch (IOException $e) {
        die('Sorry, trip information is not available, because the AMC web site trips.outdoors.org could not be contacted. Please try again later. Error: '.htmlspecialchars($e->getMessage()));
    }  
    $xml->loadXML($data);
}
echo $xsl->transformToXML($xml);

function getXMLData($url) {
    // get data from AMC web site and re-encode it as utf8 to make it valid
    // unfortunately, we may have to output some HTML comments as a side effect of bug workarounds
    // If retrieval fails, this function will throw IOException.
    $triesLeft = 2;   // occasionally trips.outdoors.org returns no content, so we retry
    $errno = 0;
    $errmsg = '';
    while ($triesLeft--) {
        $ch = curl_init($url);
        //curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 15); 
        //phpinfo();
        $hasCurlBug = false; //($_SERVER['SERVER_ADDR'] == '127.0.0.1');  // CURLOPT_RETURNTRANSFER or ob_start + ob_end_clean crashes PHP 5 (some versions)! If the raw results aren't output for whatever reason, PHP 5 crashes. So we enclose them in comments.
        if ($hasCurlBug) {
            echo '<!--';
            ob_start();
            curl_exec($ch);
            $data = ob_get_contents();
            //ob_end_clean(); 
            echo '-->';
        }
        else {
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            $data = curl_exec($ch);
        }
        $errno = curl_errno($ch);
        $errmsg = curl_error($ch);
        curl_close($ch);
        //if ($errno)) {
            //print htmlspecialchars(curl_error($ch));
        //}
        if (!$errno && strlen($data)) {
            return utf8_encode($data);
        }
    }
    if (!strlen($errmsg)) {
        $errmsg = 'Empty server response despite multiple tries';
    }
    throw new IOException($errmsg, $errno);
    return null;
}

?>