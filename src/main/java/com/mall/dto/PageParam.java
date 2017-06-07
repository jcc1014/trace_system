package com.mall.dto;

/**
 * Description: ����ѯ�����ͷ�ҳ�������ϵ�һ�� 
 * @author Li Zheng
 * @date 2017��6��7������5:06:44
 */
public class PageParam<T> {

    /**
     * ҳ��
     */
    private Integer pno;
    
    /**
     * ҳ��С
     */
    private Integer pageSize;
    
    /**
     * Я������
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
