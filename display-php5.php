<?php
//$xmlPath = "empty.xml";
//$xmlPath = "Narrtrips-fix.xml";
$chapter = isset($_REQUEST['chapter']) ? $_REQUEST['chapter'] : '';
if ($chapter == 'boston') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    $xslPath = "narr-trips-xml-to-html-page.xsl";
}
elseif ($chapter == 'bostonym') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Boston&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    $xslPath = "narr-trips-xml-to-html-page.xsl";
}
elseif ($chapter == 'worcester') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    //$xmlPath = "http://trips.outdoors.org/xml/Narrtrips.xml";
    $xslPath = "narr-trips-xml-to-html-page.xsl";
}
elseif ($chapter == 'worcesterym') {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Worcester&tripregion=&tripstate=&tripdestination=&tripcommittee=Young%20Members&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    //$xmlPath = "http://trips.outdoors.org/xml/Narrtrips.xml";
    $xslPath = "narr-trips-xml-to-html-page.xsl";
}
else {
    $xmlPath = "http://trips.outdoors.org/index.cfm?method=ch.doxml&searchterms=&searchwhich=AND&whichsearch=byterms&tripchapter=Narragansett&tripregion=&tripstate=&tripdestination=&tripcommittee=&tripactivity=&tripstartmonth=7&tripstartday=1&tripstartyear=2005&tripstartmonthb=0&tripstartdayb=0&tripstartyearb=2010";
    //$xmlPath = "http://trips.outdoors.org/xml/Narrtrips.xml";
    $xslPath = "narr-trips-xml-to-html-page.xsl";
}
$xsl = new XSLTProcessor();
$xsl->importStyleSheet(DOMDocument::load($xslPath));

header('Content-Type: text/html;charset=UTF-8');
$xml = new DOMDocument('1.0', 'windows-1252');
if (false) {
    $xml->encoding = 'windows-1252';
    $xml->load($xmlPath);
}
else {
    $data = getXMLData($xmlPath);
    if (!strlen($data)) {
        die('Sorry, trip information is not available, because the AMC web site trips.outdoors.org could not be contacted. Please try again later.');
    }
    $xml->loadXML($data);
}
echo $xsl->transformToXML($xml);

function getXMLData($url) {
    // get data from AMC web site and re-encode it as utf8 to make it valid
    // unfortunately, we may have to output some HTML comments as a side effect of bug workarounds
    // we also output error messages.
    $triesLeft = 2;   // occasionally trips.outdoors.org returns no content, so we retry
    while ($triesLeft--) {
        $ch = curl_init($url);
        //curl_setopt($ch, CURLOPT_URL, $xmlPath);
        //curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);  // this crashes PHP 5, so we use ob_start()
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 15); 
        
        //echo 'test';
        
        $hasCurlBug = ($_REQUEST['CLIENT_IP'] == '127.0.0.1');  // ob_end_clean crashes PHP 5 too! If the raw results aren't output for whatever reason, PHP 5 crashes. So we enclose them in comments.
        if ($hasCurlBug) {
            echo '<!--';
        }
        ob_start();
        $xdata = curl_exec($ch);
        $data = ob_get_contents();
        if ($hasCurlBug) {
            echo '<!--';
            ob_start();
            $xdata = curl_exec($ch);
            $data = ob_get_contents();
            echo '-->';
        }
        else {
            ob_end_clean(); 
        }
        if (curl_errno($ch)) {
            print htmlspecialchars(curl_error($ch));
        }
        curl_close($ch);
        if (strlen($data)) {
            return utf8_encode($data);
        }
    }
    return null;
}



?>