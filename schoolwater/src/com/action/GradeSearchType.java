package com.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.json.JSONArray;

import staticData.StaticString;
import utils.GradeComparable;
import utils.Util;
import bean.ActivityIntegral;
import bean.Grade;
import bean.School;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class GradeSearchType extends ActionSupport{
	private String activityName; //获取活动名称
	private String timeStr;	//获取时间段
	private int gradeInt; //获取年级
	private String major; //获取专业
	private String levelId;	//获取上级ID
	private int num = 30; //默认取30条
	
	public void searchData() throws Exception{			
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		ObjectId acId =getActiId(); //获取活动ID	
		
		//解析时间
		String [] time =timeStr.split("-");
		Calendar calendar = Calendar.getInstance();
		calendar.set( Integer.parseInt(time[0]), 0, 1, 0, 0, 0);
		Date date1 = calendar.getTime();
		calendar.set(Integer.parseInt(time[1]), 0, 1, 0, 0, 0);
		Date date2 = calendar.getTime();
		
		ActivityIntegral activityIntegral = new ActivityIntegral();
		activityIntegral.setYear(gradeInt);
		activityIntegral.setCategoryId(acId);
		BasicDBObject projection = new BasicDBObject();
		MongoCursor<Document> cursor = null;
		if(levelId.equals("000000000000000000000000")){	//管理员
			ObjectId schoolId = (ObjectId)ServletActionContext.getContext().getSession().get("Organization_SchoolId");
			activityIntegral.setSchoolId(schoolId);
			if(!"不区分专业".equals(Util.DoGetString(major))){
				activityIntegral.setMajor(Util.DoGetString(major));
			}
			BasicDBObject query = CreateQueryFromBean.EqualObj(activityIntegral);
			cursor = DaoImpl.GetSelectCursor(ActivityIntegral.class, query, num, projection);
		}else{
			String organizationId =(String)ServletActionContext.getContext().getSession().get("Organization_id");
			activityIntegral.setOrganizationId(new ObjectId(organizationId));
			BasicDBObject query = CreateQueryFromBean.EqualObj(activityIntegral);			
		    cursor =DaoImpl.GetSelectCursor(ActivityIntegral.class, query, projection);
		}
		
		//存入数组
		ArrayList<String> idcards = new ArrayList<String>();
		ArrayList<Grade> grades = new ArrayList<Grade>();
		ArrayList<Document> arrayList = new ArrayList<Document>();
		while(cursor.hasNext()){
			arrayList.add(cursor.next());
		}
		for (int i = 0; i < arrayList.size(); i++) {
			Date date=(Date)arrayList.get(i).get("CreateTime");
			if(date.compareTo(date1)>=0&&date.compareTo(date2)<=0){
				if(!idcards.contains(arrayList.get(i).getString("IdCard"))){
					idcards.add(arrayList.get(i).getString("IdCard"));
					Grade grade = new Grade();
					grade.setName(arrayList.get(i).getString("Name"));
					grade.setIdCard(arrayList.get(i).getString("IdCard"));
					grade.setScore(arrayList.get(i).getDouble("Grade"));
					ArrayList<bean.Detail> details = new ArrayList<bean.Detail>();
					bean.Detail detail = new bean.Detail();
					detail.setContext(arrayList.get(i).getString("ThingName"));
					detail.setScore(arrayList.get(i).getDouble("Grade"));
					details.add(detail);
					grade.setDetail(details);
					grades.add(grade);
				}else{
					for (int i1 = 0; i1 < grades.size(); i1++) {
						if(arrayList.get(i).getString("IdCard").equals(grades.get(i1).getIdCard())){
							grades.get(i1).setScore(grades.get(i1).getScore()+arrayList.get(i).getDouble("Grade"));
							ArrayList<bean.Detail> details = grades.get(i1).getDetail();
							bean.Detail detail = new bean.Detail();
							detail.setContext(arrayList.get(i).getString("ThingName"));
							detail.setScore(arrayList.get(i).getDouble("Grade"));
							details.add(detail);
							grades.get(i1).setDetail(details);
							break;
						}
					}
				}
			}
		}
//		while(cursor.hasNext()){					
//			Document document = cursor.next();
//			Date date=(Date)document.get("CreateTime");
//			if(date.compareTo(date1)>=0&&date.compareTo(date2)<=0){
//				if(!idcards.contains(document.getString("IdCard"))){
//					idcards.add(document.getString("IdCard"));
//					Grade grade = new Grade();
//					grade.setName(document.getString("Name"));
//					grade.setIdCard(document.getString("IdCard"));
//					grade.setScore(document.getDouble("Grade"));
//					ArrayList<bean.Detail> details = new ArrayList<bean.Detail>();
//					bean.Detail detail = new bean.Detail();
//					detail.setContext(document.getString("ThingName"));
//					detail.setScore(document.getDouble("Grade"));
//					details.add(detail);
//					grade.setDetail(details);
//					grades.add(grade);
//				}else{
//					for (int i = 0; i < grades.size(); i++) {
//						if(document.getString("IdCard").equals(grades.get(i).getIdCard())){
//							grades.get(i).setScore(grades.get(i).getScore()+document.getDouble("Grade"));
//							ArrayList<bean.Detail> details = grades.get(i).getDetail();
//							bean.Detail detail = new bean.Detail();
//							detail.setContext(document.getString("ThingName"));
//							detail.setScore(document.getDouble("Grade"));
//							details.add(detail);
//							grades.get(i).setDetail(details);
//							break;
//						}
//					}
//				}
//			}
//		}
		
		//排序，从大到小
		GradeComparable comparable = new GradeComparable();
		Collections.sort(grades, comparable);
		JSONArray jsonArray = new JSONArray();		
		for (int i = 0; i <  grades.size(); i++) {
			net.sf.json.JSONObject object = net.sf.json.JSONObject.fromObject(grades.get(i));
			jsonArray.put(object);
		}
		response.getWriter().print(jsonArray.toString());
	}
	
	@SuppressWarnings("unchecked")
	private ObjectId getActiId() throws Exception{
		ObjectId id= null;
		//根据activityName获取ID
		School school = new School();
		school.set_id((ObjectId)ServletActionContext.getContext().getSession().get("Organization_SchoolId"));
		BasicDBObject query = CreateQueryFromBean.EqualObj(school);
		BasicDBObject projection = new BasicDBObject();
		projection.put(StaticString.School_InActivityCategoty, 1);
		MongoCursor<Document> cursor =DaoImpl.GetSelectCursor(School.class, query, projection);
		ArrayList<Document> arrayList = null;
		if(cursor.hasNext()){
			Document document =cursor.next();
			arrayList =	(ArrayList<Document>)document.get("InActivityCategoty");
		}
		for (int i = 0; i < arrayList.size(); i++) {
			if(arrayList.get(i).getString("Name").equals(Util.DoGetString(activityName))){
				id=(ObjectId)arrayList.get(i).get("_id");
				break;
			}
		}		
		return id;
	}
	
	public String getActivityName() {
		return activityName;
	}
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	public String getTimeStr() {
		return timeStr;
	}
	public void setTimeStr(String timeStr) {
		this.timeStr = timeStr;
	}

	public int getGradeInt() {
		return gradeInt;
	}

	public void setGradeInt(int gradeInt) {
		this.gradeInt = gradeInt;
	}

	public String getLevelId() {
		return levelId;
	}

	public void setLevelId(String levelId) {
		this.levelId = levelId;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}
}
