/**
 * 
 */
package com.wechat.entity;

import java.util.List;
import java.util.Map;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * @version V1.0
 * @author jcc
 * @date 
 */
public class NewsMsgEntity {
	private List<String> touser;
	private Map<String,List<Map<String,String>>> news;
	private int agentid;
	public List<String> getTouser() {
		return touser;
	}
	public void setTouser(List<String> touser) {
		this.touser = touser;
	}
	public String getMsgtype() {
		return "news";
	}

	public int getAgentid() {
		return agentid;
	}
	public void setAgentid(int agentid) {
		this.agentid = agentid;
	}
	public Map<String, List<Map<String, String>>> getNews() {
		return news;
	}
	public void setNews(Map<String, List<Map<String, String>>> news) {
		this.news = news;
	}
	
}
