package com.order.po;

public class Meat {
    private String id;

    private String pch;

    private String kind;

    private String grade;

    private Double num;

    private Double remain;

    private String sccj;

    private String rksj;

    private String jcbg;

    private String type;

    private String datetime;
    
    private String cgr;
    
    private double cgj; //采购价

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getPch() {
        return pch;
    }

    public void setPch(String pch) {
        this.pch = pch == null ? null : pch.trim();
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind == null ? null : kind.trim();
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public Double getNum() {
        return num;
    }

    public void setNum(Double num) {
        this.num = num;
    }

    public Double getRemain() {
        return remain;
    }

    public void setRemain(Double remain) {
        this.remain = remain;
    }

    public String getSccj() {
        return sccj;
    }

    public void setSccj(String sccj) {
        this.sccj = sccj == null ? null : sccj.trim();
    }

    public String getRksj() {
        return rksj;
    }

    public void setRksj(String rksj) {
        this.rksj = rksj == null ? null : rksj.trim();
    }

    public String getJcbg() {
        return jcbg;
    }

    public void setJcbg(String jcbg) {
        this.jcbg = jcbg == null ? null : jcbg.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime == null ? null : datetime.trim();
    }

	public String getCgr() {
		return cgr;
	}

	public void setCgr(String cgr) {
		this.cgr = cgr;
	}

	public double getCgj() {
		return cgj;
	}

	public void setCgj(double cgj) {
		this.cgj = cgj;
	}
    
}