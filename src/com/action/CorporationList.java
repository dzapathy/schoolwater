package com.action;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.types.ObjectId;

import utils.Util;
import bean.Organization;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class CorporationList  extends ActionSupport{
	private String oldClub;//id
	private String newClub;//name
	private String deleteClub;//ID
	
	//更新或添加社团
	public String addClub() throws Exception{
		//更新操作
		if(!"".equals(newClub.trim())&&!"".equals(oldClub.trim())&&newClub!=null&&oldClub!=null){
			Organization organization = new Organization();
			organization.set_id(new ObjectId(oldClub));
			BasicDBObject query = CreateQueryFromBean.EqualObj(organization);			
			Organization organization2 = new Organization();
			organization2.setName(Util.DoGetString(newClub.trim()));		
			DaoImpl.update(query, organization2, false);
			return SUCCESS;						
		}
		//插入操作
		if((!"".equals(newClub.trim()))&&newClub!=null&&"".equals(oldClub.trim())){					
			Organization organization = new Organization();
			organization.set_id(new ObjectId());
			String orid =(String)ServletActionContext.getContext().getSession().get("Organization_id");
			organization.setLevelTopId(new ObjectId(orid));
			organization.setName(Util.DoGetString(newClub.trim()));
			ObjectId schId = (ObjectId)ServletActionContext.getContext().getSession().get("Organization_SchoolId");
			organization.setSchoolId(schId);
			DaoImpl.InsertWholeBean(organization);
			return SUCCESS;
		}
		return ERROR;
	}
	
	//删除下属组织
	public void deleteClub() throws Exception{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		Organization organization = new Organization();
		organization.set_id(new ObjectId(deleteClub));
		BasicDBObject query = CreateQueryFromBean.EqualObj(organization);
		DaoImpl .DeleteDocment(Organization.class, query);
		response.getWriter().print("true");
	}
	
	public String getOldClub() {
		return oldClub;
	}
	public void setOldClub(String oldClub) {
		this.oldClub = oldClub;
	}
	public String getNewClub() {
		return newClub;
	}
	public void setNewClub(String newClub) {
		this.newClub = newClub;
	}
	public String getDeleteClub() {
		return deleteClub;
	}
	public void setDeleteClub(String deleteClub) {
		this.deleteClub = deleteClub;
	}
}
