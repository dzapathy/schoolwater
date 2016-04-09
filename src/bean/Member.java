package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class Member {
	private ObjectId StuId;
	private ObjectId SchoolId;
	private String IdCard;
	private String Name;
	private String Abstract ;
	private String MajorName;
	private Integer Degree;
	private String Phone;
	private Integer Grade;	
	private Integer State;
	private Date NowTime;
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
	public String getAbstract() {
		return Abstract;
	}
	public void setAbstract(String abstract1) {
		Abstract = abstract1;
	}
	public String getMajorName() {
		return MajorName;
	}
	public void setMajorName(String majorName) {
		MajorName = majorName;
	}
	public Integer getDegree() {
		return Degree;
	}
	public void setDegree(Integer degree) {
		Degree = degree;
	}
	public String getPhone() {
		return Phone;
	}
	public void setPhone(String phone) {
		Phone = phone;
	}
	public Integer getGrade() {
		return Grade;
	}
	public void setGrade(Integer grade) {
		Grade = grade;
	}
	public Integer getState() {
		return State;
	}
	public void setState(Integer state) {
		State = state;
	}
	public Date getNowTime() {
		return NowTime;
	}
	public void setNowTime(Date nowTime) {
		NowTime = nowTime;
	}
	
}
