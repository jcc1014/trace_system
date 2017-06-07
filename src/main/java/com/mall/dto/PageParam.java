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
    private Integer page;
    
    /**
     * ҳ��С
     */
    private Integer pageSize;
    
    /**
     * ��ʼ�У�����sql limit��
     */
    private Integer startRow;
    
    /**
     * ��ҳ��
     */
    private Integer totalPages;
    
    /**
     * �ܼ�¼��
     */
    private Long totalRecords;
    
    /**
     * Я������
     */
    private T obj;

    public PageParam() {}

    public PageParam(Integer page, T obj) {
    	this(page, null, obj);
    }
    
    public PageParam(Integer page, Integer pageSize, T obj) {
        this.page = page;
        this.pageSize = pageSize == null || pageSize == 0 ? 8 : pageSize;
        this.obj = obj;
        this.startRow = this.page != null && this.page != 0 && this.pageSize != null && this.pageSize != 0 ? (this.page - 1) * this.pageSize : 0;
    }

    public PageParam(Integer pno, Integer pageSize, Long totalRecords, T obj) {
    	this(pno, pageSize, obj);
    	this.setTotalRecords(totalRecords);
    }
    
    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getStartRow() {
		return startRow;
	}

	public void setStartRow(Integer startRow) {
		this.startRow = startRow;
	}

	public Integer getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(Integer totalPages) {
		this.totalPages = totalPages;
	}

	public Long getTotalRecords() {
		return totalRecords;
	}

	public void setTotalRecords(Long totalRecords) {
		this.totalRecords = totalRecords;
		if(totalRecords != null && this.pageSize != null && this.pageSize != 0) {
			this.totalPages = (int)(totalRecords % this.pageSize == 0 ? totalRecords / this.pageSize : (totalRecords / this.pageSize) + 1);
		} else {
			this.totalPages = 0;
		}
	}

	public T getObj() {
        return obj;
    }

    public void setObj(T obj) {
        this.obj = obj;
    }
    
}
