<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date">
  
  <xsl:import href="amc-trips-to-html-email-custom.xsl"/>
  <xsl:output encoding="ascii" indent="yes" method="html"/>
  
  <!--xsl:param name="tripListingsPageLink" select="'http://amcboston.org/youngmembers/trip_list.shtml'"/-->
  <xsl:param name="listingsURL" select="''"/>
  <xsl:param name="groupHomePageURL" select="''"/>
  <xsl:param name="groupTitle" select="'AMC'"/>

  <xsl:param name="mailheaderHTML">
<p>Questions? Want to learn how to get involved? Visit the Young Members
web site
(<a href="http://amcboston.org/youngmembers/">http://amcboston.org/youngmembers/</a>)
and check out the Frequently Asked Questions page. If
you still have questions or concerns, please contact the YM Chair at <a
href="mailto:youngmembers@amcboston.org">youngmembers@amcboston.org</a>.</p>

<p>This summary is mailed approximately twice per month. Trips added or
changed in the past two weeks are marked <span
class="tagNew">Updated</span>. The web site is updated whenever new
trips become available or fill up, so for the most up-to-date list of
activities, please check the listings on the web site.</p>

<p><i>NOTE: To unsubscribe from this email, please follow the link at
the bottom of this message. To change your email address, first
unsubscribe using the link at the bottom of this message, and then
re-subscribe using the link on the YM home page. If you experience any
problems with this mailing list or the web site, please contact Andrew at <a
href="mailto:amc2006@shearersoftware.com">amc2006@shearersoftware.com</a>.
Thanks!</i></p>
</xsl:param>
  
</xsl:stylesheet>

<!-- 
Local Variables:
coding: utf-8;
End:
 -->