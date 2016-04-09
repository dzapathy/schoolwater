package bean;

import java.util.ArrayList;

import org.bson.types.ObjectId;

public class Organization {

	private ObjectId LevelTopId ;
	private ObjectId SchoolId;
	private ArrayList<Manager> Manager;
	private ObjectId _id;
	private String Name;
	
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
	public ObjectId getLevelTopId() {
		return LevelTopId;
	}
	public void setLevelTopId(ObjectId levelTopId) {
		LevelTopId = levelTopId;
	}
	public ObjectId getSchoolId() {
		return SchoolId;
	}
	public void setSchoolId(ObjectId schoolId) {
		SchoolId = schoolId;
	}
	public ArrayList<Manager> getManager() {
		return Manager;
	}
	public void setManager(ArrayList<Manager> manager) {
		Manager = manager;
	}

	
}
