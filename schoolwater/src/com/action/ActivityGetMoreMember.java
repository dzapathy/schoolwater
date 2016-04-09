package com.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import staticData.StaticString;
import bean.TableContentInfo;

import com.dao.CreateAndQuery;
import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;

public class ActivityGetMoreMember {

	String lastId;
	String tableId;
	int pageSize=10;//显示的条数
	
	ArrayList<String> tableInfoColumnName= (ArrayList<String>)ServletActionContext.getContext()
			.getSession().get("TableInfoColumnName");
	
	//加载更多
	public String getMore() throws Exception{
		
		System.out.println("111111111111");
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		TableContentInfo tableContentInfo=new TableContentInfo();
		//tableContentInfo.setSchoolId(new ObjectId(schoolId));加上mc值为null
		tableContentInfo.setTableId(new ObjectId(tableId));
		tableContentInfo.setTableType(0);
		
		TableContentInfo tableContentInfo2=new TableContentInfo();
		tableContentInfo2.set_id(new ObjectId(lastId));
		
		BasicDBObject sort=new BasicDBObject();
		sort.put(StaticString.TableContentInfo_id, -1);		
		
		CreateAndQuery andQuery=new CreateAndQuery();
		andQuery.Add(CreateQueryFromBean.EqualObj(tableContentInfo));
		andQuery.Add(CreateQueryFromBean.LtObj(tableContentInfo2));
		
		BasicDBObject query=andQuery.GetResult();
		BasicDBObject projection=new BasicDBObject();
		projection.put(StaticString.TableContentInfo_TableContentColumn, 1);
		
		MongoCursor<Document> mc=DaoImpl.GetSelectCursor(TableContentInfo.class, 
				query, sort, pageSize, projection);
		
		ArrayList<Document> arrayList=new ArrayList<Document>();
		while(mc.hasNext()){
			Document document=mc.next();
			arrayList.add(document);
		}
		
		JSONArray jsonArray=new JSONArray();
		if(arrayList!=null&&arrayList.size()>0){			
			ArrayList<Document> columinfo=new ArrayList<Document>();
			
			//遍历每一个成员
			for(int i=0;i<arrayList.size();i++){
				columinfo.clear();
				columinfo=(ArrayList<Document>)arrayList.get(i)
						.get(StaticString.TableContentInfo_TableContentColumn);
				JSONObject jsonObject=new JSONObject();
				//每个字段头
				for(int j=0;j<tableInfoColumnName.size();j++){
					for(int k=0;k<columinfo.size();k++){
						
						if(tableInfoColumnName.get(j)
								.equals(columinfo.get(k).get("Name"))){
							jsonObject.put(tableInfoColumnName.get(j),
									columinfo.get(k).get("Content"));
							break;
						}
					}
				}
				
				jsonObject.put(StaticString.TableContentInfo_id, arrayList.get(i).get(StaticString.TableContentInfo_id));
				jsonArray.add(jsonObject);
			}
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				for(int j=0;j<tableInfoColumnName.size();j++){
					System.out.println(jsonObject.get(tableInfoColumnName.get(j)));
				}
				
		    }
			response.getWriter().print(jsonArray.toString());
		}else{
			response.getWriter().print(jsonArray.toString());
		}		
		return null;
	}
	
	public String getLastId() {
		return lastId;
	}

	public void setLastId(String lastId) {
		this.lastId = lastId;
	}
	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
}
