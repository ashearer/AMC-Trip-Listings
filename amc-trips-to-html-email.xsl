<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date">

  <xsl:import href="functions/day-abbreviation/date.day-abbreviation.template.xsl"/>
  <xsl:import href="functions/month-abbreviation/date.month-abbreviation.template.xsl"/>
  <xsl:import href="functions/day-in-month/date.day-in-month.template.xsl"/>
  <xsl:import href="trip-rating.inc.xsl"/>
  <xsl:import href="amc-trips-to-html-inc.xsl"/>

  <xsl:output encoding="UTF-8" indent="yes" method="html"/>
  
  <xsl:param name="tripListingsPageLink" select="'http://amcboston.org/youngmembers/trip_list.shtml'"/>

  <xsl:template match="/">
    <html lang="en">
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>AMC Trip Listings</title>


    </head>
    <body><div class="mail">
        <style type="text/css">
          <xsl:text disable-output-escaping="yes">&lt;!--</xsl:text>
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

.mail, .mail td {font: 12px/16px "Lucida Grande", Verdana, "Bitstream Vera Sans", Geneva, Arial, sans-serif}
.mail h3 {background-color: #369; color: white; padding: 0.2em 0.7em 0.3em 0.7em; margin: 1em 0 0.5em 0;
    font-size: 140%; border: 1px solid #2E4C7B; border-width: 1px 0}
.contents .date {text-align: right; vertical-align: top; white-space: nowrap; border-right: 1px solid #D4E5F7; padding-top: 0.3em; padding-left: 0.5em; padding-right: 0.7em}
.contents .title {vertical-align: top; padding-left: 0.7em; padding-top: 0.3em; color: black}
.contents .emptySection td {padding-left: 0.7em; padding-top: 0.3em; font-style: italic}

.rating .inner {color: white; background-color: #369; padding: 0 2px; cursor: pointer}
.contents td a {text-decoration: none; color: inherit}
.contents td a:hover {text-decoration: underline}
.contents tr.emptySection td a {text-decoration: underline; color: blue}
.rating {font-size: 90%; color: white}
.tagNew, .tagWaitlist, .tagFull, .tagCancel {font-size: 90%; color: white; padding: 0 2px}
.tagNew {background-color: green}
.tagWaitlist {background-color: yellow; color: #666666; border: 1px solid #666666}
.tagFull, .tagCancel {background-color: red}
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
</xsl:text>
<xsl:text disable-output-escaping="yes">--&gt;</xsl:text>
</style>
      <xsl:apply-templates/>
    </div>
    </body>
    </html>
  </xsl:template>

  <xsl:key name="trips-by-category" match="*" use="activity_category"/>
 
  <xsl:template match="trips">
<h2>Boston AMC Young Members Trip Listings</h2>
     <!--xsl:copy-of select="mailheader" /-->
<p>This is a summary of upcoming trips with the Boston Appalachian Mountain Club
Young Members. For full descriptions, including
registration information, please visit:
<a href="http://amcboston.org/youngmembers/trip_list.shtml">http://amcboston.org/youngmembers/trip_list.shtml</a>.</p>

<p>We're now sending out this summary at least bimonthly, as well as updating the
web site when new trips become available or fill up. (This should smooth out the demand
for trips, with less of a rush to sign up at
the beginning of each month, giving you a better chance of getting into a
trip the rest of the time.) Trips added or changed in the past two weeks are marked <span
class="tagNew">Updated</span>.</p>

<p>Other questions? Want to learn how to get involved? Visit the Young Members
web site
(<a href="http://amcboston.org/youngmembers/">http://amcboston.org/youngmembers/</a>)
and check out the Frequently Asked Questions page. If
you still have questions or concerns, please contact the YM Chair at <a
href="mailto:youngmembers@amcboston.org">youngmembers@amcboston.org</a>.</p>

<p>The trips listed in this email are subject to change, so for the most
up-to-date list of activities, please check the listings on the web site.</p>

<p><i>NOTE: To unsubscribe from this email, please follow the link at
the bottom of this message. To change your email address, first
unsubscribe using the link at the bottom of this message, and then
re-subscribe using the link on the YM home page. If you experience any
problems with this mailing list or the web site, please contact Andrew at <a
href="mailto:amc2006@shearersoftware.com">amc2006@shearersoftware.com</a>.
Thanks!</i></p>

    <table class="contents" border="0" cellpadding="0" cellspacing="0">
      <!-- Muenchian method for grouping by activity_category -->
      <xsl:for-each select="*[count(. | key('trips-by-category', activity_category)[1]) = 1]">
        <xsl:sort select="activity_category"/>
        <tr class="section">
          <td colspan="3"> <br/><h3><a href="http://amcboston.org/youngmembers/trip_list.shtml#{substring(activity_category, 1, 5)}"><xsl:value-of select="activity_category"/></a></h3></td>
        </tr>
        <!--xsl:if test="not(*)">
          <tr class="emptySection">
            <td colspan="2">See below for details.</td>
          </tr>
        </xsl:if-->
        <xsl:for-each select="key('trips-by-category', activity_category)">
          <xsl:call-template name="trip-summary-row">
            <xsl:with-param name="showInternalNav" select="0"/>
          </xsl:call-template">
        </xsl:for-each>
      </xsl:for-each>
    </table>

    <hr/>

    
    <table class="contents" border="0" cellpadding="0" cellspacing="0">
      <tr class="section">
        <td colspan="3"><h3>All Events by Date</h3></td>
      </tr>
      <xsl:for-each select="*">
        <xsl:sort select="trip_start_date"/>
        <xsl:call-template name="trip-summary-row">
          <xsl:with-param name="showInternalNav" select="0"/>
        </xsl:call-template">
      </xsl:for-each>
    </table>
        <!--xsl:if test="not(trip)">
          <tr class="emptySection">
            <td colspan="2">See the <a href="http://amcboston.org/youngmembers/trip_list.shtml">web page</a> for details.</td>
          </tr>
        </xsl:if-->
    
    <br/>
        
    <xsl:call-template name="hike-rating-key"/>
    
    <p><strong><a href="http://amcboston.org/youngmembers/trip_list.shtml">See the web site</a></strong> for full descriptions.</p>
    
  </xsl:template>
  
</xsl:stylesheet>

<!-- 
Local Variables:
coding: utf-8;
End:
 -->