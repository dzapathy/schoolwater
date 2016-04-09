package bean;

import java.util.ArrayList;
import java.util.Date;

import org.bson.types.ObjectId;

public class TableInfo {
	private ObjectId OrganizationId;
	private ObjectId ActivityId ;
	private Integer Type ;
	private Date CreateTime;
	private ArrayList<TableInfoColumn> TableInfoColumn;
	private ObjectId _id;
	private String Name;
	public ObjectId getOrganizationId() {
		return OrganizationId;
	}
	public void setOrganizationId(ObjectId organizationId) {
		OrganizationId = organizationId;
	}
	public ObjectId getActivityId() {
		return ActivityId;
	}
	public void setActivityId(ObjectId activityId) {
		ActivityId = activityId;
	}
	public Integer getType() {
		return Type;
	}
	public void setType(Integer type) {
		Type = type;
	}
	public Date getCreateTime() {
		return CreateTime;
	}
	public void setCreateTime(Date createTime) {
		CreateTime = createTime;
	}
	public ArrayList<TableInfoColumn> getTableInfoColumn() {
		return TableInfoColumn;
	}
	public void setTableInfoColumn(ArrayList<TableInfoColumn> tableInfoColumn) {
		TableInfoColumn = tableInfoColumn;
	}
	public ObjectId get_id() {
		return _id;
	}
	public void set_id(ObjectId _id) {
		this._id = _id;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
}
