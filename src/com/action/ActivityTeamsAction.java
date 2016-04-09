package com.action;

import java.sql.Date;
import java.util.ArrayList;

import javax.print.Doc;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.json.JSONArray;
import org.json.JSONObject;

import staticData.StaticString;
import utils.Util;

import bean.Member;
import bean.TableContentInfo;
import bean.TableInfo;
import bean.TeamInfo;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

public class ActivityTeamsAction extends ActionSupport {

	private String teamInfoId;
	private String delIdCard;
	
	
	private static String staticTeamInfoId;
	
	@SuppressWarnings("unchecked")
	public String search() throws Exception {
		//保存id
		staticTeamInfoId = teamInfoId;
		
		TeamInfo teamInfo = new TeamInfo();
		teamInfo.set_id(new ObjectId(teamInfoId));
		
		BasicDBObject query = CreateQueryFromBean.EqualObj(teamInfo);
		BasicDBObject projection = new BasicDBObject();
		//projection.put("Member", 1);
		projection.put(StaticString.Member_Name, 1); //成员姓名
		projection.put(StaticString.Member_IdCard, 1); //成员学号
		projection.put(StaticString.Member_MajorName, 1); //成员专业
		projection.put(StaticString.Member_Phone, 1); //成员电话
		projection.put(StaticString.Member_Degree, 1); //成员学历
		projection.put(StaticString.Member_State, 1); //申请状态
		
		MongoCursor<Document> mongoCursor = DaoImpl.GetSelectCursor(TeamInfo.class, query, projection);
		ArrayList<Document> memberInfos = new ArrayList<Document>();
		while(mongoCursor.hasNext()) {
			memberInfos = (ArrayList<Document>) mongoCursor.next().get("Member");
		}
		JSONArray data = new JSONArray();
		for(int i = 0; i < memberInfos.size(); i ++) {
			JSONObject object = new JSONObject(memberInfos.get(i));
			String major = object.get("Degree").toString();
			if(major.equals("0")){
				object.put("Degree", "专科");
			} else if(major.equals("1")) {
				object.put("Degree", "本科");
			} else if(major.equals("2")) {
				object.put("Degree", "硕士");
			} else {
				object.put("Degree", "博士");
			}
			data.put(object);
		}
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().print(data.toString());
		
		return null;
	}
	
	public String delMember() throws Exception {
		
		System.out.println(staticTeamInfoId);
		System.out.println(delIdCard);
		
		TeamInfo teamInfo = new TeamInfo();
		teamInfo.set_id(new ObjectId(staticTeamInfoId));
		BasicDBObject query = CreateQueryFromBean.EqualObj(teamInfo);

		Member member = new Member();
		member.setIdCard(delIdCard);
		ObjectId schoolId = (ObjectId) ServletActionContext.getContext()
				.getSession().get("Organization_SchoolId");
		member.setSchoolId(schoolId);
		
		ArrayList<Member> list = new ArrayList<Member>();
		list.add(member);
		
		DaoImpl.DeleteSonSomeBean(TeamInfo.class, query, Member.class, list);
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().print("删除成功！");
		
		return null;
	}
	
	public String del() throws Exception {
		
		
		System.out.println(teamInfoId);

		TeamInfo teamInfo = new TeamInfo();
		teamInfo.set_id(new ObjectId(teamInfoId));
		BasicDBObject query = CreateQueryFromBean.EqualObj(teamInfo);
		BasicDBObject projection = new BasicDBObject();
		projection.put("ActivityId", 1);
		projection.put(StaticString.Member_IdCard, 1);
		MongoCursor<Document> mongoCursor = DaoImpl.GetSelectCursor(TeamInfo.class, query, projection);
		Document document = null;
		while(mongoCursor.hasNext()) {
			document = mongoCursor.next();
		}
		
		if(document != null) {
			ArrayList<Document> memberList = (ArrayList<Document>) document.get("Member");
			System.out.println(memberList.size());
			ObjectId activityId = (ObjectId)document.get("ActivityId");
			System.out.println(activityId);
			
			
			TableInfo tableInfo = new TableInfo();
			tableInfo.setType(0);
			tableInfo.setActivityId(activityId);
			BasicDBObject query1 = CreateQueryFromBean.EqualObj(tableInfo);
			BasicDBObject projection1 =new BasicDBObject();
			projection1.put("_id", 1);
			MongoCursor<Document> mongoCursor2 = DaoImpl.GetSelectCursor(TableInfo.class, query1, projection1);
			Document document2 = null;
			while(mongoCursor2.hasNext()) {
				document2 = mongoCursor2.next();
			}
			TableContentInfo tableContentInfo = new TableContentInfo();
			tableContentInfo.setTableId((ObjectId)document2.get("_id"));
			for(int i = 0; i < memberList.size(); i ++) {
				tableContentInfo.setIdCard((String)memberList.get(i).get("IdCard"));
				BasicDBObject query2 = CreateQueryFromBean.EqualObj(tableContentInfo);
				
				System.out.println("哈铪铪");
				DaoImpl.DeleteDocment(TableContentInfo.class, query2);
			}
			DaoImpl.DeleteDocment(TeamInfo.class, query);
		}
		
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().print("删除成功！");
		
		return null;
	}
	
	
	
	
	

	public String getTeamInfoId() {
		return teamInfoId;
	}

	public void setTeamInfoId(String teamInfoId) {
		this.teamInfoId = teamInfoId;
	}

	public String getDelIdCard() {
		return delIdCard;
	}

	public void setDelIdCard(String delIdCard) {
		this.delIdCard = delIdCard;
	}
}
