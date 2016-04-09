package com.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.types.ObjectId;

import bean.Manager;
import bean.Organization;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 删除管理员的action
 * @author lliangx
 *
 */
@SuppressWarnings("serial")
public class ClubManagerAction extends ActionSupport{
	private String chk_value;//要删除的userid
	private String orgId;
	
	public void removeManager() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String [] deleteStr = chk_value.split("~");
		//查找删除
		for (int i = 0; i < deleteStr.length; i++) {
			Organization organization =  new Organization();
			organization.set_id(new ObjectId(orgId));
			ArrayList<Manager> managers = new ArrayList<Manager>();		
			Manager manager = new Manager();
			manager.setUserId(deleteStr[i]);
			managers.add(manager);				
			organization.setManager(managers);
			BasicDBObject query =CreateQueryFromBean.EqualObj(organization);
			DaoImpl.DeleteSonSomeBean(Organization.class, query, Manager.class, managers);
		}
		response.getWriter().print("true");
	}

	public String getChk_value() {
		return chk_value;
	}

	public void setChk_value(String chk_value) {
		this.chk_value = chk_value;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
}
