<?php
//$xmlPath = "empty.xml";
//$xmlPath = "Narrtrips-fix.xml";
ini_set('display_errors', true);
ini_set('error_reporting', E_ALL);
require_once('_private/timer.inc.php');
$version = 2.1;   // to make cache unique between versions
require_once('Cache/Lite.php');
require_once('_private/formatListings.inc.php');
$cacheOptions = array(
    'cacheDir' => '/tmp/',
    'lifeTime' => 300
);
//$cache = new Cache_Lite_Output($cacheOptions);
$groupID = isset($_REQUEST['c']) ? $_REQUEST['c'] : '';
//include('_private/config.inc.php');

$format = isset($_REQUEST['output']) ? $_REQUEST['output'] : '';
if ($format == 'ics') {
    $xslPath = "amc-trips-to-ical.xsl";
    $contentType = 'text/calendar;charset=UTF-8';
}
elseif ($format == 'rss') {
    $xslPath = "amc-trips-to-rss.xsl";
    $contentType = 'application/rss+xml';
}
elseif ($format == 'email') {
    $xslPath = "amc-trips-to-html-email.xsl";
    $contentType = 'text/html;charset=UTF-8';
}
elseif ($format == 'bostonpage') {
    $xslPath = "amc-trips-to-boston-page.xsl";
    $contentType = 'text/html;charset=UTF-8';
}
else {
    $xslPath = "amc-trips-to-html-page.xsl";
    $contentType = 'text/html;charset=UTF-8';
    $GLOBALS['showTimer'] = !empty($_REQUEST['timer']);
}
header('Content-Type: '.$contentType);
//if (!empty($_REQUEST['nc']) || !$cache->start($format.$version.$groupID)) {

if (empty($_REQUEST['nc'])) {
    $cache = new Cache_Lite($cacheOptions);
    $cacheID = $format.$version.$groupID;
    $cachedData = $cache->get($cacheID);
}
else {
    $cache = $cacheID = $cachedData = null;
}

if (!$cachedData) { 
    $result = formatListings($groupID, $xslPath);
    if (!strlen($result)) {
        die('Error: the XML data could not be formatted for display. Please try again later.');
    }
    if ($cache) {
        $cache->save($result, $cacheID);
    }
}
else {
    $result = $cachedData;
}

echo $result;

if ($format != 'ics') {
    echo '<!-- ';
    echo strlen($cachedData) ? 'retrieved from cache ' : 'generated ';
    timeMilestone('');
    echo ' -->';
}

?>