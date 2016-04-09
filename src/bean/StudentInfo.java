package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class StudentInfo {
	private Integer Sex;
	private ObjectId SchoolId;
	private Integer Degree ;
	private String IdCard ;
	private String MajorName;
	private ObjectId MajorId;
	private Integer Grade;
	private String Email;
	private ObjectId _id;
	private String Name;
	private String Pwd;
	private String Phone;
	private Date CreateTime;	
	
	public String getPhone() {
		return Phone;
	}
	public void setPhone(String phone) {
		Phone = phone;
	}
	public Integer getSex() {
		return Sex;
	}
	public void setSex(Integer sex) {
		Sex = sex;
	}
	public ObjectId getSchoolId() {
		return SchoolId;
	}
	public void setSchoolId(ObjectId schoolId) {
		SchoolId = schoolId;
	}
	public Integer getDegree() {
		return Degree;
	}
	public void setDegree(Integer degree) {
		Degree = degree;
	}
	public String getIdCard() {
		return IdCard;
	}
	public void setIdCard(String idCard) {
		IdCard = idCard;
	}
	public String getMajorName() {
		return MajorName;
	}
	public void setMajorName(String majorName) {
		MajorName = majorName;
	}
	public ObjectId getMajorId() {
		return MajorId;
	}
	public void setMajorId(ObjectId majorId) {
		MajorId = majorId;
	}
	public Integer getGrade() {
		return Grade;
	}
	public void setGrade(Integer grade) {
		Grade = grade;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
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
	public String getPwd() {
		return Pwd;
	}
	public void setPwd(String pwd) {
		Pwd = pwd;
	}
	public Date getCreateTime() {
		return CreateTime;
	}
	public void setCreateTime(Date createTime) {
		CreateTime = createTime;
	}
}
