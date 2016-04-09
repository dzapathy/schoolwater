package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class InActivity  {
	private ObjectId _id;
	private String Name;
	private ObjectId CategoryId;
	private String CategoryName;
	private String ImgUrl;
	private Date DeadLine ;
	private String  RunTime;
	private String Content ;
	private String AttachmentName;
	private String AttachmentUrl;
	private Date  ReleaseTime;
	private ObjectId OrganizationId;
	private String OrganizationName;
	private Integer OnlyTeam;
	private ObjectId SchoolId;
	
	public ObjectId getSchoolId() {
		return SchoolId;
	}
	public void setSchoolId(ObjectId schoolId) {
		SchoolId = schoolId;
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
	public Integer getOnlyTeam() {
		return OnlyTeam;
	}
	public void setOnlyTeam(Integer onlyTeam) {
		OnlyTeam = onlyTeam;
	}
	public ObjectId getCategoryId() {
		return CategoryId;
	}
	public void setCategoryId(ObjectId categoryId) {
		CategoryId = categoryId;
	}
	public String getCategoryName() {
		return CategoryName;
	}
	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}
	
}
