<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vsa="http://www.vedaxml.com/products/vedascore/apply/v1"
	exclude-result-prefixes="vsa">

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="timestamp"/>
    
    <xsl:variable name="collection">vsa_response</xsl:variable>
    
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
				<xsl:call-template name="payloadToPart">
					<xsl:with-param name="payload" select="$payload"/>
				</xsl:call-template>
			</parts>
		</request>
    </xsl:template>
    
    <xsl:template name="payloadToPart">
    	<xsl:param name="payload"/>
    
    	<response>
    		<_id><xsl:value-of select="$payload//vsa:enquiry-id"/></_id>
    		<xsl:apply-templates select="* | node()" />
    	</response>
    	
    </xsl:template>

	<xsl:template match="*[ancestor::vsa:response]">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*|text()|comment()">
		<xsl:copy />
	</xsl:template>
</xsl:stylesheet>