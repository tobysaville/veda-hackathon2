

import java.io.File;
import java.io.IOException;
import java.util.Properties;

import org.apache.camel.Exchange;
import org.apache.camel.core.xml.CamelPropertyPlaceholderDefinition;
import org.apache.camel.test.spring.CamelSpringTestSupport;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class RequestHandlerRouteTest extends CamelSpringTestSupport {

	Logger log = Logger.getLogger(getClass());
		
	Properties properties;
	
	@Before
	public void before() {
//        deleteDirectory("target/inbox");
//        deleteDirectory("target/outbox");
//        deleteDirectory("target/dropbox");
	}
	
	@Override
	protected AbstractApplicationContext createApplicationContext() {
		AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("/META-INF/spring/test-context.xml");
		
		/*CamelPropertyPlaceholderDefinition cpphd = (CamelPropertyPlaceholderDefinition) ctx.getBean("properties");
		
		try {
			String propsPath = "/"+cpphd.getLocation().substring(cpphd.getLocation().indexOf(":")+1)+".cfg";
			
			properties = new Properties();
			properties.load(getClass().getResourceAsStream(propsPath));
		} catch (IOException e) {
			throw new RuntimeException(e);
			
		}*/
		
		return ctx;
	}




    @Test
    public void testMoveFile() throws Exception {
//    	String startRoute = "file://target/inbox";
    	String startRoute = "direct:start";
//    	String endRoute = "file://target/outbox";
    	
//    	String resultFilePath = endRoute.replaceFirst("file://", "");
    	
    	String request = IOUtils.toString(getClass().getResourceAsStream("/request.xml"));
    	
        // create a new file in the inbox folder with the name hello.txt and containing Hello World as body
        String response = (String) template.requestBody/*AndHeader*/(startRoute, request/*, Exchange.FILE_NAME, "books.xml"*/);
    	
        // wait a while to let the file be moved
//        log.info("waiting for 2 seconds for completion");
        Thread.sleep(8000);
//        log.info("waiting complete");

        // test the file was moved
//        File target = new File(resultFilePath+"/books.xml");
//        assertTrue("File should have been moved", target.exists());

        // test that its content is correct as well
//        String content = context.getTypeConverter().convertTo(String.class, target);
//        assertEquals(request, content);
        
        log.debug("test complete: " + response);
    }
	
	@Test
	public void test() throws Throwable {
		System.out.print("starting... ");
		String body = IOUtils.toString(getClass().getResourceAsStream("/IKQ0.txt"));
//		String body = IOUtils.toString(getClass().getResourceAsStream("/file.csv"));
		//System.out.println("body : " + body);
		template.sendBody(body);
		//Thread.sleep(5000);
		System.out.println("done");
	}


    
}
