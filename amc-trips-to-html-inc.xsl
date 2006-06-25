<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date">

  <xsl:import href="functions/day-abbreviation/date.day-abbreviation.template.xsl"/>
  <xsl:import href="functions/month-abbreviation/date.month-abbreviation.template.xsl"/>
  <xsl:import href="functions/day-in-month/date.day-in-month.template.xsl"/>
  <xsl:import href="functions/date/date.add.template.xsl"/>
  <xsl:import href="trip-rating.inc.xsl"/>
  <!--xsl:output encoding="UTF-8" indent="yes" method="html"/-->
    
  <!-- URL for trip listings page; leave as the empty string to generate
  internal links to the trip anchors -->
  <xsl:param name="listingsURL" select="''"></xsl:param>
  
  <!-- Show "Updated" tag if the trip has been updated with the last n days
  (updateHorizonDays param). Show "Cancel" tag for n days after a trip has
  been cancelled (cancelHorizonDays param), but hide the trip entirely after that,
  so the listing doesn't stay polluted with cancelled trips, esp. since trips
  have often been cancelled just in order to be replaced with a new trip on the
  same day).
  -->
  
  <xsl:param name="updateHorizonDays" select="14"/>
  <xsl:param name="cancelHorizonDays" select="7"/>
  <xsl:param name="showHikeRatingKey" select="1"/>
  
  <!-- Compute numeric updateHorizon and cancelHorizon in YYYYMMDD format
  based on updateHorizonDays, cancelHorizonDays, and the current date.
  Use purely numeric YYYYMMDD format because XSLT 1.0 only allows numeric
  less/greater comparisons. -->
  <xsl:variable name="updateHorizon">
    <xsl:call-template name="date:add">
      <xsl:with-param name="date-time" select="date:date-time()"/>
      <xsl:with-param name="duration" select="concat('-P',$updateHorizonDays,'D')"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="updateHorizonNumeric" select="translate(substring($updateHorizon, 1, 10),'-','')"/>
  <xsl:variable name="cancelHorizon">
    <xsl:call-template name="date:add">
      <xsl:with-param name="date-time" select="date:date-time()"/>
      <xsl:with-param name="duration" select="concat('-P',$cancelHorizonDays,'D')"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="cancelHorizonNumeric" select="translate(substring($cancelHorizon, 1, 10),'-','')"/>
  
  <xsl:template match="a">
    <!-- antispam email obfuscation for mailto: links -->
    <xsl:choose>
      <xsl:when test="@href and starts-with(@href, 'mailto:')">
      <a>
      <xsl:attribute name="href">
        <xsl:value-of select="substring-before(@href, '@')"/>
        <xsl:text>REMOVE_123_THIS@ANTI_S.pam-</xsl:text>
        <xsl:value-of select="substring-after(@href, '@')"/>
      </xsl:attribute>
      <xsl:value-of select="substring(., 1, 1)"/>
      <span style="display: none">.REMOVE.NEXT.WORD.poodle</span>
      <xsl:value-of select="substring-before(substring(., 2), '@')"/>
      <xsl:text> at </xsl:text>
      <span style="display: none">remove6XJ29.this.text</span>
      <xsl:value-of select="substring-after(., '@')"/>
      </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="obfuscatedEmailLink">
    <xsl:param name="address"/>
    <a>
    <xsl:attribute name="href">
      <xsl:value-of select="substring-before($address, '@')"/>
      <xsl:text>REMOVE_123_THIS@ANTI_S.pam-</xsl:text>
      <xsl:value-of select="substring-after($address, '@')"/>
    </xsl:attribute>
    <xsl:value-of select="substring($address, 1, 1)"/>
    <span style="display: none">.REMOVE.NEXT.WORD.poodle</span>
    <xsl:value-of select="substring-before(substring($address, 2), '@')"/>
    <xsl:text> at </xsl:text>
    <span style="display: none">remove6XJ29.this.text</span>
    <xsl:value-of select="substring-after($address, '@')"/>
    </a>
  </xsl:template>
  
  <xsl:template match="p|small|b|strong|i|em|span|div|br">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()" />
    </xsl:copy>
  </xsl:template>

  <!-- Joy St. trip listing format -->
  
  <xsl:template name="trip-summary-row">
      <xsl:param name="showInternalNav" select="1"/>
      <xsl:variable name="lastUpdatedNumeric" select="translate(substring(last_updated, 1, 10),'-','')"/>
      <!-- above line translates date (in standard YYYY-MM-DDTHH:MM:SS... format)
      to purely numeric YYYYMMDD format, because XSLT allows only numeric comparisons -->
      <xsl:if test="(status != 'Cancelled' and status != 'Canceled') or $lastUpdatedNumeric &gt;= $cancelHorizonNumeric">
          <tr>
            <td class="date"><xsl:call-template name="date-range">
              <xsl:with-param name="start_date"><xsl:value-of select="trip_start_date"/></xsl:with-param>
              <xsl:with-param name="end_date"><xsl:value-of select="trip_end_date"/></xsl:with-param>
              </xsl:call-template></td>
            <td class="title">
              <xsl:variable name="rating">
                <xsl:call-template name="extract-hike-rating">
                  <xsl:with-param name="title" select="trip_title"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:variable name="title">
                <xsl:call-template name="strip-hike-rating-from-title">
                  <xsl:with-param name="title" select="trip_title"/>
                  <xsl:with-param name="rating" select="$rating"/>
                </xsl:call-template>
              </xsl:variable>
              <a href="{concat($listingsURL, '#trip', trip_id)}"><xsl:value-of
              select="$title"/><xsl:if test="$showInternalNav = 1"><span class="navOnly"> &#8595;</span></xsl:if></a>
              
              
              <xsl:if test="normalize-space($rating)"><xsl:text> </xsl:text><xsl:call-template name="rating"><xsl:with-param name="rating" select="$rating"/></xsl:call-template></xsl:if>
              <xsl:choose>
                <xsl:when test="@cancel or status = 'Cancelled' or status = 'Canceled'">
                  <xsl:text> </xsl:text><span class="tagCancel">Cancelled</span>
                </xsl:when>
                <xsl:when test="@full or status = 'Full'">
                  <xsl:text> </xsl:text><span class="tagFull">Full</span>
                </xsl:when>
                <xsl:when test="@wait or status = 'Waitlist' or status = 'Wait Listed'">
                  <xsl:text> </xsl:text><span class="tagWaitlist">Waitlist</span>
                </xsl:when>
                <xsl:when test="@new">
                  <xsl:text> </xsl:text><span class="tagNew">New</span>
                </xsl:when>
                <xsl:when test="$lastUpdatedNumeric &gt;= $updateHorizonNumeric">
                  <xsl:text> </xsl:text><span class="tagNew">Updated</span>
                </xsl:when>
              </xsl:choose>
            </td>
          </tr>
      </xsl:if>
  </xsl:template>
  
  <!--xsl:if test="$byDate = 1"-->
    <xsl:key name="trips-by-category" match="*" use="activity_category"/>
  <!--/xsl:if-->
  
  <xsl:template match="trips">
    <xsl:param name="showInternalNav" select="1"/>
    <h2><a name="contents"></a>At a Glance</h2>
    <table class="contents" border="0" cellpadding="0" cellspacing="0">
      <xsl:if test="1 = 1 or $byDate = 1">
        <tr class="section">
          <td colspan="2">All Events by Date</td>
        </tr>
        <xsl:for-each select="*">
          <xsl:sort select="trip_start_date"/>
          <xsl:call-template name="trip-summary-row"/>
        </xsl:for-each>
      </xsl:if>
      
      <xsl:if test="1 = 1 or $byDate != 1">
        <!-- Muenchian method for grouping by activity_category -->
        <xsl:for-each select="*[count(. | key('trips-by-category', activity_category)[1]) = 1]">
          <xsl:sort select="activity_category"/>
          <tr class="section">
            <td colspan="2">
              <xsl:if test="$byDate != 1">
                <a href="#{substring(activity_category, 1, 5)}">
                  <xsl:value-of select="activity_category"/><xsl:if
                  test="$showInternalNav = 1"><span class="navOnly"> &#8595;</span></xsl:if>
                </a>
              </xsl:if>
              <xsl:if test="$byDate = 1">
                <xsl:value-of select="activity_category"/>
              </xsl:if>
            </td>
          </tr>
          <!--xsl:if test="not(*)">
            <tr class="emptySection">
              <td colspan="2">See below for details.</td>
            </tr>
          </xsl:if-->
          <xsl:for-each select="key('trips-by-category', activity_category)">
            <xsl:call-template name="trip-summary-row"/>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:if>
    </table>
    
    <xsl:if test="$byDate = 1">
      <xsl:call-template name="hike-rating-key"/>
      <xsl:for-each select="*">
        <xsl:sort select="trip_start_date"/>
        <xsl:call-template name="joyst-trip"/>
      </xsl:for-each>
    </xsl:if>
    
    <xsl:if test="$byDate != 1">
      <!-- Muenchian method for grouping by activity_category -->
      <xsl:for-each select="*[count(. | key('trips-by-category', activity_category)[1]) = 1]">
        <xsl:sort select="activity_category"/>
        <h2><a name="{substring(activity_category, 1, 5)}"></a><xsl:value-of select="activity_category" /></h2>
        <xsl:if test="activity_category = 'Hiking'"><xsl:call-template name="hike-rating-key"/></xsl:if>
        <xsl:for-each select="key('trips-by-category', activity_category)">
            <xsl:call-template name="joyst-trip"/>
            <!--xxsl:sort select="trip_start_date" /-->
        </xsl:for-each>
      </xsl:for-each>
      <!--div style="text-align: right"><a href="#top">Top Of Page</a></div-->
    </xsl:if>
    
    <xsl:for-each select="p">
      <xsl:copy>
        <xsl:apply-templates select="*|@*|text()"/>
      </xsl:copy>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="joyst-trip">
      <xsl:variable name="lastUpdatedNumeric" select="translate(substring(last_updated, 1, 10),'-','')"/>
      <xsl:variable name="creationDateNumeric" select="translate(substring(creation_date, 1, 10),'-','')"/>
      <!-- above line translates date (in standard YYYY-MM-DDTHH:MM:SS... format)
      to purely numeric YYYYMMDD format, because XSLT allows only numeric comparisons -->
    <xsl:if test="(status != 'Canceled' and status != 'Cancelled') or $lastUpdatedNumeric &gt;= $cancelHorizonNumeric">
    <div class="trip vevent">
      <a><xsl:attribute name="name">trip<xsl:value-of select="trip_id"/></xsl:attribute></a>
