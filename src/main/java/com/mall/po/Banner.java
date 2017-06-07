package com.mall.po;

public class Banner {
    private String banner_id;
    
    private String banner_title;

    private String banner_path;

    private String banner_url;

    private String banner_index;
    
    private String banner_type;

    private String createtime;

    public String getBanner_id() {
        return banner_id;
    }

    public void setBanner_id(String banner_id) {
        this.banner_id = banner_id == null ? null : banner_id.trim();
    }

    public String getBanner_path() {
        return banner_path;
    }

    public void setBanner_path(String banner_path) {
        this.banner_path = banner_path == null ? null : banner_path.trim();
    }

    public String getBanner_url() {
        return banner_url;
    }

    public void setBanner_url(String banner_url) {
        this.banner_url = banner_url == null ? null : banner_url.trim();
    }

    public String getBanner_index() {
        return banner_index;
    }

    public void setBanner_index(String bannner_index) {
        this.banner_index = bannner_index == null ? null : bannner_index.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }
    
    public String getBanner_type() {
    	return banner_type;
    }
    
    public void setBanner_type(String banner_type) {
    	this.banner_type = banner_type == null ? null : banner_type.trim();
    }
    
    public String getBanner_title() {
    	return banner_title;
    }
    
    public void setBanner_title(String banner_title) {
    	this.banner_title = banner_title == null ? null : banner_title.trim();
    }
    
    
}