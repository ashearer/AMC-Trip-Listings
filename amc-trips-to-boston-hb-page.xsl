<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="groupTitle">AMC Worcester Young Members</xsl:param>
  <xsl:param name="rssURL"/>
  <xsl:param name="icsURL"/>
  <xsl:param name="byDate" select="0"/>
  <xsl:include href="amc-trips-to-html-inc.xsl" />
  <xsl:output encoding="UTF-8" indent="yes" method="xml"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
  <xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <!--meta http-equiv="content-type" value="text/html;charset=utf-8"  this is already inserted by XSLT processor -->
  <title><xsl:value-of select="$groupTitle"/> Trip Listings</title>
  <meta name="generator" content="AMC trip listing formatter, by Andrew Shearer" />
  <meta name="keywords" content="hiking, backpacking, boston, AMC, HB, winter hiking, Spring hiking, instruction, White Mountains, New England" />
  <link href="http://www.hbbostonamc.org/templates/amctemplate/template_css/template_css.css" type="text/css" rel="stylesheet" />
  <link rel="stylesheet" href="trip_list.css" type="text/css" />
  <xsl:if test="normalize-space($rssURL)">
  <link rel="alternate" type="application/rss+xml" title="RSS" href="{$rssURL}" />
  </xsl:if>
  <xsl:if test="normalize-space($icsURL)">
  <link rel="alternate" type="text/calendar" title="iCalendar" href="{$icsURL}" />
  </xsl:if>
  <link rel="shortcut icon" href="http://www.hbbostonamc.org/images/favicon.ico" />
  <script type="text/javascript" src="trip_list.js"></script>
</head>
<body style="background: #AAC4F2; color: black; margin-left: 0; margin-top: 0">

<div id="pagewrap">
  <div id="layer10" onclick="location.href='http://www.hbbostonamc.org/index.php';" style="cursor:pointer;">
    <div id="searchbox">
      
<form action="http://hbbostonamc.org/index.php?option=com_search" method="get">
	<div class="search">
		<input name="searchword" id="mod_search_searchword" maxlength="20" alt="search" class="inputbox" type="text" size="20" value="search..."  onblur="if(this.value=='') this.value='search...';" onfocus="if(this.value=='search...') this.value='';" /><input type="submit" value="Search" class="button"/>	</div>

	<input type="hidden" name="option" value="com_search" />
	<input type="hidden" name="Itemid" value="" />	
</form>    </div>
  </div>
  <div id="layer20">
    	 	<div align="center">
		 			 	<img src="http://www.hbbostonamc.org/images/MainImage/Winter/ammonoosuc.jpg" border="0" width="840" height="182" alt="ammonoosuc.jpg" /><br />
		 		 	</div>
	  	  </div>
  <div id="layer30">
    <div id="layer31">
      <div id="layer31inner">
        		<div class="moduletable">
			
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr align="left"><td><a href="http://www.hbbostonamc.org/" class="mainlevel" >Home</a></td></tr>
<tr align="left"><td><a href="http://www.hbbostonamc.org/index.php/Table/About-HB/" class="mainlevel" >About H/B</a></td></tr>
<tr align="left"><td><a href="http://www.hbbostonamc.org/index.php/Table/Trips-Activities/" class="mainlevel" id="active_menu">Trips &amp; Activities</a></td></tr>
<tr align="left"><td><a href="http://www.hbbostonamc.org/index.php/Table/News/" class="mainlevel" >News</a></td></tr>
<tr align="left"><td><a href="http://www.hbbostonamc.org/index.php/Table/Instructional-Programs-Workshops/" class="mainlevel" >Instructional Programs</a></td></tr>
<tr align="left"><td><a href="http://www.hbbostonamc.org/index.php/Table/Spring/" class="mainlevel" >Spring Hiking Program</a></td></tr>
<tr align="left"><td><a href="http://www.hbbostonamc.org/index.php/Table/Spring-Leadership/" class="mainlevel" >Spring Leadership</a></td></tr>
<tr align="left"><td><a href="http://www.hbbostonamc.org/index.php/Links/" class="mainlevel" >Web Links</a></td></tr>
<tr align="left"><td><a href="http://www.hbbostonamc.org/index.php/Table/Resource-Documents/" class="mainlevel" >Resource documents</a></td></tr>
</table>		</div>
				<!--div class="moduletable">
							<h3>
					HB Workshops and Meetings				</h3>
				<link href='modules/mod_events_cal.css' rel='stylesheet' type='text/css' />
