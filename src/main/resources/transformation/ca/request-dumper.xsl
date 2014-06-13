<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ns36="http://vedaxml.com/vxml2/veda-cth-request-v1.0"
	xmlns:ns35="http://vedaxml.com/vxml2/veda-th-request-v1.0">

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*"/>
    
   <!--  <xsl:import href="../dumper/request-template.xsl"/> -->
    
    <xsl:param name="timestamp"/>
    
    <xsl:variable name="collection">ca_request</xsl:variable>
    
    <xsl:template match="/">
    
		<xsl:call-template name="dumperRequest">
		    <xsl:with-param name="payload" select="//ns36:companyTradingHistoryRequest"/>
		    <xsl:with-param name="collection" select="$collection"/>
		    <xsl:with-param name="uuid" select="//ns35:uuid"/>
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
    		<_id><xsl:value-of select="$payload//ns35:uuid"/></_id>
    		<!-- <xsl:apply-templates select="//*[ancestor::vs2:request]"/> -->
    		<xsl:apply-templates select="* | node()" />
    	</request>
    	
    </xsl:template>

	<xsl:template match="*[ancestor::ns36:companyTradingHistoryRequest]">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*|text()|comment()">
		<xsl:copy />
	</xsl:template>
</xsl:stylesheet>