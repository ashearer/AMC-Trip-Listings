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
					<TR><TD COLSPAN="2" ALIGN="LEFT" class="ymSectionHead"><xsl:value-of select="@id"/></TD></TR>
					<xsl:for-each select="trip">
						<TR class="ymTripTitle"><TD WIDTH="25%" ALIGN="RIGHT"><xsl:value-of select="date"/></TD><TD ALIGN="LEFT"><xsl:value-of select="title"/></TD></TR>
					</xsl:for-each>
					</tbody></TABLE>
					<P/>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c)1998-2004. Sonic Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="html" userelativepaths="yes" externalpreview="no" url="april.xml" htmlbaseurl="" outputurl="email.html" processortype="internal" profilemode="0" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""/></scenarios><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no" ><SourceSchema srcSchemaPath="..\website\april.xml" srcSchemaRoot="listing" AssociatedInstance=""/></MapperInfo>
</metaInformation>
-->