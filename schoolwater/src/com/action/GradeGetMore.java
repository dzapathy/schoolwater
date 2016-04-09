package com.action;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.json.JSONArray;
import org.json.JSONObject;

import staticData.StaticString;
import bean.ActivityIntegral;

import com.dao.CreateAndQuery;
import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class GradeGetMore extends ActionSupport{
	private String lastContentId;
	private String tableId;
	
	public static final int limit =10;
	
	public void getMoreData() throws Exception{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
				
		//测试
		System.out.println("lastContentId:"+lastContentId);
		System.out.println("tableId:"+tableId);
		
		ActivityIntegral activityIntegral1 = new ActivityIntegral();
		activityIntegral1.setTableId(new ObjectId(tableId));
		
		ActivityIntegral activityIntegral2 = new ActivityIntegral();
		activityIntegral2.set_id(new ObjectId(lastContentId));
		
		CreateAndQuery andQuery=new CreateAndQuery();//条件合并
		andQuery.Add(CreateQueryFromBean.EqualObj(activityIntegral1));
		andQuery.Add(CreateQueryFromBean.LtObj(activityIntegral2));
		BasicDBObject query=andQuery.GetResult();
		
		BasicDBObject sort=new BasicDBObject(); //降序排序
		sort.put(StaticString.ActivityIntegral_id, -1);
		
		BasicDBObject projection = new BasicDBObject();
		
//		ArrayList<ActivityIntegral> integrals = new ArrayList<ActivityIntegral>(); //存于ArrayList<ActivityIntegral>
//		MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(ActivityIntegral.class, query, sort, limit, projection);
//		while(cursor.hasNext()){
//			Document document = cursor.next();
//			ActivityIntegral activityIntegral = new ActivityIntegral();
//			activityIntegral.set_id(document.getObjectId("_id"));
//			activityIntegral.setName(document.getString("Name"));
//			activityIntegral.setIdCard(document.getString("IdCard"));
//			activityIntegral.setMajor(document.getString("Major"));
//			activityIntegral.setLevel(document.getString("Level"));
//			activityIntegral.setYear(document.getInteger("Year"));
//			activityIntegral.setScope(document.getString("Scope"));
//			activityIntegral.setThingName(document.getString("ThingName"));
//			activityIntegral.setGrade(document.getDouble("Grade"));
//			activityIntegral.setRemark(document.getString("Remark"));
//			integrals.add(activityIntegral);
//		}
		
		//JSONArray json  = JSONArray.fromObject(integrals);
		JSONArray json = new JSONArray();//转换为JSONArray
		MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(ActivityIntegral.class, query, sort, limit, projection);
		while(cursor.hasNext()){
			Document document = cursor.next();
			//System.out.println(document.toJson());
			JSONObject object = new JSONObject();
			object.put("_id", document.getObjectId("_id"));
			object.put("Name", document.getString("Name"));
			object.put("IdCard", document.getString("IdCard"));
			object.put("Major", document.getString("Major"));
			object.put("Level", document.getString("Level"));
			object.put("Year", document.getInteger("Year"));
			object.put("Scope", document.getString("Scope"));
			object.put("ThingName", document.getString("ThingName"));
			object.put("Grade", document.getDouble("Grade"));
			object.put("Remark", document.getString("Remark"));
			json.put(object);
		}
		response.getWriter().print(json.toString());
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
}
