package com.veda.icc.esb.common.camel.processors.neo4j;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;

public class CreateAddress implements Processor {

	
	
	@Override
	public void process(Exchange exchange) throws Exception {
		
		String body = (String) exchange.getIn().getBody();
		
		String result = String.format(ADD_TEMPLATE, body);
		
		exchange.getIn().setBody(result);
	}
	
	private static final String ADD_TEMPLATE = "{\r\n" + 
			"  \"query\" : \"CREATE (n:Address { props } ) RETURN n\",\r\n" + 
			"  \"params\" : {\r\n" + 
			"    \"props\" : %s\r\n" + 
			"  }\r\n" + 
			"}";
	
}
