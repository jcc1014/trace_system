package com.mall.controller;

import com.mall.dto.PageParam;
import com.mall.dto.Result;
import com.mall.enums.DictTypeEnum;
import com.mall.enums.ResultEnum;
import com.mall.po.Dict;
import com.mall.po.Goods;
import com.mall.service.DictService;
import com.mall.service.GoodsPicService;
import com.mall.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("goods")
public class GoodsController {

	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private DictService dictService;

	@Autowired
	private GoodsPicService goodsPicService;

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
	 * @param add
	 * @return
	 */
	@RequestMapping("edit.do")
	public String addGoods(boolean add, ModelMap modelMap){
		modelMap.put("add", add);
		return "goods/goods_add";
	}
	
	/**
	 * Description: 删除商品
	 * @author Li Zheng
	 * @date 2017年6月8日下午11:34:34
	 * @param id
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

    /**
     * Description: 上传商品图片
     * @author Li Zheng
     * @date 2017年6月14日16:41:29
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "uploadPic.do", produces = "application/json;charset=utf-8")
    public Result<Map<String, String>> uploadPic(HttpServletRequest request, @RequestParam("file") MultipartFile file) {
        try {
            String dirName = "/uploadPic";
            String path = request.getSession().getServletContext().getRealPath(dirName);
            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdir();
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //后缀
            String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            String fileName = sdf.format(new Date()) + (int)(Math.random() * 10000) + suffix;
            String picPath = path + File.separator + fileName;

            File pic = new File(picPath);
            file.transferTo(pic);
            String src = request.getContextPath() + dirName + "/" + fileName;
            Map<String, String> map = new HashMap<>();
            map.put("realPath", picPath);
            map.put("src", src);
            return new Result<>(ResultEnum.SUCCESS, map);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result<>(ResultEnum.FAILURE);
        }
    }

    /**
     * Description: 删除已上传的图片
     * @author liz
     * @date 2017-06-14 22点40分
     * @param realPath
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deletePic.do", produces = "application/json;charset=utf-8")
    public Result<String> deletePic(String realPath) {
	    try {
	        File file = new File(realPath);
	        if (file.exists()) {
	            file.delete();
            }
            return new Result<>(ResultEnum.SUCCESS);
        } catch (Exception e) {
	        e.printStackTrace();
	        return new Result<>(ResultEnum.FAILURE);
        }
    }
}
