package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class ActivityIntegral {
	private ObjectId _id;
	private ObjectId TableId;
	private String TableName;
	private ObjectId ActivityId;
	private ObjectId OrganizationId;
	private ObjectId StuId;
	private ObjectId SchoolId;
	private String IdCard;
	private String Name;
	private String Major;
	private String Scope;
	private String Level;
	private String ThingName;
	private ObjectId CategoryId;
	private String CategoryName;
	private Double Grade;
	private String Remark;
	private Date CreateTime;
	private Integer Year;
	public ObjectId get_id() {
		return _id;
	}
	public void set_id(ObjectId _id) {
		this._id = _id;
	}
	public ObjectId getTableId() {
		return TableId;
	}
	public void setTableId(ObjectId tableId) {
		TableId = tableId;
	}
	public String getTableName() {
		return TableName;
	}
	public void setTableName(String tableName) {
		TableName = tableName;
	}
	public ObjectId getActivityId() {
		return ActivityId;
	}
	public void setActivityId(ObjectId activityId) {
		ActivityId = activityId;
	}
	public ObjectId getOrganizationId() {
		return OrganizationId;
	}
	public void setOrganizationId(ObjectId organizationId) {
		OrganizationId = organizationId;
	}
	public ObjectId getStuId() {
		return StuId;
	}
	public void setStuId(ObjectId stuId) {
		StuId = stuId;
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
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getMajor() {
		return Major;
	}
	public void setMajor(String major) {
		Major = major;
	}
	public String getScope() {
		return Scope;
	}
	public void setScope(String scope) {
		Scope = scope;
	}
	public String getLevel() {
		return Level;
	}
	public void setLevel(String level) {
		Level = level;
	}
	public String getThingName() {
		return ThingName;
	}
	public void setThingName(String thingName) {
		ThingName = thingName;
	}
	public ObjectId getCategoryId() {
		return CategoryId;
	}
	public void setCategoryId(ObjectId categoryId) {
		CategoryId = categoryId;
	}
	public String getCategoryName() {
		return CategoryName;
	}
	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}
	public Double getGrade() {
		return Grade;
	}
	public void setGrade(Double grade) {
		Grade = grade;
	}
	public String getRemark() {
		return Remark;
	}
	public void setRemark(String remark) {
		Remark = remark;
	}
	public Date getCreateTime() {
		return CreateTime;
	}
	public void setCreateTime(Date createTime) {
		CreateTime = createTime;
	}
	public Integer getYear() {
		return Year;
	}
	public void setYear(Integer year) {
		Year = year;
	}

	
}
