<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date">

  <xsl:import href="functions/day-abbreviation/date.day-abbreviation.template.xsl"/>
  <xsl:import href="functions/month-abbreviation/date.month-abbreviation.template.xsl"/>
  <xsl:import href="functions/day-in-month/date.day-in-month.template.xsl"/>
  <xsl:import href="trip-rating.inc.xsl"/>
  <!--xsl:output encoding="UTF-8" indent="yes" method="html"/-->

  <xsl:template match="listing">

    <div class="navOnly">
    <img class="pulloutPhoto" width="240" height="180"
    src="images/trip-list-photo.jpg" alt="Photo from an AMC trip" />
    <!--ul class="contents">
      <xsl:for-each select="trips">
        <li><a href="#{@link}"><xsl:value-of select="@id" /></a></li>
      </xsl:for-each>
    </ul-->
    </div>
    
    <h2><a name="how_to"></a>How To Sign Up</h2>
    <xsl:apply-templates select="webheader" />

    
    <h2><a name="contents"></a>At a Glance</h2>
    <table class="contents" border="0" cellpadding="0" cellspacing="0">
      <xsl:for-each select="trips">
        <tr class="section">
          <td colspan="2"><a href="#{@link}"><xsl:value-of select="@id"/><span class="navOnly"> &#8595;</span></a></td>
        </tr>
        <xsl:if test="not(trip)">
          <tr class="emptySection">
            <td colspan="2">See below for details.</td>
          </tr>
        </xsl:if>
        <xsl:for-each select="trip">
          <tr>
            <td class="date"><xsl:value-of select="date"/></td>
            <td class="title">
              <a href="#{generate-id()}"><xsl:value-of select="title"/><span class="navOnly"> &#8595;</span></a>
            
              <xsl:if test="rating"><xsl:text> </xsl:text><xsl:apply-templates select="rating"/></xsl:if>
              
              <xsl:if test="@new"><xsl:text> </xsl:text><span class="tagNew">New</span></xsl:if>
              <xsl:if test="@full"><xsl:text> </xsl:text><span class="tagFull">Full</span></xsl:if>
              <xsl:if test="@wait"><xsl:text> </xsl:text><span class="tagWaitlist">Waitlist</span></xsl:if>
            </td>
          </tr>
        </xsl:for-each>
      </xsl:for-each>
    </table>
    
    <xsl:for-each select="trips">
    <h2><a name="{@link}"></a><xsl:value-of select="@id"/></h2>
    <xsl:if test="@link='Hiking'">
    <xsl:call-template name="hike-rating-key"/>
    
    </xsl:if>
    
    <xsl:for-each select="trip">
      <div class="trip">
        <a name="{generate-id()}"></a>
        <span class="date"><xsl:value-of select="date"/></span>
        <xsl:text> </xsl:text>
        <span class="title"><xsl:value-of select="title"/></span>
        
        <xsl:if test="rating">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="rating" />
        </xsl:if>
        
        <xsl:if test="@new"><xsl:text> </xsl:text><span class="tagNew">New</span></xsl:if>
        <xsl:if test="@full"><xsl:text> </xsl:text><span class="tagFull">Full</span></xsl:if>
        <xsl:if test="@wait"><xsl:text> </xsl:text><span class="tagWaitlist">Waitlist</span></xsl:if>
        <div class="desc"><xsl:apply-templates select="desc"/></div>
      </div>
    </xsl:for-each>
    <!--div style="text-align: right"><a href="#top">Top Of Page</a></div-->
    <xsl:for-each select="p">
      <xsl:copy>
      <xsl:apply-templates select="*|@*|text()"/>
      </xsl:copy>
    </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  
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
              <a href="{concat('#trip', trip_id)}"><xsl:value-of select="$title"/><span class="navOnly"> &#8595;</span></a>
            
              <xsl:if test="normalize-space($rating)"><xsl:text> </xsl:text><xsl:call-template name="rating"><xsl:with-param name="rating" select="$rating"/></xsl:call-template></xsl:if>
              
              <xsl:if test="@new"><xsl:text> </xsl:text><span class="tagNew">New</span></xsl:if>
              <xsl:if test="@full or status = 'Full'"><xsl:text> </xsl:text><span class="tagFull">Full</span></xsl:if>
              <xsl:if test="@wait or status = 'Waitlist'"><xsl:text> </xsl:text><span class="tagWaitlist">Waitlist</span></xsl:if>
              <xsl:if test="@cancel or status = 'Cancelled' or status = 'Canceled'"><xsl:text> </xsl:text><span class="tagCancel">Cancelled</span></xsl:if>
            </td>
          </tr>
  </xsl:template>
  
  <!--xsl:if test="$byDate = 1"-->
    <xsl:key name="trips-by-category" match="*" use="activity_category"/>
  <!--/xsl:if-->
  
  <xsl:template match="trips">
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
                  <xsl:value-of select="activity_category"/><span class="navOnly"> &#8595;</span>
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
    <div class="trip">
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
      <span class="title"><xsl:value-of select="$title"/></span>
      
      <xsl:if test="normalize-space($rating)">
        <xsl:text> </xsl:text>
        <xsl:call-template name="rating">
          <xsl:with-param name="rating" select="normalize-space($rating)"/>
        </xsl:call-template>
      </xsl:if>
      
      <xsl:if test="@new"><xsl:text> </xsl:text><span class="tagNew">New</span></xsl:if>
      <xsl:if test="@full or status = 'Full'"><xsl:text> </xsl:text><span class="tagFull">Full</span></xsl:if>
      <xsl:if test="@wait or status = 'Waitlist'"><xsl:text> </xsl:text><span class="tagWaitlist">Waitlist</span></xsl:if>
      <xsl:if test="@cancel or status = 'Cancelled' or status = 'Canceled'"><xsl:text> </xsl:text><span class="tagCancel">Cancelled</span></xsl:if>
      <div class="desc"><xsl:apply-templates select="web_desc"/>

        <br />
        <xsl:if test="registration_required = 'Yes' and not(normalize-space(registrar)) and not(normalize-space(external_link))">Reg. req&#8217;d. </xsl:if>
        <xsl:if test="normalize-space(external_link)">
        
          <xsl:choose>
            <xsl:when test="registration_required = 'Yes' and not(normalize-space(registrar))"> Reg. at </xsl:when>
            <xsl:otherwise> See </xsl:otherwise>
          </xsl:choose>
          <a href="{external_link}"><xsl:value-of select="external_link"/></a>.<xsl:text> </xsl:text>
        </xsl:if>
        
        <xsl:variable name="regOverridesCL1" select="normalize-space(registrar) and registrar = coleader1 and (not(normalize-space(coleader1_phone)) or registrar_phone = coleader1_phone) and (not(normalize-space(coleader1_email)) or registrar_email = coleader1_email)"/>
        <xsl:variable name="regOverridesL1" select="not($regOverridesCL1) and normalize-space(registrar) and registrar = leader1 and (not(normalize-space(leader1_phone)) or registrar_phone = leader1_phone) and (not(normalize-space(leader1_email)) or registrar_email = leader1_email)"/>
        
        <xsl:if test="normalize-space(registrar)">
          <xsl:text> Reg. with </xsl:text>
          <xsl:if test="$regOverridesCL1"> CL </xsl:if>
          <xsl:if test="$regOverridesL1"> L </xsl:if>
          <xsl:call-template name="joyst-leader">
            <xsl:with-param name="prefixDelim"/>
            <xsl:with-param name="nodeName">registrar</xsl:with-param>
          </xsl:call-template>
          <xsl:text>. </xsl:text>
        </xsl:if>
                
        <xsl:if test="(normalize-space(leader1) and not($regOverridesL1)) or normalize-space(concat(leader2,leader3,leader4))">
         <span class="leaders">
          <xsl:text>L </xsl:text>
          <xsl:if test="not($regOverridesL1)">
            <xsl:call-template name="joyst-leader">
              <xsl:with-param name="isFirst">1</xsl:with-param>
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
              <xsl:with-param name="isFirst">1</xsl:with-param>
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
  </xsl:template>

  <xsl:template name="joyst-leader">
    <xsl:param name="nodeName">leader1</xsl:param>
    <xsl:param name="isFirst">0</xsl:param>
    
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
  </xsl:template>

  <xsl:template name="date-range">
    <xsl:param name="start_date"/>
    <xsl:param name="end_date"/>
    
    <!-- ISO 8601 date manipulation depends on EXSLT -
    see http://www.xml.com/pub/a/2005/01/05/tr-xml.html -->

    <xsl:choose>
      <xsl:when test="function-available('date:day-abbreviation')">
        <!-- EXSLT implementation -->
        <!--testttt
            <xsl:value-of select="trip_start_date"/>
            <xsl:value-of select="substring($start_date, 1, 10)"/>
        --><xsl:choose>
          <xsl:when test="$start_date = $end_date">
            <xsl:value-of select="date:day-abbreviation(substring($start_date, 1, 10))"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="date:month-abbreviation(substring($start_date, 1, 10))"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="date:day-in-month(substring($start_date, 1, 10))"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="date:day-abbreviation(substring($start_date, 1, 10))"/>–<xsl:value-of
              select="date:day-abbreviation(substring($end_date, 1, 10))"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="date:month-abbreviation(substring($start_date, 1, 10))"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="date:day-in-month(substring($start_date, 1, 10))"/>–<xsl:if
              test="date:month-abbreviation(substring($start_date, 1, 10)) != date:month-abbreviation(substring($end_date, 1, 10))">
              <xsl:value-of select="date:month-abbreviation(substring(substring($end_date, 1, 10), 1, 10))"/>
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="date:day-in-month(substring($end_date, 1, 10))"/>
          </xsl:otherwise>
        </xsl:choose>
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