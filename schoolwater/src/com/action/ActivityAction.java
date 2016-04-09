package com.action;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import staticData.StaticString;

import bean.InActivity;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ActivityAction extends ActionSupport {

	private String _id;

	public String get_id() {
		return _id;
	}

	public void set_id(String _id) {
		this._id = _id;
	}

	@Override
	public String execute() throws Exception {

		// ´æsession activityId

		InActivity inActivity = new InActivity();
		inActivity.set_id(new ObjectId(_id));
		BasicDBObject query = CreateQueryFromBean.EqualObj(inActivity);
		BasicDBObject projection = new BasicDBObject();
		projection.put(StaticString.InActivity_id, 1);
		projection.put(StaticString.InActivity_Name, 1);
		projection.put(StaticString.InActivity_ReleaseTime, 1);
		MongoCursor<Document> mc = DaoImpl.GetSelectCursor(InActivity.class,
				query, projection);
		Document document = null;
		while (mc.hasNext()) {
			document = mc.next();
		}

		ActionContext.getContext().getSession()
				.put("SelectedActivityId", document.get("_id").toString());
		ActionContext.getContext().getSession()
				.put("SelectedActivityName", document.get("Name"));
		ActionContext.getContext().getSession()
				.put("SelectedActivityReleaseTime", document.get("ReleaseTime"));

		
		ServletActionContext.getRequest().setAttribute("activityDetail",
				get_id());
		return SUCCESS;
	}
}
