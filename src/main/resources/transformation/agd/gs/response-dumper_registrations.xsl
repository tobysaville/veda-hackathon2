<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:ser="http://schemas.ppsr.gov.au/2011/04/services" 
	xmlns:data="http://schemas.ppsr.gov.au/2011/04/data"
	exclude-result-prefixes="ser data soap">

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="timestamp"/>
    
    <xsl:variable name="collection">registrations</xsl:variable>
    
    <xsl:template match="/">
    
		<xsl:call-template name="dumperPart">
		    <xsl:with-param name="payload" select="//RetrieveGrantorSearchResultDetailResponseMessage"/>
		    <xsl:with-param name="collection" select="$collection"/>
		    <xsl:with-param name="uuid" select="//data:CustomersRequestMessageId"/>
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
    
    	<xsl:apply-templates select="//data:RegistrationDetail" />
    	
    </xsl:template>

	<xsl:template match="*[parent::data:RegistrationDetail]">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	
	<xsl:template match="*[self::data:RegistrationDetail]">
		<RegistrationDetail>
			<xsl:apply-templates select="@*|node()" />
		</RegistrationDetail>
	</xsl:template>
	
	<xsl:template match="//data:Grantors">
		<OrganisationNumber><xsl:value-of select=".//data:OrganisationNumber[1]"/></OrganisationNumber>
		<OrganisationName><xsl:value-of select=".//data:OrganisationName[1]"/></OrganisationName>
	</xsl:template>
	
	<xsl:template match="data:RegistrationDetail/*//*"/>
		
	<!--<xsl:template match="@*|text()|comment()">
		<xsl:copy />
	</xsl:template>-->
	
</xsl:stylesheet>