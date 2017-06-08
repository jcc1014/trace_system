package com.mall.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mall.dto.PageParam;
import com.mall.dto.Result;
import com.mall.enums.DictTypeEnum;
import com.mall.enums.ResultEnum;
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
	 * Description: 打开商品列表页
	 * @author Li Zheng
	 * @date 2017年6月8日下午10:28:39
	 * @param goods 查询条件
	 * @param page
	 * @param pageSize
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("list.do")
	public String listGoods(Goods goods, Integer page, Integer pageSize, ModelMap modelMap) {
		Long total = goodsService.count(goods);
		PageParam<Goods> pageParam = new PageParam<Goods>(page, pageSize, total, goods);
		List<Goods> list = goodsService.selectByPage(pageParam);
		List<Dict> types = dictService.selectByExample(new Dict(DictTypeEnum.VEGETABLES));
		modelMap.put("list", list);
		modelMap.put("types", types);
		modelMap.put("condition", pageParam);
	    return "goods/goods_list";
	}
	
	
	
	/**
	 * Description: 添加商品
	 * @author Li Zheng
	 * @date 2017年6月8日下午10:29:04
	 * @param request
	 * @param goods
	 * @return
	 */
	@RequestMapping("add.do")
	public String addGoods(HttpServletRequest request,Goods goods){
		return null;
	}
	
	/**
	 * Description: 删除商品
	 * @author Li Zheng
	 * @date 2017年6月8日下午11:34:34
	 * @param goods_id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "delete.do", produces = "application/json;charset=utf-8")
	public Result<Goods> deleteGoods(String id) {
		int rows = goodsService.deleteByPrimaryKey(id);
		if (rows > 0) {
			return new Result<>(ResultEnum.SUCCESS);
		}
		return new Result<>(ResultEnum.FAILURE);
	}
}
