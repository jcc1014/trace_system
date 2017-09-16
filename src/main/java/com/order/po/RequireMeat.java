package com.order.po;

public class RequireMeat {
    private String id;

    private String kind;

    private String grade;

    private String sccj;

    private String datetime;

    private String status;

    private String confirm_time;

    private Double num;

    private Double sum;

    private Long price;

    private Double remain;

    private String baseid;
    
    private String sign;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
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

    public String getSccj() {
        return sccj;
    }

    public void setSccj(String sccj) {
        this.sccj = sccj == null ? null : sccj.trim();
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime == null ? null : datetime.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getConfirm_time() {
        return confirm_time;
    }

    public void setConfirm_time(String confirm_time) {
        this.confirm_time = confirm_time == null ? null : confirm_time.trim();
    }

    public Double getNum() {
        return num;
    }

    public void setNum(Double num) {
        this.num = num;
    }

    public Double getSum() {
        return sum;
    }

    public void setSum(Double sum) {
        this.sum = sum;
    }

    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    public Double getRemain() {
        return remain;
    }

    public void setRemain(Double remain) {
        this.remain = remain;
    }

    public String getBaseid() {
        return baseid;
    }

    public void setBaseid(String baseid) {
        this.baseid = baseid == null ? null : baseid.trim();
    }

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}
    
}