package com.action;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import bean.SystemNotice;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class BulletinAction extends ActionSupport{
	private String _id;

	public String get_id() {
		return _id;
	}
	public void set_id(String _id) {
		this._id = _id;
	}

	@Override
	public String execute() throws Exception {
		SystemNotice sn=new SystemNotice();
		sn.set_id(new ObjectId(get_id()));
		BasicDBObject query =CreateQueryFromBean.EqualObj(sn);
		BasicDBObject projection=new BasicDBObject();
		MongoCursor<Document> mc=DaoImpl.GetSelectCursor(SystemNotice.class, query, projection);
		ServletActionContext.getRequest().setAttribute("announcementdetail", mc);
		return SUCCESS;
	}	
}
