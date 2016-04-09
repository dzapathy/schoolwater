package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class ActivityShare  {
	private ObjectId _id;
	private ObjectId StuId;
	private Integer ActivityType;
	private Date OccurrenceTime;
	private Integer Way;
	private ObjectId ActivityId;
	public ObjectId get_id() {
		return _id;
	}
	public void set_id(ObjectId _id) {
		this._id = _id;
	}
	public ObjectId getStuId() {
		return StuId;
	}
	public void setStuId(ObjectId stuId) {
		StuId = stuId;
	}
	public Integer getActivityType() {
		return ActivityType;
	}
	public void setActivityType(Integer activityType) {
		ActivityType = activityType;
	}
	public Date getOccurrenceTime() {
		return OccurrenceTime;
	}
	public void setOccurrenceTime(Date occurrenceTime) {
		OccurrenceTime = occurrenceTime;
	}
	public Integer getWay() {
		return Way;
	}
	public void setWay(Integer way) {
		Way = way;
	}
	public ObjectId getActivityId() {
		return ActivityId;
	}
	public void setActivityId(ObjectId activityId) {
		ActivityId = activityId;
	}
	
}
