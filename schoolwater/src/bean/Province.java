package bean;

import java.util.ArrayList;

import org.bson.types.ObjectId;

public class Province {
	private ObjectId _id;
	private String Name;
	private ArrayList<City> City;
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
	public ArrayList<City> getCity() {
		return City;
	}
	public void setCity(ArrayList<City> city) {
		City = city;
	}
	
}
