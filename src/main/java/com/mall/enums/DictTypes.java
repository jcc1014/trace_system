package com.mall.enums;

/**
 * Description: 维护dict中的dict_type 
 * @author Li Zheng
 * @date 2017年6月7日下午10:36:32
 */
public enum DictTypes {
	VEGETABLES("vegetables");
	
	private String value;

	private DictTypes() {}

	private DictTypes(String value) {
		this.value = value;
	}

	public String value() {
		return value;
	}

}
