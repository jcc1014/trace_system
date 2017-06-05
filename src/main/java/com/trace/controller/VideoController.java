package com.trace.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONException;
import com.trace.po.Video;
import com.trace.service.VideoService;
import com.trace.util.DateUtils;

@Controller
@RequestMapping("video")
public class VideoController {

	@Autowired
	private VideoService videoService;
	
	private String configPath = "video";
	private String picPath = "uploadPic";
	
	@RequestMapping("uploadVideo.do")
	public void  uploadVideo(HttpServletRequest request,HttpServletResponse response)
    		throws IllegalStateException, IOException, JSONException
    {
		Map<String,Object> map = new HashMap<String, Object>();;
		String path  = request.getSession().getServletContext().getRealPath("/")+configPath+"\\";
		
         //将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
        CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(
                request.getSession().getServletContext());
        //检查form中是否有enctype="multipart/form-data"
        if(multipartResolver.isMultipart(request))
        {
            //将request变成多部分request
            MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
           //获取multiRequest 中所有的文件名
            Iterator<?> iter=multiRequest.getFileNames();
            String fileName = null;
            while(iter.hasNext())
            {
                //一次遍历所有文件
                MultipartFile file=multiRequest.getFile(iter.next().toString());
                if(file!=null)
                {
                	fileName = file.getOriginalFilename();
                	String prefix=fileName.substring(fileName.lastIndexOf(".")+1);
                	fileName = UUID.randomUUID().toString()+"."+prefix;
                	map.put("filename",file.getOriginalFilename());
                    //上传
                    file.transferTo(new File(path+fileName));
                    Video video = new Video();
                    video.setVideo_id(UUID.randomUUID().toString());
                    video.setVideo_path(path+fileName);
                    //map = subjectService.importExcel(user, "", path+fileName);
                    map.put("path",path+fileName);
                    map.put("name",fileName);
                    map.put("code","success");
                }
                 
            }
           
        }else{
            map.put("code","error");
        }
        PrintWriter out = null;
		try {
			String rs = JSON.toJSONString(map);
			out = response.getWriter();
			out.print(rs);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
    }
	@RequestMapping("uploadPurchaseVideo.do")
	public void  uploadPurchaseVideo(HttpServletRequest request,HttpServletResponse response)
			throws IllegalStateException, IOException, JSONException
	{
		Map<String,Object> map = new HashMap<String, Object>();;
		String path  = request.getSession().getServletContext().getRealPath("/")+configPath+"\\";
		
		//将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
		CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(
				request.getSession().getServletContext());
		//检查form中是否有enctype="multipart/form-data"
		if(multipartResolver.isMultipart(request))
		{
			//将request变成多部分request
			MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
			//获取multiRequest 中所有的文件名
			Iterator<?> iter=multiRequest.getFileNames();
			String fileName = null;
			String nowDate = null;
			while(iter.hasNext())
			{
				//一次遍历所有文件
				MultipartFile file=multiRequest.getFile(iter.next().toString());
				if(file!=null)
				{
					nowDate = DateUtils.getCurrentDate("yyyyMMdd");
					//fileName = user.getUserid()+"_"+nowDate+file.getOriginalFilename();
					fileName = file.getOriginalFilename();
                	String prefix=fileName.substring(fileName.lastIndexOf(".")+1);
                	fileName = nowDate+"."+prefix;
                	map.put("filename",file.getOriginalFilename());
					//上传
					file.transferTo(new File(path+fileName));
					Video video = new Video();
					video.setVideo_id(UUID.randomUUID().toString());
					video.setVideo_path(path+fileName);
					//map = subjectService.importExcel(user, "", path+fileName);
					map.put("path",path+fileName);
					map.put("code","success");
					map.put("name",fileName);
				}
				
			}
			
		}else{
			map.put("code","error");
		}
		PrintWriter out = null;
		try {
			String rs = JSON.toJSONString(map);
			out = response.getWriter();
			out.print(rs);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
	}
	@RequestMapping("uploadTestVideo.do")
	public void  uploadTestVideo(HttpServletRequest request,HttpServletResponse response)
			throws IllegalStateException, IOException, JSONException
	{
		Map<String,Object> map = new HashMap<String, Object>();;
		String path  = request.getSession().getServletContext().getRealPath("/")+configPath+"\\";
		
		//将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
		CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(
				request.getSession().getServletContext());
		//检查form中是否有enctype="multipart/form-data"
		if(multipartResolver.isMultipart(request))
		{
			//将request变成多部分request
			MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
			//获取multiRequest 中所有的文件名
			Iterator<?> iter=multiRequest.getFileNames();
			String fileName = null;
			String nowDate = null;
			while(iter.hasNext())
			{
				//一次遍历所有文件
				MultipartFile file=multiRequest.getFile(iter.next().toString());
				if(file!=null)
				{
					nowDate = DateUtils.getCurrentDate("yyyyMMddHHmmss");
					//fileName = user.getUserid()+"_"+nowDate+file.getOriginalFilename();
					fileName = file.getOriginalFilename();
                	String prefix=fileName.substring(fileName.lastIndexOf(".")+1);
                	fileName = nowDate+"."+prefix;
					map.put("filename",file.getOriginalFilename());
					//上传
					file.transferTo(new File(path+fileName));
					Video video = new Video();
					video.setVideo_id(UUID.randomUUID().toString());
					video.setVideo_path(path+fileName);
					//map = subjectService.importExcel(user, "", path+fileName);
					map.put("path",path+fileName);
					map.put("code","success");
					map.put("name",fileName);
				}
				
			}
			
		}else{
			map.put("code","error");
		}
		PrintWriter out = null;
		try {
			String rs = JSON.toJSONString(map);
			out = response.getWriter();
			out.print(rs);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
	}
	@RequestMapping("uploadTransportPic.do")
	public void  uploadTransportPic(HttpServletRequest request,HttpServletResponse response)
			throws IllegalStateException, IOException, JSONException
	{
		Map<String,Object> map = new HashMap<String, Object>();;
		String path  = request.getSession().getServletContext().getRealPath("/")+picPath+"\\";
		
		//将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
		CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(
				request.getSession().getServletContext());
		//检查form中是否有enctype="multipart/form-data"
		if(multipartResolver.isMultipart(request))
		{
			//将request变成多部分request
			MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
			//获取multiRequest 中所有的文件名
			Iterator<?> iter=multiRequest.getFileNames();
			String fileName = null;
			String nowDate = null;
			while(iter.hasNext())
			{
				//一次遍历所有文件
				MultipartFile file=multiRequest.getFile(iter.next().toString());
				if(file!=null)
				{
					nowDate = DateUtils.getCurrentDate("yyyyMMddHHmmss");
					//fileName = user.getUserid()+"_"+nowDate+file.getOriginalFilename();
					fileName = file.getOriginalFilename();
                	String prefix=fileName.substring(fileName.lastIndexOf(".")+1);
                	fileName = nowDate+"."+prefix;
					map.put("filename",file.getOriginalFilename());
					//上传
					file.transferTo(new File(path+fileName));
					Video video = new Video();
					video.setVideo_id(UUID.randomUUID().toString());
					video.setVideo_path(path+fileName);
					//map = subjectService.importExcel(user, "", path+fileName);
					map.put("path",path+fileName);
					map.put("code","success");
					map.put("name",fileName);
				}
				
			}
			
		}else{
			map.put("code","error");
		}
		PrintWriter out = null;
		try {
			String rs = JSON.toJSONString(map);
			out = response.getWriter();
			out.print(rs);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
	}
	
	@RequestMapping("watchVideo")
	public String watchVideo(HttpServletRequest request,Model model,String path){
		model.addAttribute("video", path);
		return "video/watchVideo";
	}
}
