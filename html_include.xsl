<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="UTF-8" indent="yes" method="html"/>
	<xsl:template match="/">

				<IMG ALIGN="RIGHT" SRC="BaxterPage.jpg" ALT="Crossing a stream in Baxter" VSPACE="4" HSPACE="4"/>
				<TABLE><tbody class="ymText">
				<xsl:for-each select="listing/trips"><TR><TD COLSPAN="2"><A href="#{@link}"><xsl:value-of select="@id" /></A></TD></TR></xsl:for-each>
				</tbody></TABLE>
				<br clear="all" />
				<TABLE WIDTH="100%" CELLSPACING="0"><tbody class="ymText">
					<TR><TD ALIGN="RIGHT"><A href="trip_list_pf.shtml" TARGET="pf_window">(Printer Friendly Version)</A></TD>
					</TR>
				</tbody></TABLE>
				<TABLE WIDTH="100%" CELLSPACING="0"><tbody class="ymColorSectionHead">
  				<TR><TD ALIGN="LEFT"><A name="how_to">How To Sign Up</A></TD></TR>
				</tbody></TABLE>
				<BR/>
				<SPAN class="ymText"><xsl:value-of disable-output-escaping="yes" select="listing/webheader" /></SPAN>
				<P/>
				<TABLE WIDTH="100%" CELLSPACING="0"><tbody class="ymText">
  				<TR><TD ALIGN="RIGHT"><A HREF="#top">Top Of Page</A></TD></TR>
				</tbody></TABLE>
				<BR/>
				<xsl:for-each select="/listing/trips">
				<TABLE WIDTH="100%" CELLSPACING="0"><tbody class="ymColorSectionHead">
				  <TR><TD ALIGN="LEFT"><A name="{@link}"><xsl:value-of select="@id"/></A></TD></TR>
				</tbody></TABLE>
				<BR/>
				<xsl:if test="@link='hike'">
				<TABLE WIDTH="100%" CELLSPACING="3" BORDER="1"><tbody class="ymText">
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

				<P/><CENTER><IMG ALIGN="CENTER" SRC="menuSpacer.gif" ALT="" HEIGHT="1" WIDTH="75%" /></CENTER><P/>
				</xsl:if>				
					<xsl:for-each select="trip">
						<SPAN class="ymTripTitle"><xsl:value-of select="date"/><xsl:text disable-output-escaping="yes">  </xsl:text><xsl:value-of select="title"/>
						<xsl:if test="@new"><font color="GREEN"><b><i>(New!)</i></b></font></xsl:if>
						<xsl:if test="@full"><font color="RED"><b>(Trip Full)</b></font></xsl:if>
						<xsl:if test="@wait"><font color="GREEN"><b>(Waitlist Open)</b></font></xsl:if></SPAN><br/>
						<SPAN class="ymTripDesc"><xsl:value-of select="desc" /></SPAN><br/>
					    <P/><CENTER><IMG ALIGN="CENTER" SRC="menuSpacer.gif" ALT="spacer" HEIGHT="1" WIDTH="75%" /></CENTER><P/>
					</xsl:for-each>
					<P/>
					<TABLE WIDTH="100%" CELLSPACING="0"><tbody class="ymText">
					  <TR><TD ALIGN="RIGHT"><A HREF="#top">Top Of Page</A></TD></TR>
					</tbody></TABLE>
					<BR/>
				</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>