package com.mall.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mall.dto.PageParam;
import com.mall.enums.DictTypes;
import com.mall.po.Dict;
import com.mall.po.Goods;
import com.mall.service.DictService;
import com.mall.service.GoodsService;

@Controller
@RequestMapping("goods")
public class GoodsController {

	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private DictService dictService;
	
	/**
	 * Description: ����Ʒ�б� 
	 * @author Li Zheng
	 * @date 2017��6��7������4:56:41
	 * @return
	 */
	@RequestMapping("list.do")
	public String goodsList(Goods goods, Integer page, Integer pageSize, ModelMap modelMap) {
		Long total = goodsService.count(goods);
		PageParam<Goods> pageParam = new PageParam<Goods>(page, pageSize, total, goods);
		List<Goods> list = goodsService.selectByPage(pageParam);
		List<Dict> types = dictService.selectByExample(new Dict(DictTypes.VEGETABLES));
		modelMap.put("list", list);
		modelMap.put("types", types);
		modelMap.put("condition", pageParam);
	    return "goods/goods_list";
	}
	
	
	
	/**
	 * ����ϵͳǰ��̨��ͨ���Լ����ݿ���ͨ�����Գɹ���
	 * @param request
	 * @param goods
	 * @return
	 */
	@RequestMapping("add")
	public String addGoods(HttpServletRequest request,Goods goods){
		goods.setGoods_id(UUID.randomUUID().toString());
		goods.setGoods_name("������");
		goods.setGoods_type("tomato");
		goodsService.insertSelective(goods);
		return null;
	}
}
