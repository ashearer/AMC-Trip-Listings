<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="groupTitle">AMC Boston Young Members</xsl:param>
  <xsl:param name="byDate" select="1"/>
  <xsl:include href="amc-trips-to-html-inc.xsl" />
  <xsl:output encoding="UTF-8" indent="yes" method="html"
    doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
  <xsl:template match="/">

<html>
<head>
  <title>AMC Boston Young Members - Trip Listings</title>
  <meta name="generator" content="Boston AMC XSLT stylesheet by Andrew Shearer" />
  <link rel="stylesheet" href="ymStyle.css" type="text/css" />
  <link rel="stylesheet" href="trip_list.css" type="text/css" />
  <meta http-equiv="content-type" value="text/html;charset=utf-8" />
  <script type="text/javascript" src="trip_list.js"></script>
  <base href="http://amcboston.org/youngmembers/trip_list.shtml" />
</head>
<body>
<A name="top"></A>
<!-- **************************************************************************
*                                                                             *
* Main table for page. Divides page into header, menu, and main content areas *
*                                                                             *
*************************************************************************** -->
<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="620">
<!-- First Row -->
<TR class="navOnly">
  <TD class="ymSideBarBackground" VALIGN="TOP" HEIGHT="10" WIDTH="20"></TD>
  <TD class="ymSideBarBackground" VALIGN="TOP" HEIGHT="10" WIDTH="90"></TD>
  <TD class="ymBackground" WIDTH="5"></TD>
  <TD class="ymBackground" VALIGN="TOP" HEIGHT="10" WIDTH="505"></TD>
</TR>
<!-- Second Row -->
<TR class="navOnly">
  <TD class="ymSideBarBackground" VALIGN="TOP" HEIGHT="100" WIDTH="20"></TD>
  <TD COLSPAN="3" WIDTH="600"><TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="600" background="titleBanner.jpg">
                  <TR><TD HEIGHT="60" WIDTH="100%"></TD></TR>
                  <TR><TD HEIGHT="40" WIDTH="100%"><IMG ALIGN="RIGHT" SRC="trip_list.gif" ALT="Trip Listings" WIDTH="190" HEIGHT="40" /></TD></TR>
                  </TABLE></TD>
</TR>
<!-- Third Row -->
<TR class="ymLinkBarBackground navOnly">
  <TD class="ymSideBarBackground" VALIGN="TOP" WIDTH="20"></TD>
  <TD COLSPAN="3" ALIGN="RIGHT" VALIGN="middle" WIDTH="600"><SPAN class="ymText"><A class="ymHeaderLink" href="http://www.outdoors.org/">AMC Home</A>&#160;&#160;|&#160;&#160;<A class="ymHeaderLink" href="http://www.amcboston.org">Boston Chapter Home</A>&#160;&#160;|&#160;&#160;<A class="ymHeaderLink" href="http://www.amcboston.org/main/join.html">Join the AMC</A>&#160;&#160;</SPAN></TD>
