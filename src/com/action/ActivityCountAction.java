package com.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import staticData.StaticString;
import bean.ActivityJudge;
import bean.SearchStudent;
import bean.StudentInfo;
import bean.TableContentInfo;
import bean.TableInfo;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ActivityCountAction extends ActionSupport{
	private String activityId;
	
	@Override
	public String execute() throws Exception {
		activityId =(String)ServletActionContext.getContext().getSession().get("SelectedActivityId");
		System.out.println("活动ID"+activityId);
		
		//获取活动关联的表ID
		ObjectId tableId = null;
		TableInfo tableInfo = new TableInfo();
		tableInfo.setActivityId(new ObjectId(activityId));
		BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);
		BasicDBObject p = new BasicDBObject();
		p.put(StaticString.TableInfo_id, 1);
		MongoCursor<Document> c = DaoImpl.GetSelectCursor(TableInfo.class, query, p);
		while(c.hasNext()){
			Document d1 = c.next();
			tableId =(ObjectId)d1.get("_id");
		}
		
		ArrayList<SearchStudent> searchStudents = new ArrayList<SearchStudent>();
		//获取报名人数，签到人数
		TableContentInfo contentInfo = new TableContentInfo();
		contentInfo.setTableId(tableId);
		contentInfo.setTableType(0);
		BasicDBObject query2 = CreateQueryFromBean.EqualObj(contentInfo);
		BasicDBObject p2 = new BasicDBObject();
		p2.put(StaticString.TableContentInfo_TableContentColumn, 1);
		p2.put(StaticString.TableContentInfo_IdCard, 1);
		p2.put(StaticString.TableContentInfo_SchoolId, 1);
		p2.put(StaticString.TableContentInfo_StuId, 1);
		MongoCursor<Document> cursor2 = DaoImpl.GetSelectCursor(TableContentInfo.class, query2, p2);
		int bmCount = 0; //报名人数
		int qdCount = 0; //签到人数
		ArrayList<Document> lists = new ArrayList<Document>();
		while(cursor2.hasNext()){
			bmCount++;
			Document d  = cursor2.next();
			lists.add(d);
					
		}
		//2015.10.29
		for (int i = 0; i < lists.size(); i++) {
			SearchStudent searchStudent = new SearchStudent();
			searchStudent.setIdCard(lists.get(i).getString("IdCard"));
			searchStudent.setSchoolId(lists.get(i).getObjectId("SchoolId"));
			searchStudent.setStuId(lists.get(i).getObjectId("StuId"));
			searchStudents.add(searchStudent);
			@SuppressWarnings("unchecked")
			ArrayList<Document> documents =(ArrayList<Document>) lists.get(i).get("TableContentColumn");			
			for (int i1 = 0; i1 < documents.size(); i1++) {
				String signIn = (String)documents.get(i1).get("Name");
			    if(signIn.equals("SignIn")){
					String context = (String)documents.get(i1).get("Content");
					if(context.equals("1")){
						qdCount++;
					}
					break;
				}
			}
		}
		ServletActionContext.getRequest().setAttribute("bmCount", bmCount);//报名人数
		ServletActionContext.getRequest().setAttribute("qdCount", qdCount);//签到人数
		
		//获取男女比例和年纪分布
		Map<Integer, Integer> map = new HashMap<Integer, Integer>();
		int man = 0;
		int woman = 0;
		for (int i = 0; i < searchStudents.size(); i++) {
			StudentInfo studentInfo = new StudentInfo();
			studentInfo.set_id(searchStudents.get(i).getStuId());
			studentInfo.setSchoolId(searchStudents.get(i).getSchoolId());
			studentInfo.setIdCard(searchStudents.get(i).getIdCard());
			BasicDBObject basicDBObject = CreateQueryFromBean.EqualObj(studentInfo);
			BasicDBObject basicDBObject2 = new BasicDBObject();
			basicDBObject2.put(StaticString.StudentInfo_Grade, 1);
			basicDBObject2.put(StaticString.StudentInfo_Sex, 1);
			MongoCursor<Document> mongoCursor = DaoImpl.GetSelectCursor(StudentInfo.class, basicDBObject, basicDBObject2);
			Document document =null;
			if(mongoCursor.hasNext()){
				document = mongoCursor.next();		
			}
			if(document!=null){
				int grade = document.getInteger("Grade");
				int sex = document.getInteger("Sex");
				if(sex ==0){
					man++;
				}else{
					woman ++;
				}
				if(map.isEmpty()){
					map.put(grade, 1);
				}else{
					for (Integer key : map.keySet()) {
						 System.out.println("key= "+ key + " and value= " + map.get(key));
						 if(key==grade){
							int value = map.get(key);
							value++;
							map.put(grade, value);
						 }else{
							 map.put(grade, 1);
						 }
					}
				}
			}
		}
		
		ServletActionContext.getRequest().setAttribute("man", man);//男生人数
		ServletActionContext.getRequest().setAttribute("woman", woman);//女生人数
		ServletActionContext.getRequest().setAttribute("map", map);
		
		//获取评论条数
		ActivityJudge activityJudge = new ActivityJudge();
		activityJudge.setActivityId(new ObjectId(activityId));
		BasicDBObject query3 = CreateQueryFromBean.EqualObj(activityJudge);
		BasicDBObject p3 = new BasicDBObject();
		p3.put(StaticString.ActivityJudge_id, 1);
		p3.put(StaticString.ActivityJudge_Type, 1);
		MongoCursor<Document> cursor3 = DaoImpl.GetSelectCursor(ActivityJudge.class, query3, p3);
		int pjCount= 0 ;
		int pjZhichi = 0;
		int pjFandui = 0;
		while(cursor3.hasNext()){
			pjCount++;
			Document document = cursor3.next();
			Integer type = document.getInteger("Type");
			if(type!=null){
				if(type==0){
					pjFandui++;
				}else if(type ==1){
					pjZhichi++;
				}else{
				}
			}
		}
		ServletActionContext.getRequest().setAttribute("pjCount", pjCount); //评价数量
		ServletActionContext.getRequest().setAttribute("pjZhichi", pjZhichi); //支持人数
		ServletActionContext.getRequest().setAttribute("pjFandui", pjFandui); //反对人数
		return SUCCESS;
	}
	
	
	public String getActivityId() {
		return activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}
}
