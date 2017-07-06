package com.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

public class CommonUtils {

	public static void rememberPass(String username,String password,HttpServletResponse response) {
		Cookie name = null;
		try {
			name = new Cookie("username", URLEncoder.encode(username,"utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		name.setMaxAge(365*24*60*60);
		name.setPath("/");
		Cookie pass = new Cookie("password", password);
		pass.setMaxAge(365*24*60*60);
		pass.setPath("/");
		response.addCookie(name);
		response.addCookie(pass);
	}
}
