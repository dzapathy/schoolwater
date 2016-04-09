package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class OutActivity{
	
	private String Category;
	private String ImgUrl;
	private Date DeadLine ;
	private String  RunTime;
	private String Content ;
	private String AttachmentName;
	private String AttachmentUrl;
	private Date  ReleaseTime;
	private String Organization;
	private ObjectId _id;
	private String Name;
	
	public String getCategory() {
		return Category;
	}
	public void setCategory(String category) {
		Category = category;
	}
	public String getImgUrl() {
		return ImgUrl;
	}
	public void setImgUrl(String imgUrl) {
		ImgUrl = imgUrl;
	}
	public Date getDeadLine() {
		return DeadLine;
	}
	public void setDeadLine(Date deadLine) {
		DeadLine = deadLine;
	}
	public String getRunTime() {
		return RunTime;
	}
	public void setRunTime(String runTime) {
		RunTime = runTime;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public String getAttachmentName() {
		return AttachmentName;
	}
	public void setAttachmentName(String attachmentName) {
		AttachmentName = attachmentName;
	}
	public String getAttachmentUrl() {
		return AttachmentUrl;
	}
	public void setAttachmentUrl(String attachmentUrl) {
		AttachmentUrl = attachmentUrl;
	}
	public Date getReleaseTime() {
		return ReleaseTime;
	}
	public void setReleaseTime(Date releaseTime) {
		ReleaseTime = releaseTime;
	}
	public String getOrganization() {
		return Organization;
	}
	public void setOrganization(String organization) {
		Organization = organization;
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
}
