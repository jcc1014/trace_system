package com.order.po;

public class PsMeat {
    private String id;

    private String require_id;

    private Double num;

    private String psr;

    private String pch; //批次号

    private String xm;

    private String cph; //车牌号

    private String code; 

    private String qrcode;

    private String status;

    private String sign;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getRequire_id() {
        return require_id;
    }

    public void setRequire_id(String require_id) {
        this.require_id = require_id == null ? null : require_id.trim();
    }

    public Double getNum() {
        return num;
    }

    public void setNum(Double num) {
        this.num = num;
    }

    public String getPsr() {
        return psr;
    }

    public void setPsr(String psr) {
        this.psr = psr == null ? null : psr.trim();
    }

    public String getPch() {
        return pch;
    }

    public void setPch(String pch) {
        this.pch = pch == null ? null : pch.trim();
    }

    public String getXm() {
        return xm;
    }

    public void setXm(String xm) {
        this.xm = xm == null ? null : xm.trim();
    }

    public String getCph() {
        return cph;
    }

    public void setCph(String cph) {
        this.cph = cph == null ? null : cph.trim();
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    public String getQrcode() {
        return qrcode;
    }

    public void setQrcode(String qrcode) {
        this.qrcode = qrcode == null ? null : qrcode.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign == null ? null : sign.trim();
    }
}