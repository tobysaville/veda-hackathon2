<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vsa="http://www.vedaxml.com/products/vedascore/apply/v1"
	xmlns:bic="http://www.vedaxml.com/bureau/internal/core/v1"
	exclude-result-prefixes="bic">

    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/bic:ErrorResponse/errorMessage">
    	
    	<xsl:variable name="faultCode">
    		<xsl:call-template name="fault-code">
    			<xsl:with-param name="code" select="errorSegmentId"/>
    			<xsl:with-param name="subCode" select="code"/>
    		</xsl:call-template>		
    	</xsl:variable>
    	
    	<xsl:variable name="faultString">
    		<xsl:call-template name="fault-string">
    			<xsl:with-param name="faultCode" select="$faultCode"/>
    		</xsl:call-template>		
    	</xsl:variable>
    	
    	<xsl:variable name="faultActor">
    		<xsl:call-template name="fault-actor">
    			<xsl:with-param name="faultCode" select="$faultCode"/>
    		</xsl:call-template>		
    	</xsl:variable>
    	
    	<xsl:variable name="faultMessage">
    		<xsl:call-template name="fault-message">
    			<xsl:with-param name="faultCode" select="$faultCode"/>
    			<xsl:with-param name="message" select="message"/>
    		</xsl:call-template>		
    	</xsl:variable>
    	
    	<xsl:choose>
    		<xsl:when test="errorSegmentId = 'XX' or errorSegmentId = 'YY' or errorSegmentId = 'WW' or code = '0009'">
    			<xsl:call-template name="system-error">
    				<xsl:with-param name="faultCode" select="$faultCode"/>
    				<xsl:with-param name="faultString" select="$faultString"/>
					<xsl:with-param name="faultActor" select="$faultActor"/>
    				<xsl:with-param name="faultMessage" select="$faultMessage"/>
    			</xsl:call-template>
			</xsl:when>
    		<xsl:when test="errorSegmentId != 'XX' and errorSegmentId != 'YY' and errorSegmentId != 'WW'">
				<xsl:call-template name="product-error">
					<xsl:with-param name="faultCode" select="$faultCode"/>
					<xsl:with-param name="faultString" select="$faultString"/>
					<xsl:with-param name="faultActor" select="$faultActor"/>
					<xsl:with-param name="faultMessage" select="$faultMessage"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="yes">Bureau error scenario not handled. See rules in response-transformation-error.xsl</xsl:message>
			</xsl:otherwise>
   		</xsl:choose>
    
    </xsl:template>

	<xsl:template name="system-error">
		<xsl:param name="faultCode"/>
		<xsl:param name="faultString"/>
		<xsl:param name="faultActor"/>
		<xsl:param name="faultMessage"/>
		
	    <vsa:error>
			<vsa:code>
				<vsa:value><xsl:value-of select="$faultCode"/></vsa:value>
			</vsa:code>
			<vsa:message>
				<vsa:fault-string><xsl:value-of select="$faultString"/></vsa:fault-string>
			</vsa:message>
	    	<vsa:role><xsl:value-of select="$faultActor"/></vsa:role>
	    	<vsa:description><xsl:value-of select="$faultMessage"/></vsa:description>
		</vsa:error>
    </xsl:template>
    
	<xsl:template name="product-error">
		<xsl:param name="faultCode"/>
		<xsl:param name="faultString"/>
		<xsl:param name="faultActor"/>
		<xsl:param name="faultMessage"/>
		
	    <vsa:errors>
	        <vsa:error>
		    	<vsa:fault-code><xsl:value-of select="$faultCode"/></vsa:fault-code>
	            <vsa:fault-string><xsl:value-of select="$faultString"/></vsa:fault-string>
	            <vsa:fault-actor><xsl:value-of select="$faultActor"/></vsa:fault-actor>
	        	<vsa:detail><xsl:value-of select="$faultMessage"/></vsa:detail>
	        </vsa:error>
	    </vsa:errors>
    </xsl:template>
    
    <xsl:template name="fault-code">
    	<xsl:param name="code"/>
    	<xsl:param name="subCode"/>
    	
    	<xsl:choose>
    		<xsl:when test="$code = 'XX'">ESBS001</xsl:when>
    		<xsl:when test="$code = 'WW'">PEGP005</xsl:when>
    		<xsl:when test="$code = 'YY'">ESBS001</xsl:when>
    		<xsl:otherwise>
	    		<xsl:choose>
	    			<xsl:when test="$subCode = 'UN18'">PEGP001</xsl:when>
	    			<xsl:when test="$subCode = 'INID'">PEGP002</xsl:when>
	    			<xsl:when test="$subCode = 'DMR5'">PEGP003</xsl:when>
	    			<xsl:when test="$subCode = '0009'">ESBS001</xsl:when>
	    			<xsl:otherwise>PEGP004</xsl:otherwise>
	    		</xsl:choose>
    		</xsl:otherwise>
    	</xsl:choose>
    	
    </xsl:template>
    
    <xsl:template name="fault-actor">
    	<xsl:param name="faultCode"/>
    	<xsl:choose>
    		<xsl:when test="starts-with($faultCode, 'ESB')">Product Assembly</xsl:when>
    		<xsl:when test="starts-with($faultCode, 'PEG')">Bureau</xsl:when>
    		<xsl:otherwise>Product Assembly</xsl:otherwise>
		</xsl:choose>
   	</xsl:template>
    
    <xsl:template name="fault-string">
    	<xsl:param name="faultCode"/>
   		<xsl:choose>
   			<xsl:when test="$faultCode = 'ESBS001'">Service unavailable</xsl:when>
   			<xsl:when test="$faultCode = 'PEGP001'">Individual is under 18 error</xsl:when>
   			<xsl:when test="$faultCode = 'PEGP002'">Individual not found</xsl:when>
   			<xsl:when test="$faultCode = 'PEGP003'">Individual not found</xsl:when>
   			<xsl:when test="$faultCode = 'PEGP004'">Business rules breached</xsl:when>
   			<xsl:when test="$faultCode = 'PEGP005'">Response is over maximum size</xsl:when>
   			<xsl:otherwise>Service unavailable</xsl:otherwise>
   		</xsl:choose>
    </xsl:template>
	
	<xsl:template name="fault-message">
		<xsl:param name="faultCode"/>
		<xsl:param name="message"/>
		<xsl:choose>
			<xsl:when test="$faultCode = 'ESBS001'">An unrecoverable error has occurred. Please re-try again later or contact Veda quoting enquiry-id for resolution.</xsl:when>
			<xsl:when test="$faultCode = 'PEGP001'"><xsl:value-of select="$message"/></xsl:when>
			<xsl:when test="$faultCode = 'PEGP002'"><xsl:value-of select="$message"/></xsl:when>
			<xsl:when test="$faultCode = 'PEGP003'"><xsl:value-of select="$message"/></xsl:when>
			<xsl:when test="$faultCode = 'PEGP004'"><xsl:value-of select="$message"/> Please contact Veda quoting enquiry-id for resolution.</xsl:when>
			<xsl:when test="$faultCode = 'PEGP005'"><xsl:value-of select="$message"/> Please contact Veda quoting enquiry-id for resolution.</xsl:when>
			<xsl:otherwise>An unrecoverable error has occurred. Please re-try again later or contact Veda quoting enquiry-id for resolution.</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>