</TR>
<!-- Fourth Row -->
<TR>
  <TD class="xymSideBarBackground navOnly" COLSPAN="2" VALIGN="TOP" WIDTH="110">
          <!-- ****************************************************************
          *                                                                   *
          * Left Navigation Table. Contains all navigation links. Depending   *
          * on the main page, the left nav may show submenu items.            *
          *                                                                   *
          ***************************************************************** -->
          <TABLE CELLSPACING="0" CELLPADDING="2" BORDER="0" WIDTH="110">
            <tbody class="ymMenuText">
              <TR class="ymSideBarBackground">
                <TD WIDTH="110" HEIGHT="20" COLSPAN="3"></TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="10"></TD>
                <TD WIDTH="100" COLSPAN="2"><A class="ymMenuLink" href="./">Home</A></TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="110" COLSPAN="3"><IMG ALIGN="middle" SRC="menuSpacer.gif" ALT="" HEIGHT="1" WIDTH="110" /></TD>
              </TR>
              <!-- ************************************************************
              *                                                               *
              * Selected Left Nav item. Use the style ymMenuSelect or         *
              * ymSubMenuSelect on the table row containing the selected      *
              * item. Comment out the link for the selected menu item.        *
              *                                                               *
              ************************************************************* -->
              <TR CLASS="ymMenuSelect">
                <TD WIDTH="10"></TD>
                <!--
                <TD WIDTH="100" COLSPAN="2"><A class="ymMenuLink" href="trip_list.html">Trip Listings</A></TD>
                -->
                <TD WIDTH="100" COLSPAN="2">Trip Listings</TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="110" COLSPAN="3"><IMG ALIGN="middle" SRC="menuSpacer.gif" ALT="" HEIGHT="1" WIDTH="110" /></TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="10"></TD>
                <TD WIDTH="100" COLSPAN="2"><A class="ymMenuLink" href="faq.html">FAQ</A></TD>
              </TR>
              <!--
              <TR class="ymMenuBackground">
                <TD WIDTH="10"></TD>
                <TD WIDTH="10"></TD>
                <TD CLASS="ymSubMenuText" WIDTH="90" ALIGN="LEFT"><A class="ymMenuLink" href="potluck.html">- Potluck FAQ</A></TD>
              </TR>
               -->
              <TR class="ymMenuBackground">
                <TD WIDTH="100" COLSPAN="3"><IMG ALIGN="middle" SRC="menuSpacer.gif" ALT="" HEIGHT="1" WIDTH="110" /></TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="10"></TD>
                <TD WIDTH="100" COLSPAN="2" ALIGN="LEFT"><A class="ymMenuLink" href="leader_info.html">Leader Info</A></TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="110" COLSPAN="3"><IMG ALIGN="middle" SRC="menuSpacer.gif" ALT="" HEIGHT="1" WIDTH="110" /></TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="10"></TD>
                <TD WIDTH="100" COLSPAN="2"><A class="ymMenuLink" href="photo_gallery.html">Photo Gallery</A></TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="110" COLSPAN="3"><IMG ALIGN="middle" SRC="menuSpacer.gif" ALT="" HEIGHT="1" WIDTH="110" /></TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="10"></TD>
                <TD WIDTH="100" COLSPAN="2"><A class="ymMenuLink" href="resource.html">Resources &amp; Links</A></TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="110" COLSPAN="3"><IMG ALIGN="middle" SRC="menuSpacer.gif" ALT="" HEIGHT="1" WIDTH="110" /></TD>
              </TR>
              <TR class="ymMenuBackground">
                <TD WIDTH="10"></TD>
                <TD WIDTH="100" COLSPAN="2"><A class="ymMenuLink" href="contact.html">Contact Us!</A></TD>
              </TR>
              <TR class="ymSideBarBackground">
                <TD WIDTH="110" HEIGHT="20" COLSPAN="3"></TD>
              </TR>
              <TR class="ymSideBarBackground">
                <TD WIDTH="110" COLSPAN="3"><IMG ALIGN="middle" SRC="sidebar.jpg" ALT="" WIDTH="110" /></TD>
              </TR>
            </tbody>
          </TABLE>
    <!-- **********************************************************************
    *                                                                         *
    * End of Left Navigation Table.                                           *
    *                                                                         *
    *********************************************************************** -->
  </TD>
  <!-- A spacer column to provide space between menu and content -->
  <TD class="ymBackground navOnly" WIDTH="1"></TD>
  <TD VALIGN="TOP" WIDTH="505" class="pageContent">
<!-- **************************************************************************
*                                                                             *
* Main Content Area. Contains the page content.                               *
*                                                                             *
*************************************************************************** -->
<!-- ***********************************************************************
     [START_MONTHLY_TRIP_LISTINGS] - CUT AND PASTE TRIP LISTINGS FROM
     THE XXX_TRIP_BODY.HTML FILE HERE!
     *********************************************************************** -->

      <xsl:apply-templates/>

<!-- ***********************************************************************
     [END_MONTHLY_TRIP_LISTINGS] - CUT AND PASTE TRIP LISTINGS FROM
     THE XXX_TRIP_BODY.HTML FILE ABOVE THIS COMMENT!
     *********************************************************************** -->
<p>
<a target="_top" href="http://t.extreme-dm.com/?login=ymtrips">
<img src="http://u1.extreme-dm.com/i.gif" height="38"
border="0" width="41" alt="" /></a>
<script language="javascript1.2" type="text/javascript">
EXs=screen;EXw=EXs.width;navigator.appName!="Netscape"?
EXb=EXs.colorDepth:EXb=EXs.pixelDepth;
</script><script language="javascript" type="text/javascript">
EXd=document;EXw?"":EXw="na";EXb?"":EXb="na";
EXd.write("&lt;img src=\"http://t0.extreme-dm.com",
"/0.gif?tag=ymtrips&amp;j=y&amp;srw="+EXw+"&amp;srb="+EXb+"&amp;",
"l="+escape(EXd.referrer)+"\" height=1 width=1&gt;");
</script>
</p>

  </TD>
</TR>
</TABLE>


</body>
</html>

	</xsl:template>
</xsl:stylesheet>

<!-- 
Local Variables:
coding: utf-8;
End:
 -->