package com.mall.po;

import com.mall.enums.DictTypes;

public class Dict {
    private String dict_id;

    private String dict_name;

    private String dict_type;

    private String parentid;

    public Dict() {}

    public Dict(DictTypes dictTypes) {
    	this.dict_type = dictTypes.value();
    }

	public String getDict_id() {
        return dict_id;
    }

    public void setDict_id(String dict_id) {
        this.dict_id = dict_id == null ? null : dict_id.trim();
    }

    public String getDict_name() {
        return dict_name;
    }

    public void setDict_name(String dict_name) {
        this.dict_name = dict_name == null ? null : dict_name.trim();
    }

    public String getDict_type() {
        return dict_type;
    }

    public void setDict_type(String dict_type) {
        this.dict_type = dict_type == null ? null : dict_type.trim();
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid == null ? null : parentid.trim();
    }
}