package com.mall.po;

public class Address {
    private String address_id;

    private String member_id;

    private String sheng;

    private String shi;

    private String qu;

    private String address_detail;

    private String zipcode;

    private String phone;

    private String status;

    public String getAddress_id() {
        return address_id;
    }

    public void setAddress_id(String address_id) {
        this.address_id = address_id == null ? null : address_id.trim();
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id == null ? null : member_id.trim();
    }

    public String getSheng() {
        return sheng;
    }

    public void setSheng(String sheng) {
        this.sheng = sheng == null ? null : sheng.trim();
    }

    public String getShi() {
        return shi;
    }

    public void setShi(String shi) {
        this.shi = shi == null ? null : shi.trim();
    }

    public String getQu() {
        return qu;
    }

    public void setQu(String qu) {
        this.qu = qu == null ? null : qu.trim();
    }

    public String getAddress_detail() {
        return address_detail;
    }

    public void setAddress_detail(String address_detail) {
        this.address_detail = address_detail == null ? null : address_detail.trim();
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode == null ? null : zipcode.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }
}