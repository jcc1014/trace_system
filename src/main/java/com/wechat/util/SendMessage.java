/**
 * 
 */
package com.wechat.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.trace.util.Log4JUtils;
import com.wechat.entity.NewsMsgEntity;
import com.wechat.entity.TextMessageEntity;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * @version V1.0
 * @author  jcc
 * @date 
 */
public class SendMessage {
	//private static Logger log = Logger.getLogger(SendMessage.class);  
	/**
	 * 
	 * <p>MethodName: gettoken </p>
	 * <p>Description: </p>
	 * @version V1.0
	 * @author jcc
	 * @date 
	 * @return
	 * @throws IOException
	 */
	public static String getToken() throws  IOException
	{
		CloseableHttpClient httpclient = HttpClients.createDefault();
		String id = GetProperties.getParam("corpid");
		String secrect = GetProperties.getParam("secrect");
		String url = WeChatUrl.getTokenUrl(id, secrect);
		HttpPost httpPost = new HttpPost(url);
		JSONObject jsonParam = new JSONObject();  
        StringEntity entity = new StringEntity(jsonParam.toString(),"utf-8");
        entity.setContentEncoding("UTF-8");    
        entity.setContentType("application/json");
		httpPost.setEntity(entity);
		HttpResponse result = httpclient.execute(httpPost);
		String resData = EntityUtils.toString(result.getEntity());  
        JSONObject resJson = JSON.parseObject(resData);  
        String code = resJson.get("access_token").toString(); 
        Log4JUtils.getLogger().info("access_token:"+code);
		return code;
	}
	
	/**
	 * 
	 * <p>MethodName: resultOfSyncRequest</p>
	 * <p>Description:</p>
	 * @version V1.0
	 * @author 
	 * @date 
	 * @param jsonObject
	 * @param url
	 * @return
	 * @throws IOException
	 */
	public static JSONObject resultOfSyncRequest(JSONObject jsonObject,String url)throws IOException
	{
		CloseableHttpClient httpclient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(url);
		StringEntity entity = new StringEntity(jsonObject.toString(),"utf-8");
		entity.setContentEncoding("UTF-8");    
		entity.setContentType("application/json");
		httpPost.setEntity(entity);
		HttpResponse result = httpclient.execute(httpPost);
		String resData = EntityUtils.toString(result.getEntity());  
		JSONObject resJson = JSON.parseObject(resData);  
		return resJson;
	}
	
	/**
	 * 
	 * <p>MethodName: sendTextMessage</p>
	 * <p>Description: </p>
	 * @version V1.0
	 * @author 
	 * @date
	 * @param textMessageEntity
	 * @return JSONObject
	 * @throws IOException
	 */
	public static JSONObject sendTextMessage(TextMessageEntity textMessageEntity) throws  IOException
	{
		String token = getToken();
		String url = WeChatUrl.getMessageUrl(token);
		JSONObject jsonParam = new JSONObject(); 
		List<String> userList = textMessageEntity.getTouser();
		if(null!=userList&&0<userList.size())
		{
			StringBuffer userBuffer = new StringBuffer(1024);
			for (String userid : userList) {
				userBuffer.append(userid).append("|");
			}
			String userString = userBuffer.substring(0, userBuffer.length()-1).toString();
			jsonParam.put("touser", userString);
		}
		jsonParam.put("msgtype", textMessageEntity.getMsgtype());
		jsonParam.put("agentid", textMessageEntity.getAgentid());
		Map<String,String> map = textMessageEntity.getText();
		jsonParam.put("text",JSONObject.toJSON(map));
		jsonParam.put("safe", textMessageEntity.getSafe());
		JSONObject jsonObject = resultOfSyncRequest(jsonParam,url);
		return jsonObject;
	}
	
	/**
	 * 
	 * <p>MethodName: sendNewsMessage</p>
	 * <p>Description: </p>
	 * @version V1.0
	 * @author 
	 * @date 
	 * @param newsMsgEntity
	 * @return
	 * @throws IOException
	 */
	public static JSONObject sendNewsMessage(NewsMsgEntity newsMsgEntity) throws  IOException
	{
		
		String token = getToken();
		String url = WeChatUrl.getMessageUrl(token);
		JSONObject jsonParam = new JSONObject(); 
		List<String> userList = newsMsgEntity.getTouser();
		if(null!=userList&&0<userList.size())
		{
			StringBuffer userBuffer = new StringBuffer(1024);
			for (String userid : userList) {
				userBuffer.append(userid).append("|");
			}
			String userString = userBuffer.substring(0, userBuffer.length()-1).toString();
			jsonParam.put("touser", userString);
		}
		jsonParam.put("msgtype", newsMsgEntity.getMsgtype());
		jsonParam.put("agentid", newsMsgEntity.getAgentid());
		Map<String, List<Map<String, String>>> map = newsMsgEntity.getNews();
		jsonParam.put("news",JSONObject.toJSON(map));
		JSONObject jsonObject = resultOfSyncRequest(jsonParam,url);
		return jsonObject;
	}
	
	/**
	 * 
	 * <p>MethodName:getOauthCode </p>
	 * <p>Description </p>
	 * @version V1.0
	 * @author 
	 * @date 
	 * @param redirectURL
	 * @param state
	 * @return rs
	 */
	public static String getOauthCode(String redirectURL,String state)
	{
		String rs = null;
		String corpid = GetProperties.getParam("corpid");
		rs = WeChatUrl.getCodeUrl(corpid, redirectURL, state);
		return rs;
	}
	
	public static void main(String[] args) {
		demoText();
	}
	
	public static void demoText(){
		List<String> userList = new ArrayList<String>();
		userList.add("erp-0000");
		//userList.add("zhanghao");
		TextMessageEntity textMessageEntity = new TextMessageEntity();
		textMessageEntity.setTouser(userList);
		Map<String, String> text = new HashMap<String, String>();
		text.put("content", "hello\nhello");
		textMessageEntity.setText(text);
		try {
			JSONObject jsonObject = SendMessage.sendTextMessage(textMessageEntity);
			Log4JUtils.getLogger().error(jsonObject.get("errcode"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static void sendMsg(String msg){
		List<String> userList = new ArrayList<String>();
		userList.add("erp-0000");
		userList.add("zhanghao");
		TextMessageEntity textMessageEntity = new TextMessageEntity();
		textMessageEntity.setTouser(userList);
		Map<String, String> text = new HashMap<String, String>();
		text.put("content",msg);
		textMessageEntity.setText(text);
		try {
			JSONObject jsonObject = SendMessage.sendTextMessage(textMessageEntity);
			Log4JUtils.getLogger().error(jsonObject.get("errcode"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void demoNews(){
		List<String> userList = new ArrayList<String>();
		userList.add("erp-0000");
		userList.add("zhanghao");
		NewsMsgEntity newsMsgEntity = new NewsMsgEntity();
		newsMsgEntity.setTouser(userList);
		Map<String,String> map = new HashMap<String, String>();
		map.put("title", "");
		map.put("description", "");
		map.put("url", GetProperties.getParam("domain")+"/baseInfo/login.do");
		map.put("picurl", GetProperties.getParam("domain")+"/images/s_sq_01.png");
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		list.add(map);
		Map<String, List<Map<String, String>>> news = new HashMap<String, List<Map<String,String>>>() ;
		news.put("articles", list);
		newsMsgEntity.setNews(news);
		try {
			JSONObject jsonObject = SendMessage.sendNewsMessage(newsMsgEntity);
			 Log4JUtils.getLogger().info(jsonObject.get("errcode"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
