package com.veda.icc.esb.common.camel.io;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;

public class FileLoader implements Processor {

	private Logger log = Logger.getLogger(getClass());
	
	@Override
	public void process(Exchange exchange) throws Exception {

	    String file = exchange.getIn().getHeader("common.io.fileloader.location", String.class);
	
	    if (file == null) {
	    	log.error("no file location found");
	    }
	
	    try {
			String content = IOUtils.toString(getClass().getResourceAsStream(file));
			exchange.getIn().setBody(content);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}
}