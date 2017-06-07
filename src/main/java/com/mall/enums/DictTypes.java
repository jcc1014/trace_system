package com.mall.enums;

/**
 * Description: ά��dict�е�dict_type 
 * @author Li Zheng
 * @date 2017��6��7������10:36:32
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
