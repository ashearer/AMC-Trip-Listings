<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="UTF-8" indent="yes" method="html"/>
	<xsl:template match="/">
		<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>AMC Young Members - Trip Listings</title>
				<LINK rel="stylesheet" href="ymStyle.css" type="text/css"></LINK>
				<style type="text/css">
				.ymPageHead {font-family:Comic Sans MS, arial;font-weight:bold;font-size:14pt}
				.ymHeader {font-family:arial;font-weight:bold;font-size:14pt}

				.ymBackground {background-color:#ffffff}
				.ymHeaderBackground {background-color: lightblue}
				.ymMenuBackground {background-color:#66cc99}
				.ymSideBarBackground {background-color:#33aa33}
				.ymLinkBarBackground {background-color:#999999}

				.ymBody {font-family:arial;font-size:10pt}

				.ymSectionHead {font-family:arial;font-weight:bold;font-size:12pt}

				.ymColorSectionHead {background-color:#66cc99;font-family:arial;font-weight:bold;font-size:12pt}

				.ymSubSectionHead {font-family:arial;font-weight:bold;font-size:10pt}

				.ymTripDesc {font-family:arial;font-size:10pt;font-weight:normal}
				.ymTripTitle {font-family:arial;font-size:10pt;font-weight:normal;background-color:#ffffff}
				.ymAltTripTitle {font-family:arial;font-size:10pt;font-weight:normal;background-color:#eeeeee}

				.none {font-family:arial;font-size:10pt;list-style-type:none}
				.nonea {font-family:arial;font-size:9pt;list-style-type:none}
				.disc {font-family:arial;font-size:10pt;list-style-type:disc}

				 A:link {color: blue}
				 A:visited {color: brown}
				 A:active {color: brown}
				 A:hover {color: black}
				</style>
			</head>
			<body bgcolor="white" class="ymBody">
			<TABLE WIDTH="600" CELLSPACING="0">
				<tr><td><CENTER><SPAN class="ymPageHead">YM Trip Listings - <xsl:value-of select="/listing/@month" /><xsl:text disable-output-escaping="yes">  </xsl:text><xsl:value-of select="/listing/@year" /></SPAN></CENTER></td></tr>
				</TABLE>
				<P/>
				<TABLE WIDTH="600" CELLSPACING="0"><tbody class="ymTripDesc">
				<TR><TD><xsl:value-of disable-output-escaping="yes" select="listing/mailheader" /></TD></TR>
				</tbody></TABLE>
				<p/>
				<p/>
				<xsl:for-each select="/listing/trips">
					<TABLE WIDTH="600" CELLSPACING="1" CELLPADDING="4" bgcolor="blue"><tbody class="ymTripTitle">
					<xsl:choose>
					<xsl:when test="@link='hike'">
					<TR><TD bgcolor="white" COLSPAN="2" ALIGN="LEFT" class="ymSectionHead"><xsl:value-of select="@id"/></TD></TR>
					<TR><TD bgcolor="white" COLSPAN="2" ALIGN="LEFT" class="ymTripTitle"><i>(For an explanation of the hike / backpack ratings, see the chart at the end of this email)</i></TD></TR>
					</xsl:when>
					<xsl:otherwise>
					<TR><TD bgcolor="white" COLSPAN="2" ALIGN="LEFT" class="ymSectionHead"><xsl:value-of select="@id"/></TD></TR>
					</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="trip">
						<TR class="ymTripTitle"><TD bgcolor="white" WIDTH="25%" ALIGN="RIGHT" valign="TOP"><xsl:value-of select="date"/></TD><TD bgcolor="white" ALIGN="LEFT"><xsl:value-of select="title"/>
						<xsl:if test="@new"><font color="GREEN"><b><i>(New!)</i></b></font></xsl:if>
						<xsl:if test="@full"><font color="RED"><b>(Trip Full)</b></font></xsl:if>
						<xsl:if test="@wait"><font color="GREEN"><b>(Waitlist is Open)</b></font></xsl:if></TD></TR>
					</xsl:for-each>
					</tbody></TABLE>
					<P/>
				</xsl:for-each>
				<TABLE WIDTH="600" CELLSPACING="3" BORDER="1"><tbody class="ymTripTitle">
				  <TR>
				    <TH COLSPAN="3">Hiking / Backpacking Rating System</TH>
				  </TR>
				  <TR>
				    <TH>First Letter(s)</TH>
				    <TD>Mileage</TD>
				    <TD>AA = 13+ miles; A = 9-13 miles; B = 5-9 miles; C = under 5 miles</TD>
				  </TR>
				  <TR>
				    <TH>Middle Number</TH>
				    <TD>Leader's hiking pace on "average" (*) terrain</TD>
				    <TD>1 = very fast 2.5+ mph; 2 = fast 2-2.5 mph; 3 = moderate 1.5-2 mph; 4 = leisurely 1.5 mph</TD>
				  </TR>
				  <TR>
				    <TH>End Letters</TH>
				    <TD>Terrain</TD>
				    <TD>A = very strenuous; B = strenuous; C = average; D = easy</TD>
				  </TR>
				  <TR>
				    <TD COLSPAN="3" align="CENTER"><i>(* An example of average terrain would be the hilly trails in the Blue Hills)</i></TD>
				  </TR>
				</tbody></TABLE>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
