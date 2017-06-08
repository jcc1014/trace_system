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
    private Integer page;
    
    /**
     * 页大小
     */
    private Integer pageSize;
    
    /**
     * 开始行（用于sql limit）
     */
    private Integer startRow;
    
    /**
     * 总页数
     */
    private Integer totalPages;
    
    /**
     * 总记录数
     */
    private Long totalRecords;
    
    /**
     * 携带参数
     */
    private T obj;

    public PageParam() {}

    public PageParam(T obj) {
    	this(null, null, obj);
    }
    
    public PageParam(Integer page, T obj) {
    	this(page, null, obj);
    }
    
    public PageParam(Integer page, Integer pageSize, T obj) {
        this.page = page == null || page == 0 ? 1 : page;
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
