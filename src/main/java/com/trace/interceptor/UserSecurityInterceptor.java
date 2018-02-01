package com.trace.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.trace.util.Log4JUtils;


public class UserSecurityInterceptor implements HandlerInterceptor{

    private List<String> excludedUrls;
    
    @Override
    public void afterCompletion(HttpServletRequest arg0,
            HttpServletResponse arg1, Object arg2, Exception arg3)
            throws Exception {
        
    }

    public List<String> getExcludedUrls() {
        return excludedUrls;
    }

    public void setExcludedUrls(List<String> excludedUrls) {
        this.excludedUrls = excludedUrls;
    }

    @Override
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
            Object arg2, ModelAndView arg3) throws Exception {
        
    }

    @Override
    public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1,
            Object arg2) throws Exception {
        
        String requestUri = arg0.getRequestURI();
        for (String url : excludedUrls) {
            if (requestUri.endsWith(url)) {
                return true;
            }
        }
        
        HttpSession session = arg0.getSession();
        if (session.getAttribute("user") == null) {
            Log4JUtils.getLogger().info(requestUri);
            if(requestUri.contains("sync")){
            	return true;
            }
            if(requestUri.contains("mall")){
            	arg1.sendRedirect(arg0.getContextPath() + "/mall/login.do");
            }else if(requestUri.contains("baseInfo")||
            		requestUri.contains("meat")||
            		requestUri.contains("require")||
            		requestUri.contains("purchase")||
            		requestUri.contains("distribution")){
            	arg1.sendRedirect(arg0.getContextPath() + "/baseInfo/login.do");
            }
            else{
            	arg1.sendRedirect(arg0.getContextPath() + "/login.do");
            }
        }
        return true;
    }

}
