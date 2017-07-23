/**
 * 
 */
package com.wechat.util;

import java.util.Properties;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * @version V1.0
 * @author
 * @date 
 */
public class GetProperties {
	
	public static String getParam(String param)
	{
		String rs = null;
		Properties prop = new Properties();  
		try
		{
			prop.load(GetProperties.class.getResourceAsStream("../wechat.properties"));     
			rs = prop.getProperty(param);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return rs;
	}
	
}
