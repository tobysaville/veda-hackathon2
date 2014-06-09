package com.veda.icc.esb.utilities.dumper.camel.json;

import java.io.IOException;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.apache.log4j.Logger;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.ObjectMapper;

public class ValidationProcessor implements Processor {

	Logger log = Logger.getLogger(getClass());
	
	@Override
	public void process(Exchange exchange) throws Exception {
		String json = (String) exchange.getIn().getBody();
		
		if (!isValidJSON(json))
			log.error("invalid json");
	}

	public boolean isValidJSON(final String json) {
		
		boolean valid = false;
		
		if (json ==null)
			return valid;

		try {
			final JsonParser parser = new ObjectMapper().getFactory().createJsonParser(json);
			while (parser.nextToken() != null) {}
			valid = true;
		} catch (JsonParseException jpe) {
			jpe.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}

		return valid;
	}
}
