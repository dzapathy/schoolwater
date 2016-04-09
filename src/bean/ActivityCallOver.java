package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class ActivityCallOver {
	
	private ObjectId _id;
	private ObjectId ActivityId;
	private Date Deadline;
	private Double PositionX;
	private Double PositionY;
	
	public ObjectId get_id() {
		return _id;
	}
	public void set_id(ObjectId _id) {
		this._id = _id;
	}
	public ObjectId getActivityId() {
		return ActivityId;
	}
	public void setActivityId(ObjectId activityId) {
		ActivityId = activityId;
	}
	public Double getPositionX() {
		return PositionX;
	}
	public void setPositionX(Double positionX) {
		PositionX = positionX;
	}
	public Double getPositionY() {
		return PositionY;
	}
	public void setPositionY(Double positionY) {
		PositionY = positionY;
	}
	public Date getDeadline() {
		return Deadline;
	}
	public void setDeadline(Date deadline) {
		Deadline = deadline;
	}
	
}
