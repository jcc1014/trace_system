package com.order.po;

public class DistributionInfo {
    private String distribution_id; //配送id

    private String require_id; //需求单id

    private String require_name; //需求名称

    private Double require_num; //需求数量

    private String kind; //种类

    private Double yps; //一配送
 
    private Double wps; //未配送
    
    private String distribution_address; //配送地址

    public String getDistribution_id() {
        return distribution_id;
    }

    public void setDistribution_id(String distribution_id) {
        this.distribution_id = distribution_id == null ? null : distribution_id.trim();
    }

    public String getRequire_id() {
        return require_id;
    }

    public void setRequire_id(String require_id) {
        this.require_id = require_id == null ? null : require_id.trim();
    }

    public String getRequire_name() {
        return require_name;
    }

    public void setRequire_name(String require_name) {
        this.require_name = require_name == null ? null : require_name.trim();
    }

    public Double getRequire_num() {
        return require_num;
    }

    public void setRequire_num(Double require_num) {
        this.require_num = require_num;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind == null ? null : kind.trim();
    }

    public Double getYps() {
        return yps;
    }

    public void setYps(Double yps) {
        this.yps = yps;
    }

    public Double getWps() {
        return wps;
    }

    public void setWps(Double wps) {
        this.wps = wps;
    }

	public String getDistribution_address() {
		return distribution_address;
	}

	public void setDistribution_address(String distribution_address) {
		this.distribution_address = distribution_address;
	}
}