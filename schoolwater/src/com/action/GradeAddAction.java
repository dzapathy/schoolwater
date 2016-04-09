package com.action;

import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.json.JSONArray;
import org.json.JSONObject;

import utils.Util;
import bean.ActivityIntegral;
import bean.ActivityIntegralTable;
import bean.School;
import bean.StudentInfo;
import bean.TableContentInfo;
import bean.TableInfo;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

public class GradeAddAction extends ActionSupport {

	private String inActivityId;
	private String tableId;
	private String data;
	private String tableName;

	public void searchTable() throws Exception {

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		System.out.println(inActivityId);
		System.out.println("test1");

		ActivityIntegral activityIntegral = new ActivityIntegral();
		activityIntegral.setActivityId(new ObjectId(inActivityId));
		BasicDBObject q = CreateQueryFromBean.EqualObj(activityIntegral);
		long num = DaoImpl.GetSelectCount(ActivityIntegral.class, q);
		if (num == 0) {

			TableInfo tableInfo = new TableInfo();
			tableInfo.setActivityId(new ObjectId(inActivityId));
			BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);
			BasicDBObject projection = new BasicDBObject();
			MongoCursor<Document> mc = DaoImpl.GetSelectCursor(TableInfo.class,
					query, projection);
			ArrayList<Document> tableList = new ArrayList<Document>();
			while (mc.hasNext()) {
				tableList.add(mc.next());
				System.out.println("test2");
			}
			System.out.println("test3");
			JSONArray jsonArray = new JSONArray();

			for (int i = 0; i < tableList.size(); i++) {
				Document document = tableList.get(i);
				JSONObject object = new JSONObject();
				object.put("id", (ObjectId) document.get("_id"));
				object.put("Name", (String) document.get("Name"));
				jsonArray.put(object);
			}

			response.getWriter().print(jsonArray.toString());
		} else {
			response.getWriter().print("error");
		}

	}

	public void searchTableContent() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		System.out.println(tableId);

		TableContentInfo tableContentInfo = new TableContentInfo();
		tableContentInfo.setTableId(new ObjectId(tableId));
		BasicDBObject query = CreateQueryFromBean.EqualObj(tableContentInfo);
		BasicDBObject projection = new BasicDBObject();
		MongoCursor<Document> mc = DaoImpl.GetSelectCursor(
				TableContentInfo.class, query, projection);
		ArrayList<Document> tableList = new ArrayList<Document>();
		while (mc.hasNext()) {
			tableList.add(mc.next());
		}

		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < tableList.size(); i++) {
			ObjectId stuId = (ObjectId) tableList.get(i).get("StuId");

			StudentInfo studentInfo = new StudentInfo();
			studentInfo.set_id(stuId);
			query = CreateQueryFromBean.EqualObj(studentInfo);
			MongoCursor<Document> mongoCursor = DaoImpl.GetSelectCursor(
					StudentInfo.class, query, projection);
			Document document = new Document();
			while (mongoCursor.hasNext()) {
				System.out.println("获得数据");
				document = mongoCursor.next();

				System.out.println("test2");
				System.out.println(document.get("IdCard"));
				JSONObject object = new JSONObject();
				object.put("IdCard", (String) document.get("IdCard"));
				System.out.println(document.get("IdCard"));
				object.put("Name", (String) document.get("Name"));
				System.out.println(document.get("IdCard"));
				object.put("MajorName", (String) document.get("MajorName"));
				System.out.println(document.get("IdCard"));
				object.put("Grade", (Integer) document.get("Grade"));
				System.out.println(document.get("IdCard"));
				jsonArray.put(object);
			}
			System.out.println(i);
		}
		System.out.println("test1000003000");
		System.out.println(jsonArray.length());

		response.getWriter().print(jsonArray.toString());

	}

	public void save() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		System.out.println("save!!!");

		System.out.println(data);

		JSONArray jsonArray = new JSONArray(data);
		System.out.println(inActivityId);

		System.out.println(data);
		ObjectId TableId = new ObjectId();
		ActivityIntegralTable activityIntegralTable = new ActivityIntegralTable();
		activityIntegralTable.set_id(TableId);
		activityIntegralTable.setCreateTime(new Date());
		activityIntegralTable.setName(Util.DoGetString(tableName));

		// 获取组织id
		String organizationId = (String) ServletActionContext.getContext()
				.getSession().get("Organization_id");
		System.out.println("获取组织id");
		// 获取学校id
		ObjectId schoolId = (ObjectId) ServletActionContext.getContext()
				.getSession().get("Organization_SchoolId");
		System.out.println("获取学校id");
		activityIntegralTable.setOrganizationId(new ObjectId(organizationId));
		activityIntegralTable.setSchoolId(schoolId);

		DaoImpl.InsertWholeBean(activityIntegralTable);

		System.out.println("创建activityIntegralTable");

		System.out.println(jsonArray.length());
		for (int i = 0; i < jsonArray.length(); i++) {
			JSONObject jo = (JSONObject) jsonArray.get(i);
			System.out.println(jo.toString());
			System.out
					.println(Util.DoGetString((String) jo.get("categoryName")));

			ActivityIntegral activityIntegral2 = new ActivityIntegral();
			activityIntegral2.set_id(new ObjectId());
			if (!Util.DoGetString(inActivityId).equals("-1")) {
				activityIntegral2.setActivityId(new ObjectId(inActivityId));
			} else {
				activityIntegral2.setActivityId(new ObjectId(
						"000000000000000000000000"));
			}
			System.out.println("setActivityId");
			activityIntegral2.setCategoryName(Util.DoGetString((String) jo
					.get("categoryName")));
			System.out.println("setCategoryName");
			activityIntegral2.setCreateTime(new Date());
			activityIntegral2
					.setGrade(Double.valueOf((String) jo.get("grade")));
			System.out.println("setGrade");
			activityIntegral2.setIdCard(Util.DoGetString((String) jo
					.get("idCard")));
			activityIntegral2.setLevel(Util.DoGetString((String) jo
					.get("level")));
			activityIntegral2.setMajor(Util.DoGetString((String) jo
					.get("major")));
			activityIntegral2
					.setName(Util.DoGetString((String) jo.get("name")));
			activityIntegral2.setOrganizationId(new ObjectId(organizationId));
			System.out.println("setOrganizationId");
			activityIntegral2.setRemark(Util.DoGetString((String) jo
					.get("remark")));
			activityIntegral2.setSchoolId(schoolId);
			System.out.println("setSchoolId");
			activityIntegral2.setScope(Util.DoGetString((String) jo
					.get("scope")));
			// 根据学校id和学号查学生的objectid
			StudentInfo studentInfo = new StudentInfo();
			studentInfo.setSchoolId(schoolId);
			studentInfo.setIdCard(Util.DoGetString((String) jo.get("idCard")));
			BasicDBObject query = CreateQueryFromBean.EqualObj(studentInfo);
			BasicDBObject projection = new BasicDBObject();
			MongoCursor<Document> mongoCursor = DaoImpl.GetSelectCursor(
					StudentInfo.class, query, projection);
			// 如果没有查到设为24个0
			Document document = null;
			while (mongoCursor.hasNext()) {
				document = mongoCursor.next();
			}
			if (document != null) {
				activityIntegral2.setStuId((ObjectId) document.get("_id"));
				System.out.println("setStuId");
			} else {
				activityIntegral2.setStuId(new ObjectId(
						"000000000000000000000000"));
			}
			// 根据categoryName查categoryId
			School school = new School();
			school.set_id(schoolId);
			query = CreateQueryFromBean.EqualObj(school);
			MongoCursor<Document> mCursor = DaoImpl.GetSelectCursor(
					School.class, query, projection);
			while (mCursor.hasNext()) {
				Document document2 = mCursor.next();
				ArrayList<Document> category = (ArrayList<Document>) document2
						.get("InActivityCategoty");
				System.out.println("活动种类：" + category.size());
				for (int j = 0; j < category.size(); j++) {
					if (category
							.get(j)
							.get("Name")
							.equals(Util.DoGetString((String) jo
									.get("categoryName")))) {
						activityIntegral2.setCategoryId((ObjectId) category
								.get(j).get("_id"));
						System.out.println("获取categoryId");
						System.out.println(category.get(j).get("_id"));
						break;
					}
				}
			}
			activityIntegral2.setTableId(TableId);
			System.out.println("setTableId");
			activityIntegral2.setTableName(Util.DoGetString(tableName));
			activityIntegral2.setThingName(Util.DoGetString((String) jo
					.get("thingName")));
			System.out.println("setThingName");
			activityIntegral2.setYear(Integer.valueOf((String) jo.get("year"))
					.intValue());
			System.out.println("setYear");
			DaoImpl.InsertWholeBean(activityIntegral2);
			System.out.println("activityIntegral2创建完成");
		}
		response.getWriter().print("success");

	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getInActivityId() {
		return inActivityId;
	}

	public void setInActivityId(String inActivityId) {
		this.inActivityId = inActivityId;
	}

	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

}
