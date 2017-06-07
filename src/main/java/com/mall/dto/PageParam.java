package com.mall.dto;

/**
 * Description: 将查询条件和分页参数整合到一起 
 * @author Li Zheng
 * @date 2017年6月7日下午5:06:44
 */
public class PageParam<T> {

    /**
     * 页码
     */
    private Integer pno;
    
    /**
     * 页大小
     */
    private Integer pageSize;
    
    /**
     * 携带参数
     */
    private T obj;

    public PageParam() {}

    public PageParam(Integer pno, Integer pageSize, T obj) {
        this.pno = pno;
        this.pageSize = pageSize;
        this.obj = obj;
    }

    public Integer getPno() {
        return pno;
    }

    public void setPno(Integer pno) {
        this.pno = pno;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public T getObj() {
        return obj;
    }

    public void setObj(T obj) {
        this.obj = obj;
    }
    
}
