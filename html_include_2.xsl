<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes" method="html"/>
  <xsl:template match="/">

<style type="text/css">
/* Colors:
#369 Medium Blue
#A56E27 Brown (complement to #369)
#D4E5F7 Light Blue (lightened #369)
#2E4C6B Dark Blue (darkened #369)
#1F3047 Darker Blue (darkened #369)
#69C Light Blue
#036 Dark Blue
#DDD Light Gray
*/

html, body, td {font: 12px/16px "Lucida Grande", Verdana, "Bitstream Vera Sans", Geneva, Arial, sans-serif}
.pageContent {padding: 0 1em}
.pulloutPhoto {float: right; border: 1em solid white; border-width: 0 0 07em 1em;
    background-color: white /* wipe out blue stripe while image loads */}
h2 {background-color: #369; color: white; padding: 0.2em 0.7em; margin: 1em 0 0.5em 0; font-size: 140%}

.contents .section td {padding-top: 0.8em; border-bottom: 1px solid #369; padding-left: 0.7em; color: #A56E27; background-color: #FFF; padding-bottom: 0.3em; font-weight: bold; font-size: 110%}
.contents .date {text-align: right; vertical-align: top; white-space: nowrap; border-right: 1px solid #D4E5F7; padding-top: 0.3em; padding-left: 0.5em}
.contents .title {vertical-align: top; padding-left: 0.7em; padding-top: 0.3em}
.contents .rating .inner {/*vertical-align: 2px;*/ color: white; background-color: #369; padding: 0 2px}

.trip {margin-bottom: 0.7em; margin-top: 0.7em; padding-bottom: 0.7em; border-bottom: 0px solid #D4E5F7}
.trip .date, .contents .date {padding-right: 0.7em; color: #1F3047}
.trip .date {margin-right: 0.5em; font-weight: bold; border-right: 1px solid #369; }
.trip .title {font-weight: bold}
.rating {font-size: 90%; color: white}
.rating .inner {color: #1F3047; border-bottom: 1px dotted gray}
.tagNew, .tagWaitlist, .tagFull {font-size: 90%; color: white; padding: 0 2px}
.tagNew {background-color: green}
.tagWaitlist {background-color: yellow}
.tagFull {background-color: red}
.trip .desc {margin-top: 0.2em}
.ratingKey tbody td, .ratingKey tbody th {vertical-align: top; text-align: left;
border-top: 1px solid gray; border-bottom: none; padding: 0.2em 0.4em 0.2em 0.4em;
white-space: nowrap; font-size: 11px}
.ratingKey tbody td {padding-bottom: 0.3em}
.ratingKey thead th {padding: 0.5em 0.4em}
.ratingKey td.gap, .ratingKey th.gap {border: none; background-color: #D4E5F7}
.ratingKey tbody .footnote td {white-space: normal; font-style: italic; padding: 0.6em 0.4em}
.ratingKey {margin-bottom: 1em; background-color: #D4E5F7; padding: 0.2em 1em; color: black}
@media print {
    .navOnly {display: none}
    .rating .inner {border-bottom: none; color: black}
    h2 {background-color: white; color: #2E4C68; padding: 0.2em 0; border-top: 1px solid #369; border-bottom: 1px solid #369}
}

</style>


    <div class="navOnly">
    <img class="pulloutPhoto" width="240" height="180"
    src="http://localhost:8008/personal/pictures/2004/01/vermont-snowshoeing/img_2900-sm.jpg?t=Vermont_Snowshoeing_AMC_hiking" alt="Photo from an AMC trip" />
    <ul class="contents">
      <xsl:for-each select="listing/trips">
        <li><a href="#{@link}"><xsl:value-of select="@id" /></a></li>
      </xsl:for-each>
    </ul>
    </div>
    
    <h2><a name="how_to"></a>How To Sign Up</h2>
    <xsl:value-of disable-output-escaping="yes" select="listing/webheader" />

    
    <h2><a name="contents"></a>At a Glance</h2>
    <table class="contents" border="0" cellpadding="0" cellspacing="0">
      <xsl:for-each select="/listing/trips">
        <tr class="section">
          <td colspan="2"><xsl:value-of select="@id"/></td>
        </tr>
        <xsl:for-each select="trip">
          <tr>
            <td class="date"><xsl:value-of select="date"/></td>
            <td class="title"><xsl:value-of select="title"/>
            
            <xsl:if test="rating">
             <xsl:text> </xsl:text>
             <span class="rating">
             <xsl:attribute name="title">
               <xsl:choose>
                 <xsl:when test="starts-with(rating, 'AA')">13+ miles, </xsl:when>
                 <xsl:when test="starts-with(rating, 'A')">9-13 miles, </xsl:when>
                 <xsl:when test="starts-with(rating, 'B')">5-9 miles, </xsl:when>
                 <xsl:when test="starts-with(rating, 'C')">under 5 miles, </xsl:when>
               </xsl:choose>
               <xsl:choose>
                 <xsl:when test="substring(rating, string-length(rating)-1, 1) = '1'">very fast 2.5+ mph, </xsl:when>
                 <xsl:when test="substring(rating, string-length(rating)-1, 1) = '2'">fast 2-2.5 mph, </xsl:when>
                 <xsl:when test="substring(rating, string-length(rating)-1, 1) = '3'">moderate 1.5-2 mph, </xsl:when>
                 <xsl:when test="substring(rating, string-length(rating)-1, 1) = '4'">leisurely 1.5 mph, </xsl:when>
               </xsl:choose>
               <xsl:choose>
                 <xsl:when test="substring(rating, string-length(rating), 1) = 'A'">very strenuous</xsl:when>
                 <xsl:when test="substring(rating, string-length(rating), 1) = 'B'">strenuous</xsl:when>
                 <xsl:when test="substring(rating, string-length(rating), 1) = 'C'">average</xsl:when>
                 <xsl:when test="substring(rating, string-length(rating), 1) = 'D'">easy</xsl:when>
               </xsl:choose>
             </xsl:attribute>(<span class="inner"><xsl:value-of select="rating"/></span>)</span>
            </xsl:if>
            
            <xsl:if test="@new"><font color="GREEN"><b><i>(New!)</i></b></font></xsl:if>
            <xsl:if test="@full"><font color="RED"><b>(Trip Full)</b></font></xsl:if>
            <xsl:if test="@wait"><font color="GREEN"><b>(Waitlist Open)</b></font></xsl:if>
            </td>
          </tr>
        </xsl:for-each>
      </xsl:for-each>
    </table>
    
    <xsl:for-each select="/listing/trips">
    <h2><a name="{@link}"></a><xsl:value-of select="@id"/></h2>
    <xsl:if test="@link='Hiking'">
    <div class="ratingKey">
    <!--table width="100%" cellspacing="2" border="0" align="center">
      <thead>
      <tr>
        <th colspan="3">Hiking / Backpacking Rating System</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <th>First Letter(s)</th>
        <td>Mileage</td>
        <td>AA = 13+ miles; A = 9-13 miles; B = 5-9 miles; C = under 5 miles</td>
      </tr>
      <tr>
        <th>Middle Number</th>
        <td>Leader's hiking pace on "average" (*) terrain</td>
        <td>1 = very fast 2.5+ mph; 2 = fast 2-2.5 mph; 3 = moderate 1.5-2 mph; 4 = leisurely 1.5 mph</td>
      </tr>
      <tr>
        <th>End Letter</th>
        <td>Terrain</td>
        <td>A = very strenuous; B = strenuous; C = average; D = easy</td>
      </tr>
      <tr>
        <td colspan="3" align="center"><i>(* An example of average terrain would be the hilly trails in the Blue Hills)</i></td>
      </tr>
    </tbody></table-->
    
    <table cellspacing="0" border="0" align="center">
      <thead>
      <tr>
        <th colspan="5">Hiking / Backpacking Rating System</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <th>First: Mileage</th>
        <th class="gap">&#160;</th>
        <th>Middle: Pace*</th>
        <th class="gap">&#160;</th>
        <th>Last: Terrain</th>
      </tr>
      <!--tr>
        <th>Mileage</th>
        <th>Pace</th>
        <th>Terrain</th>
      </tr-->
      <tr>
        <td>AA = 13+ miles<br />A = 9-13 miles<br />B = 5-9 miles<br />C = under 5 miles</td>
        <td class="gap">&#160;</td>
        <td>1 = very fast 2.5+ mph<br />2 = fast 2-2.5 mph<br />3 = moderate 1.5-2 mph<br />4 = leisurely 1.5 mph</td>
        <td class="gap">&#160;</td>
        <td>A = very strenuous<br />B = strenuous<br />C = average<br />D = easy</td>
      </tr>
      <tr class="footnote">
        <td colspan="5" align="center">* Pace is the leader&#8217;s
        hiking pace on &#8220;average&#8221; terrain, such as the
        hilly trails in the Blue Hills.</td>
      </tr>
    </tbody></table>
    </div>
    
    </xsl:if>				
        <xsl:for-each select="trip">
          <div class="trip">
            <span class="date"><xsl:value-of select="date"/></span>
            <xsl:text> </xsl:text>
            <span class="title"><xsl:value-of select="title"/></span>
            
            <xsl:if test="rating">
             <xsl:text> </xsl:text>
             <span class="rating">
             <xsl:attribute name="title">
               <xsl:choose>
                 <xsl:when test="starts-with(rating, 'AA')">13+ miles, </xsl:when>
                 <xsl:when test="starts-with(rating, 'A')">9-13 miles, </xsl:when>
                 <xsl:when test="starts-with(rating, 'B')">5-9 miles, </xsl:when>
                 <xsl:when test="starts-with(rating, 'C')">under 5 miles, </xsl:when>
               </xsl:choose>
               <xsl:choose>
                 <xsl:when test="substring(rating, string-length(rating)-1, 1) = '1'">very fast 2.5+ mph, </xsl:when>
                 <xsl:when test="substring(rating, string-length(rating)-1, 1) = '2'">fast 2-2.5 mph, </xsl:when>
                 <xsl:when test="substring(rating, string-length(rating)-1, 1) = '3'">moderate 1.5-2 mph, </xsl:when>
                 <xsl:when test="substring(rating, string-length(rating)-1, 1) = '4'">leisurely 1.5 mph, </xsl:when>
               </xsl:choose>
               <xsl:choose>
                 <xsl:when test="substring(rating, string-length(rating), 1) = 'A'">very strenuous</xsl:when>
                 <xsl:when test="substring(rating, string-length(rating), 1) = 'B'">strenuous</xsl:when>
                 <xsl:when test="substring(rating, string-length(rating), 1) = 'C'">average</xsl:when>
                 <xsl:when test="substring(rating, string-length(rating), 1) = 'D'">easy</xsl:when>
               </xsl:choose>
             </xsl:attribute>(<span class="inner"><xsl:value-of select="rating"/></span>)</span>
            </xsl:if>
            
            <xsl:if test="@new"><font color="GREEN"><b><i>(New!)</i></b></font></xsl:if>
            <xsl:if test="@full"><font color="RED"><b>(Trip Full)</b></font></xsl:if>
            <xsl:if test="@wait"><font color="GREEN"><b>(Waitlist Open)</b></font></xsl:if>
            <div class="desc"><xsl:copy-of select="desc"/></div>
          </div>
        </xsl:for-each>
        <!--div style="text-align: right"><a href="#top">Top Of Page</a></div-->
        <xsl:for-each select="p">
          <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

<!-- 
Local Variables:
coding: utf-8;
End:
 -->