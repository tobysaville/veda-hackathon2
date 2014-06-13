package com.veda.icc.esb.common.camel.processors.util;

import org.apache.camel.Exchange;
import org.apache.camel.Message;
import org.apache.camel.Processor;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by faisal.masood on 8/05/2014.
 * <p/>
 * This {@link org.apache.camel.Processor} is just converting the input type to {@link java.util.List}. Since {@link List} is needed for
 * camel beanio endpoint.
 * <p/>
 * I have put a logic that if incoming type is of type {@link java.util.List} then get the first object and pass on. This reverse case of case above.
 *
 * @author faisal.masood
 */
public class ToListProcessor implements Processor {
    @SuppressWarnings("rawtypes")
	@Override
    public void process(Exchange exchange) throws Exception {
        final Message inMessage = exchange.getIn();

        if (inMessage.getBody() instanceof List && !((List)inMessage.getBody()).isEmpty()) {
            inMessage.setBody(( (List) inMessage.getBody() ).get(0));
        } else {
            List<Object> a = new ArrayList<>();
            a.add(exchange.getIn().getBody());

            inMessage.setBody(a);
        }

    }
}