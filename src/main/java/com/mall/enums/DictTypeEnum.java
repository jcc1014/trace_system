package com.mall.enums;

/**
 * Description: 维护dict中的dict_type 
 * @author Li Zheng
 * @date 2017年6月7日下午10:36:32
 */
public enum DictTypeEnum {
	VEGETABLES("vegetables");
	
	private String value;

	private DictTypeEnum() {}

	private DictTypeEnum(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

}
