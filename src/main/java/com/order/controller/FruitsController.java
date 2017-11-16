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
import com.order.po.Fruit;
import com.order.po.PsFruit;
import com.order.po.RequireFruit;
import com.order.po.SalePrice;
import com.order.service.FruitService;
import com.order.service.PsFruitService;
import com.order.service.RequireFruitService;
import com.order.service.SalePriceService;
import com.trace.po.Qrcode;
import com.trace.service.QrcodeService;
import com.trace.util.DateUtils;
import com.trace.util.QRCodeUtil;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("fruit")
public class FruitsController {

	@Autowired
	private FruitService fruitService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private RequireFruitService requireFruitService;
	@Autowired
	private PsFruitService psFruitSevice;
	@Autowired
	private SalePriceService salePriceService;
	@Autowired
	private QrcodeService qrcodeService;
	
	@RequestMapping("add")
	public String add(HttpServletRequest request,Model model){
		Goods goods = new Goods();
		goods.setGoods_type("00f9667f-976a-4728-b122-2c6d7ef7d3b8");
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("pch", "f"+DateUtils.getCurrentDate("yyMMddHHmmss"));
		return "orderModule/fruit/add";
		
	}
	@RequestMapping("addSave")
	@ResponseBody
	public String addMeat(HttpServletRequest request,Fruit fruit,SalePrice salePrice){
		fruit.setId(UUIDFactory.getInstance().newUUID());
		fruit.setRemain(fruit.getNum());
		fruit.setRksj(DateUtils.getCurrentDate("yyyy-MM-dd"));
		salePrice.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		salePrice.setId(UUIDFactory.getInstance().newUUID());
		salePrice.setStatus("1");
		int r = fruitService.insertSelective(fruit);
		if(r==1){
			salePriceService.insertSelective(salePrice);
		}
		String rs = ResultUtil.resultString(r);
		return rs;
		
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delMeat(HttpServletRequest request,String id){
		int r = fruitService.deleteByPrimaryKey(id);
		String rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	@RequestMapping("list")
	public String list(HttpServletRequest request,Model model,Fruit fruit){
		String page = "orderModule/fruit/list";
		List<Fruit> list = fruitService.select(fruit);
		model.addAttribute("list", list);
		return page;
		
	}
	
	@RequestMapping("requireList")
	public String requireList(HttpServletRequest request,Model model,RequireFruit requireFruit){
		String page = "orderModule/fruit/requireList";
		requireFruit.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		requireFruit.setStatus("0");
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		requireFruit.setBaseid(null!=baseInfo?baseInfo.getId():null);
		List<RequireFruit> list1 = requireFruitService.select(requireFruit);
		requireFruit.setStatus("1");
		List<RequireFruit> list2 = requireFruitService.select(requireFruit);
		List<RequireFruit> list = new ArrayList<RequireFruit>();
		list.addAll(list1);
		list.addAll(list2);
		model.addAttribute("list", list);
		return page;
	}
	@RequestMapping("require_add")
	public String require_add(HttpServletRequest request,Model model){
		Goods goods = new Goods();
		goods.setGoods_type("00f9667f-976a-4728-b122-2c6d7ef7d3b8"); //水果
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		return "orderModule/fruit/require_add";
		
	}
	
	@RequestMapping("addRequire")
	@ResponseBody
	public String addRequire(HttpServletRequest request,Model model,RequireFruit requireFruit){
		String rs = "";
		requireFruit.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		requireFruit.setStatus("0");
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		requireFruit.setBaseid(null!=baseInfo?baseInfo.getId():null);
		requireFruit.setId(UUIDFactory.getInstance().newUUID());
		requireFruit.setRemain(requireFruit.getNum());
		int r = requireFruitService.insertSelective(requireFruit);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	@RequestMapping("submitRequire")
	@ResponseBody
	public String submitRequire(HttpServletRequest request,Model model,RequireFruit requireFruit){
		String rs = "";
		requireFruit.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		requireFruit.setStatus("1");
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		requireFruit.setBaseid(null!=baseInfo?baseInfo.getId():null);
		int r = requireFruitService.updateStatus(requireFruit);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	
	@RequestMapping("salePrice")
	public String salePrice(HttpServletRequest request,SalePrice salePrice,Model model){
		String page = "redirect:saleList.do";
		Fruit fruit = new Fruit();
		fruit.setRksj(DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<Fruit> list = fruitService.select(fruit);
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
		List<SalePrice> salePriceList = salePriceService.selectFruitPrice(map);
		model.addAttribute("salePriceList", salePriceList);
		return "orderModule/fruit/salePrice";
	}
	
	@RequestMapping("confirmList")
	public String confirmList(HttpServletRequest request,Model model,RequireFruit requireFruit){
		String page = "orderModule/fruit/confirm_list";
		requireFruit.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		requireFruit.setStatus("2");
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		requireFruit.setBaseid(null!=baseInfo?baseInfo.getId():null);
		List<RequireFruit> list = requireFruitService.select(requireFruit);
		if(0==list.size()){
			requireFruit.setStatus("3");
			list = requireFruitService.select(requireFruit);
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
		model.addAttribute("time", requireFruit.getDatetime());
		model.addAttribute("baseInfo", baseInfo);
		
		return page;
	}
	
	@RequestMapping("detail")
	public String ps_detail(HttpServletRequest request,Model model,String id){
		String page = "orderModule/fruit/detail";
		PsFruit psFruit = new PsFruit();
		//psFruit.setRequire_id(id);
		List<PsFruit> list = psFruitSevice.select(psFruit);
		model.addAttribute("list", list);
		return page;
	}
	
	@RequestMapping("sign")
	public String confirm(HttpServletRequest request,Model model,String time,String baseid){
		String rs = "orderModule/fruit/sign";
		model.addAttribute("time", time);
		model.addAttribute("baseid", baseid);
		return rs;
	}
	@RequestMapping("signSave")
	@ResponseBody
	public String signSave(HttpServletRequest request,Model model,String time,String baseid,String signname){
		String rs = "orderModule/fruit/requireList";
		RequireFruit requireFruit = new RequireFruit();
		requireFruit.setDatetime(time);
		requireFruit.setStatus("3");
		requireFruit.setBaseid(baseid);
		requireFruit.setSign(signname);
		int r = requireFruitService.updateByTimeAndBaseId(requireFruit);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	@RequestMapping("getRemain")
	@ResponseBody
	public String getRemain(HttpServletRequest request,String pch){
		String rs = "";
		Fruit fruit = new Fruit();
		fruit.setPch(pch);
		List<Fruit> list = fruitService.select(fruit);
		if(1==list.size()){
			fruit = list.get(0);
			rs = JSON.toJSONString(fruit);
		}
		return rs;
	}
	
	@RequestMapping("ps")
	public String ps(HttpServletRequest request,Model model,String id){
		String page = "orderModule/fruit/ps";
		RequireFruit requireFruit = requireFruitService.selectByPrimaryKey(id);
		Fruit fruit = new Fruit();
		fruit.setDatetime(requireFruit.getDatetime());
		fruit.setKind(requireFruit.getKind());
		fruit.setGrade(requireFruit.getGrade());
		List<Fruit> fruitList = fruitService.select(fruit);
		model.addAttribute("fruitList", fruitList);
		model.addAttribute("requireFruit", requireFruit);
		model.addAttribute("pch", "fruitps"+DateUtils.getCurrentDate("yyMMddHHmmss"));
		return page;
	}
	@RequestMapping("psList")
	public String psList(HttpServletRequest request,Model model,String id){
		String page = "orderModule/fruit/ps_list";
		RequireFruit requireFruit = new RequireFruit();
		requireFruit.setDatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		requireFruit.setStatus("1");
		List<RequireFruit> list1 = requireFruitService.select(requireFruit);
		requireFruit.setStatus("2");
		List<RequireFruit> list2 = requireFruitService.select(requireFruit);
		List<RequireFruit> list = new ArrayList<RequireFruit>();
		list.addAll(list1);
		list.addAll(list2);
		model.addAttribute("list", list);
		return page;
	}
	@RequestMapping("psDetailList")
	public String psDetailList(HttpServletRequest request,Model model,String id){
		String page = "orderModule/fruit/ps_detail_list";
		RequireFruit requireFruit = requireFruitService.selectByPrimaryKey(id);
		PsFruit psFruit = new PsFruit();
		psFruit.setRequire_id(id);
		List<PsFruit> list = psFruitSevice.select(psFruit);
		model.addAttribute("list", list);
		model.addAttribute("requireFruit", requireFruit);
		return page;
	}
	@RequestMapping("psSave")
	@ResponseBody
	public String psSave(HttpServletRequest request,Model model,PsFruit psFruit){
		String rs = "";
		psFruit.setId(UUIDFactory.getInstance().newUUID());
		Qrcode qrcode = new Qrcode();
		qrcode.setQrcode_id(UUIDFactory.getInstance().newUUID());
		String path  = request.getSession().getServletContext().getRealPath("/")+"qrcode\\";
		String logoPath  = request.getSession().getServletContext().getRealPath("/")+"\\images\\qrcode_logo.png";
		String content = "http://119.188.168.205:8080/trace_system/fruit/qrcode.do?id="+psFruit.getId();
		String filename = UUIDFactory.getInstance().newUUID();
		try {
			QRCodeUtil.encode(content, logoPath, path, filename, true);
			qrcode.setQrcode_path(filename+".jpg");
			qrcodeService.add(qrcode);
			psFruit.setQrcode(qrcode.getQrcode_id());
			psFruit.setStatus("1");
		} catch (Exception e) {
			e.printStackTrace();
		}
		int r = psFruitSevice.insertSelective(psFruit);
		if(r==1){
			RequireFruit requireFruit = requireFruitService.selectByPrimaryKey(psFruit.getRequire_id());
			double remain = requireFruit.getRemain();
			double num = psFruit.getNum();
			if(remain>num||remain==num){
				requireFruit.setRemain(remain-num);
				if(remain==num){
					requireFruit.setStatus("2");
				}
				requireFruitService.updateByPrimaryKeySelective(requireFruit);
			}
			Fruit fruit = new Fruit();
			fruit.setPch(psFruit.getPch());
			List<Fruit> meatList = fruitService.select(fruit);
			if(1==meatList.size()){
				fruit = meatList.get(0);
				fruit.setRemain(fruit.getRemain()-psFruit.getNum());
				fruitService.updateByPrimaryKeySelective(fruit);
			}
		}
		rs = ResultUtil.resultString(r);
		return rs;
	}
	
	@RequestMapping("qrcode")
	public String qrcode(HttpServletRequest request,String id,Model model){
		String page = "";
		PsFruit psFruit = psFruitSevice.selectByPrimaryKey(id);
		if(null!= psFruit){
			model.addAttribute("psFruit", psFruit);
			Fruit fruit = new Fruit();
			fruit.setPch(psFruit.getPch());
			List<Fruit> fruitList = fruitService.select(fruit);
			model.addAttribute("fruit", fruitList.size()>0?fruitList.get(0):null);
		}
		return page;
	}
}
