package com.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import staticData.StaticString;
import utils.Util;
import bean.InActivity;
import bean.TableInfo;
import bean.TableInfoColumn;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class OmnipotentAction extends ActionSupport{
	private String tableName;	//表名称
	private String select;			//活动类型
	private List<String> nameList;	
	private List<String> lengthList;
	private String chooseList;
	@Override
	public String execute() throws Exception {		
		//查找对应活动ID
		ObjectId activityId=null; //设置活动ID
		String organizationId=(String)ServletActionContext.getContext().getSession().get("Organization_id");
		if("不绑定活动".equals(Util.DoGetString(select))){
			activityId = new ObjectId("000000000000000000000000");
		}else{
			InActivity activity = new InActivity();
			activity.setOrganizationId(new ObjectId(organizationId));
			activity.setName(Util.DoGetString(select));
			BasicDBObject query = CreateQueryFromBean.EqualObj(activity);
			BasicDBObject p = new BasicDBObject();
			p.put(StaticString.InActivity_Name, 1);
			p.put(StaticString.InActivity_id, 1);
			MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(InActivity.class, query, p);
			while(cursor.hasNext()){
				Document document = cursor.next();
				activityId= document.getObjectId("_id");
			}
		}
		
		//存入表头
		ArrayList<TableInfoColumn> tableInfoColumn = new ArrayList<TableInfoColumn>();
		TableInfoColumn infoColumn1 = new TableInfoColumn();
		infoColumn1.setName("姓名");
		infoColumn1.setChoose(true);
		infoColumn1.setLength(5);
		tableInfoColumn.add(infoColumn1);
		TableInfoColumn infoColumn2 = new TableInfoColumn();
		infoColumn2.setName("学号");
		infoColumn2.setChoose(true);
		infoColumn2.setLength(10);
		tableInfoColumn.add(infoColumn2);
		
		ArrayList<Integer> numList = new ArrayList<Integer>();
		if(chooseList!=null){
			String [] str = chooseList.split(",");				 
			for(int i = 0; i< str.length ; i++){
				numList.add(Integer.parseInt((str[i].trim()))-3);			
			}
		}
		
		if(nameList!=null&&chooseList==null){
		for(int i =0 ;i< nameList.size() ;i++){
			TableInfoColumn infoColumn = new TableInfoColumn();
			infoColumn.setName(Util.DoGetString(nameList.get(i)));
			infoColumn.setChoose(false);
			infoColumn.setLength(Integer.parseInt(lengthList.get(i)));
			tableInfoColumn.add(infoColumn);
		}}
		if(nameList!=null&&chooseList!=null){
			for(int i =0 ;i< nameList.size() ;i++){
				TableInfoColumn infoColumn = new TableInfoColumn();
				infoColumn.setName(Util.DoGetString(nameList.get(i)));
				if(numList.contains(i)){
					infoColumn.setChoose(true);
				}else{
					infoColumn.setChoose(false);
				}
				infoColumn.setLength(Integer.parseInt(lengthList.get(i)));
				tableInfoColumn.add(infoColumn);
			}
		}		
		ObjectId tableId = new ObjectId();
		
		//存入TableInfo
		TableInfo tableInfo = new TableInfo();
		tableInfo.set_id(tableId);
		tableInfo.setName(Util.DoGetString(tableName));
		tableInfo.setType(1);	//其他数据表
		tableInfo.setOrganizationId(new ObjectId(organizationId));
		tableInfo.setActivityId(activityId);
		tableInfo.setCreateTime(new Date());	
		tableInfo.setTableInfoColumn(tableInfoColumn);
		DaoImpl.InsertWholeBean(tableInfo);		
		ServletActionContext.getRequest().setAttribute("tableId", tableId);
		ServletActionContext.getRequest().setAttribute("tableName", tableName);
		
		return SUCCESS;
	}
	
	public String getSelect() {
		return select;
	}
	public void setSelect(String select) {
		this.select = select;
	}
	public List<String> getNameList() {
		return nameList;
	}
	public void setNameList(List<String> nameList) {
		this.nameList = nameList;
	}
	public List<String> getLengthList() {
		return lengthList;
	}
	public void setLengthList(List<String> lengthList) {
		this.lengthList = lengthList;
	}
	public String getChooseList() {
		return chooseList;
	}
	public void setChooseList(String chooseList) {
		this.chooseList = chooseList;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
}
