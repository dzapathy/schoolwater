package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class SystemNotice {

	private ObjectId _id;
	private String Title;
	private String Content;
	private Date ReleaseTime;
	private String Publisher;
	private Integer Receiver;
	
	public ObjectId get_id() {
		return _id;
	}
	public void set_id(ObjectId _id) {
		this._id = _id;
	}
	public Date getReleaseTime() {
		return ReleaseTime;
	}
	public void setReleaseTime(Date releaseTime) {
		ReleaseTime = releaseTime;
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

	
	public String getPublisher() {
		return Publisher;
	}
	public void setPublisher(String publisher) {
		Publisher = publisher;
	}
	
	public Integer getReceiver() {
		return Receiver;
	}
	public void setReceiver(Integer receiver) {
		Receiver = receiver;
	}
}
