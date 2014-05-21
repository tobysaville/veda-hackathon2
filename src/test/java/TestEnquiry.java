

import java.io.File;

import org.apache.camel.EndpointInject;
import org.apache.camel.Exchange;
import org.apache.camel.Produce;
import org.apache.camel.ProducerTemplate;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.mock.MockEndpoint;
import org.apache.camel.model.dataformat.XmlJsonDataFormat;
import org.apache.camel.test.junit4.CamelTestSupport;
import org.apache.commons.io.IOUtils;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

public class TestEnquiry extends CamelTestSupport {

	
	@Produce(uri = "direct:start")
    private ProducerTemplate template;
	 
    @EndpointInject(uri = "mock:result")
    private MockEndpoint resultEndpoint;

    XmlJsonDataFormat xmlJsonFormat = new XmlJsonDataFormat();
    
	@Before
	public void before() {
        deleteDirectory("target/inbox");
        deleteDirectory("target/outbox");
        
        
	}
	
	@BeforeClass
	public static void beforeClass() {
		
	}
	
	@Override
	protected RouteBuilder createRouteBuilder() throws Exception {
		return new RouteBuilder() {
			@Override
			public void configure() throws Exception {
				from("file://target/inbox").
				marshal(xmlJsonFormat).
				log("json: ${body}").
				to("file://target/outbox")
				.convertBodyTo(String.class)/*.
				to("mongodb:connectionBean?database=hackday-db&collection=hackday-coll&operation=operationName")*/
				;
				/*.process(new Processor() {
					
					public void process(Exchange exchange) throws Exception {
						
					}
				});*/
			}
		};
	}
}
