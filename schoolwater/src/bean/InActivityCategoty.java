package bean;

import org.bson.types.ObjectId;

public class InActivityCategoty {
	
	private String Name;
	private ObjectId _id;
	
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
