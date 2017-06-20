package com.mall.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONException;
import com.trace.util.DateUtils;

@Controller
@RequestMapping("upload")
public class UploadController {

	@RequestMapping("upload")
	public void  uploadVideo(HttpServletRequest request,HttpServletResponse response,String path)
    		throws IllegalStateException, IOException, JSONException
    {
		Map<String,Object> map = new HashMap<String, Object>();;
		path  = request.getSession().getServletContext().getRealPath("/")+path+"\\";
		
        CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(
                request.getSession().getServletContext());
        if(multipartResolver.isMultipart(request))
        {
            MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
            Iterator<?> iter=multiRequest.getFileNames();
            String fileName = null;
            while(iter.hasNext())
            {
                MultipartFile file=multiRequest.getFile(iter.next().toString());
                if(file!=null)
                {
                	fileName = file.getOriginalFilename();
                	String prefix=fileName.substring(fileName.lastIndexOf(".")+1);
                	fileName = DateUtils.getCurrentDate("yyyyMMddHHmmss")+"."+prefix;
                	map.put("filename",file.getOriginalFilename());
                    file.transferTo(new File(path+fileName));
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
}
