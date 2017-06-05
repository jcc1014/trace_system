package com.mall.po;

public class Role {
    private String role_id;

    private String role_name;

    private String role_description;

    public String getRole_id() {
        return role_id;
    }

    public void setRole_id(String role_id) {
        this.role_id = role_id == null ? null : role_id.trim();
    }

    public String getRole_name() {
        return role_name;
    }

    public void setRole_name(String role_name) {
        this.role_name = role_name == null ? null : role_name.trim();
    }

    public String getRole_description() {
        return role_description;
    }

    public void setRole_description(String role_description) {
        this.role_description = role_description == null ? null : role_description.trim();
    }
}