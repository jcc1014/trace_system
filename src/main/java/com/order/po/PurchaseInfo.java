package com.order.po;

public class PurchaseInfo {
    private String purchase_id;

    private String kind; //种类

    private Double number; //数量

    private Double remain_number; //剩余量

    private String grade;
    
    private String createtime;

    private String createuser;

    private String status;

    private String parentid;

    private String type; //正常还是缺货
    
    private double price;
    
    private double supply_number;
    
    private String spyb;

    private String cgdh;
    
    private String dw; //单位

    public String getPurchase_id() {
        return purchase_id;
    }

    public void setPurchase_id(String purchase_id) {
        this.purchase_id = purchase_id == null ? null : purchase_id.trim();
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind == null ? null : kind.trim();
    }

    public Double getNumber() {
        return number;
    }

    public void setNumber(Double number) {
        this.number = number;
    }

    public Double getRemain_number() {
        return remain_number;
    }

    public void setRemain_number(Double remain_number) {
        this.remain_number = remain_number;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

    public String getCreateuser() {
        return createuser;
    }

    public void setCreateuser(String createuser) {
        this.createuser = createuser == null ? null : createuser.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid == null ? null : parentid.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getSupply_number() {
		return supply_number;
	}

	public void setSupply_number(double supply_number) {
		this.supply_number = supply_number;
	}

	public String getSpyb() {
		return spyb;
	}

	public void setSpyb(String spyb) {
		this.spyb = spyb;
	}
	public String getCgdh() {
		return cgdh;
	}

	public void setCgdh(String cgdh) {
		this.cgdh = cgdh;
	}

	public String getDw() {
		return dw;
	}

	public void setDw(String dw) {
		this.dw = dw;
	}
	
	
}