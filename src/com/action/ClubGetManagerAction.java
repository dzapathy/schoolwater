package com.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.json.JSONArray;

import staticData.StaticString;
import bean.Manager;
import bean.Organization;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClubGetManagerAction extends ActionSupport{
	private String organizationId;
	
	@SuppressWarnings("unchecked")
	public void getManager() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		Organization organization = new Organization();
		organization.set_id(new ObjectId(organizationId));
		BasicDBObject query = CreateQueryFromBean.EqualObj(organization);
		BasicDBObject p = new BasicDBObject();
		p.put(StaticString.Organization_Manager, 1);
		MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(Organization.class, query, p);
		Document document=null;
		ArrayList<Document> arrayList =null;
		while(cursor.hasNext()){
			document=cursor.next();
			arrayList = (ArrayList<Document>)document.get("Manager");
		}
		if(arrayList!=null){
			ArrayList<Manager> managers = new ArrayList<Manager>();
			for (int i = 0; i < arrayList.size(); i++) {
				Manager manager = new Manager();
				manager.setName(arrayList.get(i).getString("Name"));
				manager.setUserId(arrayList.get(i).getString("UserId"));
				managers.add(manager);
			}
			JSONArray array = new JSONArray();
			for (int i = 0; i < managers.size(); i++) {
				JSONObject object =JSONObject.fromObject(managers.get(i));
				array.put(object);
			}
			response.getWriter().print(array.toString());
		}else{
			response.getWriter().print("[]");
		}
	}
	
	public String getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(String organizationId) {
		this.organizationId = organizationId;
	}
}
