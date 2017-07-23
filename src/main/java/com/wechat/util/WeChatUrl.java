/**
 * 
 */
package com.wechat.util;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * @version V1.0
 * @author
 * @date 
 */
public class WeChatUrl {
	private static final String TokenUrl = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=ourid&corpsecret=oursecrect";
	private static final String MessageUrl = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=OUR_ACCESS_TOKEN";
	private static final String CodeUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=CORPID&redirect_uri=OUR_REDIRECT_URI&response_type=code&scope=snsapi_base&state=ourstate#wechat_redirect";
	private static final String UserInfoUrl ="https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=OUR_ACCESS_TOKEN&code=OURCODE";
	
	public static String getTokenUrl(String id,String secrect)
	{
		String url = TokenUrl.replaceAll("ourid", id).replaceAll("oursecrect", secrect);
		return url;
	}
	
	public static String getMessageUrl(String token)
	{
		String url = MessageUrl.replaceAll("OUR_ACCESS_TOKEN", token);
		return url;
	}
	
	public static String getCodeUrl(String corpid,String redirect_url,String state)
	{
		String url = CodeUrl.replaceAll("CORPID", corpid).replaceAll("OUR_REDIRECT_URI", redirect_url).replaceAll("ourstate", state);
		return url;
	}
	
	public static String getUserInfoUrl(String token,String code)
	{
		String url = UserInfoUrl.replaceAll("OUR_ACCESS_TOKEN", token).replaceAll("OURCODE", code);
		return url;
	}
	
	
}
