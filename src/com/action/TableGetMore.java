package com.action;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import utils.LoadMore;
import utils.Util;

import bean.SearchTableContent;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class TableGetMore extends ActionSupport{
	private String lastContentId;
	private String tableId;
	private String columnName;
	
	public static final int limit =10;
	
	public void getMoreData() throws Exception{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		
		String [] columnNames = Util.DoGetString(columnName).split(",");
		
		//≤‚ ‘
		System.out.println("lastContentId:"+lastContentId);
		System.out.println("tableId"+tableId);
		for (int i = 0; i < columnNames.length; i++) {
			System.out.print(columnNames[i]+" ");
		}
		System.out.println();
		
		SearchTableContent searchTableContent = new SearchTableContent(tableId, lastContentId, columnNames, limit);
		String json = LoadMore.searchMore(searchTableContent);
		
		response.getWriter().print(json);
	}
	
	public String getLastContentId() {
		return lastContentId;
	}
	public void setLastContentId(String lastContentId) {
		this.lastContentId = lastContentId;
	}
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	
}
