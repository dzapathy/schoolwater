package com.action;

import java.util.ArrayList;
import java.util.Date;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import bean.SchoolNotice;
import bean.TableContentInfo;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ActivityNewsAction extends ActionSupport {

	private String name;
	private String content;
	private String tableId;
	
	@Override
	public String execute() throws Exception {
		
		//如果选择了具体的表
		if(tableId != null){
			TableContentInfo tableContentInfo = new TableContentInfo();
			tableContentInfo.setTableId(new ObjectId(tableId));
			//查询选中表格的内容信息
			BasicDBObject query = CreateQueryFromBean.EqualObj(tableContentInfo);
			BasicDBObject projection = new BasicDBObject();
			MongoCursor<Document> mCursor = DaoImpl.GetSelectCursor(TableContentInfo.class, query, projection);
			ArrayList<Document> studentList = new ArrayList<Document>();
			while(mCursor.hasNext()) {
				studentList.add(mCursor.next());
			}
			//如果表格中有人
			if(studentList != null && studentList.size() != 0){
				String organizationId = (String) ServletActionContext.getContext().getSession().get("Organization_id");
				String organizationName=(String)ServletActionContext.getContext().getSession().get("Organization_Name");
				
				//创建校方通知表信息
				String activityName = (String) ActionContext.getContext().getSession().get("SelectedActivityName");
				String addMessage = "<strong>" + activityName + "</strong><hr>";
				for(int i = 0; i < studentList.size(); i++) {
					Document document = studentList.get(i);
					ObjectId stuId = (ObjectId)document.get("StuId");
					SchoolNotice schoolNotice = new SchoolNotice();
					schoolNotice.set_id(new ObjectId());
					schoolNotice.setContent(addMessage + content);
					schoolNotice.setOrganizationId(new ObjectId(organizationId));
					schoolNotice.setOrganizationName(organizationName);
					schoolNotice.setReceiver(stuId);
					schoolNotice.setReleaseTime(new Date());
					schoolNotice.setTitle(name);
					DaoImpl.InsertWholeBean(schoolNotice);
				}
				return SUCCESS;
			} else {
				return null;
			}
		} else {
			return null;
		}
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}


	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
}
