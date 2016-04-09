package bean;

import java.util.ArrayList;
import java.util.Date;

import org.bson.types.ObjectId;

public class TableContentInfo {
	private ObjectId _id;
	private ObjectId StuId;
	private ObjectId TableId;
	private ObjectId SchoolId;
	private String IdCard;
	private Integer TableType;
	private ArrayList<TableContentColumn> TableContentColumn;
	private Date CreateTime;
	
	public ObjectId get_id() {
		return _id;
	}
	public void set_id(ObjectId _id) {
		this._id = _id;
	}
	public ObjectId getStuId() {
		return StuId;
	}
	public void setStuId(ObjectId stuId) {
		StuId = stuId;
	}
	public ObjectId getTableId() {
		return TableId;
	}
	public void setTableId(ObjectId tableId) {
		TableId = tableId;
	}
	public ArrayList<TableContentColumn> getTableContentColumn() {
		return TableContentColumn;
	}
	public void setTableContentColumn(
			ArrayList<TableContentColumn> tableContentColumn) {
		TableContentColumn = tableContentColumn;
	}
	public ObjectId getSchoolId() {
		return SchoolId;
	}
	public void setSchoolId(ObjectId schoolId) {
		SchoolId = schoolId;
	}
	public String getIdCard() {
		return IdCard;
	}
	public void setIdCard(String idCard) {
		IdCard = idCard;
	}
	public Integer getTableType() {
		return TableType;
	}
	public void setTableType(Integer tableType) {
		TableType = tableType;
	}
	public Date getCreateTime() {
		return CreateTime;
	}
	public void setCreateTime(Date createTime) {
		CreateTime = createTime;
	}
	
}
