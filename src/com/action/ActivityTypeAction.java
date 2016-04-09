package com.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.types.ObjectId;

import utils.Util;
import bean.ActivityIntegral;
import bean.InActivity;
import bean.InActivityCategoty;
import bean.School;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ActivityTypeAction extends ActionSupport{	
	private String addType;
	private String deleteType;//要删除的活动类型id
	private String oldType;//id
		
	//插入或更新活动类型
	public void addType() throws Exception {	
		//插入操作
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		if(addType!=null&&!"".equals(addType)&&"".equals(oldType)){		
			School school = new School();
	  		ObjectId o = (ObjectId)ServletActionContext.getContext().getSession().get("Organization_SchoolId");  		
	  		school.set_id(o);
	  		BasicDBObject  query =CreateQueryFromBean.EqualObj(school);
	  		ArrayList<InActivityCategoty> activityCategoties = new ArrayList<InActivityCategoty>();
	  		InActivityCategoty activityCategoty = new InActivityCategoty();
	  		activityCategoty.set_id(new ObjectId());
	  		activityCategoty.setName(Util.DoGetString(addType.trim()));
	  		activityCategoties.add(activityCategoty);	  		
	  		DaoImpl.InsertSonBean(School.class, query, InActivityCategoty.class,activityCategoties );
	  		response.getWriter().print("新增成功");
		}
		//更新操作
		if(addType!=null&&!("".equals(oldType))){  //更新			  		
			School school = new School(); 
			ArrayList<InActivityCategoty> activityCategoties = new ArrayList<InActivityCategoty>();
			InActivityCategoty activityCategoty = new InActivityCategoty();
			activityCategoty.set_id(new ObjectId(oldType));
			activityCategoties.add(activityCategoty);
			school.setInActivityCategoty(activityCategoties);
			BasicDBObject query = CreateQueryFromBean.EqualObj(school);
				  		
			School school2 = new School();
			ArrayList<InActivityCategoty> activityCategoties2 = new ArrayList<InActivityCategoty>();
			InActivityCategoty activityCategoty2 = new InActivityCategoty();
			activityCategoty2.setName(Util.DoGetString(addType.trim()));
			activityCategoties2.add(activityCategoty2);
			school2.setInActivityCategoty(activityCategoties2);
			DaoImpl.update(query, school2, true);
				  						  		
			//修改关联的数据表InActivity
			InActivity activity = new InActivity();
			activity.setCategoryId(new ObjectId(oldType));
			BasicDBObject inactivityq = CreateQueryFromBean.EqualObj(activity);
			InActivity activity2 = new InActivity();
			activity2.setCategoryName(Util.DoGetString(addType.trim()));
			DaoImpl.update(inactivityq, activity2, true);
				  						  		
			//修改关联的数据表ActivityIntegral
			ActivityIntegral activityIntegral = new ActivityIntegral();
			activityIntegral.setCategoryId(new ObjectId(oldType));
			BasicDBObject activityinteq = CreateQueryFromBean.EqualObj(activityIntegral);
			ActivityIntegral activityIntegral2 = new ActivityIntegral();
			activityIntegral2.setCategoryName(Util.DoGetString(addType.trim()));
			DaoImpl.update(activityinteq, activityIntegral2, true);
			response.getWriter().print("更新成功");
		}
	}

	//删除活动类型
	public void deleteType() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		InActivity activity = new InActivity();
		activity.setCategoryId(new ObjectId(deleteType));
		BasicDBObject inactivityq = CreateQueryFromBean.EqualObj(activity);					
		long actinum=DaoImpl.GetSelectCount(InActivity.class,inactivityq );
		if(actinum>0){			
			response.getWriter().print("false");
		}else{
			ActivityIntegral activityIntegral = new ActivityIntegral();
			activityIntegral.setCategoryId(new ObjectId(deleteType));
			BasicDBObject activityinteq = CreateQueryFromBean.EqualObj(activityIntegral);
			long jifennum = DaoImpl.GetSelectCount(ActivityIntegral.class, activityinteq);
			if(jifennum>0){
				response.getWriter().print("false");
			}else{	
				School school = new School();		
				ArrayList<InActivityCategoty> activityCategoties = new ArrayList<InActivityCategoty>();
				InActivityCategoty activityCategoty = new InActivityCategoty();
				activityCategoty.set_id(new ObjectId(deleteType));
				activityCategoties.add(activityCategoty);
				school.setInActivityCategoty(activityCategoties);
				BasicDBObject query = CreateQueryFromBean.EqualObj(school);
				DaoImpl.DeleteSonSomeBean(School.class, query, InActivityCategoty.class, activityCategoties); //删除？
				response.getWriter().print("true");
			}
		}	
	}
	
	public String getAddType() {
		return addType;
	}
	
	public void setAddType(String addType) {
		this.addType = addType;
	}

	public String getDeleteType() {
		return deleteType;
	}

	public void setDeleteType(String deleteType) {
		this.deleteType = deleteType;
	}

	public String getOldType() {
		return oldType;
	}

	public void setOldType(String oldType) {
		this.oldType = oldType;
	}		
}
