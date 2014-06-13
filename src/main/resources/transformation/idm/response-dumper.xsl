<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:idm="http://vedaxml.com/vxml2/idmatrix-v4-0.xsd"
	xmlns:vgc="http://vedaxml.com/vxml2/idmatrix-v2-0-vgate-context.xsd"
	xmlns:wsa="http://www.w3.org/2005/08/addressing"
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	exclude-result-prefixes="idm vgc wsa">

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="timestamp"/>
    
    <xsl:variable name="collection">idm_response</xsl:variable>
    
    <xsl:template match="/">
    
		<xsl:call-template name="dumperPart">
		    <xsl:with-param name="payload" select="//idm:response"/>
		    <xsl:with-param name="collection" select="$collection"/>
		    <xsl:with-param name="uuid" select="//idm:enquiry-id"/>
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
    		<_id><xsl:value-of select="//wsa:MessageID"/></_id>
    		<xsl:apply-templates select="* | node()" />
    	</response>
    	
    </xsl:template>

	<xsl:template match="*[ancestor::idm:response]">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*|text()|comment()">
		<xsl:copy />
	</xsl:template>
	
	<xsl:template match="/soapenv:Envelope/soapenv:Header"/>
	<!-- <xsl:template match="/soapenv:Envelope/soapenv:Header/vgc:vgate-context"/>
	<xsl:template match="/soapenv:Envelope/soapenv:Header/wsa:*[not(self::wsa:MessageID)]"/> -->
</xsl:stylesheet>