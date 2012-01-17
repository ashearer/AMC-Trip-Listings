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

<div id="e1" style="position:absolute;left:9;top:231;width:579;height:243;">
    <p class="text"><font face="Arial" color="#000000" size="2"><b><br/>
      </b></font></p>
</div>
      <div id="e2" style="position:absolute;left:11;top:570;width:412;height:37;"><span class="text"><b><i><font face="Arial" size="2"><span style="font-size:12px;line-height:16px;">Copyright. Appalachian Mountain Club. All rights reserved.<br/>Last updated November 2011.<br/></span></font></i></b></span>      </div>
      <!--div id="e3" style="position:absolute; left:186px; top:181px; width:250; height:30;">
        <table border="0" cellspacing="0" cellpadding="0" width="250">
          <tr>
            <td nowrap="nowrap" height="30" align="center" valign="middle"><span class="text"><b><font face="Arial" size="4"><span style="font-size:18px;line-height:24px;">INTRO </span></font><font face="Arial"><span style="font-size:18px;line-height:24px;">Trip Listings</span></font></b></span></td>
          </tr>
        </table>
      </div-->
      <div id="e4" style="position:absolute;left:499;top:174;width:80;height:23;">
        <table border="0" cellspacing="0" cellpadding="0" width="80">
          <tr>
            <td nowrap="nowrap" height="23" align="center" valign="top"><span class="text"><a href="http://amcboston.org/intro/"><b><font face="Arial"><span style="font-size:14px;line-height:19px;">HOME<br/></span></font></b></a></span></td>
          </tr>
        </table>
      </div>
<!--$begin exclude$-->
    <span style="position:absolute; width:600px; height:169px; left: 2px; top: 0px;"><img src="http://amcboston.org/intro/images/Banner.jpg" alt="banner" width="672" height="169" border="0" usemap="#Map2Map"/></span>
    <map name="Map2Map">
      <area shape="rect" coords="529,137,637,171" href="mailto:info@amcINTRO.org" alt="Contact Us"/>
      <area shape="rect" coords="389,135,497,165" href="http://amcboston.org/intro/forms.html" target="_self" alt="Forms"/>
      <area shape="rect" coords="211,134,363,166" href="http://amcboston.org/intro/leaders.html" target="_self" alt="Leader's Page"/>
      <area shape="rect" coords="8,136,188,175" href="http://www.amcboston.org/" target="_new" alt="AMC Boston Chapter"/>
    </map>
<!--$end exclude$-->

<div style="position: absolute; top: 180px; left: 8px">
<h1><xsl:value-of select="$groupTitle"/> Trip Listings</h1>


<xsl:apply-templates/>

<xsl:if test="normalize-space($groupHomePageURL)">
  <div>&#8593; <a href="{$groupHomePageURL}"><xsl:value-of select="$groupTitle"/></a></div>
</xsl:if>

<p>
    <i><font face="Arial,Helvetica"><font size="-2">Copyright. Appalachian Mountain Club. 2012. All rights reserved.</font></font></i> <font size="-2"></font>
</p>
<p>
    <map name="Map" id="Map">
        <area shape="rect" target="_self" coords="1,1,144,22" href="http://www.outdoors.org/" />
        <area shape="rect" target="_self" coords="152,2,277,21" href="http://www.amcboston.org/" />
        <area shape="rect" target="_self" coords="283,2,407,24" href="http://www.amcboston.org/intro/library.html" />
        <area shape="rect" target="_self" coords="414,3,497,17" href="mailto:mmady@mindspring.com" />
    </map>
</p>

</div>
</body>
</html>

	</xsl:template>
</xsl:stylesheet>
