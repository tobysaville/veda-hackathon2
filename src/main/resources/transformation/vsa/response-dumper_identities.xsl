<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vsa="http://www.vedaxml.com/products/vedascore/apply/v1"
	exclude-result-prefixes="vsa">

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="timestamp"/>
    
    <xsl:variable name="collection">identities</xsl:variable>
    
    <xsl:template match="/">
    
		<xsl:call-template name="dumperPart">
		    <xsl:with-param name="collection" select="$collection"/>
		    <xsl:with-param name="uuid" select="//vsa:enquiry-id"/>
		    <xsl:with-param name="timestamp" select="$timestamp"/>
		
		</xsl:call-template>
    </xsl:template>
    
    <xsl:template name="dumperPart">
	    <xsl:param name="collection"/>
	    <xsl:param name="uuid"/>
	    <xsl:param name="timestamp"/>
    
	    <request>
			<collection><xsl:value-of select="$collection"/></collection>
			<uuid><xsl:value-of select="$uuid"/></uuid>
			<timestamp><xsl:value-of select="$timestamp"/></timestamp>
			<parts>
				<xsl:apply-templates select="//vsa:primary-match" />
			</parts>
		</request>
    </xsl:template>
	
	<xsl:template match="*[parent::vsa:primary-match ]">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="*[self::vsa:primary-match]">
		<identity>
			<xsl:apply-templates select="@*|node()" />
		</identity>
	</xsl:template>
	
	<xsl:template match="*[self::vsa:individual-name]">
		<family-name><xsl:value-of select="vsa:family-name"/></family-name>
		<first-given-name><xsl:value-of select="vsa:first-given-name"/></first-given-name>
		<other-given-name><xsl:value-of select="vsa:other-given-name"/></other-given-name>
	</xsl:template>
	
	<xsl:template match="@*|text()|comment()">
		<xsl:copy />
	</xsl:template>
	
</xsl:stylesheet>