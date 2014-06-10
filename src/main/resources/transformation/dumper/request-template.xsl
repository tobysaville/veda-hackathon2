<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template name="dumperRequest">
	    <xsl:param name="parts"/>
	    <xsl:param name="collection"/>
	    <xsl:param name="uuid"/>
	    <xsl:param name="timestamp"/>
    
	    <request>
			<collection><xsl:value-of select="$collection"/></collection>
			<uuid><xsl:value-of select="$uuid"/></uuid>
			<timestamp><xsl:value-of select="$timestamp"/></timestamp>
			<parts>
				<xsl:value-of select="$parts"/>
			</parts>
		</request>
    </xsl:template>

</xsl:stylesheet>