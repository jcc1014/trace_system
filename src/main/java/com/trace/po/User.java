/**
 * @Description: 
 * @maven.com.trace.po
 * @FileName:User.java
 * @Created By:景长超
 * @Created:2017年4月10日 下午10:08:55
 */
package com.trace.po;

/**
 * @Description
 * @ClassName User
 * @author 景长超
 * @Created 2017 2017年4月10日 下午10:08:55
 */
public class User {
	
	private String userid;
	private String username;
	private String password;
	private String usertype;
	private String phone;
	private String baseid; //基地信息
	private String realname; //真实姓名
	private String sfzh;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getBaseid() {
		return baseid;
	}
	public void setBaseid(String baseid) {
		this.baseid = baseid;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public String getSfzh() {
		return sfzh;
	}
	public void setSfzh(String sfzh) {
		this.sfzh = sfzh;
	}
	
}
