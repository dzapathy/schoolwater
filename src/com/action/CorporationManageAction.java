package com.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import staticData.StaticString;
import utils.Util;
import bean.Manager;
import bean.Organization;
import bean.StudentInfo;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class CorporationManageAction extends ActionSupport{
	private String orgId;
	//分配账号
	private String username;
	private String password;
	private String userId;
	//绑定账号
	private String user;
	
	//绑定账号方法
	@SuppressWarnings("unchecked")
	public void bangding() throws Exception{	
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		//首先判断该ID是否已经是管理员
		Organization organization = new Organization();
		organization.set_id(new ObjectId(orgId));
		BasicDBObject query = CreateQueryFromBean.EqualObj(organization);
		BasicDBObject p = new BasicDBObject();
		p.put(StaticString.Organization_Manager, 1);
		MongoCursor<Document> cursor =DaoImpl.GetSelectCursor(Organization.class, query, p);
		ArrayList<Document> managers = null;
		while(cursor.hasNext()){
			Document document = cursor.next();
			managers = (ArrayList<Document>)document.get("Manager");
		}		
		boolean tag =false;//判断是否存在
		if(managers!=null){
			for (int i = 0; i < managers.size(); i++) {
				String userIdlist=(String) managers.get(i).get("UserId");
				if(userIdlist.equals(user)){
					tag=true;break;
				}
			}
		}
		if(tag){
			response.getWriter().print("该ID已经是管理员了");
		}else{
			String name=null;
			String pwd = null;
			String userId = null;
			StudentInfo studentInfo = new StudentInfo();
			studentInfo.setIdCard(user);
			BasicDBObject q = CreateQueryFromBean.EqualObj(studentInfo);
			BasicDBObject projection = new BasicDBObject();
			projection.put(StaticString.StudentInfo_Name, 1);
			projection.put(StaticString.StudentInfo_Pwd, 1);
			projection.put(StaticString.StudentInfo_Phone, 1);
			MongoCursor<Document> cursor1 =DaoImpl .GetSelectCursor(StudentInfo.class, q, projection);
			while(cursor1.hasNext()){
				Document document = cursor1.next();
				name = document.getString("Name");
				pwd = document.getString("Pwd");
				userId = document.getString("Phone");
			}
			if(name!=null){
				ArrayList<Manager> arrayList = new ArrayList<Manager>();
				Manager manager = new Manager();
				manager.setName(name);
				manager.setPwd(pwd);
		    	manager.setUserId(userId);
				arrayList.add(manager);		
				DaoImpl.InsertSonBean(Organization.class, query, Manager.class, arrayList);		
				response.getWriter().print("新建成功");
			}else{
				response.getWriter().print("该学号对应学生没有注册app");
			}
		}
	}
	
	//分配帐号方法
	@SuppressWarnings("unchecked")
	public void fenpei() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		Organization organization = new Organization();
		organization.set_id(new ObjectId(orgId));
		BasicDBObject query = CreateQueryFromBean.EqualObj(organization);
		BasicDBObject p = new BasicDBObject();
		p.put(StaticString.Organization_Manager, 1);
		MongoCursor<Document> cursor =DaoImpl.GetSelectCursor(Organization.class, query, p);
		ArrayList<Document> managers = null;
		while(cursor.hasNext()){
			Document document = cursor.next();
			managers = (ArrayList<Document>)document.get("Manager");
		}
		boolean tag =false;//判断是否存在
		if(managers!=null){
			for (int i = 0; i < managers.size(); i++) {
				String userIdlist=(String) managers.get(i).get("UserId");
				if(userIdlist.equals(userId)){
					tag=true;break;
				}
			}
		}
		if(tag){
			response.getWriter().print("该ID已经是管理员了");
		}else{
			ArrayList<Manager> arrayList = new ArrayList<Manager>();
			Manager manager = new Manager();
			manager.setName(Util.DoGetString(username));
			manager.setPwd(Util.DoGetString(password));
	    	manager.setUserId(Util.DoGetString(userId));
			arrayList.add(manager);		
			DaoImpl.InsertSonBean(Organization.class, query, Manager.class, arrayList);		
			response.getWriter().print("新建成功");
		}
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
	
}
