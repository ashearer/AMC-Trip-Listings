<?php
//$path = 'include';

echo 'one';

$xmlPath = "empty.xml";
$xmlPath = "Narrtrips-fix.xml";
//$arguments = array('/_xml' => "http://trips.outdoors.org/xml/Narrtrips.xml");
//$arguments = array('/_xml' => "Narrtrips-fix.xml");
//$arguments = array('/_xml' => $xmlPath);
if (!function_exists('xslt_create')) {
    dl('xslt.so');
}
$xsltproc = xslt_create();
//xslt_set_encoding($xsltproc, 'windows-1252');
xslt_set_encoding($xsltproc, 'UTF-8');
$xslPath = "joy-st-trips-xml-to-html-inc.xsl";
//$xslPath = "empty.xsl";
//$html = xslt_process($xsltproc, 'arg:/_xml', $xslPath, NULL, $arguments);
echo 'two';
xslt_set_error_handler($xsltproc, "xslt_error_handler");
//$html = xslt_process($xsltproc, $xmlPath, $xslPath, null);
$xml = $xsl = "";
$xml='<?xml version="1.0"?>
<para>
 oops, I misspelled the closing tag
</para>';

// XSL content :
$xsl='<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
   <strong><xsl:value-of select="para"/></strong>
</xsl:template>
</xsl:stylesheet>';


$xml = file_get_contents($xmlPath);
$xsl = file_get_contents($xslPath);
//echo $xml;
//echo strlen($xml);
//echo '33';
$arguments = array('/_xml' => $xml, '/_xsl' => $xsl);
$html = xslt_process($xsltproc, 'arg:/_xml', 'arg:/_xsl', null, $arguments);

echo '3';
if (empty($html)) {
    die('XSLT processing error: '. xslt_error($xsltproc));
}
xslt_free($xsltproc);
echo $html;

// Our XSLT error handler
function xslt_error_handler($handler, $errno, $level, $info)
{
    // for now, let's just see the arguments
    var_dump(func_get_args());
}
?>