package bean;

import java.util.Date;

import org.bson.types.ObjectId;

public class ActivityJudge {

	private Integer Type;
	private ObjectId _id;
	private ObjectId StuId;
	private Integer ActivityType;
	private Date OccurrenceTime;
	private ObjectId ActivityId;
	public Integer getType() {
		return Type;
	}
	public void setType(Integer type) {
		Type = type;
	}
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
	public ObjectId getActivityId() {
		return ActivityId;
	}
	public void setActivityId(ObjectId activityId) {
		ActivityId = activityId;
	}
	
	
}
