/**
 * 
 */
package com.wechat.entity;

import java.util.List;
import java.util.Map;

import com.wechat.util.GetProperties;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * @version V1.0
 * @author
 * @date 
 */
public class TextMessageEntity {
	private List<String> touser;
	private Map<String,String> text;
	
	public List<String> getTouser() {
		return touser;
	}
	public void setTouser(List<String> touser) {
		this.touser = touser;
	}
	public String getMsgtype() {
		return "text";
	}
	public int getAgentid() {
		return Integer.parseInt(GetProperties.getParam("message-agentid"));
	}
	public Map<String, String> getText() {
		return text;
	}
	public void setText(Map<String, String> text) {
		this.text = text;
	}
	public String getSafe() {
		return "0";
	}
	
	
}
