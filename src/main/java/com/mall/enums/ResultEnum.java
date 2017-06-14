package com.mall.enums;

/**
 * Description: 处理结果枚举
 * @author Li Zheng
 * @date 2017年6月8日下午11:11:11
 */
public enum ResultEnum {
	SUCCESS(200, "成功"),
	FAILURE(-1, "失败");
	
	private Integer code;
	
	private String msg;
	
	private ResultEnum() {}
	
	private ResultEnum(Integer code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	public Integer getCode() {
		return code;
	}

	public String getMsg() {
		return msg;
	}
	
}
