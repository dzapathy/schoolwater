package com.action;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.types.ObjectId;

import bean.TableContentInfo;
import bean.TableInfo;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class AllTableDeleteTableAction extends ActionSupport{
	private String tableId;
	
	public void deleteTable() throws Exception{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		//执行删除操作
		TableInfo info = new TableInfo();	//删除头信息
		info.set_id(new ObjectId(tableId));
		BasicDBObject query1 = CreateQueryFromBean.EqualObj(info);
		DaoImpl.DeleteDocment(TableInfo.class, query1);
		
		TableContentInfo contentInfo = new TableContentInfo();	//删除具体信息
		contentInfo.setTableId(new ObjectId(tableId));
		BasicDBObject query2 = CreateQueryFromBean.EqualObj(contentInfo);
		DaoImpl.DeleteDocment(TableContentInfo.class, query2);
		
		response.getWriter().print("true");
	}

	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
}