<table cellpadding="0" cellspacing="0" width="140" align="center" class="mod_events_monthyear">
<tr >
<td><a class="mod_events_link" href="http://www.hbbostonamc.org/index.php/component/option,com_events/Itemid,38/task,view_year/day,1/month,03/year,2007/mod_cal_year,2007/mod_cal_month,03/" title="Go to calendar - previous year">&laquo;</a>
</td><td><a class="mod_events_link" href="http://www.hbbostonamc.org/index.php/component/option,com_events/Itemid,38/task,view_month/day,1/month,2/year,2008/mod_cal_year,2008/mod_cal_month,2/" title="Go to calendar - previous month">&lt;</a>
</td><td align="center"><a class="mod_events_link" href="http://www.hbbostonamc.org/index.php/component/option,com_events/Itemid,38/task,view_month/month,03/year,2008/" title="Go to calendar - current month">March</a>
<a class="mod_events_link" href="http://www.hbbostonamc.org/index.php/component/option,com_events/Itemid,38/task,view_year/month,03/year,2008/" title="Go to calendar - current year">2008</a>
</td><td><a class="mod_events_link" href="http://www.hbbostonamc.org/index.php/component/option,com_events/Itemid,38/task,view_month/day,1/month,4/year,2008/mod_cal_year,2008/mod_cal_month,4/" title="Go to calendar - next month">&gt;</a>
</td><td><a class="mod_events_link" href="http://www.hbbostonamc.org/index.php/component/option,com_events/Itemid,38/task,view_year/day,1/month,03/year,2009/mod_cal_year,2009/mod_cal_month,03/" title="Go to calendar - next year">&raquo;</a>
</td></tr>
</table>
<table align="center" class="mod_events_table" cellspacing="0" cellpadding="2">
<tr class="mod_events_dayname">
<td class='mod_events_td_dayname'><span class="sunday">S</span></td>
<td class='mod_events_td_dayname'>M</td>
<td class='mod_events_td_dayname'>T</td>
<td class='mod_events_td_dayname'>W</td>
<td class='mod_events_td_dayname'>T</td>
<td class='mod_events_td_dayname'>F</td>
<td class='mod_events_td_dayname'><span class="saturday">S</span></td>
</tr>
<tr>
<td class='mod_events_td_dayoutofmonth'>24</td>
<td class='mod_events_td_dayoutofmonth'>25</td>
<td class='mod_events_td_dayoutofmonth'>26</td>
<td class='mod_events_td_dayoutofmonth'>27</td>
<td class='mod_events_td_dayoutofmonth'>28</td>
<td class='mod_events_td_dayoutofmonth'>29</td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,01/Itemid,38/' title='Go to calendar - current day'>1</a></td>
</tr>
<tr><td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,02/Itemid,38/' title='Go to calendar - current day'>2</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,03/Itemid,38/' title='Go to calendar - current day'>3</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,04/Itemid,38/' title='Go to calendar - current day'>4</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,05/Itemid,38/' title='Go to calendar - current day'>5</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,06/Itemid,38/' title='Go to calendar - current day'>6</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,07/Itemid,38/' title='Go to calendar - current day'>7</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,08/Itemid,38/' title='Go to calendar - current day'>8</a></td>
</tr>
<tr><td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,09/Itemid,38/' title='Go to calendar - current day'>9</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,10/Itemid,38/' title='Go to calendar - current day'>10</a></td>
<td class='mod_events_td_daywithevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,11/Itemid,38/' title='Go to calendar - current day'><b>11</b></a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,12/Itemid,38/' title='Go to calendar - current day'>12</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,13/Itemid,38/' title='Go to calendar - current day'>13</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,14/Itemid,38/' title='Go to calendar - current day'>14</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,15/Itemid,38/' title='Go to calendar - current day'>15</a></td>
</tr>
<tr><td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,16/Itemid,38/' title='Go to calendar - current day'>16</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,17/Itemid,38/' title='Go to calendar - current day'>17</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,18/Itemid,38/' title='Go to calendar - current day'>18</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,19/Itemid,38/' title='Go to calendar - current day'>19</a></td>
<td class='mod_events_td_daywithevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,20/Itemid,38/' title='Go to calendar - current day'><b>20</b></a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,21/Itemid,38/' title='Go to calendar - current day'>21</a></td>
<td class='mod_events_td_todaynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,22/Itemid,38/' title='Go to calendar - current day'>22</a></td>
</tr>
<tr><td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,23/Itemid,38/' title='Go to calendar - current day'>23</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,24/Itemid,38/' title='Go to calendar - current day'>24</a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,25/Itemid,38/' title='Go to calendar - current day'>25</a></td>
<td class='mod_events_td_daywithevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,26/Itemid,38/' title='Go to calendar - current day'><b>26</b></a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,27/Itemid,38/' title='Go to calendar - current day'>27</a></td>
<td class='mod_events_td_daywithevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,28/Itemid,38/' title='Go to calendar - current day'><b>28</b></a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,29/Itemid,38/' title='Go to calendar - current day'>29</a></td>
</tr>
<tr><td class='mod_events_td_daywithevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,30/Itemid,38/' title='Go to calendar - current day'><b>30</b></a></td>
<td class='mod_events_td_daynoevents'><a class='mod_events_daylink' href='http://www.hbbostonamc.org/index.php/component/option,com_events/task,view_day/year,2008/month,03/day,31/Itemid,38/' title='Go to calendar - current day'>31</a></td>
<td class="mod_events_td_dayoutofmonth">1</td>
<td class="mod_events_td_dayoutofmonth">2</td>
<td class="mod_events_td_dayoutofmonth">3</td>
<td class="mod_events_td_dayoutofmonth">4</td>
<td class="mod_events_td_dayoutofmonth">5</td>
</tr></table>
		</div-->
				<!--div class="moduletable">
							<h3>
					HB Leaders Login Form				</h3>
					<form action="http://www.hbbostonamc.org/" method="post" name="login" >
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
			<label for="mod_login_username">
				Username			</label>
			<br />
			<input name="username" id="mod_login_username" type="text" class="inputbox" alt="username" size="10" />
			<br />
			<label for="mod_login_password">
				Password			</label>
			<br />
			<input type="password" id="mod_login_password" name="passwd" class="inputbox" size="10" alt="password" />
			<br />
			<input type="checkbox" name="remember" id="mod_login_remember" class="inputbox" value="yes" alt="Remember Me" />
			<label for="mod_login_remember">
				Remember me			</label>
			<br />
			<input type="submit" name="Submit" class="button" value="Login" />
		</td>
	</tr>
	<tr>
		<td>
			<a href="http://www.hbbostonamc.org/index.php/Lost-password.html">
				Lost Password?</a>
		</td>
	</tr>
			<tr>
			<td>
				No account yet?				<a href="http://www.hbbostonamc.org/index.php/Create-an-account.html">
					Register</a>
			</td>
		</tr>
			</table>
	
	<input type="hidden" name="option" value="login" />
	<input type="hidden" name="op2" value="login" />
	<input type="hidden" name="lang" value="english" />
	<input type="hidden" name="return" value="http://www.hbbostonamc.org/index.php/Table/Trips-Activities/" />
	<input type="hidden" name="message" value="0" />
	<input type="hidden" name="force_session" value="1" />
	<input type="hidden" name="jad8ecbb1d8c82c3dedc3d8f9a9e65c90" value="1" />
	</form>
			</div-->
		      </div>
    </div>
    <div id="layer32">
            <div id="layer32b" >
        <div id="layer32btext" >
          <span class="pathway"><a href="http://www.hbbostonamc.org/" class="pathway">Home</a> <img src="http://www.hbbostonamc.org/templates/amctemplate/images/arrow.png" border="0" alt="arrow" />   Trips &amp; Activities </span>        </div>
      </div>
      <div id="layer32inner">
        			<div class="componentheading">
			Trips &amp; Activities			</div>
					<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center" class="contentpane">
					<tr>
				<td width="60%" valign="top" class="contentdescription" colspan="2">				



