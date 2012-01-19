<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="groupTitle">AMC Boston INTRO</xsl:param>
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

<body style="background: #ccccff; color: black; margin-top: 0">

    <span><img src="http://amcboston.org/intro/images/Banner.jpg" alt="banner" width="672" height="169" border="0" usemap="#Map2Map"/></span>
    <map name="Map2Map">
      <area shape="rect" coords="529,137,637,171" href="mailto:info@amcINTRO.org" alt="Contact Us"/>
      <area shape="rect" coords="389,135,497,165" href="http://amcboston.org/intro/forms.html" target="_self" alt="Forms"/>
      <area shape="rect" coords="211,134,363,166" href="http://amcboston.org/intro/leaders.html" target="_self" alt="Leader's Page"/>
      <area shape="rect" coords="8,136,188,175" href="http://www.amcboston.org/" target="_new" alt="AMC Boston Chapter"/>
    </map>

<h1><xsl:value-of select="$groupTitle"/> Trip Listings</h1>

<xsl:apply-templates/>

<xsl:if test="normalize-space($groupHomePageURL)">
  <div>&#8593; <a href="{$groupHomePageURL}"><xsl:value-of select="$groupTitle"/></a></div>
</xsl:if>

<p>
    <small><i>Copyright © Appalachian Mountain Club 2012. All rights reserved.</i></small>
</p>

</body>
</html>

	</xsl:template>
</xsl:stylesheet>
