package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class UserSkimTime {
	
	private ObjectId _id;
	private ObjectId StuId ;
	private Date LoginTime;
	private Date ExitTime;
	
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
	public Date getLoginTime() {
		return LoginTime;
	}
	public void setLoginTime(Date loginTime) {
		LoginTime = loginTime;
	}
	public Date getExitTime() {
		return ExitTime;
	}
	public void setExitTime(Date exitTime) {
		ExitTime = exitTime;
	}
	
}
