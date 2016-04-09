package com.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.json.JSONArray;

import staticData.StaticString;
import bean.ActivityIntegralTable;
import bean.ActivityIntegralTableSon;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class GradeGetMoreTable extends ActionSupport{
	private String levelId; //上级组织ID
	private String lastTableId; //最后一个表的ID
	private int num = 10; //每次加载10条数据
	
	public void getMore() throws Exception {		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");	
		if("000000000000000000000000".equals(levelId)){ //超级管理员
			ActivityIntegralTable table = new ActivityIntegralTable();
			table.set_id(new ObjectId(lastTableId));
			BasicDBObject query = CreateQueryFromBean.LtObj(table);
			BasicDBObject projection = new BasicDBObject();
			projection.put(StaticString.ActivityIntegralTable_CreateTime, 1);
			projection.put(StaticString.ActivityIntegralTable_Name, 1);
			projection.put(StaticString.ActivityIntegralTable_id, 1);
			projection.put(StaticString.ActivityIntegralTable_SchoolId, 1);
			BasicDBObject sort = new BasicDBObject();
			sort.put(StaticString.ActivityIntegralTable_id, -1);
			MongoCursor<Document> curser = DaoImpl.GetSelectCursor(ActivityIntegralTable.class, query,sort, projection);
			ObjectId schoolId =(ObjectId)ServletActionContext.getContext().getSession().get("Organization_SchoolId");
			ArrayList<Document> list = new ArrayList<Document>();
			while(curser.hasNext()){
				Document document= curser.next();
				if(schoolId.equals(document.getObjectId("SchoolId"))){
					list.add(document);
					if(list.size()>=num){
						break;
					}
				}
			}
			
			response.getWriter().print("true");	
		}else{	//普通管理员
			ActivityIntegralTable table = new ActivityIntegralTable();
			table.set_id(new ObjectId(lastTableId));
			BasicDBObject query = CreateQueryFromBean.LtObj(table);
			BasicDBObject projection = new BasicDBObject();
			projection.put(StaticString.ActivityIntegralTable_CreateTime, 1);
			projection.put(StaticString.ActivityIntegralTable_Name, 1);
			projection.put(StaticString.ActivityIntegralTable_id, 1);
			projection.put(StaticString.ActivityIntegralTable_OrganizationId, 1);
			BasicDBObject sort = new BasicDBObject();
			sort.put(StaticString.ActivityIntegralTable_id, -1);
			MongoCursor<Document> curser = DaoImpl.GetSelectCursor(ActivityIntegralTable.class, query,sort, projection);
			String organization_id =(String)ServletActionContext.getContext().getSession().get("Organization_id");				
			ObjectId orgaId = new ObjectId(organization_id);
			ArrayList<Document> list = new ArrayList<Document>();		
			while(curser.hasNext()){
				Document document= curser.next();
				ObjectId id = document.getObjectId("OrganizationId");
				if(orgaId.equals(id)){
					list.add(document);
					if(list.size()>=num){
						break;
					}
				}
			}
			
			ArrayList<ActivityIntegralTableSon> tableSons = new ArrayList<ActivityIntegralTableSon>();
			for (int i = 0; i < list.size(); i++) {
				ActivityIntegralTableSon tableSon = new ActivityIntegralTableSon();
				tableSon.setName(list.get(i).getString("Name"));
				String createTime = new SimpleDateFormat("yyyy-MM-dd").format(list.get(i).getDate("CreateTime"));
				tableSon.setCreateTime(createTime);
				tableSon.set_id(list.get(i).get("_id").toString());
				tableSons.add(tableSon);
			}
				
			JSONArray jsonArray = new JSONArray();		
			for (int i = 0; i <  tableSons.size(); i++) {
				net.sf.json.JSONObject object = net.sf.json.JSONObject.fromObject(tableSons.get(i));
				jsonArray.put(object);
			}
			response.getWriter().print(jsonArray.toString());
		}
	}
	
	public String getLevelId() {
		return levelId;
	}
	public void setLevelId(String levelId) {
		this.levelId = levelId;
	}
	public String getLastTableId() {
		return lastTableId;
	}
	public void setLastTableId(String lastTableId) {
		this.lastTableId = lastTableId;
	}
}
