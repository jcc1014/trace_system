/**
 * @Title: DateUtils.java
 * @Package org.zxgs.jweb.utils
 * @Description: TODO(用一句话描述该文件做什么)
 * @author 马超
 * @date 2012-8-10 上午8:59:17
 * @version V1.0
*/
package com.trace.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * @Title: DateUtils.java
 * @Package org.zxgs.jweb.utils
 * @Description: 时间通用类
 * @author 马超
 * @date 2012-8-10 上午8:59:17
 * @version V1.0
 */
public class DateUtils {
	/**
	 * 
	 *@Description: TODO(两个日期的差值)
	 *@author 曹建 2012-11-21 下午5:13:41 
	 *@param time1
	 *@param time2
	 *@return
	 */
	public static long getQuot(String time1, String time2) {
		long quot = 0;
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date date1 = ft.parse(time1);
			Date date2 = ft.parse(time2);
			quot = date1.getTime() - date2.getTime();
			quot = quot / 1000 / 60 / 60 / 24;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return quot;
	}
	/**
	 * 
	 *@Description: 取得系统当前时间 String 自定义格式 yyyy年MM月dd日
	 *@author 马超
	 *@date 2012-8-10 上午8:59:52
	 *@param str   yyyy年MM月dd日
	 *@return
	 */
	public static String getCurrentDate(String str) {
		SimpleDateFormat df=new SimpleDateFormat(str); 
		Calendar rightNow = Calendar.getInstance();
		return df.format(rightNow.getTime());
	}
	/**
	 * 
	 *@Description: 获取当前时间 格式为yyyy-MM-dd HH:mm:ss
	 *@author 曹建   2012-8-25 上午10:00:53
	 *@return
	 */
	public static String getCurrentDate() {
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		Calendar rightNow = Calendar.getInstance();
		return df.format(rightNow.getTime());
	}
	/**
	 * 
	 *@Description: 获取当前时间 格式为yyyy-MM-dd
	 *@author 曹建   2012-8-25 上午10:00:53
	 *@return
	 */
	public static String getCurrentDateNew() {
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd"); 
		Calendar rightNow = Calendar.getInstance();
		return df.format(rightNow.getTime());
	}
	/**
	 * 
	 *@Description: 获取当前时间 格式为yyyy
	 *@author 曹建   2012-8-25 上午10:00:53
	 *@return
	 */
	public static String getCurrentYearNew() {
		SimpleDateFormat df=new SimpleDateFormat("yyyy"); 
		Calendar rightNow = Calendar.getInstance();
		return df.format(rightNow.getTime());
	}
	/**
	 * 
	 * @author      : caojian  时间：2012-4-25 上午11:30:06
	 * @description :  取得系统当前时间前n个月的相对应的一天
	 * @modify      : 修改人 时间 简单描述 
	 * @param n
	 * @return  String  
	 */
	@SuppressWarnings("static-access")
	public static String getNMonthBeforeCurrentDay(int n,String str) {
		Calendar c = Calendar.getInstance();
		c.add(c.MONTH, -n);
		SimpleDateFormat df=new SimpleDateFormat(str); 
		return df.format(c.getTime());

	}
 
	/**
	 * 
	 * @author      : caojian  时间：2012-4-25 上午11:30:31
	 * @description : 取得系统当前时间后n个月的相对应的一天
	 * @modify      : 修改人 时间 简单描述 
	 * @param n
	 * @return String  
	 */
	@SuppressWarnings("static-access")
	public static String getNMonthAfterCurrentDay(int n,String str) {
		Calendar c = Calendar.getInstance();
		c.add(c.MONTH, n);
		SimpleDateFormat df=new SimpleDateFormat(str); 
		return df.format(c.getTime());

	}
 
	/**
	 * 
	 * @author      : caojian  时间：2012-4-25 上午11:30:58
	 * @description : 取得系统当前时间前n天
	 * @modify      : 修改人 时间 简单描述 
	 * @param n
	 * @return String yyyy-mm-dd
	 */
	@SuppressWarnings("static-access")
	public static String getNDayBeforeCurrentDate(int n,String str) {
		Calendar c = Calendar.getInstance();
		c.add(c.DAY_OF_MONTH, -n);
		SimpleDateFormat df=new SimpleDateFormat(str); 
		return df.format(c.getTime());
	}
 
	/**
	 * 
	 * @author      : caojian  时间：2012-4-25 上午11:31:19
	 * @description : 取得系统当前时间后n天
	 * @modify      : 修改人 时间 简单描述 
	 * @param n
	 * @return String yyyy-MM-dd
	 */
	@SuppressWarnings("static-access")
	public static String getNDayAfterCurrentDate(int n,String str) {
		Calendar c = Calendar.getInstance();
		c.add(c.DAY_OF_MONTH, n);
		SimpleDateFormat df=new SimpleDateFormat(str); 
		return df.format(c.getTime());
	}
}
