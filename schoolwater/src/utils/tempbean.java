package utils;

import java.util.ArrayList;
import java.util.Date;

import org.bson.types.ObjectId;

import bean.ActivityCallOver;
import bean.ActivityComment;
import bean.ActivityIntegralTable;
import bean.ActivityShare;
import bean.AppVersion;
import bean.InActivity;
import bean.InActivityCategoty;
import bean.Major;
import bean.Manager;
import bean.Member;
import bean.Organization;
import bean.OutActivity;
import bean.School;
import bean.SchoolNotice;
import bean.StudentInfo;
import bean.Suggestion;
import bean.SystemManager;
import bean.SystemNotice;
import bean.TableContentColumn;
import bean.TableContentInfo;
import bean.TableInfo;
import bean.TableInfoColumn;
import bean.TeamInfo;
import bean.UserReport;
import bean.UserSkimFunction;
import bean.UserSkimTime;

import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;

public class tempbean {
	public static void main(String[] args) throws Exception {		
//		ActivityIntegralTable activityIntegralTable = new ActivityIntegralTable();
//		activityIntegralTable.set_id(new ObjectId());
//		activityIntegralTable.setCreateTime(new Date());
//		activityIntegralTable.setName("笑");
//		activityIntegralTable.setOrganizationId(new ObjectId("5614909ed347560da8343c6d"));
//		activityIntegralTable.setSchoolId(new ObjectId("56148844d347560cccfebe92"));
//		DaoImpl.InsertWholeBean(activityIntegralTable);
		DaoImpl.DeleteDocment(Suggestion.class, new BasicDBObject());
	}	
	
