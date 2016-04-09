package com.action;
/**
 * 获取积分表内容，存入arraylist
 */
import java.util.ArrayList;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import staticData.StaticString;

import bean.ActivityIntegral;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class GradeSearchContext extends ActionSupport{
	private String id;
	private String tableName;
	
	public static final int limit = 10;//获取条数
	@Override
	public String execute() throws Exception {
		ActivityIntegral integral = new ActivityIntegral();
		integral.setTableId(new ObjectId(id));
		BasicDBObject query = CreateQueryFromBean.EqualObj(integral);
		BasicDBObject projection = new BasicDBObject();	
		
		BasicDBObject sort = new BasicDBObject();
		sort.put(StaticString.ActivityIntegral_id, -1);
		
		ArrayList<ActivityIntegral> integrals = new ArrayList<ActivityIntegral>();
		MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(ActivityIntegral.class, query,sort,limit, projection);
		while(cursor.hasNext()){
			Document document = cursor.next();
			ActivityIntegral activityIntegral = new ActivityIntegral();
			activityIntegral.set_id(document.getObjectId("_id"));
			activityIntegral.setName(document.getString("Name"));
			activityIntegral.setIdCard(document.getString("IdCard"));
			activityIntegral.setMajor(document.getString("Major"));
			activityIntegral.setLevel(document.getString("Level"));
			activityIntegral.setYear(document.getInteger("Year"));
			activityIntegral.setScope(document.getString("Scope"));
			activityIntegral.setThingName(document.getString("ThingName"));
			activityIntegral.setGrade(document.getDouble("Grade"));
			activityIntegral.setRemark(document.getString("Remark"));
			integrals.add(activityIntegral);
		}
		
		ServletActionContext.getRequest().setAttribute("activityIntegrals", integrals);
		ServletActionContext.getRequest().setAttribute("tableId", id);
		ServletActionContext.getRequest().setAttribute("tableName", tableName);
		return SUCCESS;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
}
