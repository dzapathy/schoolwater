package com.action;

import java.util.ArrayList;
import java.util.Date;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import utils.Util;
import bean.TableInfo;
import bean.TableInfoColumn;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ActivityNewTableAction extends ActionSupport {

	private String select; // 选中的数据源
	private String tableName; // 新建的表格的名称
	private String tdContent; // 新表格的新字段
	private String tdLength;
	private String tdChoose;

	@Override
	public String execute() throws Exception {

		String[] activityId = Util.DoGetString(select).split(";");

		ObjectId tInfo_Id = new ObjectId();
		TableInfo tInfo = new TableInfo();
		tInfo.set_id(tInfo_Id);
		if (activityId[1].equals("-1")) {
			tInfo.setActivityId(new ObjectId(activityId[0]));
			ActionContext.getContext().put("OldTableInfo_id", "-1");
		} else {
			TableInfo tableInfo = new TableInfo();
			tableInfo.set_id(new ObjectId(activityId[0]));
			BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);
			BasicDBObject projection = new BasicDBObject();
			MongoCursor<Document> mc = DaoImpl.GetSelectCursor(TableInfo.class,
					query, projection);
			Document document = null;
			while(mc.hasNext()){
				document = mc.next();
			}
			ObjectId activityId2 = (ObjectId) document.get("ActivityId");
			tInfo.setActivityId(activityId2);
			ActionContext.getContext().put("OldTableInfo_id", activityId[0]);
		}

		tInfo.setCreateTime(new Date());
		tInfo.setName(Util.DoGetString(tableName));
		// 获取session中的organizationId
		String organizationId = (String) ServletActionContext.getContext()
				.getSession().get("Organization_id");
		tInfo.setOrganizationId(new ObjectId(organizationId));
		tInfo.setType(1);

		ArrayList<TableInfoColumn> tableInfoColumn = new ArrayList<TableInfoColumn>();
		String[] tdColumn = Util.DoGetString(tdContent).split(";");
		String[] tdL = tdLength.split(";");
		String []tdC = tdChoose.split(";");
		for (int i = 1; i < tdColumn.length; i++) {
			TableInfoColumn major = new TableInfoColumn();
			major.setName(tdColumn[i]);
			major.setChoose(Boolean.parseBoolean(tdC[i]));
			major.setLength(Integer.parseInt(tdL[i]));
			tableInfoColumn.add(major);
		}
		tInfo.setTableInfoColumn(tableInfoColumn);

		// 把新的信息表写入数据库中
		DaoImpl.InsertWholeBean(tInfo);
		
		ActionContext.getContext().put("TableInfo_id", tInfo_Id);
		System.out.println("success!");

		return SUCCESS;
	}

	public String getSelect() {
		return select;
	}

	public void setSelect(String select) {
		this.select = select;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getTdContent() {
		return tdContent;
	}

	public void setTdContent(String tdContent) {
		this.tdContent = tdContent;
	}

	public String getTdLength() {
		return tdLength;
	}

	public void setTdLength(String tdLength) {
		this.tdLength = tdLength;
	}

	public String getTdChoose() {
		return tdChoose;
	}

	public void setTdChoose(String tdChoose) {
		this.tdChoose = tdChoose;
	}
}
