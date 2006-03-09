<?php
require_once('_private/config.inc.php');
require_once('_private/timer.inc.php');

class IOException extends Exception {}

function formatListings($groupID, $xslPath, $xslParams = null) {
    // retrieves and formats AMC listings corresponding to the given groupID
    // using an XSL template
    
    $groupData = getAMCGroupData($groupID);
    timeMilestone('Retrieved raw XML listings from main site');
    $xsl = new XSLTProcessor();
    $xsl->importStyleSheet(DOMDocument::load($xslPath));
    if ($xslParams === null && isset($_SERVER['SERVER_NAME'])) {
        // we don't set listingsURL if we're running from cmd line/cron
        $listingsURL = 'http://'.$_SERVER['SERVER_NAME']
            .($_SERVER['SERVER_PORT'] != 80 ? ':'.$_SERVER['SERVER_PORT'] : '')
            .'/amc/listings/?c='.urlencode($groupID);
        $xsl->setParameter('', 'listingsURL', $listingsURL);
        $xsl->setParameter('', 'rssURL', $listingsURL . '&output=rss');
        $xsl->setParameter('', 'icsURL', $listingsURL . '&output=ics');
    }
    else foreach ($xslParams as $key => $value) {
        //echo "set param $key to $value; ";
        $xsl->setParameter('', $key, $value);
    }
    $xsl->setParameter('', 'groupTitle', $groupData['title']);
    $xsl->setParameter('', 'groupID', $groupID);
    $xsl->setParameter('', 'groupHomePageURL', $groupData['homePageUrl']);
    timeMilestone('Set up XSLT engine');

    $xml = new DOMDocument('1.0', 'windows-1252');
    if (false) {
        $xml->encoding = 'windows-1252';
        $xml->load($groupData['xmlUrl']);
    }
    else {
        try {
            $data = getXMLData($groupData['xmlUrl']);
            if (!strlen($data)) {
                die('Sorry, trip information is not available, because the AMC web site trips.outdoors.org could not be contacted. Please try again later.');
            }
        }
        catch (IOException $e) {
            die('Sorry, trip information is not available, because the AMC web site trips.outdoors.org could not be contacted. Please try again later. Error: '.htmlspecialchars($e->getMessage()));
        }  
        $xml->loadXML($data);
    }
    timeMilestone('Loaded XML data');
    $result = $xsl->transformToXML($xml);
    timeMilestone('Applied XSLT template');
    return $result;
}

function getXMLData($url) {
    // get data from AMC web site and re-encode it as utf8 to make it valid
    // unfortunately, we may have to output some HTML comments as a side effect of bug workarounds
    // If retrieval fails, this function will throw IOException.
    $triesLeft = 3;   // occasionally trips.outdoors.org returns no content, so we retry
    $errno = 0;
    $errmsg = '';
    while ($triesLeft--) {
        $ch = curl_init($url);
        //curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 15); 
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
