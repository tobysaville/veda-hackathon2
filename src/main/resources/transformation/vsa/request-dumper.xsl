<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vsa="http://www.vedaxml.com/products/vedascore/apply/v1"
	xmlns:vs2="http://www.vedaxml.com/services/xmlchannel/vsa/v2"
	exclude-result-prefixes="vsa vs2">

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*"/>
    
   <!--  <xsl:import href="../dumper/request-template.xsl"/> -->
    
    <xsl:param name="timestamp"/>
    
    <xsl:variable name="collection">vsa_request</xsl:variable>
    
    <xsl:template match="/">
    
		<xsl:call-template name="dumperRequest">
		    <xsl:with-param name="payload" select="//vs2:request"/>
		    <xsl:with-param name="collection" select="$collection"/>
		    <xsl:with-param name="uuid" select="//vs2:enquiry-id"/>
		    <xsl:with-param name="timestamp" select="$timestamp"/>
		
		</xsl:call-template>
    </xsl:template>
    
    <xsl:template name="dumperRequest">
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
    
    	<request>
    		<_id><xsl:value-of select="$payload//vs2:enquiry-id"/></_id>
    		<xsl:apply-templates select="* | node()" />
    	</request>
    	
    </xsl:template>

	<xsl:template match="*[ancestor::vs2:request]">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*|text()|comment()">
		<xsl:copy />
	</xsl:template>
</xsl:stylesheet>