<!--div class="sponsor"><xsl:value-of select="committee"/></div-->
      <span class="date">
      
        <xsl:call-template name="date-range">
          <xsl:with-param name="start_date"><xsl:value-of select="trip_start_date"/></xsl:with-param>
          <xsl:with-param name="end_date"><xsl:value-of select="trip_end_date"/></xsl:with-param>
        </xsl:call-template>
      </span>
      <xsl:text> </xsl:text>
      
      <!-- parse trip rating from end of title if one appears to be present
      (3 or 4 chars in parens at end of title). Store in $rating -->
      <xsl:variable name="rating">
        <xsl:if test="substring(trip_title, string-length(trip_title)) = ')' and
          substring(trip_title, string-length(trip_title)-5, 2) = ' ('">
          <!-- 3-char rating -->
          <xsl:value-of select="substring(trip_title, string-length(trip_title)-3, 3)"/>
        </xsl:if>
        <xsl:if test="substring(trip_title, string-length(trip_title)) = ')' and
          substring(trip_title, string-length(trip_title)-6, 4) = ' (AA'">
          <!-- 4-char rating, must start with AA -->
          <xsl:value-of select="substring(trip_title, string-length(trip_title)-4, 4)"/>
        </xsl:if>
      </xsl:variable>
      <xsl:variable name="title">
        <!-- if we retreived a $rating, truncate trip_title correspondingly; store in $title -->
        <xsl:if test="normalize-space($rating)">
          <xsl:value-of select="substring(trip_title, 0, string-length(trip_title) - string-length(normalize-space($rating)) - 2)"/>
        </xsl:if>
        <xsl:if test="not(normalize-space($rating))">
          <!-- didn't get a rating; pass through trip_title unmodified -->
          <xsl:value-of select="trip_title"/>
        </xsl:if>
      </xsl:variable>
      <span class="title summary"><xsl:value-of select="$title"/></span>
      
      <xsl:if test="normalize-space($rating)">
        <xsl:text> </xsl:text>
        <xsl:call-template name="rating">
          <xsl:with-param name="rating" select="normalize-space($rating)"/>
        </xsl:call-template>
      </xsl:if>
      
      <xsl:choose>
        <xsl:when test="@cancel or status = 'Cancelled' or status = 'Canceled'">
          <xsl:text> </xsl:text><span class="tagCancel">Cancelled</span>
        </xsl:when>
        <xsl:when test="@full or status = 'Full'">
          <xsl:text> </xsl:text><span class="tagFull">Full</span>
        </xsl:when>
        <xsl:when test="@wait or status = 'Waitlist' or status = 'Wait Listed'">
          <xsl:text> </xsl:text><span class="tagWaitlist">Waitlist</span>
        </xsl:when>
        <xsl:when test="@new or $creationDateNumeric &gt;= $updateHorizonNumeric">
          <xsl:text> </xsl:text><span class="tagNew">New</span>
        </xsl:when>
        <xsl:when test="$lastUpdatedNumeric &gt;= $updateHorizonNumeric">
          <xsl:text> </xsl:text><span class="tagNew">Updated</span>
        </xsl:when>
      </xsl:choose>
      <div class="desc description"><xsl:apply-templates select="web_desc"/>

        <br />
        <xsl:if test="registration_required = 'Yes' and not(normalize-space(registrar)) and not(normalize-space(external_link))">Reg. req&#8217;d. </xsl:if>
        <xsl:if test="normalize-space(external_link)">
        
          <xsl:choose>
            <xsl:when test="registration_required = 'Yes' and not(normalize-space(registrar))"> Reg. at </xsl:when>
            <xsl:otherwise> See </xsl:otherwise>
          </xsl:choose>
          <a class="url" href="{external_link}"><xsl:value-of select="external_link"/></a>.<xsl:text> </xsl:text>
        </xsl:if>
        
        <xsl:variable name="regOverridesCL1" select="normalize-space(registrar) and registrar = coleader1 and (not(normalize-space(coleader1_phone)) or registrar_phone = coleader1_phone) and (not(normalize-space(coleader1_email)) or registrar_email = coleader1_email)"/>
        <xsl:variable name="regOverridesL1" select="not($regOverridesCL1) and normalize-space(registrar) and registrar = leader1 and (not(normalize-space(leader1_phone)) or registrar_phone = leader1_phone) and (not(normalize-space(leader1_email)) or registrar_email = leader1_email)"/>
        
        <xsl:if test="normalize-space(registrar)">
          <xsl:text> Reg. with </xsl:text>
          <xsl:if test="$regOverridesCL1"> CL </xsl:if>
          <xsl:if test="$regOverridesL1"> L </xsl:if>
          <xsl:call-template name="joyst-leader">
            <xsl:with-param name="isFirst" select="1"/>
            <xsl:with-param name="nodeName">registrar</xsl:with-param>
          </xsl:call-template>
          <xsl:text>. </xsl:text>
        </xsl:if>
                
        <xsl:if test="(normalize-space(leader1) and not($regOverridesL1)) or normalize-space(concat(leader2,leader3,leader4))">
         <span class="leaders">
          <xsl:text>L </xsl:text>
          <xsl:if test="not($regOverridesL1)">
            <xsl:call-template name="joyst-leader">
              <xsl:with-param name="isFirst" select="1"/>
              <xsl:with-param name="nodeName">leader1</xsl:with-param>
            </xsl:call-template>
          </xsl:if>
          <xsl:call-template name="joyst-leader">
            <xsl:with-param name="isFirst" select="$regOverridesL1"/>
            <xsl:with-param name="nodeName">leader2</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="joyst-leader">
            <xsl:with-param name="nodeName">leader3</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="joyst-leader">
            <xsl:with-param name="nodeName">leader4</xsl:with-param>
          </xsl:call-template>. </span>
        </xsl:if>
        
        
        <xsl:if test="(normalize-space(coleader1) and not($regOverridesCL1)) or normalize-space(concat(coleader2,coleader3,coleader4))">
          <span class="leaders">
          <xsl:text>CL </xsl:text>
          <xsl:if test="not($regOverridesCL1)">
            <xsl:call-template name="joyst-leader">
              <xsl:with-param name="isFirst" select="1"/>
              <xsl:with-param name="nodeName">coleader1</xsl:with-param>
            </xsl:call-template>
          </xsl:if>
          <xsl:call-template name="joyst-leader">
            <xsl:with-param name="isFirst" select="$regOverridesCL1"/>
            <xsl:with-param name="nodeName">coleader2</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="joyst-leader">
            <xsl:with-param name="nodeName">coleader3</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="joyst-leader">
            <xsl:with-param name="nodeName">coleader4</xsl:with-param>
          </xsl:call-template>.</span>
        </xsl:if>
        
      </div>
      
    </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="joyst-leader">
    <xsl:param name="nodeName" select="'leader1'"/>
    <xsl:param name="isFirst" select="0"/>
    
    <xsl:if test="normalize-space(*[name()=$nodeName])">
      <xsl:if test="not($isFirst)">, </xsl:if>
      <!--xsl:if test="$isRegistrar">Reg. with </xsl:if-->
      <xsl:value-of select="*[name()=$nodeName]"/>
      <xsl:variable name="email" select="*[name()=concat($nodeName,'_email')]"/>
      <xsl:if test="normalize-space($email)"><xsl:text> </xsl:text>
        <xsl:call-template name="obfuscatedEmailLink"><xsl:with-param name="address">mailto:<xsl:value-of select="$email"/></xsl:with-param></xsl:call-template>
      </xsl:if>
      <xsl:variable name="phone" select="*[name()=concat($nodeName,'_phone')]"/>
      <xsl:if test="normalize-space($phone)"><xsl:text> </xsl:text>
        <xsl:value-of select="$phone"/>
        <xsl:if test="normalize-space(*[name()=concat($nodeName, '_call_time')])"><xsl:text> </xsl:text>
          <xsl:value-of select="*[name()=concat($nodeName, '_call_time')]"/>
        </xsl:if>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="hike-rating-key">
    <xsl:if test="$showHikeRatingKey > 0">
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
        <!--tr>
          <th>Mileage</th>
          <th>Pace</th>
          <th>Terrain</th>
        </tr-->
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
          <div class="navOnly">
          To get an English translation for any blue trip rating, move your
          mouse over it and either hover there for a second or click.</div>
          </td>
        </tr>
      </tbody></table>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="date-range">
    <xsl:param name="start_date"/>
    <xsl:param name="end_date"/>
    <xsl:variable name="start_date_w3c" select="substring($start_date, 1, 10)"/>
    <xsl:variable name="end_date_w3c" select="substring($end_date, 1, 10)"/>
    
    <!-- ISO 8601 date manipulation depends on EXSLT -
    see http://www.xml.com/pub/a/2005/01/05/tr-xml.html -->

    <xsl:choose>
      <xsl:when test="function-available('date:day-abbreviation')">
        <!-- EXSLT implementation -->
        <!-- output days of week (such as "Mon" or "Fri–Sun") -->
        <xsl:value-of select="date:day-abbreviation($start_date_w3c)"/>
        <xsl:if test="$start_date_w3c != $end_date_w3c">
          <xsl:text>–</xsl:text>
          <xsl:value-of select="date:day-abbreviation($end_date_w3c)"/>
        </xsl:if>
        <xsl:text> </xsl:text>
        <!-- output start date, such as "Jan 1" -->
        <!-- use enclosing abbr for hCalendar microformat -->
        <abbr class="dtstart" title="{$start_date_w3c}">
          <xsl:value-of select="date:month-abbreviation($start_date_w3c)"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="date:day-in-month($start_date_w3c)"/>
        </abbr>
        <!-- output dash, if multi-day -->
        <xsl:if test="$start_date_w3c != $end_date_w3c">–</xsl:if>
        <!-- output end date, such as the "Feb 2" in "Jan 30–Feb 2", or the "3" in "Jan 1–3" -->
        <!-- abbr will display visible content for multi-day events only -->
        <abbr class="dtend" title="{date:add($end_date_w3c, 'P1D')}">
          <xsl:if test="$start_date_w3c != $end_date_w3c">
            <xsl:if test="date:month-abbreviation($start_date_w3c) != date:month-abbreviation($end_date_w3c)">
              <xsl:value-of select="date:month-abbreviation($end_date_w3c)"/>
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="date:day-in-month($end_date_w3c)"/>
          </xsl:if>
        </abbr>
      </xsl:when>
      <xsl:otherwise>
        <!-- date EXST functions not available -->
        <xsl:choose>
          <xsl:when test="$start_date = $end_date">
            <xsl:call-template name="date:day-abbreviation">
              <xsl:with-param name="date-time" select="substring($start_date, 1, 10)"/>
            </xsl:call-template>
            <xsl:text> </xsl:text>
            <xsl:call-template name="date:month-abbreviation">
              <xsl:with-param name="date-time" select="substring($start_date, 1, 10)"/>
            </xsl:call-template>
            <xsl:text> </xsl:text>
            <xsl:call-template name="date:day-in-month">
              <xsl:with-param name="date-time" select="substring($start_date, 1, 10)"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="date:day-abbreviation">
              <xsl:with-param name="date-time" select="substring($start_date, 1, 10)"/>
            </xsl:call-template>–<xsl:call-template name="date:day-abbreviation">
              <xsl:with-param name="date-time" select="substring($end_date, 1, 10)"/>
            </xsl:call-template>
            <xsl:text> </xsl:text>
            <xsl:call-template name="date:month-abbreviation">
              <xsl:with-param name="date-time" select="substring($start_date, 1, 10)"/>
            </xsl:call-template>
            <xsl:text> </xsl:text>
            <xsl:call-template name="date:day-in-month">
              <xsl:with-param name="date-time" select="substring($start_date, 1, 10)"/>
            </xsl:call-template><!-- –<xsl:if
              test="date:month-abbreviation($start_date) != date:month-abbreviation(substring($end_date, 1, 10))">
              <xsl:value-of select="date:month-abbreviation(substring($end_date, 1, 10))"/> 
              <xsl:text> </xsl:text>
            </xsl:if>-->
            <xsl:value-of select="date:day-in-month(substring($end_date, 1, 10))"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="extract-hike-rating">
    <xsl:param name="title"/>
    
    <!-- parse trip rating from end of title if one appears to be present
    (3 or 4 chars in parens at end of title). Store in $rating -->
    <xsl:if test="substring(trip_title, string-length(trip_title)) = ')' and
      substring(trip_title, string-length(trip_title)-5, 2) = ' ('">
      <!-- 3-char rating -->
      <xsl:value-of select="substring(trip_title, string-length(trip_title)-3, 3)"/>
    </xsl:if>
    <xsl:if test="substring(trip_title, string-length(trip_title)) = ')' and
      substring(trip_title, string-length(trip_title)-6, 4) = ' (AA'">
      <!-- 4-char rating, must start with AA -->
      <xsl:value-of select="substring(trip_title, string-length(trip_title)-4, 4)"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="strip-hike-rating-from-title">
    <xsl:param name="title"/>
    <xsl:param name="rating"/>
    
    <!-- if we retreived a $rating, truncate trip_title correspondingly; store in $title -->
    <xsl:if test="normalize-space($rating)">
      <xsl:value-of select="substring(trip_title, 0, string-length(trip_title) - string-length(normalize-space($rating)) - 2)"/>
    </xsl:if>
    <xsl:if test="not(normalize-space($rating))">
      <!-- didn't get a rating; pass through trip_title unmodified -->
      <xsl:value-of select="trip_title"/>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>

<!-- 
Local Variables:
coding: utf-8;
End:
 -->