package com.mall.controller;

import java.util.Scanner;

public class Demo {
	public static void main(String[] args) {
		System.out.println("请输入正整数Y和W");
		@SuppressWarnings("resource")
		Scanner scanner = new  Scanner(System.in);
		int w = scanner.nextInt();
		int y = scanner.nextInt();
		System.out.println("现在是结果：");
		System.out.println(s(w,y));
	}
	
	public static String s(int y,int w){
		int r = 0;
		int root = 6;
		int gys = 1;
		if(y>w||y==w){
			r = root-y+1;
		}else if(w>y){
			r = root-w+1;
		}
		for (int i = 1; i <= r; i++) {
			if(r%i==0&&root%i==0){
				gys = i;
			}
		}
		r = r/gys;
		root = root/gys;
		return r+"/"+root;
	}

	
}
