<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vsa="http://www.vedaxml.com/products/vedascore/apply/v1"
	xmlns:vs2="http://www.vedaxml.com/services/xmlchannel/vsa/v2">

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
   <!--  <xsl:import href="../dumper/request-template.xsl"/> -->
    
    <xsl:param name="timestamp"/>
    
    <xsl:variable name="collection">vsa-request</xsl:variable>
    
    <xsl:template match="/">
    
		<xsl:call-template name="dumperRequest">
		    <xsl:with-param name="request" select="//vs2:request"/>
		    <xsl:with-param name="collection" select="$collection"/>
		    <xsl:with-param name="uuid" select="//vs2:enquiry-id"/>
		    <xsl:with-param name="timestamp" select="$timestamp"/>
		
		</xsl:call-template>
    </xsl:template>

    
    <xsl:template name="dumperRequest">
	    <xsl:param name="request"/>
	    <xsl:param name="collection"/>
	    <xsl:param name="uuid"/>
	    <xsl:param name="timestamp"/>
    
	    <request>
			<collection><xsl:value-of select="$collection"/></collection>
			<uuid><xsl:value-of select="$uuid"/></uuid>
			<timestamp><xsl:value-of select="$timestamp"/></timestamp>
			<parts>
				<!-- <xsl:copy-of select="$parts"/> -->
				<xsl:call-template name="requestToPart">
					<xsl:with-param name="request" select="$request"/>
				</xsl:call-template>
			</parts>
		</request>
    </xsl:template>
    
    <xsl:template name="requestToPart">
    	<xsl:param name="request"/>
    
    	<request>
    		<_id><xsl:value-of select="$request//vs2:enquiry-id"/></_id>
    		<!-- <xsl:copy-of select="//*[ancestor::vs2:request]" copy-namespaces="no"/> -->
    		<xsl:apply-templates select="//*[ancestor::vs2:request]"/>
    	</request>
    	
    </xsl:template>

	<xsl:template match="//vs2:*[ancestor::vs2:request]">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*|text()|comment()">
		<xsl:copy />
	</xsl:template>
</xsl:stylesheet>