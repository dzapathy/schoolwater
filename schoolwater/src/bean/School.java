package bean;

import java.util.ArrayList;
import java.util.Date;

import org.bson.types.ObjectId;

public class School {
	
	private String AddressP;
	private String AddressC;
	private String Tel;
	private String LogoUrl;
	private String ShowUrl;
	private Date OpenTime;
	private ArrayList<Major> Major;
	private ObjectId _id;
	private String Name;
	private ArrayList<InActivityCategoty> InActivityCategoty;
	
	public String getAddressP() {
		return AddressP;
	}
	public void setAddressP(String addressP) {
		AddressP = addressP;
	}
	public String getAddressC() {
		return AddressC;
	}
	public void setAddressC(String addressC) {
		AddressC = addressC;
	}
	public String getTel() {
		return Tel;
	}
	public void setTel(String tel) {
		Tel = tel;
	}
	public String getLogoUrl() {
		return LogoUrl;
	}
	public void setLogoUrl(String logoUrl) {
		LogoUrl = logoUrl;
	}
	public Date getOpenTime() {
		return OpenTime;
	}
	public void setOpenTime(Date openTime) {
		OpenTime = openTime;
	}
	public ArrayList<Major> getMajor() {
		return Major;
	}
	public void setMajor(ArrayList<Major> major) {
		Major = major;
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
	public ArrayList<InActivityCategoty> getInActivityCategoty() {
		return InActivityCategoty;
	}
	public void setInActivityCategoty(
			ArrayList<InActivityCategoty> inActivityCategoty) {
		InActivityCategoty = inActivityCategoty;
	}
	public String getShowUrl() {
		return ShowUrl;
	}
	public void setShowUrl(String showUrl) {
		ShowUrl = showUrl;
	}
	
	
}
