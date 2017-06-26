package com.mall.utils;

import org.apache.commons.codec.digest.DigestUtils;

import java.security.MessageDigest;

/**
 * @author liz
 * @description: md5校验工具类
 * @date 2017/6/25 17:50
 */
public class MD5Util {
	
	private static final String DEFAULT_SALT = "jccRexliz，我是盐哈哈哈哈！";
	
	public static String getMd5(String keyWord) {
		return getMd5(keyWord, true);
	}
	
	public static String getMd5(String keyWord, boolean doubleMd5) {
		return getMd5(keyWord, DEFAULT_SALT, doubleMd5);
	}
	
	/**
	 * @description: 获取md5
	 * @author liz
	 * @date 2017/6/25 17:55
	 */
	public static String getMd5(String keyWord, String salt, boolean doubleMd5) {
		if (doubleMd5) {
			keyWord = DigestUtils.md5Hex(keyWord) + salt;
		} else {
			keyWord = keyWord + salt;
		}
		char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
		try {
			byte[] strTemp = keyWord.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char[] str = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte b = md[i];
				str[k++] = hexDigits[b >> 4 & 0xf];
				str[k++] = hexDigits[b & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			return null;
		}
	}
	
}
