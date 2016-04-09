package bean;

import org.bson.types.ObjectId;

public class UserSkimFunction {
	
	private ObjectId _id;
	private ObjectId StuId ;
	private String Function;
	
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
	public String getFunction() {
		return Function;
	}
	public void setFunction(String function) {
		Function = function;
	}
	
}
