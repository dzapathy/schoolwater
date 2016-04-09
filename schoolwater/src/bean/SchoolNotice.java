package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class SchoolNotice{
	
	private ObjectId _id;
	private String Title;
	private String Content;
	private ObjectId OrganizationId;
	private String OrganizationName;
	private ObjectId Receiver;
	private Date ReleaseTime;
	

	public ObjectId getOrganizationId() {
		return OrganizationId;
	}
	public void setOrganizationId(ObjectId organizationId) {
		OrganizationId = organizationId;
	}
	public String getOrganizationName() {
		return OrganizationName;
	}
	public void setOrganizationName(String organizationName) {
		OrganizationName = organizationName;
	}
	public ObjectId getReceiver() {
		return Receiver;
	}
	public void setReceiver(ObjectId receiver) {
		Receiver = receiver;
	}

	public ObjectId get_id() {
		return _id;
	}
	public void set_id(ObjectId _id) {
		this._id = _id;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
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
	
}
