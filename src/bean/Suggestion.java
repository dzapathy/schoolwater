package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class Suggestion {
	
	private ObjectId _id;
	private String From;
	private String Content;
	private Date ReleaseTime;
	private ObjectId DealPerson;
	private String Solution;
	private Date DealTime;
	private Integer State;//1 已处理 0未处理

	
	public ObjectId get_id() {
		return _id;
	}
	public void set_id(ObjectId _id) {
		this._id = _id;
	}
	public String getFrom() {
		return From;
	}
	public void setFrom(String from) {
		From = from;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public Date getReleaseTime() {
		return ReleaseTime;
	}
	public void setReleaseTime(Date releaseTime) {
		ReleaseTime = releaseTime;
	}
	public ObjectId getDealPerson() {
		return DealPerson;
	}
	public String getSolution() {
		return Solution;
	}
	public Date getDealTime() {
		return DealTime;
	}
	public Integer getState() {
		return State;
	}
	public void setDealPerson(ObjectId dealPerson) {
		DealPerson = dealPerson;
	}
	public void setSolution(String solution) {
		Solution = solution;
	}
	public void setDealTime(Date dealTime) {
		DealTime = dealTime;
	}
	public void setState(Integer state) {
		State = state;
	}
	
}
