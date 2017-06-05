package com.mall.po;

public class Banner {
    private String banner_id;

    private String banner_path;

    private String banner_url;

    private String bannner_index;

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

    public String getBannner_index() {
        return bannner_index;
    }

    public void setBannner_index(String bannner_index) {
        this.bannner_index = bannner_index == null ? null : bannner_index.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }
}