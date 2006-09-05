<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="groupTitle">AMC Boston Young Members</xsl:param>
  <xsl:param name="byDate" select="1"/>
  <xsl:include href="amc-trips-to-html-inc.xsl" />
  <xsl:output encoding="UTF-8" indent="yes" method="xml"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
  <xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>AMC Boston Young Members - Trip Listings</title>
<meta name="generator" content="Boston AMC XSLT stylesheet by Andrew Shearer" />
<link rev="made" href="amc2006@shearersoftware.com" />
<meta name="dc.title" content="Trip Listings" />
<link rel="stylesheet" type="text/css" href="style.css" />
<link rel="stylesheet" type="text/css" href="trip_list.css" />
<script type="text/javascript" src="common.js"></script>
<xsl:if test="normalize-space($rssURL)">
<link rel="alternate" type="application/rss+xml" title="RSS" href="{$rssURL}" />
</xsl:if>
<xsl:if test="normalize-space($icsURL)">
<link rel="alternate" type="text/calendar" title="iCalendar" href="{$icsURL}" />
</xsl:if>
</head>
<body>

<xsl:comment>#include virtual="includes/header.inc.html"</xsl:comment>

<div id="template_content">
<div class="main">

<xsl:apply-templates/>

</div>

</div>

<xsl:comment>#include virtual="includes/footer.inc.html"</xsl:comment>

</body>
</html>

	</xsl:template>
</xsl:stylesheet>

<!-- 
Local Variables:
coding: utf-8;
End:
 -->