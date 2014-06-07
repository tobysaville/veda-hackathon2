package com.veda.icc.esb.utilities.dumper;

import org.apache.camel.spring.Main;
import org.apache.log4j.Logger;

public class MainRunner {
	
	Logger log = Logger.getLogger(getClass());
	
    private Main main;
    
    public static void main(String[] args) throws Exception {
    	MainRunner example = new MainRunner();
        example.boot();
    }
 
    public void boot() throws Exception {
        // create a Main instance
        main = new Main();
        // enable hangup support so you can press ctrl + c to terminate the JVM
        main.enableHangupSupport();
        // bind MyBean into the registery
 
        // run until you terminate the JVM
        log.info("Starting Camel. Use ctrl + c to terminate the JVM.\n");
        main.run();
    }
 
}
