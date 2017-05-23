package com.trace.po;

public class TraceFlow {

	private String trace_id;
	private String farmer_id; //农户
	private String purchase_id; //采购
	private String test_id; //检验
	private String sampling_id; //抽检
	private String transport_id; //运输
	private String sale_id; //销售
	private String trace_status; //追溯状态
	private String qrcode; //二维码
	private String createtime; //二维码
	
	public String getTrace_id() {
		return trace_id;
	}
	public void setTrace_id(String trace_id) {
		this.trace_id = trace_id;
	}
	public String getFarmer_id() {
		return farmer_id;
	}
	public void setFarmer_id(String farmer_id) {
		this.farmer_id = farmer_id;
	}
	public String getPurchase_id() {
		return purchase_id;
	}
	public void setPurchase_id(String purchase_id) {
		this.purchase_id = purchase_id;
	}
	public String getTest_id() {
		return test_id;
	}
	public void setTest_id(String test_id) {
		this.test_id = test_id;
	}
	public String getSampling_id() {
		return sampling_id;
	}
	public void setSampling_id(String sampling_id) {
		this.sampling_id = sampling_id;
	}
	public String getTransport_id() {
		return transport_id;
	}
	public void setTransport_id(String transport_id) {
		this.transport_id = transport_id;
	}
	public String getSale_id() {
		return sale_id;
	}
	public void setSale_id(String sale_id) {
		this.sale_id = sale_id;
	}
	public String getTrace_status() {
		return trace_status;
	}
	public void setTrace_status(String trace_status) {
		this.trace_status = trace_status;
	}
	public String getQrcode() {
		return qrcode;
	}
	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	
}
