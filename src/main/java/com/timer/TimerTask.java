/**
 * 
 */
package com.timer;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * @version V1.0
 * @author jcc
 * @date 
 */
public interface TimerTask {
	
	/**
	 * 提交今日需求单
	 */
	public void submitTodayRequire();  
	
	/**
	 * 提交今日供应单
	 */
	public void submitTodayProduce();
	
	/**
	 * 提交今日缺货单
	 */
	public void submitTodayQhd();
	
	/**
	 * 提交今日采购单
	 */
	public void submitTodayCgd();
	
}
