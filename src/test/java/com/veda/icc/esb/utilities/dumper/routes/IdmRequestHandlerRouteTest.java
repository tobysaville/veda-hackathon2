package com.veda.icc.esb.utilities.dumper.routes;

import java.util.Properties;

import org.apache.camel.test.spring.CamelSpringTestSupport;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class IdmRequestHandlerRouteTest extends CamelSpringTestSupport {

	Logger log = Logger.getLogger(getClass());
		
	Properties properties;
	
	@Before
	public void before() {
	}
	
	@Override
	protected AbstractApplicationContext createApplicationContext() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("/META-INF/spring/test-context.xml");
		
		return ctx;
	}

    @Test
    public void test() throws Exception {
    	String startRoute = "direct:idm-orchestrator";
    	
    	String request = IOUtils.toString(getClass().getResourceAsStream("/request.xml"));
    	
        // create a new file in the inbox folder with the name hello.txt and containing Hello World as body
        String response = (String) template.requestBody(startRoute, request);
    	
        // wait a while to let the file be moved
        log.debug("waiting for async completion");
        Thread.sleep(8000);
        log.debug("waiting complete");
        
        log.debug("test complete: " + response);
    }
    
}
