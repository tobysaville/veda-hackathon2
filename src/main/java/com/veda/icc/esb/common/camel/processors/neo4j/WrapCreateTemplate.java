package com.veda.icc.esb.common.camel.processors.neo4j;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;

public class WrapCreateTemplate implements Processor {

	@Override
	public void process(Exchange exchange) throws Exception {
		
		String body = (String) exchange.getIn().getBody();

		String template = (String) exchange.getIn().getHeader("visualise.template");
		
		String result = String.format(template, body);
		
		exchange.getIn().setBody(result);
	}
	
}
