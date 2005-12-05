<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes" method="html"/>

  <xsl:template match="rating">
    <xsl:call-template name="rating">
      <xsl:with-param name="rating" select="."/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="rating">
    <xsl:param name="rating"/>
    <span class="rating" onclick="window.alert('{$rating}: ' + this.title + '.')"><xsl:attribute name="title">
      <xsl:choose>
        <xsl:when test="starts-with($rating, 'AA')">13+ miles, </xsl:when>
        <xsl:when test="starts-with($rating, 'A')">9-13 miles, </xsl:when>
        <xsl:when test="starts-with($rating, 'B')">5-9 miles, </xsl:when>
        <xsl:when test="starts-with($rating, 'C')">under 5 miles, </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="substring($rating, string-length($rating)-1, 1) = '1'">very fast 2.5+ mph, </xsl:when>
        <xsl:when test="substring($rating, string-length($rating)-1, 1) = '2'">fast 2-2.5 mph, </xsl:when>
        <xsl:when test="substring($rating, string-length($rating)-1, 1) = '3'">moderate 1.5-2 mph, </xsl:when>
        <xsl:when test="substring($rating, string-length($rating)-1, 1) = '4'">leisurely 1.5 mph, </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="substring($rating, string-length($rating), 1) = 'A'">very strenuous terrain</xsl:when>
        <xsl:when test="substring($rating, string-length($rating), 1) = 'B'">strenuous terrain</xsl:when>
        <xsl:when test="substring($rating, string-length($rating), 1) = 'C'">average terrain</xsl:when>
        <xsl:when test="substring($rating, string-length($rating), 1) = 'D'">easy terrain</xsl:when>
      </xsl:choose>
    </xsl:attribute>(<span class="inner"><xsl:value-of select="$rating"/></span>)</span>
  </xsl:template>

</xsl:stylesheet>