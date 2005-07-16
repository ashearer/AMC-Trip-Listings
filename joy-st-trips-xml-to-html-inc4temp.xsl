<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date">


  <xsl:import href="functions/day-abbreviation/date.day-abbreviation.template.xsl"/>
  
  
  <xsl:import href="functions/month-abbreviation/date.month-abbreviation.template.xsl"/>
  
  <xsl:import href="functions/day-in-month/date.day-in-month.template.xsl"/>


  <xsl:output encoding="UTF-8" indent="yes" method="html"/>

  <xsl:template match="rating">
    <span class="rating" onclick="window.alert('{.}: ' + this.title + '.')"><xsl:attribute name="title">
      <xsl:choose>
        <xsl:when test="starts-with(., 'AA')">13+ miles, </xsl:when>
        <xsl:when test="starts-with(., 'A')">9-13 miles, </xsl:when>
        <xsl:when test="starts-with(., 'B')">5-9 miles, </xsl:when>
        <xsl:when test="starts-with(., 'C')">under 5 miles, </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="substring(., string-length(.)-1, 1) = '1'">very fast 2.5+ mph, </xsl:when>
        <xsl:when test="substring(., string-length(.)-1, 1) = '2'">fast 2-2.5 mph, </xsl:when>
        <xsl:when test="substring(., string-length(.)-1, 1) = '3'">moderate 1.5-2 mph, </xsl:when>
        <xsl:when test="substring(., string-length(.)-1, 1) = '4'">leisurely 1.5 mph, </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="substring(., string-length(.), 1) = 'A'">very strenuous terrain</xsl:when>
        <xsl:when test="substring(., string-length(.), 1) = 'B'">strenuous terrain</xsl:when>
        <xsl:when test="substring(., string-length(.), 1) = 'C'">average terrain</xsl:when>
        <xsl:when test="substring(., string-length(.), 1) = 'D'">easy terrain</xsl:when>
      </xsl:choose>
    </xsl:attribute>(<span class="inner"><xsl:value-of select="."/></span>)</span>
  </xsl:template>

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
        <div style="navOnly">
        To get an English translation for any blue trip rating, move your
        mouse over it and either hover there for a second or click.</div>
        </td>
      </tr>
    </tbody></table>
    </div>
    
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
  <xsl:template match="trips">
    <xsl:for-each select="*">
      <div class="trip">
        <a name="{generate-id()}"></a>
<div class="sponsor"><xsl:value-of select="committee"/></div>
        <span class="date">

<!-- ISO 8601 date manipulation depends on EXSLT -
see http://www.xml.com/pub/a/2005/01/05/tr-xml.html -->
<!--
          <xsl:choose>
            <xsl:when test="function-available('date:day-abbreviation')">
-->              <!-- EXSLT implementation -->
<!--              <xsl:choose>
                <xsl:when test="trip_start_date = trip_end_date">
                  <xsl:value-of select="date:day-abbreviation(trip_start_date)"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="date:month-abbreviation(trip_start_date)"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="date:day-in-month(trip_start_date)"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="date:day-abbreviation(trip_start_date)"/>–<xsl:value-of
                    select="date:day-abbreviation(trip_end_date)"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="date:month-abbreviation(trip_start_date)"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="date:day-in-month(trip_start_date)"/>–<xsl:if
                    test="date:month-abbreviation(trip_start_date) != date:month-abbreviation(trip_end_date)">
                    <xsl:value-of select="date:month-abbreviation(trip_end_date)"/>
                    <xsl:text> </xsl:text>
                  </xsl:if>
                  <xsl:value-of select="date:day-in-month(trip_end_date)"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
-->              <!-- date EXST functions not available -->
<!--              <xsl:choose>
                <xsl:when test="trip_start_date = trip_end_date">
                  <xsl:call-template name="date:day-abbreviation">
                    <xsl:with-param name="date-time" select="trip_start_date"/>
                  </xsl:call-template>
                  <xsl:text> </xsl:text>
                  <xsl:call-template name="date:month-abbreviation">
                    <xsl:with-param name="date-time" select="trip_start_date"/>
                  </xsl:call-template>
                  <xsl:text> </xsl:text>
                  <xsl:call-template name="date:day-in-month">
                    <xsl:with-param name="date-time" select="trip_start_date"/>
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:call-template name="date:day-abbreviation">
                    <xsl:with-param name="date-time" select="trip_start_date"/>
                  </xsl:call-template>–<xsl:call-template name="date:day-abbreviation">
                    <xsl:with-param name="date-time" select="trip_end_date"/>
                  </xsl:call-template>
                  <xsl:text> </xsl:text>
                  <xsl:call-template name="date:month-abbreviation">
                    <xsl:with-param name="date-time" select="trip_start_date"/>
                  </xsl:call-template>
                  <xsl:text> </xsl:text>
                  <xsl:call-template name="date:day-in-month">
                    <xsl:with-param name="date-time" select="trip_start_date"/>
                  </xsl:call-template>--><!-- –<xsl:if
                    test="date:month-abbreviation(trip_start_date) != date:month-abbreviation(trip_end_date)">
                    <xsl:value-of select="date:month-abbreviation(trip_end_date)"/> 
                    <xsl:text> </xsl:text>
                  </xsl:if>-->
