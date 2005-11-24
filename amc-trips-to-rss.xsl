<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:g="http://base.google.com/ns/1.0"
 xmlns:dcterms="http://purl.org/dc/terms/"
 xmlns:dc="http://purl.org/dc/elements/1.1/">
  <xsl:include href="amc-trips-to-html-inc.xsl"/>
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:param name="groupTitle">AMC</xsl:param>
  <xsl:param name="groupHomePageURL"/>
  <xsl:param name="listingsURL"/>
  <xsl:template match="trips">

<rss version="2.0" xmlns:g="http://base.google.com/ns/1.0"> 
  <channel>
    <title><xsl:value-of select="$groupTitle"/> Trip Listings</title>
  	<description>Local outdoors-related events</description>
  	<link><xsl:value-of select="$listingsURL"/></link>
  	
  	<xsl:for-each select="*">
  	  <xsl:call-template name="trip"/>
  	</xsl:for-each>
  </channel>
</rss>
  </xsl:template>
  
  <xsl:template name="trip">
    <item>
      <title>
        <xsl:call-template name="date-range">
          <xsl:with-param name="start_date"><xsl:value-of select="trip_start_date"/></xsl:with-param>
          <xsl:with-param name="end_date"><xsl:value-of select="trip_end_date"/></xsl:with-param>
        </xsl:call-template>
        <xsl:text>. </xsl:text>
        <xsl:call-template name="RSSHTMLEscape">
          <xsl:with-param name="text" select="trip_title"/>
        </xsl:call-template>
        <xsl:if test="@new"><xsl:text> </xsl:text>(New)</xsl:if>
        <xsl:if test="@full or status = 'Full'"><xsl:text> </xsl:text>(Full)</xsl:if>
        <xsl:if test="@wait or status = 'Waitlist'"><xsl:text> </xsl:text>(Waitlist)</xsl:if>
        <xsl:if test="@cancel or status = 'Cancelled' or status = 'Canceled'"><xsl:text> </xsl:text>(Canceled)</xsl:if>
      </title>
      
      <description>
        <xsl:call-template name="RSSHTMLEscape">
          <xsl:with-param name="text" select="web_desc"/>
        </xsl:call-template>
        <!--xsl:text> </xsl:text>
        <xsl:call-template name="regAndLeaderInfo"/-->
      </description>
      
      <xsl:if test="normalize-space(external_link)">
        <link><xsl:value-of select="external_link"/></link> <!-- +++ link to event desc on ashearer.com -->
      </xsl:if>
      <guid isPermaLink="true"><xsl:value-of select="$listingsURL"/>#trip<xsl:value-of select="trip_id"/></guid>
    
      <g:event_date_range>
        <g:start>
          <xsl:call-template name="FixW3CDate">
            <xsl:with-param name="date" select="trip_start_date"/>
          </xsl:call-template>
        </g:start>
        <g:end>
          <xsl:call-template name="FixW3CDate">
            <xsl:with-param name="date" select="trip_end_date"/>
          </xsl:call-template>
        </g:end>
      </g:event_date_range>
      
      <dc:date>
        <xsl:call-template name="FixW3CDateTime">
          <xsl:with-param name="date" select="last_updated"/>
        </xsl:call-template>
      </dc:date>
      
      <dcterms:modified>
        <xsl:call-template name="FixW3CDateTime">
          <xsl:with-param name="date" select="last_updated"/>
        </xsl:call-template>
      </dcterms:modified>
      
      <xsl:if test="normalize-space(activity_category)">
        <category><xsl:value-of select="activity_category"/></category>
        <g:tag><xsl:value-of select="activity_category"/></g:tag>
      </xsl:if>
      <xsl:if test="normalize-space(activity_category2) and activity_category2 != activity_category">
        <g:tag><xsl:value-of select="activity_category2"/></g:tag>
      </xsl:if>
      <xsl:if test="normalize-space(committee) and committee != activity_category2 and committee != activity_category">
        <g:tag><xsl:value-of select="activity_category2"/></g:tag>
      </xsl:if>
      
      <g:location>
        <xsl:if test="normalize-space(trip_location)">
          <xsl:value-of select="trip_location"/>, 
        </xsl:if>
        <xsl:if test="normalize-space(trip_state)">
          <xsl:value-of select="trip_state"/>, 
        </xsl:if>
        <xsl:value-of select="trip_country"/>
      </g:location>
    
   <!--title>Google's 2005 Halloween Fright Fest</title>
   <description>Come face to face with your most horrific fears. This year's Halloween fest will be sure to scare your socks off, complete with a real haunted Googleplex, decomposed BBQ roadkill, and vials of beetlejuice.</description>
   <link>http://provider-website.com/item1-info-page.html</link>
   <g:image_link>http://www.providers-website.com/image1.jpg</g:image_link>
   <guid>1028</guid>
   <g:expiration_date>2005-12-20</g:expiration_date>
   <g:label>Festival</g:label>
   <g:label>Halloween</g:label>
   <g:label>Party</g:label>
   <g:label>Costumes</g:label>
   
   <g:currency>USD</g:currency>
   <g:price>10</g:price>
   <g:price_type>starting</g:price_type>
   <g:payment_accepted>Cash</g:payment_accepted>
   <g:payment_accepted>Check</g:payment_accepted>
   <g:payment_accepted>Visa</g:payment_accepted>
   <g:payment_notes>Cash only for local orders</g:payment_notes>
   <g:event_date_range>
   	<g:start>2005-07-04T20:00:00</g:start>
     	<g:end>2005-07-04T23:00:00</g:end>
   </g:event_date_range>
   <g:location>1600 Amphitheatre Parkway, Mountain View, CA, 94043</g:location-->
   
   
    </item>
    
	</xsl:template>
  
  <xsl:template name="RSSHTMLEscape">
    <!-- double-encoding of HTML in RSS, required by standard (or practice, in the case of title elem) -->
    <xsl:param name="text"/>
    
    <xsl:call-template name="my-replace-string">
      <xsl:with-param name="text">
        <xsl:call-template name="my-replace-string">
          <xsl:with-param name="text" select="$text"/>
          <xsl:with-param name="from" select="'&amp;'"/>
          <xsl:with-param name="to" select="'&amp;amp;'"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="from" select="'&lt;'"/>
      <xsl:with-param name="to" select="'&amp;lt;'"/>
    </xsl:call-template>
        
        <!-- trying to simulate
        replace-string(replace-string($text, '&amp;', '&amp;amp;'), '&lt;', '&amp;lt;') -->
        
  </xsl:template>
  
  <xsl:template name="my-replace-string">
    <xsl:param name="from"/>
    <xsl:param name="to"/>
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text,$from)">
        <xsl:value-of select="substring-before($text,$from)"/>
        <xsl:value-of select="$to"/>
        <xsl:call-template name="my-replace-string">
          <xsl:with-param name="text" select="substring-after($text,$from)"/>
          <xsl:with-param name="from" select="$from"/>
          <xsl:with-param name="to" select="$to"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="FixW3CDate">
    <!-- make a W3C date string YYYY-MM-DD out of a longer string 
    (which may have included the time) -->
    <xsl:param name="date"/>
 
    <xsl:value-of select="substring($date,1,10)"/>
  </xsl:template>
   
  <xsl:template name="FixW3CDateTime">
    <!-- make a W3C datetime 2001-01-01T13:01:01 out of a string
    that may be missing the T between the date and the time -->
    <xsl:param name="date"/>
 
    <xsl:value-of select="substring($date,1,10)"/>
    <xsl:text>T</xsl:text>
    <xsl:value-of select="substring($date,12,8)"/>
  </xsl:template>
   
</xsl:stylesheet>

<!-- 
Local Variables:
coding: utf-8;
End:
 -->