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
    
    private String base_id;
    
    private String grade;
    
    private String spyb;
    
    private double price;
    
    private double sum_price;
    
    private String createtime;
    
    private String signname;
    
    private String dw; //单位
    
    private String issale; //单位

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

	public String getBase_id() {
		return base_id;
	}

	public void setBase_id(String base_id) {
		this.base_id = base_id;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getSum_price() {
		return sum_price;
	}

	public void setSum_price(double sum_price) {
		this.sum_price = sum_price;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getSignname() {
		return signname;
	}

	public void setSignname(String signname) {
		this.signname = signname;
	}

	public String getSpyb() {
		return spyb;
	}

	public void setSpyb(String spyb) {
		this.spyb = spyb;
	}

	public String getDw() {
		return dw;
	}

	public void setDw(String dw) {
		this.dw = dw;
	}

	public String getIssale() {
		return issale;
	}

	public void setIssale(String issale) {
		this.issale = issale;
	}
	
}