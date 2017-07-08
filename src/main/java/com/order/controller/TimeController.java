package com.order.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.trace.util.DateUtils;

@Controller
@RequestMapping("time")
public class TimeController {

	@RequestMapping("nowTime")
	@ResponseBody
	public String getNowTime(HttpServletRequest request,String type){
		Map<String,Object> map = new HashMap<String, Object>();
		String time = DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss");
		int r = -100;
		switch (type) {
		case "require":
			r = compare_date(time, DateUtils.getCurrentDate("yyyy-MM-dd")+" 20:00:00");
			break;
		case "purchase":
			r = 0;
			break;
		default:
			break;
		}
		map.put("code", r);
		return JSON.toJSONString(map);
	}
	
	public static int compare_date(String DATE1, String DATE2) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date dt1 = df.parse(DATE1);
			Date dt2 = df.parse(DATE2);
			if (dt1.getTime() > dt2.getTime()) {
				return 1;
			} else if (dt1.getTime() < dt2.getTime()) {
				return -1;
			} else {
				return 0;
			}
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return 0;
	}
	
	public static void main(String[] args) {
		System.out.println(compare_date("2017-07-09 10:00:00", "2017-07-09 11:00:00"));
	}
}


