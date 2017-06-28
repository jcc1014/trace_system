package com.mall.controller;

import com.mall.dto.PageParam;
import com.mall.dto.Result;
import com.mall.enums.ResultEnum;
import com.mall.po.Dict;
import com.mall.po.Goods;
import com.mall.po.GoodsPic;
import com.mall.service.DictService;
import com.mall.service.GoodsPicService;
import com.mall.service.GoodsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.io.UnsupportedEncodingException;
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
	 * @return
	 */
	@RequestMapping("list.do")
	public String listGoods(Goods goods, Integer page, Integer pageSize, ModelMap modelMap) {
		Long total = goodsService.count(goods);
		/*if(null!=goods.getGoods_name()&&!"".equals(goods.getGoods_name())){
			try {
				goods.setGoods_name(new String(goods.getGoods_name().getBytes("ISO8859-1"),"UTF-8")) ;
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}*/
		PageParam<Goods> pageParam = new PageParam<Goods>(page, pageSize, total, goods);
		List<Goods> list = goodsService.selectByPage(pageParam);
		List<Dict> types = dictService.selectByParentId("0");
		modelMap.put("list", list);
		modelMap.put("types", types);
		modelMap.put("condition", pageParam);
	    return "goods/goods_list";
	}

	/**
	 * Description: 添加商品
	 * @author Li Zheng
	 * @date 2017年6月8日下午10:29:04
	 * @return
	 */
	@RequestMapping("edit.do")
    public String addGoods(String goods_id, ModelMap modelMap) {
	    if (!StringUtils.isEmpty(goods_id)) {
	        Goods goods = goodsService.selectByPrimaryKey(goods_id);
	        modelMap.put("goods", goods);
            List<GoodsPic> pics = goodsPicService.selectByGoodsId(goods_id);
            modelMap.put("pics", pics);
        }
		List<Dict> types = dictService.selectByParentId("0");
		modelMap.put("types", types);
        return "goods/goods_add";
    }

    /**
     * @description 保存商品信息
     * @author liz
     * @date 2017/6/15 10:23
     */
    @ResponseBody
    @RequestMapping(value = "save.do", produces = "application/json;charset=utf-8")
    public Result<String> save(Goods goods, String goods_pic, String real_path, String del_pic_path) {
	    try {
            goodsService.insertGoodsAndPic(goods, StringUtils.isEmpty(goods_pic) ? null : goods_pic.split(","), StringUtils.isEmpty(real_path) ? null : real_path.split(","));
            if (!StringUtils.isEmpty(del_pic_path)) {
            	String[] del_arr = del_pic_path.split(",");
            	for (int i = 0; i < del_arr.length; i ++) {
					File file = new File(del_arr[i]);
					if (file.exists()) {
						file.delete();
					}
				}
			}
            return new Result<>(ResultEnum.SUCCESS);
        } catch (Exception e) {
	        return new Result<>(ResultEnum.FAILURE);
        }
    }

	/**
	 * Description: 删除商品
	 * @author Li Zheng
	 * @date 2017年6月8日下午11:34:34
	 * @param id 商品id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "delete.do", produces = "application/json;charset=utf-8")
	public Result<Goods> deleteGoods(String id) {
		int rows = goodsService.deleteByPrimaryKey(id);
		if (rows > 0) {
		    //删除图片
			List<GoodsPic> pics = goodsPicService.selectByGoodsId(id);
			if (pics != null && pics.size() > 0) {
				for (int i = 0; i < pics.size(); i ++) {
					GoodsPic pic = pics.get(i);
					String real_path = pic.getReal_path();
					if (StringUtils.isEmpty(real_path)) {
						continue;
					}
					File file = new File(real_path);
					if (file.exists()) {
						file.delete();
					}
				}
				goodsPicService.deleteByGoodsId(id);
			}
			return new Result<>(ResultEnum.SUCCESS);
		}
		return new Result<>(ResultEnum.FAILURE);
	}

    /**
     * @description 上传商品图片
     * @author liz
     * @date 2017/6/15 10:25
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

}
