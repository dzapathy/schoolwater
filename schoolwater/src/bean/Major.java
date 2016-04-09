package bean;

import org.bson.types.ObjectId;

public class Major  {	
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
}
