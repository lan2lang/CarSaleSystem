package com.car.entity;

import java.util.List;

/**
 * 分页实体类
 * @param <T>
 */
public class PageList<T>
{
	//处理后的数据（List）
	private List<T> data;

	//当前页码
	private int pageIndex = 1;

	//页大小
	private int pageSize = 5;

	//总记录数
	private int count = 0;

	public int getPageIndex()
	{
		return pageIndex;
	}

	public void setPageIndex(int pageIndex)
	{
		this.pageIndex = pageIndex;
	}

	public int getPageSize()
	{
		return pageSize;
	}

	public void setPageSize(int pageSize)
	{
		this.pageSize = pageSize;
	}

	public List<T> getData()
	{
		return data;
	}

	public void setData(List<T> data)
	{
		this.data = data;
	}

	public int getCount()
	{
		return count;
	}

	public void setCount(int count)
	{
		this.count = count;
	}

	public int getFirstSeq()
	{
		return (this.pageIndex - 1) * this.pageSize;
	}

	public PageList() {
	}

	public PageList(int pageIndex, int pageSize) {
		this.pageIndex = pageIndex;
		this.pageSize = pageSize;
	}

	/**
	 * 获取总页数
	 * @return
	 */
	public int getPageCount()
	{
		return (this.count - 1) / this.pageSize + 1;
		//return this.count % this.pageSize == 0 ? this.count / this.pageSize  : (this.count / this.pageSize) + 1;
	}
}