<!--                  <xsl:value-of select="date:day-in-month(trip_end_date)"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>-->
        </span>
        <xsl:text> </xsl:text>
        <span class="title"><xsl:value-of select="trip_title"/></span>
        
        <xsl:if test="rating">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="rating" />
        </xsl:if>
        
        <xsl:if test="@new"><xsl:text> </xsl:text><span class="tagNew">New</span></xsl:if>
        <xsl:if test="@full or status = 'Full'"><xsl:text> </xsl:text><span class="tagFull">Full</span></xsl:if>
        <xsl:if test="@wait or status = 'Waitlist'"><xsl:text> </xsl:text><span class="tagWaitlist">Waitlist</span></xsl:if>
        <xsl:if test="@cancel or status = 'Cancelled' or status = 'Canceled'"><xsl:text> </xsl:text><span class="tagCancel">Cancelled</span></xsl:if>
        <div class="desc"><xsl:apply-templates select="web_desc"/>

<xsl:if test="string-length(external_link) &gt; 0">
<xsl:choose><xsl:when test="registration_required = 'Yes'"> Reg. at </xsl:when>
<xsl:otherwise> See </xsl:otherwise>
</xsl:choose>
<a href="{external_link}"><xsl:value-of select="external_link"/></a>
</xsl:if>
<!--xsl:if test="string-length(concat(leader1,leader2,leader3,leader4)) &gt; 0">
<xsl:if test="string-length(coleader1,coleader2,coleader3,coleader4)) &gt; 0">
-->
<xsl:if test="string-length(registrar) &gt; 0">
<xsl:text> Reg. with </xsl:text>
<xsl:call-template name="joyst-leader">
<xsl:with-param name="nodeName">registrar</xsl:with-param>
</xsl:call-template>
</xsl:if>

<xsl:if test="string-length(concat(leader1,leader2,leader3,leader4)) &gt; 0">
<span class="leaders">
<xsl:if test="registration_required='Yes' and string-length(registrar) = 0 and string-length(external_link) = 0"> Reg w/ </xsl:if><xsl:text> L </xsl:text>
<xsl:call-template name="joyst-leader">
<xsl:with-param name="nodeName">leader1</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="joyst-leader">
<xsl:with-param name="nodeName">leader2</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="joyst-leader">
<xsl:with-param name="nodeName">leader3</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="joyst-leader">
<xsl:with-param name="nodeName">leader4</xsl:with-param>
</xsl:call-template>.</span></xsl:if>
<xsl:if test="string-length(concat(coleader1,coleader2,coleader3,coleader4)) &gt; 0">
<span class="leaders"><xsl:text> CL </xsl:text>
<xsl:call-template name="joyst-leader">
<xsl:with-param name="nodeName">coleader1</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="joyst-leader">
<xsl:with-param name="nodeName">coleader2</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="joyst-leader">
<xsl:with-param name="nodeName">coleader3</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="joyst-leader">
<xsl:with-param name="nodeName">coleader4</xsl:with-param>
</xsl:call-template>.</span></xsl:if>

<!--xsl:if test="string-length(leader2) &gt; 0"><xsl:text>, </xsl:text>
  <xsl:value-of select="leader2"/>
<xsl:if test="string-length(leader2_email) &gt; 0"><xsl:text> </xsl:text>
  <xsl:value-of select="leader2_email"/></xsl:if>
<xsl:if test="string-length(leader2_phone) &gt; 0"><xsl:text> </xsl:text>
  <xsl:value-of select="leader2_phone"/>
<xsl:if test="string-length(leader2_call_time) &gt; 0"><xsl:text> </xsl:text>
  <xsl:value-of select="leader2_call_time"/></xsl:if></xsl:if>
</xsl:if-->
</div>

      </div>
    </xsl:for-each>


    <!--div style="text-align: right"><a href="#top">Top Of Page</a></div-->
    <xsl:for-each select="p">
      <xsl:copy>
      <xsl:apply-templates select="*|@*|text()"/>
      </xsl:copy>
    </xsl:for-each>
  </xsl:template>

<xsl:template name="joyst-leader">
<xsl:param name="prefixDelim">, </xsl:param>
<xsl:param name="nodeName">leader1</xsl:param>

<xsl:if test="string-length(*[name()=$nodeName]) &gt; 0"><xsl:value-of select="prefixDelim"/>
  <xsl:value-of select="*[name()=$nodeName]"/>
<xsl:if test="string-length(*[name()=concat($nodeName,'_email')]) &gt; 0"><xsl:text> </xsl:text>
  <!--xsl:value-of select="*[name()=concat($nodeName,'_email')]"/>-->
<xsl:call-template name="obfuscatedEmailLink"><xsl:with-param name="address"><xsl:value-of select="*[name()=concat($nodeName,'_email')]"/></xsl:with-param></xsl:call-template></xsl:if>
<xsl:if test="string-length(*[name()=concat($nodeName,'_phone')]) &gt; 0"><xsl:text> </xsl:text>
  <xsl:value-of select="*[name()=concat($nodeName,'_phone')]"/>
<xsl:if test="string-length(*[name()=concat($nodeName, '_call_time')]) &gt; 0"><xsl:text> </xsl:text>
  <xsl:value-of select="*[name()=concat($nodeName, '_call_time')]"/></xsl:if></xsl:if>
</xsl:if>
</xsl:template>

</xsl:stylesheet>

<!-- 
Local Variables:
coding: utf-8;
End:
 -->