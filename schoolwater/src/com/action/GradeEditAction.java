package com.action;

import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import staticData.StaticString;
import utils.Util;
import bean.ActivityIntegral;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class GradeEditAction extends ActionSupport{
	private String oldvalues;
	private String newvalues;
	private String deletevalues; 	
	private String tableId;		 //传值
	private String tableName;
	private ObjectId categoryId;
	private String categoryName;
	
	private ObjectId schoolId=(ObjectId)ServletActionContext.getContext().getSession().get("Organization_SchoolId");
	
	//更新或插入
	public void updateOradd() throws Exception{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		
		//将新值存入newval数组里
		String [] oldval = Util.DoGetString(oldvalues).trim().split(",");
		String [] newval = Util.DoGetString(newvalues).trim().split(",");
		
//		System.out.println("tableId:"+tableId);
		
		//执行插入操作
		if(oldvalues.equals("")){
//			System.out.println("插入");
			
			//获取一堆值
			ActivityIntegral a = new ActivityIntegral();
			a.setTableId(new ObjectId(tableId));
			BasicDBObject query = CreateQueryFromBean.EqualObj(a);
			BasicDBObject p = new BasicDBObject();
			p.put(StaticString.ActivityIntegral_CategoryId, 1);
			p.put(StaticString.ActivityIntegral_CategoryName, 1);
			p.put(StaticString.ActivityIntegral_TableName, 1);
			MongoCursor<Document> curser = DaoImpl.GetSelectCursor(ActivityIntegral.class, query, 1, p);
			while(curser.hasNext()){
				Document document = curser.next();
				tableName = document.getString("TableName");
				categoryId = (ObjectId)document.get("CategoryId");
				categoryName =document.getString("CategoryName");
			}
			
//			for (int i = 0; i < newval.length; i++) {
//				System.out.print(newval[i]+" ");
//			}

			
			ActivityIntegral activityIntegral = new ActivityIntegral();
			activityIntegral.set_id(new ObjectId());
			activityIntegral.setTableId(new ObjectId(tableId));
			activityIntegral.setTableName(tableName); 
			String organizationId = (String)ServletActionContext.getContext().getSession().get("Organization_id");
			activityIntegral.setActivityId(new ObjectId(organizationId));
			activityIntegral.setOrganizationId(new ObjectId(organizationId));
			activityIntegral.setStuId(new ObjectId("000000000000000000000000"));
			ObjectId schoolId = (ObjectId)ServletActionContext.getContext().getSession().get("Organization_SchoolId");
			activityIntegral.setSchoolId(schoolId);
			activityIntegral.setIdCard(newval[1]);
			activityIntegral.setName(newval[0]);
			activityIntegral.setMajor(newval[2]);
			activityIntegral.setYear(Integer.parseInt(newval[3]));
			System.out.println(Integer.parseInt(newval[3]));
			
			activityIntegral.setScope(newval[4]);
			activityIntegral.setLevel(newval[5]);
			activityIntegral.setThingName(newval[6]);
			activityIntegral.setCategoryId(categoryId);
			activityIntegral.setCategoryName(categoryName);
			activityIntegral.setGrade(Double.parseDouble(newval[7]));
			activityIntegral.setRemark(newval[8]);
			activityIntegral.setCreateTime(new Date());
			DaoImpl.InsertWholeBean(activityIntegral);	
			response.getWriter().print("保存成功");
		}else{	//执行更新操作
//			System.out.println("更新");
			
			ActivityIntegral activityIntegral = new ActivityIntegral();
			activityIntegral.setTableId(new ObjectId(tableId));
			activityIntegral.setIdCard(oldval[1]);
			activityIntegral.setName(oldval[0]);
			activityIntegral.setMajor(oldval[2]);
			activityIntegral.setYear(Integer.parseInt(oldval[3]));
			System.out.println("更新,旧值:"+Integer.parseInt(oldval[3]));
			activityIntegral.setScope(oldval[4]);
			activityIntegral.setLevel(oldval[5]);
			activityIntegral.setThingName(oldval[6]);
			activityIntegral.setGrade(Double.parseDouble(oldval[7]));
			activityIntegral.setRemark(oldval[8]);
			BasicDBObject query = CreateQueryFromBean.EqualObj(activityIntegral); 
			
//			for (int i = 0; i < newval.length; i++) {
//				System.out.print("新值:"+newval[i]+" ");
//			}
//			System.out.println();
//			for (int i = 0; i < oldval.length; i++) {
//				System.out.print("旧值:"+oldval[i]+" ");
//			}
			
			ActivityIntegral activityIntegral1 = new ActivityIntegral();
			activityIntegral1.setIdCard(newval[1]);
			activityIntegral1.setName(newval[0]);
			activityIntegral1.setMajor(newval[2]);
			activityIntegral1.setScope(newval[4]);
			activityIntegral.setYear(Integer.parseInt(newval[3]));
			System.out.println("更新,新值:"+Integer.parseInt(newval[3]));
			activityIntegral1.setLevel(newval[5]);
			activityIntegral1.setThingName(newval[6]);
			activityIntegral1.setGrade(Double.parseDouble(newval[7]));
			activityIntegral1.setRemark(newval[8]);
			
			DaoImpl.update(query, activityIntegral1, false);
			
			response.getWriter().print("更新成功");
		}	
	}
	
	//删除
	public void delete() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		String [] delvals = Util.DoGetString(deletevalues).trim().split(";");
		if(schoolId!=null&&!"".equals(schoolId)){
			for(int i =0; i<delvals.length;i++){
			String [] delval = delvals[i].trim().split(",");
			ActivityIntegral activityIntegral = new ActivityIntegral();
			activityIntegral.setTableId(new ObjectId(tableId));
			activityIntegral.setIdCard(delval[1]);
			activityIntegral.setName(delval[0]);
			activityIntegral.setMajor(delval[2]);
			activityIntegral.setYear(Integer.parseInt(delval[3]));
			System.out.println("删除："+Integer.parseInt(delval[3]));
			activityIntegral.setScope(delval[4]);
			activityIntegral.setLevel(delval[5]);
			activityIntegral.setThingName(delval[6]);
			activityIntegral.setGrade(Double.parseDouble(delval[7]));
			activityIntegral.setRemark(delval[8]);
			BasicDBObject query = CreateQueryFromBean.EqualObj(activityIntegral);			
			DaoImpl.DeleteDocment(ActivityIntegral.class, query);			
			}
			response.getWriter().print("删除成功");		
		}else{
			response.getWriter().print("删除失败");
		}
	}
	
	public String getOldvalues() {
		return oldvalues;
	}
	public void setOldvalues(String oldvalues) {
		this.oldvalues = oldvalues;
	}
	public String getNewvalues() {
		return newvalues;
	}
	public void setNewvalues(String newvalues) {
		this.newvalues = newvalues;
	}
	public String getDeletevalues() {
		return deletevalues;
	}
	public void setDeletevalues(String deletevalues) {
		this.deletevalues = deletevalues;
	}
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}

	public ObjectId getSchoolId() {
		return schoolId;
	}

	public void setSchoolId(ObjectId schoolId) {
		this.schoolId = schoolId;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public ObjectId getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(ObjectId categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
}
