package com.veda.icc.esb.utilities.dumper.camel.mongo;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.apache.camel.component.mongodb.converters.MongoDbBasicConverters;

import com.mongodb.DBObject;

public class StringToDbObject implements Processor {

	@Override
	public void process(Exchange exchange) throws Exception {
		// TODO Auto-generated method stub

		String json = (String) exchange.getIn().getBody();
		
		DBObject dbo = MongoDbBasicConverters.fromStringToDBObject(json);
		
		exchange.getIn().setBody(dbo);
		
	}

}
