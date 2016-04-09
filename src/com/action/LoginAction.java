package com.action;

import java.util.ArrayList;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;
import staticData.StaticString;
import bean.Manager;
import bean.Organization;
import bean.School;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class LoginAction extends ActionSupport{
	private String userId;
	private String pwd;
		
	@Override
	public String execute() throws Exception {
		if(userId==null){
			return INPUT;
		}
		System.out.println("userId: "+userId);
		
		Organization organization = new Organization();	//从数据库中检索用户
		ArrayList<Manager> managerlist=new ArrayList<Manager>();
		Manager manager=new Manager();
		manager.setUserId(getUserId());
		manager.setPwd(getPwd());
		managerlist.add(manager);
		organization.setManager(managerlist);			
		BasicDBObject query=CreateQueryFromBean.EqualObj(organization);  //query								
		BasicDBObject projection = new BasicDBObject(); 	//projection
		projection.put(StaticString.Organization_SchoolId, 1);
		projection.put(StaticString.Organization_Name, 1);
		projection.put(StaticString.Organization_Manager, 1);
		projection.put(StaticString.Organization_LevelTopId, 1);
		projection.put(StaticString.Organization_id, 1);		
		long num=DaoImpl.GetSelectCount(Organization.class, query);	
		MongoCursor<Document> mc=DaoImpl.GetSelectCursor(Organization.class, query, projection); 
		if(num>0){
			if(num==1){
				Document d=mc.next();
				@SuppressWarnings("unchecked")
				ArrayList<Document> list=(ArrayList<Document>)d.get("Manager");
				//Document d1=list.get(0);				
				String manager_Name = null;
				for (Document document : list) {
					if(document.getString("UserId").equals(userId)
							&&document.getString("Pwd").equals(pwd)){
						manager_Name = document.getString("Name");
						break;
					}
				}
				
				School school = new School();
				school.set_id((ObjectId)d.get("SchoolId"));
				BasicDBObject  q =CreateQueryFromBean.EqualObj(school);
				BasicDBObject p=new BasicDBObject();
				p.put(StaticString.School_Name, 1);
				p.put(StaticString.School_id, 1);
				p.put("LogoUrl", 1);
				p.put("State", 1);
				MongoCursor<Document> m =DaoImpl.GetSelectCursor(School.class, q, p);
				Document doc = null;
				if(m.hasNext()){
					doc = m.next();
				}
				boolean tag = doc.getBoolean("State"); //true -可以登录 ;false -不可以登录
				if(tag){
					ActionContext.getContext().getSession().put("Organization_id",d.get("_id").toString());
					ActionContext.getContext().getSession().put("Organization_Name",d.get("Name"));
					ActionContext.getContext().getSession().put("Organization_SchoolId", d.get("SchoolId"));
					ActionContext.getContext().getSession().put("Manager_UserId", getUserId());
					ActionContext.getContext().getSession().put("Manager_Name", manager_Name);
					ActionContext.getContext().getSession().put("LevelTopId", d.get("LevelTopId").toString());
					ActionContext.getContext().getSession().put("School_Name", doc.get("Name"));
					ServletActionContext.getRequest().setAttribute("schoolLogoUrl", doc.get("LogoUrl"));			
					return SUCCESS;
				}else{
					//addActionError("该组织所在学校已暂停服务");
					return "renew";
				}
			}else{
				ArrayList<Document> list=new ArrayList<Document>();
				while(mc.hasNext()){
					Document d= mc.next();
					list.add(d);						
				}
				
				ActionContext.getContext().put("organizationlist", list);
				return "more";
			}								
		}else{
			addActionError("用户名或密码错误");
			return INPUT;
		}
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
}
