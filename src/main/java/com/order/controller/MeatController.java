package com.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.po.Goods;
import com.mall.service.GoodsService;
import com.order.po.BaseInfo;
import com.order.po.Meat;
import com.order.po.PsMeat;
import com.order.po.RequireMeat;
import com.order.po.SalePrice;
import com.order.service.MeatService;
import com.order.service.PsMeatService;
import com.order.service.RequireMeatService;
import com.order.service.SalePriceService;
import com.trace.po.Qrcode;
import com.trace.service.QrcodeService;
import com.trace.util.DateUtils;
import com.trace.util.QRCodeUtil;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("meat")
public class MeatController {

	@Autowired
	private MeatService meatService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private RequireMeatService requireMeatService;
	@Autowired
	private PsMeatService psMeatService;
	@Autowired
	private SalePriceService salePriceService;
	@Autowired
	private QrcodeService qrcodeService;
	
	@RequestMapping("add")
	public String add(HttpServletRequest request,Model model){
		Goods goods = new Goods();
		goods.setGoods_type("2");
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("pch", "m"+DateUtils.getCurrentDate("yyMMddHHmmss"));
		return "orderModule/meat/add";
		
	}
	@RequestMapping("addSave")
	@ResponseBody
	public String addMeat(HttpServletRequest request,Meat meat,SalePrice salePrice){
		meat.setId(UUIDFactory.getInstance().newUUID());
		meat.setRemain(meat.getNum());
		meat.setRksj(DateUtils.getCurrentDate("yyyy-MM-dd"));
		salePrice.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		salePrice.setId(UUIDFactory.getInstance().newUUID());
		salePrice.setStatus("1");
		int r = meatService.insertSelective(meat);
		if(r==1){
			salePriceService.insertSelective(salePrice);
		}
		String rs = ResultUtil.resultString(r);
		return rs;
		
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delMeat(HttpServletRequest request,String id){
		int r = meatService.deleteByPrimaryKey(id);
		String rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	@RequestMapping("list")
	public String list(HttpServletRequest request,Model model,Meat meat){
		String page = "orderModule/meat/list";
		List<Meat> list = meatService.select(meat);
		model.addAttribute("list", list);
		return page;
		
	}
	
	@RequestMapping("requireList")
	public String requireList(HttpServletRequest request,Model model,RequireMeat requireMeat){
		String page = "orderModule/meat/requireList";
		requireMeat.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		requireMeat.setStatus("0");
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		requireMeat.setBaseid(null!=baseInfo?baseInfo.getId():null);
		List<RequireMeat> list1 = requireMeatService.select(requireMeat);
		requireMeat.setStatus("1");
		List<RequireMeat> list2 = requireMeatService.select(requireMeat);
		List<RequireMeat> list = new ArrayList<RequireMeat>();
		list.addAll(list1);
		list.addAll(list2);
		model.addAttribute("list", list);
		return page;
	}
	@RequestMapping("require_add")
	public String require_add(HttpServletRequest request,Model model){
		Goods goods = new Goods();
		goods.setGoods_type("2");
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		return "orderModule/meat/require_add";
		
	}
	
	@RequestMapping("addRequire")
	@ResponseBody
	public String addRequire(HttpServletRequest request,Model model,RequireMeat requireMeat){
		String rs = "";
		requireMeat.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		requireMeat.setStatus("0");
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		requireMeat.setBaseid(null!=baseInfo?baseInfo.getId():null);
		requireMeat.setId(UUIDFactory.getInstance().newUUID());
		requireMeat.setRemain(requireMeat.getNum());
		int r = requireMeatService.insertSelective(requireMeat);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	@RequestMapping("submitRequire")
	@ResponseBody
	public String submitRequire(HttpServletRequest request,Model model,RequireMeat requireMeat){
		String rs = "";
		requireMeat.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		requireMeat.setStatus("1");
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		requireMeat.setBaseid(null!=baseInfo?baseInfo.getId():null);
		int r = requireMeatService.updateStatus(requireMeat);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	
	@RequestMapping("salePrice")
	public String salePrice(HttpServletRequest request,SalePrice salePrice,Model model){
		String page = "redirect:saleList.do";
//		RequireMeat requireMeat = new RequireMeat();
//		requireMeat.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
//		requireMeat.setStatus("0");
//		List<RequireMeat> list = requireMeatService.select(requireMeat);
		Meat meat = new Meat();
		meat.setRksj(DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<Meat> list = meatService.select(meat);
		SalePrice salePrice2 = null;
		List<SalePrice> l = null;
		for (int i = 0; i < list.size(); i++) {
			salePrice2 = new SalePrice();
			salePrice2.setKind(list.get(i).getKind());
			salePrice2.setGrade(list.get(i).getGrade());
			salePrice2.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
			l = salePriceService.select(salePrice2);
			if(null==l||0==l.size()){
				salePrice2.setStatus("0");
				salePrice2.setId(UUIDFactory.getInstance().newUUID());
				salePrice2.setId(UUIDFactory.getInstance().newUUID());
				salePriceService.insertSelective(salePrice2);
			}
		}
		
		return page;
	}
	
	@RequestMapping("saleList")
	public String saleList(HttpServletRequest request,Model model){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("date", DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<SalePrice> salePriceList = salePriceService.selectMeatPrice(map);
		model.addAttribute("salePriceList", salePriceList);
		return "orderModule/meat/salePrice";
	}
	
	@RequestMapping("confirmList")
	public String confirmList(HttpServletRequest request,Model model,RequireMeat requireMeat){
		String page = "orderModule/meat/confirm_list";
		requireMeat.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		requireMeat.setStatus("2");
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		requireMeat.setBaseid(null!=baseInfo?baseInfo.getId():null);
		List<RequireMeat> list = requireMeatService.select(requireMeat);
		if(0==list.size()){
			requireMeat.setStatus("3");
			list = requireMeatService.select(requireMeat);
			if(0==list.size()){
				model.addAttribute("signname", "wu");
			}else{
				model.addAttribute("signname", "yes");
				model.addAttribute("signnameUrl", list.get(0).getSign());
				model.addAttribute("require_id", list.get(0).getId());
			}
		}else{
			model.addAttribute("signname", "no");
		}
		model.addAttribute("list", list);
		model.addAttribute("time", requireMeat.getDatetime());
		model.addAttribute("baseInfo", baseInfo);
		
		return page;
	}
	
	@RequestMapping("detail")
	public String ps_detail(HttpServletRequest request,Model model,String id){
		String page = "orderModule/meat/detail";
		PsMeat psMeat = new PsMeat();
		psMeat.setRequire_id(id);
		List<PsMeat> list = psMeatService.select(psMeat);
		model.addAttribute("list", list);
		return page;
	}
	
	@RequestMapping("sign")
	public String confirm(HttpServletRequest request,Model model,String time,String baseid){
		String rs = "orderModule/meat/sign";
		model.addAttribute("time", time);
		model.addAttribute("baseid", baseid);
		return rs;
	}
	@RequestMapping("signSave")
	@ResponseBody
	public String signSave(HttpServletRequest request,Model model,String time,String baseid,String signname){
		String rs = "orderModule/meat/requireList";
		RequireMeat requireMeat = new RequireMeat();
		requireMeat.setDatetime(time);
		requireMeat.setStatus("3");
		requireMeat.setBaseid(baseid);
		requireMeat.setSign(signname);
		int r = requireMeatService.updateByTimeAndBaseId(requireMeat);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	@RequestMapping("getRemain")
	@ResponseBody
	public String getRemain(HttpServletRequest request,String pch){
		String rs = "";
		Meat meat = new Meat();
		meat.setPch(pch);
		List<Meat> list = meatService.select(meat);
		if(1==list.size()){
			meat = list.get(0);
			rs = JSON.toJSONString(meat);
		}
		return rs;
	}
	
	@RequestMapping("ps")
	public String ps(HttpServletRequest request,Model model,String id){
		String page = "orderModule/meat/ps";
		RequireMeat requireMeat = requireMeatService.selectByPrimaryKey(id);
		Meat meat = new Meat();
		meat.setDatetime(requireMeat.getDatetime());
		meat.setKind(requireMeat.getKind());
		meat.setGrade(requireMeat.getGrade());
		List<Meat> meatList = meatService.select(meat);
		model.addAttribute("meatList", meatList);
		model.addAttribute("requireMeat", requireMeat);
		model.addAttribute("pch", "ps"+DateUtils.getCurrentDate("yyMMddHHmmss"));
		return page;
	}
	@RequestMapping("psList")
	public String psList(HttpServletRequest request,Model model,String id){
		String page = "orderModule/meat/ps_list";
		RequireMeat requireMeat = new RequireMeat();
		requireMeat.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		requireMeat.setStatus("1");
		List<RequireMeat> list1 = requireMeatService.select(requireMeat);
		model.addAttribute("list", list1);
		return page;
	}
	@RequestMapping("psSave")
	@ResponseBody
	public String psSave(HttpServletRequest request,Model model,PsMeat psMeat){
		String rs = "";
		psMeat.setId(UUIDFactory.getInstance().newUUID());
		Qrcode qrcode = new Qrcode();
		qrcode.setQrcode_id(UUIDFactory.getInstance().newUUID());
		String path  = request.getSession().getServletContext().getRealPath("/")+"qrcode\\";
		String logoPath  = request.getSession().getServletContext().getRealPath("/")+"\\images\\qrcode_logo.png";
		String content = "http://jingcc.xin:8080/trace_system/meat/qrcode.do?id="+psMeat.getId();
		String filename = UUIDFactory.getInstance().newUUID();
		try {
			QRCodeUtil.encode(content, logoPath, path, filename, true);
			qrcode.setQrcode_path(filename+".jpg");
			qrcodeService.add(qrcode);
			psMeat.setQrcode(qrcode.getQrcode_id());
			psMeat.setStatus("1");
		} catch (Exception e) {
			e.printStackTrace();
		}
		int r = psMeatService.insertSelective(psMeat);
		if(r==1){
			RequireMeat requireMeat = requireMeatService.selectByPrimaryKey(psMeat.getRequire_id());
			double remain = requireMeat.getRemain();
			double num = psMeat.getNum();
			if(remain>num||remain==num){
				requireMeat.setRemain(remain-num);
				if(remain==num){
					requireMeat.setStatus("2");
				}
				requireMeatService.updateByPrimaryKeySelective(requireMeat);
			}
			Meat meat = new Meat();
			meat.setPch(psMeat.getPch());
			List<Meat> meatList = meatService.select(meat);
			if(1==meatList.size()){
				meat = meatList.get(0);
				meat.setRemain(meat.getRemain()-psMeat.getNum());
				meatService.updateByPrimaryKeySelective(meat);
			}
		}
		rs = ResultUtil.resultString(r);
		return rs;
	}
	
	@RequestMapping("qrcode")
	public String qrcode(HttpServletRequest request,String id,Model model){
		String page = "";
		PsMeat psMeat = psMeatService.selectByPrimaryKey(id);
		if(null!= psMeat){
			model.addAttribute("psMeat", psMeat);
			Meat meat = new Meat();
			meat.setPch(psMeat.getPch());
			List<Meat> meatList = meatService.select(meat);
			model.addAttribute("meat", meatList.size()>0?meatList.get(0):null);
		}
		return page;
	}
}
