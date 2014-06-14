<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vsa="http://www.vedaxml.com/products/vedascore/apply/v1"
	exclude-result-prefixes="vsa">

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="timestamp"/>
    
    <xsl:variable name="collection">addresses</xsl:variable>
    
    <xsl:template match="/">
    
		<xsl:call-template name="dumperPart">
		    <xsl:with-param name="payload" select="//vsa:response"/>
		    <xsl:with-param name="collection" select="$collection"/>
		    <xsl:with-param name="uuid" select="//vsa:enquiry-id"/>
		    <xsl:with-param name="timestamp" select="$timestamp"/>
		
		</xsl:call-template>
    </xsl:template>
    
    <xsl:template name="dumperPart">
	    <xsl:param name="payload"/>
	    <xsl:param name="collection"/>
	    <xsl:param name="uuid"/>
	    <xsl:param name="timestamp"/>
    
	    <request>
			<collection><xsl:value-of select="$collection"/></collection>
			<uuid><xsl:value-of select="$uuid"/></uuid>
			<timestamp><xsl:value-of select="$timestamp"/></timestamp>
			<parts>
    			<xsl:apply-templates select="//vsa:address" />
			</parts>
		</request>
    </xsl:template>
	
	<xsl:template match="*[ancestor-or-self::vsa:ddress]">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="@*|text()|comment()">
		<xsl:copy />
	</xsl:template>
	
</xsl:stylesheet>