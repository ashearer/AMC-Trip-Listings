<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date">
  <xsl:import href="amc-trips-to-html-inc.xsl" />
  <!--xsl:import href="functions/date/date.add.template.xsl"/-->
  <xsl:import href="functions/date/date.add.function.xsl"/>
  <xsl:output encoding="UTF-8" indent="yes" method="text"/>
  <xsl:param name="groupTitle">AMC</xsl:param>
  <xsl:template name="obfuscatedEmailLink">
    <xsl:param name="address"/>
    <xsl:value-of select="$address"/>
  </xsl:template>

  <xsl:template match="trips">


    <xsl:call-template name="emit_text">
      <xsl:with-param name="line">
        <xsl:text>BEGIN:VCALENDAR</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
      
    <xsl:call-template name="emit_text">
      <xsl:with-param name="line">
        <xsl:text>VERSION:2.0</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
      
    <xsl:call-template name="emit_text">
      <xsl:with-param name="line">
        <xsl:text>X-WR-CALNAME:</xsl:text>
        <xsl:value-of select="$groupTitle"/>
        <xsl:text> Trip Listings</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
      
    <!-- PRODID:-//Apple Computer\, Inc//iCal 1.5//EN
     X-WR-RELCALID:472DCB8C-5E99-11D9-AC8C-000393B3AC06 -->
 
    <xsl:call-template name="emit_text">
      <xsl:with-param name="line">
        <xsl:text>X-WR-TIMEZONE:US/Eastern</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
      
    <xsl:call-template name="emit_text">
      <xsl:with-param name="line">
        <xsl:text>CALSCALE:GREGORIAN</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
      
    <xsl:for-each select="*">
      <xsl:call-template name="amc-trip-to-ical"/>
    </xsl:for-each>

    <xsl:call-template name="emit_text">
      <xsl:with-param name="line">
        <xsl:text>END:VCALENDAR</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

  <xsl:template name="amc-trip-to-ical">
    <!--div class="sponsor"><xsl:value-of select="committee"/></div-->
      <!--span class="date">
      
        <xsl:call-template name="date-range">
          <xsl:with-param name="start_date"><xsl:value-of select="trip_start_date"/></xsl:with-param>
          <xsl:with-param name="end_date"><xsl:value-of select="trip_end_date"/></xsl:with-param>
        </xsl:call-template>
      </span-->
      
      <!--xsl:if test="rating">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="rating" />
      </xsl:if-->

      <xsl:call-template name="emit_text">
        <xsl:with-param name="line">
          <xsl:text>BEGIN:VEVENT</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="emit_text">
        <xsl:with-param name="line">
          <xsl:text>UID:</xsl:text>
          <xsl:value-of select="trip_id"/>
        </xsl:with-param>
      </xsl:call-template>
            
      <xsl:call-template name="emit_text">
        <xsl:with-param name="line">
          <xsl:text>DTSTAMP:</xsl:text>
          <xsl:call-template name="USToW3CDateTime">
            <xsl:with-param name="date" select="last_updated"/><!-- +++ must convert to UTC -->
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="emit_text">
        <xsl:with-param name="line">
          <xsl:text>LAST-MODIFIED:TZID=US/Eastern:</xsl:text>
          <xsl:call-template name="USToW3CDateTime">
            <xsl:with-param name="date" select="last_updated"/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="emit_text">
        <xsl:with-param name="line">
          <xsl:text>DTSTART;TZID=US/Eastern:</xsl:text>
          <xsl:call-template name="USToW3CDate">
            <xsl:with-param name="date" select="trip_start_date"/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="emit_text">
        <xsl:with-param name="line">
          <xsl:text>DTEND;TZID=US/Eastern:</xsl:text>
          <xsl:choose>
            <xsl:when test="function-available('date:add')">
              <xsl:call-template name="USToW3CDate">
                <xsl:with-param name="date" select="date:add(substring(trip_end_date, 0, 11),'P1D')"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="USToW3CDate">
                <xsl:with-param name="date">
                  <xsl:call-template name="date:add">
                    <xsl:with-param name="date-time" select="substring(trip_end_date, 0, 11)"/>
                    <xsl:with-param name="duration" select="'P1D'"/>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="emit_text">
        <xsl:with-param name="line">
          <xsl:text>SUMMARY:</xsl:text>
          <xsl:call-template name="quote-some">
            <xsl:with-param name="text"><xsl:value-of select="trip_title"/>
              <xsl:if test="@new"><xsl:text> </xsl:text><span class="tagNew">New</span></xsl:if>
              <xsl:if test="@full or status = 'Full'"><xsl:text> </xsl:text><span class="tagFull">Full</span></xsl:if>
              <xsl:if test="@wait or status = 'Waitlist'"><xsl:text> </xsl:text><span class="tagWaitlist">Waitlist</span></xsl:if>
              <xsl:if test="@cancel or status = 'Cancelled' or status = 'Canceled'"><xsl:text> </xsl:text><span class="tagCancel">Cancelled</span></xsl:if>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="emit_text">
        <xsl:with-param name="line">
          <xsl:text>DESCRIPTION:</xsl:text>
          <xsl:call-template name="quote-some">
            <xsl:with-param name="text">
              <xsl:value-of select="web_desc"/>
              <xsl:text> </xsl:text>
              <xsl:call-template name="regAndLeaderInfo"/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
      
      <xsl:if test="normalize-space(external_link)">
        <xsl:call-template name="emit_text">
          <xsl:with-param name="line">
            <xsl:text>URL;VALUE=URI:</xsl:text>
            <xsl:call-template name="quote-some">
              <xsl:with-param name="text">
                <xsl:value-of select="external_link"/>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

          <xsl:if test="normalize-space(leader1_email)">
      <xsl:call-template name="emit_text">
        <xsl:with-param name="line">
          <xsl:text>ORGANIZER;CN="</xsl:text>
          <xsl:call-template name="quote-some">
            <xsl:with-param name="text">
              <xsl:value-of select="leader1"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:text>"</xsl:text>
          <xsl:if test="normalize-space(leader1_email)">
            <xsl:text>:MAILTO:</xsl:text>
            <xsl:call-template name="quote-some">
              <xsl:with-param name="text">
                <xsl:value-of select="leader1_email"/>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:with-param>
      </xsl:call-template>
      </xsl:if>
        
      <xsl:call-template name="emit_text">
        <xsl:with-param name="line">
          <xsl:text>END:VEVENT</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
      
  </xsl:template>
  
  <xsl:template name="regAndLeaderInfo">
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
  </xsl:template>
  
  <!-- xCalendar to iCalendar utility functions, based on
