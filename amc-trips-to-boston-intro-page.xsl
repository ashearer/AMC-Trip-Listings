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
<body style="background: #AAC4F2; color: black; margin-top: 0">

<div id="Layer1" style="Z-INDEX: 1; LEFT: 10px; WIDTH: 490px; POSITION: absolute; TOP: 5px; HEIGHT: 97px">
    <p style="line-height: 1.1">
        <img height="36" alt="" src="http://www.amcboston.org/intro/black3.gif" width="38" /><br />
    <b><font face="Arial, Helvetica, sans-serif"><font color="#FF9900"><font size="3">Appalachian Mountain Club<br />
    Boston Chapter</font></font></font></b><br />
    <b><font face="Arial, Helvetica, sans-serif"><font color="#FFFFFF"><font size="6">INTRO Committee</font></font></font></b></p>
</div>
<table cellspacing="0" cellpadding="0" width="650" border="0">
    <tbody>
        <tr align="left">
            <td valign="top">
                <img height="138" alt="" src="http://www.amcboston.org/intro/whitemountains.jpg" width="700" />
            </td>
        </tr>
        <tr>
            <td width="100%">
                <div align="right">
                    <img height="21" src="http://www.amcboston.org/intro/INTROtopmenu.gif" width="499" usemap="#Map" border="0" /> <map name="topmenu" id="topmenu">
                        <area title="AMC Headquarters" shape="rect" alt="AMC Headquarters" coords="3,3,137,16" href="http://www.outdoors.org/" />
                        <area shape="rect" coords="138,5,145,6" href="http://www.amcboston.org/intro/index.html#" />
                        <area title="AMC Headquarters" shape="rect" alt="AMC Headquarters" coords="133,9,142,10" href="http://www.outdoors.org/" />
                        <area title="AMC Boston" shape="rect" alt="AMC Boston" coords="158,6,286,17" href="http://www.amcboston.org/" />
                        <area title="INTRO Library" shape="rect" alt="INTRO Library" coords="293,1,404,16" href="http://www.amcboston.org/intro/library.html" />
                        <area title="Contact Us" shape="rect" alt="Contact Us" coords="409,3,491,16" href="mailto:epmcmanmon@nii.net" />
                    </map><br />
                    <hr width="100%" size="2" />
                </div>
            </td>
        </tr>
    </tbody>
</table>

<h1><xsl:value-of select="$groupTitle"/> Trip Listings</h1>


<xsl:apply-templates/>

<xsl:if test="normalize-space($groupHomePageURL)">
  <div>&#8593; <a href="{$groupHomePageURL}"><xsl:value-of select="$groupTitle"/></a></div>
</xsl:if>

<p>
    <i><font face="Arial,Helvetica"><font size="-2">Copyright. Appalachian Mountain Club. 2008. All rights reserved.</font></font></i> <font size="-2"></font>
</p>
<p>
    <map name="Map" id="Map">
        <area shape="rect" target="_self" coords="1,1,144,22" href="http://www.outdoors.org/" />
        <area shape="rect" target="_self" coords="152,2,277,21" href="http://www.amcboston.org/" />
        <area shape="rect" target="_self" coords="283,2,407,24" href="http://www.amcboston.org/intro/library.html" />
        <area shape="rect" target="_self" coords="414,3,497,17" href="mailto:mmady@mindspring.com" />
    </map>
</p>

</body>
</html>

	</xsl:template>
</xsl:stylesheet>
