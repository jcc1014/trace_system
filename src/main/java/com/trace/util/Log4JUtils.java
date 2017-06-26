package com.trace.util;

import org.apache.log4j.Logger;

import sun.reflect.Reflection;

public class Log4JUtils{  
	  
    private static Logger logger =  null;  
  
    public static Logger getLogger(){  
       if (null == logger){  
            //Java8 废弃了Reflection.getCallerClass()  
           logger = Logger.getLogger(Reflection.getCallerClass().getName());  
           logger.debug("类名"+Reflection.getCallerClass().getName());  
       }  
        return logger;  
    }  
}  
