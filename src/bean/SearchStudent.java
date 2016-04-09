package bean;

import org.bson.types.ObjectId;

public class SearchStudent {
	private ObjectId stuId;
	private ObjectId schoolId;
	private String idCard;
	
	public ObjectId getStuId() {
		return stuId;
	}
	public void setStuId(ObjectId stuId) {
		this.stuId = stuId;
	}
	public ObjectId getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(ObjectId schoolId) {
		this.schoolId = schoolId;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
}