	public void ad(){
		
		{
			StudentInfo student=new StudentInfo();
			student.set_id(new ObjectId());
			student.setDegree(1);
			student.setEmail("13898624331@163.com");
			student.setGrade(2011);
			student.setIdCard("201192239");
			student.setMajorId(new ObjectId());
			student.setMajorName("医药工程");
			student.setName("张一明");
			student.setPwd("201192239");
			student.setSchoolId(new ObjectId());
			student.setSex(1);
			student.setPhone("13898624331");
		}
		
		{
			School school=new School();
			ArrayList<Major> majorlist=new ArrayList<Major>();
			for(int i=0;i<5;i++){
				Major major=new Major();
				major.set_id(new ObjectId());
				major.setName("Major"+(i+1));
				majorlist.add(major);
			}
			ArrayList<InActivityCategoty> aclist=new ArrayList<InActivityCategoty>();
			for(int i=0;i<5;i++){
				InActivityCategoty major=new InActivityCategoty();
				major.set_id(new ObjectId());
				major.setName("Category"+(i+1));
				aclist.add(major);
			}
			school.set_id(new ObjectId());
			school.setAddressC("大连市");
			school.setAddressP("辽宁省");
			school.setInActivityCategoty(aclist);
			school.setLogoUrl("http://79763.vhost82.cloudvhost.net/images/1436846049657a6672.jpg");
			school.setMajor(majorlist);
			school.setName("大连理工大学");
			school.setOpenTime(new Date());
			school.setTel("0411-746383984");
		}
	
		
		{
			Organization or=new Organization();
			ArrayList<Manager> managerlist=new ArrayList<Manager>();
			for(int i=0;i<5;i++){
				Manager major=new Manager();
				major.setName("Name"+(i+1));
				major.setPwd("pwd"+i);
				major.setUserId("userid"+i);
				managerlist.add(major);
			}
			
			or.set_id(new ObjectId());
			or.setLevelTopId(new ObjectId());
			or.setManager(managerlist);
			or.setName("超级管理员");
			or.setSchoolId(new ObjectId());
		}
		
		
		{
			InActivity ac=new InActivity();
			ac.set_id(new ObjectId());
			ac.setAttachmentName("cdscf");
			ac.setAttachmentUrl("dsacdsaca");
			ac.setCategoryName("文体类");
			ac.setCategoryId(new ObjectId());
			ac.setContent("fcsdvsdd");
			ac.setDeadLine(new Date());
			ac.setImgUrl("urlrfsdfcvsscds");
			ac.setName("给我三分钟才艺展示大赛");
			ac.setOnlyTeam(0);
			ac.setOrganizationId(new ObjectId());
			ac.setOrganizationName("自强社服务部");
			ac.setReleaseTime(new Date());
			ac.setRunTime(new Date().toString());
		}
		
		{
			ActivityComment ac=new ActivityComment();
			ac.set_id(new ObjectId());
			ac.setActivityId(new ObjectId());
			ac.setActivityType(1);
			ac.setContent("very good");
			ac.setOccurrenceTime(new Date());
			ac.setStuId(new ObjectId());
		}
		
		{
			ActivityShare ac=new ActivityShare();
			ac.set_id(new ObjectId());
			ac.setActivityId(new ObjectId());
			ac.setActivityType(1);
			ac.setWay(1);
			ac.setOccurrenceTime(new Date());
			ac.setStuId(new ObjectId());
		}
		
		{
			TableInfo ta=new TableInfo();
			ArrayList<TableInfoColumn> tableInfoColumn=new ArrayList<TableInfoColumn>();
			
			TableInfoColumn major=new TableInfoColumn();
			major.setName("姓名");
			major.setChoose(true);
			major.setLength(10);
			tableInfoColumn.add(major);
			
			TableInfoColumn major0=new TableInfoColumn();
			major0.setName("学号");
			major0.setChoose(true);
			major0.setLength(20);
			tableInfoColumn.add(major0);
			
			TableInfoColumn major1=new TableInfoColumn();
			major1.setName("性别");
			major1.setChoose(true);
			major1.setLength(2);
			tableInfoColumn.add(major1);
			
			TableInfoColumn major2=new TableInfoColumn();
			major2.setName("年级");
			major2.setChoose(true);
			major2.setLength(20);
			tableInfoColumn.add(major2);
			
			TableInfoColumn major3=new TableInfoColumn();
			major3.setName("爱好");
			major3.setChoose(true);
			major3.setLength(200);
			tableInfoColumn.add(major3);
			
			TableInfoColumn major4=new TableInfoColumn();
			major4.setName("特长");
			major4.setChoose(true);
			major4.setLength(200);
			tableInfoColumn.add(major4);
			
			TableInfoColumn major5=new TableInfoColumn();
			major5.setName("自我介绍");
			major5.setChoose(true);
			major5.setLength(200);
			tableInfoColumn.add(major5);
			
			ta.set_id(new ObjectId());
			ta.setActivityId(new ObjectId("55e25a4a5ed71714141c4375"));
			ta.setCreateTime(new Date());
			ta.setName("关于2015年迎新志愿者招募报名表");
			ta.setOrganizationId(new ObjectId("55e1a50539aeaf118c1a8850"));
			ta.setTableInfoColumn(tableInfoColumn);
			ta.setType(0);
		}
		
		{
			TableContentInfo ta=new TableContentInfo();
			ArrayList<TableContentColumn> tableInfoColumn=new ArrayList<TableContentColumn>();
			for(int i=0;i<5;i++){
				TableContentColumn major=new TableContentColumn();
				major.setName("Name"+(i+1));
				major.setContent("hahah"+i);
				tableInfoColumn.add(major);
			}
				
			ta.set_id(new ObjectId());
			ta.setStuId(new ObjectId());
			ta.setTableContentColumn(tableInfoColumn);
			ta.setTableId(new ObjectId());
		}
		
		{
			TeamInfo team=new TeamInfo();
			
			ArrayList<Member> member=new ArrayList<Member>();
			for(int i=0;i<5;i++){
				Member major=new Member();
				major.setAbstract("i want"+i);
				major.setState(1);
				major.setStuId(new ObjectId());
				member.add(major);
			}
			
			team.set_id(new ObjectId());
			team.setAbstract("asdadsad");
			team.setActivityId(new ObjectId());
			team.setMember(member);
			team.setName("water");
			team.setNeed("i need");
			team.setPassword(2011);
			team.setSlogan("we are the best!");
			team.setTeamLeader(new ObjectId());
		}
		
		{
			OutActivity ac=new OutActivity(); 
			
			ac.set_id(new ObjectId());
			ac.setAttachmentName("cdscf");
			ac.setAttachmentUrl("dsacdsaca");
			ac.setCategory("文体类");
			ac.setContent("fcsdvsdd");
			ac.setDeadLine(new Date());
			ac.setImgUrl("urlrfsdfcvsscds");
			ac.setName("给我三分钟才艺展示大赛");
			ac.setOrganization("泉水不");
			ac.setReleaseTime(new Date());
			ac.setRunTime(new Date().toString());
		}
		
		{
			SchoolNotice notice=new SchoolNotice();
			notice.set_id(new ObjectId());
			notice.setContent("aaaaaaaaaaaaaaaaaaaa");
			notice.setOrganizationId(new ObjectId());
			notice.setOrganizationName("服务部门");
			notice.setReceiver(new ObjectId());
			notice.setReleaseTime(new Date());
			notice.setTitle("title");
		}
		
		{
			SystemNotice notice=new SystemNotice();
			notice.set_id(new ObjectId());
			notice.setContent("aaaaaaaaaaaaaaaaaaaa");
			notice.setPublisher("whowhwowho");
			notice.setReleaseTime(new Date());
			notice.setTitle("title");
			notice.setReceiver(1);
		}
		
		{
			AppVersion app=new AppVersion();
			app.set_id(new ObjectId());
			app.setDownloadUrl("http://dsadcs");
			app.setGoodness("goodgood");
			app.setReleaseTime(new Date());
			app.setVersion("V1.23.2");
		}
		
		{
			Suggestion ss=new Suggestion();
			ss.set_id(new ObjectId());
			ss.setContent("cdxascsasaadaadsa");
			ss.setFrom("aaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			ss.setReleaseTime(new Date());
		}
		
		{
			ActivityCallOver call=new ActivityCallOver();
			call.set_id(new ObjectId());
			call.setActivityId(new ObjectId());
			call.setDeadline(new Date());
			call.setPositionX(34.633210);
			call.setPositionY(43.234565);
		}
		
		{
			UserSkimFunction fun=new UserSkimFunction();
			fun.set_id(new ObjectId());
			fun.setFunction("functin1");
			fun.setStuId(new ObjectId());
		}
		
		{
			SystemManager mana=new SystemManager();
			mana.set_id(new ObjectId());
			mana.setEmail("13898624331@163.com");
			mana.setName("klaus");
			mana.setPhone("13898624331");
			mana.setPwd("abcdefg");
			mana.setSex(1);
			mana.setState(1);
		}
		
		{
			UserReport report=new UserReport();
			report.set_id(new ObjectId());
			report.setContent("aaaaaaaaaa");
			report.setDealPerson(new ObjectId());
			report.setDealTime(new Date());
			report.setFrom("fromfromfrem");
			report.setReportTime(new Date());
			report.setSolution("mysutionmysolution");
		}
		
		{
			UserSkimTime time=new UserSkimTime();
			time.set_id(new ObjectId());
			time.setExitTime(new Date());
			time.setLoginTime(new Date());
			time.setStuId(new ObjectId());
		}
		
		{
			for(int j=3;j<8;j++){
				BasicDBObject ob1=new BasicDBObject();
				ob1.put("Name", "NameJJ"+j);
				ArrayList<BasicDBObject> list=new ArrayList<BasicDBObject>();
				for(int i=0;i<5;i++){
					BasicDBObject ob2=new BasicDBObject();
					ob2.put("Name"+j+i, "name");
					ob2.put("Id", j+i);
					list.add(ob2);
				}
				ob1.put("Array", list);
			}
		}
	}
}
