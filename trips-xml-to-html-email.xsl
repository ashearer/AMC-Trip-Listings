<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes" method="html"/>
  <xsl:include href="trip-rating.inc.xsl"/>
  
  <xsl:template match="/">
    <html lang="en">
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>AMC Trip Listings</title>
        <base href="http://www.amcboston.org/youngmembers/" />
        <meta name="generator" content="BBEdit 8.0" />
        <style type="text/css">
          <xsl:text disable-output-escaping="true">&lt;!--</xsl:text>
          <xsl:text>
/*
by Andrew Shearer 2004-12-26
amc2005@shearersoftware.com

Colors:
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
h2 {background-color: #369; color: white; padding: 0.2em 0.7em 0.3em 0.7em; margin: 1em 0 0.5em 0;
    font-size: 140%; border: 1px solid #2E4C7B; border-width: 1px 0}

/*.contents .section td {padding-top: 0.8em; border-bottom: 1px solid #369; padding-left: 0.7em; color: #A56E27; background-color: #FFF; padding-bottom: 0.3em; font-weight: bold}
*/
.contents .date {text-align: right; vertical-align: top; white-space: nowrap; border-right: 1px solid #D4E5F7; padding-top: 0.3em; padding-left: 0.5em}
.contents .title {vertical-align: top; padding-left: 0.7em; padding-top: 0.3em; color: black}
.contents .emptySection td {padding-left: 0.7em; padding-top: 0.3em; font-style: italic}

.rating .inner {/*vertical-align: 2px;*/ color: white; background-color: #369; padding: 0 2px; cursor: pointer}
.contents td a {text-decoration: none; color: inherit}
.contents td a:hover {text-decoration: underline}
.trip {margin-bottom: 0.7em; margin-top: 0.7em; padding-bottom: 0.7em; border-bottom: 0px solid #D4E5F7}
.trip .date, .contents .date {padding-right: 0.7em; color: #1F3047}
.trip .date {margin-right: 0.5em; font-weight: bold; border-right: 1px solid #369; }
.trip .title {font-weight: bold}
.rating {font-size: 90%; color: white}
/*.rating .inner {color: #1F3047; border-bottom: 1px dotted gray}*/
.tagNew, .tagWaitlist, .tagFull {font-size: 90%; color: white; padding: 0 2px}
.tagNew {background-color: green}
.tagWaitlist {background-color: yellow}
.tagFull {background-color: red}
.trip .desc {margin-top: 0.2em}
.mail .ratingKey {margin-top: 1em}
.ratingKey tbody td, .ratingKey tbody th {vertical-align: top; text-align: left;
border-top: 1px solid gray; border-bottom: none; padding: 0.2em 0.4em 0.2em 0.4em;
white-space: nowrap; font-size: 11px}
.ratingKey tbody td {padding-bottom: 0.3em}
.ratingKey thead th {padding: 0.5em 0.4em; font-size: 12px; text-align: center}
.ratingKey td.gap, .ratingKey th.gap {border: none; background-color: #D4E5F7}
.ratingKey tbody .footnote td {white-space: normal; font-style: italic; padding: 0.6em 0.4em}
.ratingKey tbody .example td {white-space: normal; padding: 0.6em 0.4em; border-top: none}
.ratingKey {margin-bottom: 1em; background-color: #D4E5F7; padding: 0.2em 1em; color: black}
@media print {
    .navOnly {display: none}
    .rating .inner {border-bottom: none; color: black}
    h2 {background-color: white; color: #2E4C68; padding: 0.2em 0; border-top: 1px solid #369; border-bottom: 1px solid #369}
}
</xsl:text>
<xsl:text disable-output-escaping="yes">--&gt;</xsl:text>
</style>

    </head>
    <body class="mail">
      <xsl:apply-templates/>
    </body>
    </html>
  </xsl:template>
  
  <xsl:template match="listing">

    <h2>About the AMC Boston Young Members Trip Listings</h2>
    <!--xsl:copy-of select="mailheader" /-->
<p>Young Members invites outdoor enthusiasts to
get involved with the AMC.</p>

<p>Questions? Want to learn how to get involved? Visit the Young Members
web site
(<a href="http://amcboston.org/youngmembers/">http://amcboston.org/youngmembers/</a>)
and check out the Frequently Asked Questions page. If
you still have questions or concerns, please contact the YM Chair (<a
href="mailto:youngmembers@amcboston.org">youngmembers@amcboston.org</a>).</p>

<p>For full descriptions of the trips listed below, including
registration information, visit:
<a href="http://amcboston.org/youngmembers/trip_list.shtml">http://amcboston.org/youngmembers/trip_list.shtml</a>.</p>

<p>(Note: there is no longer a separate link to a printable version
of the full trip listings, because its format will now be used automatically
when you print.)</p>

<p>The trips listed in this email are subject to change, so for the most
up-to-date list of activities, please check the listings on the web site.</p>

<p><i>NOTE: To unsubscribe from this email or to change your email
address, please follow the link at the bottom of this message. To change
your email address, first unsubscribe using the link at the bottom of
this message, and then re-subscribe using the link on the YM home page.
If you experience any problems with the email or web site, please <em>do not</em>
reply to this message. Instead, please contact Andrew at
<a href="mailto:amc2005@shearersoftware.com">amc2005@shearersoftware.com</a>.
Thanks!</i></p>


    <table class="contents" border="0" cellpadding="0" cellspacing="0">
      <xsl:for-each select="trips">
        <tr class="section">
          <td colspan="2"><h2><xsl:value-of select="@id"/></h2>
            <xsl:if test="@link='Hiking'">
                For an explanation of the trip rating codes, click on a
                particular trip rating (or hover over it with the mouse
                for a second). You can also see the full key at the bottom of this message.
            </xsl:if>
          </td>
        </tr>
        <xsl:if test="not(trip)">
          <tr class="emptySection">
            <td colspan="2">See web page for details.</td>
          </tr>
        </xsl:if>
        <xsl:for-each select="trip">
          <tr>
            <td class="date"><xsl:value-of select="date"/></td>
            <td class="title">
              <xsl:value-of select="title"/>
            
              <xsl:if test="rating"><xsl:text> </xsl:text><xsl:apply-templates select="rating"/></xsl:if>
              
              <xsl:if test="@new"><xsl:text> </xsl:text><span class="tagNew">New</span></xsl:if>
              <xsl:if test="@full"><xsl:text> </xsl:text><span class="tagFull">Full</span></xsl:if>
              <xsl:if test="@wait"><xsl:text> </xsl:text><span class="tagWaitlist">Waitlist</span></xsl:if>
            </td>
          </tr>
        </xsl:for-each>
      </xsl:for-each>
    </table>
    
    <div></div>
    
    <div class="ratingKey">
    
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
      <tr>
        <td>AA = 13+ miles<br />A = 9–13 miles<br />B = 5–9 miles<br />C = under 5 miles</td>
        <td class="gap">&#160;</td>
        <td>1 = very fast 2.5+ mph<br />2 = fast 2–2.5 mph<br />3 = moderate 1.5–2 mph<br />4 = leisurely 1.5 mph</td>
        <td class="gap">&#160;</td>
        <td>A = very strenuous<br />B = strenuous<br />C = average<br />D = easy</td>
      </tr>
      <tr class="footnote">
        <td colspan="5" align="center">* Pace is the leader&#8217;s
        hiking pace on &#8220;average&#8221; terrain, such as the
        hilly trails in the Blue Hills.</td>
      </tr>
      <tr class="example">
        <td colspan="5" align="center"><strong>Example:</strong><xsl:text> </xsl:text>
        <span class="rating" onclick="window.alert('B2C: ' + this.title + '.')"  title="5–9 miles, fast 2–2.5 mph pace, average terrain"><span class="inner">B2C</span></span>
        means 5–9 miles, fast 2–2.5 mph pace, average terrain.
        </td>
      </tr>
    </tbody></table>
    </div>
    
  </xsl:template>
  
</xsl:stylesheet>

<!-- 
Local Variables:
coding: utf-8;
End:
 -->