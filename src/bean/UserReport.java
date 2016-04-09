package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class UserReport {
	private ObjectId _id;
	private String From ;
	private Date ReportTime;
	private String Content;
	private ObjectId DealPerson;
	private String Solution;
	private Date DealTime;
	
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
	public Date getReportTime() {
		return ReportTime;
	}
	public void setReportTime(Date reportTime) {
		ReportTime = reportTime;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public ObjectId getDealPerson() {
		return DealPerson;
	}
	public void setDealPerson(ObjectId dealPerson) {
		DealPerson = dealPerson;
	}
	public String getSolution() {
		return Solution;
	}
	public void setSolution(String solution) {
		Solution = solution;
	}
	public Date getDealTime() {
		return DealTime;
	}
	public void setDealTime(Date dealTime) {
		DealTime = dealTime;
	}
	
	
}
