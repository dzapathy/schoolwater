package bean;

import java.util.ArrayList;

import org.bson.types.ObjectId;

public class TeamInfo{
	private ObjectId _id;
	private String Name;
	private ObjectId ActivityId;
	private String ActivityName;
	private String Slogan ;
	private ObjectId TeamLeader;
	private ObjectId SchoolId;
	private String IdCard;
	private String LeaderName;
	private String Abstract ;
	private String Need;
	private Integer Password;
	private ArrayList<Member> Member;
	
	
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
	
	public ObjectId getActivityId() {
		return ActivityId;
	}
	public void setActivityId(ObjectId activityId) {
		ActivityId = activityId;
	}
	public String getSlogan() {
		return Slogan;
	}
	public void setSlogan(String slogan) {
		Slogan = slogan;
	}
	public ObjectId getTeamLeader() {
		return TeamLeader;
	}
	public void setTeamLeader(ObjectId teamLeader) {
		TeamLeader = teamLeader;
	}
	public String getAbstract() {
		return Abstract;
	}
	public void setAbstract(String abstract1) {
		Abstract = abstract1;
	}
	public String getNeed() {
		return Need;
	}
	public void setNeed(String need) {
		Need = need;
	}
	public Integer getPassword() {
		return Password;
	}
	public void setPassword(Integer password) {
		Password = password;
	}
	public ArrayList<Member> getMember() {
		return Member;
	}
	public void setMember(ArrayList<Member> member) {
		Member = member;
	}
	public ObjectId getSchoolId() {
		return SchoolId;
	}
	public void setSchoolId(ObjectId schoolId) {
		SchoolId = schoolId;
	}
	public String getIdCard() {
		return IdCard;
	}
	public void setIdCard(String idCard) {
		IdCard = idCard;
	}
	public String getActivityName() {
		return ActivityName;
	}
	public void setActivityName(String activityName) {
		ActivityName = activityName;
	}
	public String getLeaderName() {
		return LeaderName;
	}
	public void setLeaderName(String leaderName) {
		LeaderName = leaderName;
	}
	
}