<h1><xsl:value-of select="$groupTitle"/> Trip Listings</h1>


<xsl:apply-templates/>

				</td>
			</tr>
					<tr>
			<td width="100%">
						</td>
		</tr>
		<tr>
			<td colspan="2">
						</td>
		</tr>
		</table>
					<div class="back_button">
				<a href='javascript:history.go(-1)'>
					[ Back ]</a>
			</div>
			      </div>
      <div id="layer32c">
        			<div class="moduletable-none">
			<div align="center">
&#160;
</div>
<div align="center">
<span style="font-size: 9pt">
&#160;
</span>
</div>
<div align="center">
<span style="font-size: 9pt"><a href="index.php/Site.html" target="_self">About this Site</a>&#160; </span><span style="font-size: 10pt; color: #c0c0c0">|</span><span style="font-size: 9pt">&#160; <a href="index.php/Table/FAQs/" target="_self">FAQ's</a>&#160; </span><span style="font-size: 9pt; color: #c0c0c0">|</span><span style="font-size: 9pt">&#160; <a href="index.php/Search.html" target="_self">Advanced Search</a>&#160; </span><span style="font-size: 9pt; color: #c0c0c0">|</span><span style="font-size: 9pt">&#160; <a href="index.php/Contact-Us/" target="_self">Contact the Webmaster</a></span> <br />
</div>
<div align="center">
&#160;
</div>
<div align="center">
<span style="font-size: 8pt"><a href="http://www.outdoors.org" target="_blank">Outdoors.org</a> &#160; <span style="color: #c0c0c0">|</span>&#160; <a href="http://www.amcboston.org/" target="_blank">AMC Boston Chapter</a></span>  
</div>
		</div>
		      </div>
    </div>
    <div class="clearfix"></div>
  </div>
  <div id="layer40">
    <div align="center" style="color: #a8c6c2"><p style="font-size: 10px; color: #999999; font-family: Arial,Helvetica,sans-serif">&#160;&#169; 2008 H/B, Boston Chapter, Appalachian Mountain Club.</p></div>  </div>
</div>
</body>
</html>
	</xsl:template>
</xsl:stylesheet>
