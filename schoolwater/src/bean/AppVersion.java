package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class AppVersion {
	private ObjectId _id;
	private String Version;
	private String Goodness;
	private String DownloadUrl;
	private Date ReleaseTime;
	
	public Date getReleaseTime() {
		return ReleaseTime;
	}
	public void setReleaseTime(Date releaseTime) {
		ReleaseTime = releaseTime;
	}
	public ObjectId get_id() {
		return _id;
	}
	public void set_id(ObjectId _id) {
		this._id = _id;
	}
	public String getVersion() {
		return Version;
	}
	public void setVersion(String version) {
		Version = version;
	}
	public String getGoodness() {
		return Goodness;
	}
	public void setGoodness(String goodness) {
		Goodness = goodness;
	}
	public String getDownloadUrl() {
		return DownloadUrl;
	}
	public void setDownloadUrl(String downloadUrl) {
		DownloadUrl = downloadUrl;
	}	
}
