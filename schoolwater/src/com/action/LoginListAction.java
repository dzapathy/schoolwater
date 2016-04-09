package com.action;

import java.util.ArrayList;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;
import staticData.StaticString;
import bean.Organization;
import bean.School;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class LoginListAction extends ActionSupport{
	private String orId;
	private String userId;
	//private String pwd;
	@Override
	public String execute() throws Exception {
		if(orId==null){
			System.out.println("orId == null");
			return INPUT;
		}
		
		//从数据库中搜索
		Organization organization =new Organization();
		organization.set_id(new ObjectId(getOrId()));
		BasicDBObject ob=CreateQueryFromBean.EqualObj(organization);
		
		BasicDBObject projection = new BasicDBObject();
		projection.put(StaticString.Organization_SchoolId, 1);
		projection.put(StaticString.Organization_Name, 1);
		projection.put(StaticString.Organization_Manager, 1);
		projection.put(StaticString.Organization_LevelTopId, 1);
		projection.put(StaticString.Organization_id, 1);
		MongoCursor<Document> mc =DaoImpl.GetSelectCursor(Organization.class, ob, projection);
		if(mc.hasNext()){
			Document d = mc.next();
			@SuppressWarnings("unchecked")
			ArrayList<Document> list=(ArrayList<Document>)d.get("Manager");
			//Document d1=list.get(0);		
			String manager_Name = null;
			for (Document document : list) {
				if(document.getString("UserId").equals(userId)){
					manager_Name = document.getString("Name");
					break;
				}
			}
			
			School school = new School();
			school.set_id((ObjectId)d.get("SchoolId"));
			BasicDBObject query = CreateQueryFromBean.EqualObj(school);
			BasicDBObject p = new BasicDBObject();
			p.put("_id", 1);
			p.put("Name", 1);
			p.put("LogoUrl", 1);
			p.put("State", 1);
			MongoCursor<Document> mCursor = DaoImpl.GetSelectCursor(School.class, query, p);
			Document doc =null;
			if(mCursor.hasNext()){
				doc = mCursor.next();
			}
			boolean tag = doc.getBoolean("State"); //true -可以登录 ;false -不可以登录
			if(tag){
				//存入session中
				ActionContext.getContext().getSession().put("Organization_id",orId);
				ActionContext.getContext().getSession().put("Organization_Name",d.get("Name"));
				ActionContext.getContext().getSession().put("LevelTopId", d.get("LevelTopId").toString());
				ActionContext.getContext().getSession().put("Organization_SchoolId", d.get("SchoolId"));
				ActionContext.getContext().getSession().put("Manager_Name", manager_Name);
				ActionContext.getContext().getSession().put("Manager_UserId",userId);
				ActionContext.getContext().getSession().put("School_Name", doc.get("Name"));
				ServletActionContext.getRequest().setAttribute("schoolLogoUrl", doc.get("LogoUrl"));
				return SUCCESS;
			}else{
				//addActionError("该组织所在学校已暂停服务");
				return "renew";
			}
		}else{
			addActionError("无该组织信息");
			return INPUT;
		}
		
	}

	public String getOrId() {
		return orId;
	}

	public void setOrId(String orId) {
		this.orId = orId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

}