http://ietfreport.isoc.org/idref/draft-hare-xcalendar/ -->
<!-- Emit text, 75 character max per line, recursively -->
<!-- bug fix: don't call normalize_space on the argument, because
it was being called inconsistently, which sometimes led to doubled-up chars
when splitting lines (first line used normalize_space, second line started at
the offset where the first ended but didn't). 
Also, each line was progressively one char shorter. -->

  <xsl:template name="emit_text">
    <xsl:param name="limit" select="number(75)"/> <!-- default limit is 75 " -->
    <xsl:param name="line"/>
        
    <xsl:value-of select="substring($line,1,$limit)"/>
    <!-- Output the newline string -->
    <xsl:text>&#13;&#10;</xsl:text>
    <xsl:if test="string-length($line) > $limit">
      <xsl:call-template name="emit_text">
        <xsl:with-param name="limit" select="$limit"/>
        <!-- +++ bug fix: iCal ignores leading whitespace on subsequent lines, 
        leading to words running together from opposite sides of a line break. -->
        <xsl:with-param name="line" select="concat(' ',substring($line,($limit + 1)))"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
   <!-- ACK: ASPN replace-string function used to model this
     http://aspn.activestate.com/ASPN/Cookbook/XSLT/Recipe/65426
     via Dan Connolly, W3C

     all characters to be quoted are in this template rather than doing multiple calls to the template
     in the hopes that this will improve performance.
     -->
  <xsl:template name="quote-some">
      <!-- rfc2445#sec4.3.11 says to quote DQUOTE, newline, semicolon, colon,
                             reverse solidus, comma -->
     <!-- bugs in original:
     * $after var is named $before; conflicts with real $before var
     * $after var is referenced by invalid entity &after (no trailing semi), not dollar sign
     * replacement text isn't quoted in value-of select attribute value
     * order of testing for special chars means that each special char
       will hide all other special chars that happen to occur nearer
       the beginning of the string but are tested for subsequently
       (e.g. if the string contains a double quote, no other special
       chars will be escaped up to that point)
  
     -->
     <xsl:variable name="text2">
       <xsl:call-template name="my-replace-string">
         <xsl:with-param name="text" select="$text"/>
         <xsl:with-param name="from" select="'\'"/>
         <xsl:with-param name="to" select="'\\'"/>
       </xsl:call-template>
     </xsl:variable>
     <xsl:variable name="text3">
       <xsl:call-template name="my-replace-string">
         <xsl:with-param name="text" select="$text2"/>
         <xsl:with-param name="from" select="'&quot;'"/>
         <xsl:with-param name="to" select="'\&quot;'"/>
       </xsl:call-template>
     </xsl:variable>
     <xsl:variable name="text4">
       <xsl:call-template name="my-replace-string">
         <xsl:with-param name="text" select="$text3"/>
         <xsl:with-param name="from" select="'&#10;'"/>
         <xsl:with-param name="to" select="'\n'"/>
       </xsl:call-template>
     </xsl:variable>
     <xsl:variable name="text5">
       <xsl:call-template name="my-replace-string">
         <xsl:with-param name="text" select="$text4"/>
         <xsl:with-param name="from" select="';'"/>
         <xsl:with-param name="to" select="'\;'"/>
       </xsl:call-template>
     </xsl:variable>
     <xsl:variable name="text6">
       <xsl:call-template name="my-replace-string">  
         <xsl:with-param name="text" select="$text5"/>
         <xsl:with-param name="from" select="':'"/>
         <xsl:with-param name="to" select="':'"/> <!-- disabled -->
       </xsl:call-template>
     </xsl:variable>
     <xsl:variable name="text7">
       <xsl:call-template name="my-replace-string">
         <xsl:with-param name="text" select="$text6"/>
         <xsl:with-param name="from" select="','"/>
         <xsl:with-param name="to" select="'\,'"/>
       </xsl:call-template>
     </xsl:variable>
     <xsl:value-of select="$text7"/>
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
   
  <xsl:template name="USToW3CDate">
    <xsl:param name="date"/>
 
    <xsl:value-of select="substring($date,1,4)"/>
    <xsl:value-of select="substring($date,6,2)"/>
    <xsl:value-of select="substring($date,9,2)"/>
  </xsl:template>
   
  <xsl:template name="USToW3CDateTime">
    <xsl:param name="date"/>
 
    <xsl:value-of select="substring($date,1,4)"/>
    <xsl:value-of select="substring($date,6,2)"/>
    <xsl:value-of select="substring($date,9,2)"/>
    <xsl:text>T</xsl:text>
    <xsl:value-of select="substring($date,12,2)"/>
    <xsl:value-of select="substring($date,15,2)"/>
    <xsl:value-of select="substring($date,18,2)"/>
  </xsl:template>
   
       <!--xsl:choose>
         <xsl:when test="contains($text,$from)">
           <xsl:variable name="before" select="substring-before($text,$from)"/>
           <xsl:variable name="after" select="substring-after($text,$from)"/>
           <xsl:call-template name="quote-some">
             <xsl:with-param name="text" select="$before"/>
           </xsl:call-template>
           <xsl:value-of select="'\\&quot;'" />
           <xsl:call-template name="quote-some">
           <xsl:with-param name="text" select="$after" />
           </xsl:call-template>
         </xsl:when>
         <xsl:when test="contains($text,'&#10;')">
           <xsl:variable name="before" select="substring-before($text,'&#10;')"/>
           <xsl:variable name="after" select="substring-after($text,'&#10;')"/>
           <xsl:call-template name="quote-some">
             <xsl:with-param name="text" select="$before"/>
           </xsl:call-template>
           <xsl:value-of select="'\n'" />
           <xsl:call-template name="quote-some">
           <xsl:with-param name="text" select="$after" />
           </xsl:call-template>
         </xsl:when>
         <xsl:when test="contains($text,';')">
           <xsl:variable name="before" select="substring-before($text,';')"/>
           <xsl:variable name="after" select="substring-after($text,';')"/>
           <xsl:call-template name="quote-some">
             <xsl:with-param name="text" select="$before"/>
           </xsl:call-template>
           <xsl:value-of select="'\;'" />
           <xsl:call-template name="quote-some">
           <xsl:with-param name="text" select="$after" />
           </xsl:call-template>
          </xsl:when>
         <xsl:when test="contains($text,':')">
           <xsl:variable name="before" select="substring-before($text,':')"/>
           <xsl:variable name="after" select="substring-after($text,':')"/>
           <xsl:call-template name="quote-some">
             <xsl:with-param name="text" select="$before"/>
           </xsl:call-template>
           <xsl:value-of select="'\:'" />
           <xsl:call-template name="quote-some">
           <xsl:with-param name="text" select="$after" />
           </xsl:call-template>
          </xsl:when>
         <xsl:when test="contains($text,'\\')">
           <xsl:variable name="before" select="substring-before($text,'\\')"/>
           <xsl:variable name="after" select="substring-after($text,'\\')"/>
           <xsl:call-template name="quote-some">
             <xsl:with-param name="text" select="$before"/>
           </xsl:call-template>
           <xsl:value-of select="'\\'" />
           <xsl:call-template name="quote-some">
           <xsl:with-param name="text" select="$after" />
           </xsl:call-template>
          </xsl:when>
         <xsl:when test="contains($text,',')">
           <xsl:variable name="before" select="substring-before($text,',')"/>
           <xsl:variable name="after" select="substring-after($text,',')"/>
           <xsl:call-template name="quote-some">
             <xsl:with-param name="text" select="$before"/>
           </xsl:call-template>
           <xsl:value-of select="'\,'" />
           <xsl:call-template name="quote-some">
           <xsl:with-param name="text" select="$after" />
           </xsl:call-template>
          </xsl:when>
       <xsl:otherwise>
           <xsl:value-of select="$text"/>
       </xsl:otherwise>
       </xsl:choose>
    </xsl:template-->
</xsl:stylesheet>

<!-- 
Local Variables:
coding: utf-8;
End:
 -->