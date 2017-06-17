package com.trace.util;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;

public class ResultUtil {

	public static String resultString(int r){
		Map<String,Object> map = new HashMap<String, Object>();
		if(1==r){
			map.put("code", "200");
			map.put("msg", "成功！");
		}else{
			map.put("code", "200");
			map.put("msg", "成功！");
		}
		String result = JSON.toJSONString(map);
		return result;
	}
}
