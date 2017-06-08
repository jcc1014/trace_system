package com.mall.dto;

import com.mall.enums.ResultEnum;

public class Result<T> {
	private Integer code;
	
	private String msg;
	
	private T data;
	
	public Result() {}
	
	public Result(ResultEnum resultEnum, T data) {
		this.code = resultEnum.getCode();
		this.msg = resultEnum.getMsg();
		this.data = data;
	}

	public Result(ResultEnum resultEnum) {
		this(resultEnum, null);
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}
	
}
