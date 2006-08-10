<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="groupTitle">AMC Worcester Young Members</xsl:param>
  <xsl:param name="rssURL"/>
  <xsl:param name="icsURL"/>
  <xsl:param name="byDate" select="0"/>
  <xsl:include href="amc-trips-to-html-inc.xsl" />
  <xsl:output encoding="UTF-8" indent="yes" method="html"
    doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
  
  <xsl:template match="/">
<html>
<head>
  <!--meta http-equiv="content-type" value="text/html;charset=utf-8"  this is already inserted by XSLT processor -->
  <title><xsl:value-of select="$groupTitle"/> Trip Listings</title>
  <meta name="generator" content="AMC trip listing formatter, by Andrew Shearer" />
  <link rel="stylesheet" href="trip_list.css" type="text/css" />
  <xsl:if test="normalize-space($rssURL)">
  <link rel="alternate" type="application/rss+xml" title="RSS" href="{$rssURL}" />
  </xsl:if>
  <xsl:if test="normalize-space($icsURL)">
  <link rel="alternate" type="text/calendar" title="iCalendar" href="{$icsURL}" />
  </xsl:if>
  <script type="text/javascript" src="trip_list.js"></script>
</head>
<body style="background: #C6DEC6 url('http://amcworcester.org/ym/images/wavu2.gif') no-repeat top;">

<xsl:if test="normalize-space($groupHomePageURL)">
  <div>&#8593; <a href="{$groupHomePageURL}"><xsl:value-of select="$groupTitle"/></a></div>
</xsl:if>
<h1><xsl:value-of select="$groupTitle"/> Trip Listings</h1>

<p>In addition to these listings, the AMC Worcester web site has more
<a href="http://www.amcworcester.org/activities/biking.htm">cycling
trips</a> and
<a href="http://www.amcworcester.org/activities/paddling.htm">paddling trips</a>.
Happy trails!</p>

<xsl:apply-templates/>


</body>
</html>

	</xsl:template>
</xsl:stylesheet>
