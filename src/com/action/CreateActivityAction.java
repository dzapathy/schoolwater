package com.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import staticData.StaticString;
import utils.FileUpload;
import bean.InActivity;
import bean.School;
import bean.TableInfo;
import bean.TableInfoColumn;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class CreateActivityAction extends ActionSupport{
	private String name;
	private String categoryName;
	private Date deadLine;
	private Date startTime;
	private Date endTime;
	private String content;	
		
	private String attachmentSavePath;
	//上传图片
	private File filePicture;
	private String filePictureContentType;
	private String filePictureFileName;
	
	//上传附件
	private File fileAttachment;
	private String fileAttachmentContentType;
	private String fileAttachmentFileName;
		
	private int chooseway;			
	private List<String> nameList;
	private List<String> lengthList;
	private String chooseList;
	
	@SuppressWarnings("unchecked")
	@Override
	public String execute() throws Exception {
		System.out.println("附件类型:"+fileAttachmentContentType);
		System.out.println("图片类型:"+filePictureContentType);		
	
		ObjectId activityId=null; //活动类别ID
		//根据活动类别name查找活动类别ID
		School school = new School();
		ObjectId schoolid =(ObjectId)ServletActionContext.getContext().getSession().get("Organization_SchoolId");
		school.set_id(schoolid);
		BasicDBObject query = CreateQueryFromBean.EqualObj(school);		
		BasicDBObject projection = new BasicDBObject();
		projection.put(StaticString.School_InActivityCategoty, 1);
		projection.put(StaticString.School_id, 0);
		MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(School.class, query, projection);
		ArrayList<Document> documents =null;
		while(cursor.hasNext()){
			Document document = cursor.next();
			documents =(ArrayList<Document>)document.get("InActivityCategoty");
		}
		if(documents!=null){
			for (int i = 0; i < documents.size(); i++) {
				if (documents.get(i).getString("Name").equals(categoryName)){
					activityId = documents.get(i).getObjectId("_id");
					break;
				}
			}
		}		
		//向InActivity表中插入数据
		InActivity activity=new InActivity();
		ObjectId id = new ObjectId(); //活动ID
		ObjectId schoolId = (ObjectId) ServletActionContext.getContext().getSession().get("Organization_SchoolId");
		activity.setSchoolId(schoolId);
		activity.set_id(id); 
		activity.setName(getName());//活动名称
		activity.setCategoryName(getCategoryName());//活动类别名称			
		activity.setCategoryId(activityId);				
		if(filePicture!=null){
			if(filePictureContentType.equals("image/jpeg")||filePictureContentType.equals("image/png")
					||filePictureContentType.equals("image/bmp")){				
//				String pictureSavePath = FileUpload.pictureUpload(filePicture);	
				String pictureSavePath = FileUpload.upload(filePicture.getPath());
				activity.setImgUrl(pictureSavePath);//存储图片URL
			}else{
				addActionError("图片格式不支持，只能上传jpg,png,bmp类型的图片");
				return INPUT;
			}
		}else{
			activity.setImgUrl("noUrl");
		}
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(1900, 0, 1, 0, 0, 0);
		Date date1 = calendar.getTime();
		if(deadLine!=null){
			activity.setDeadLine(deadLine);
		}else{
			activity.setDeadLine(date1);
		}
		
		if(startTime!=null&&endTime!=null){
			activity.setRunTime(startTime.toString()+"~"+endTime.toString());
		} else if (startTime != null && endTime == null){
			activity.setRunTime(startTime.toString()+"~"+date1.toString());
		} else if(startTime == null && endTime != null) {
			activity.setRunTime(date1.toString()+"~"+endTime.toString());
		} else {
			activity.setRunTime(date1.toString()+"~"+date1.toString());
		}
		
		if(getContent()!=null){
			activity.setContent(getContent());
		}else{
			activity.setContent("");
		}
		if(fileAttachment!=null){
			if(fileAttachmentContentType.equals("application/x-zip-compressed")){ //待测试
//				attachmentSavePath = FileUpload.attachmentUpload(fileAttachment, fileAttachmentContentType, fileAttachmentFileName,getAttachmentSavePath());
				attachmentSavePath = FileUpload.upload(fileAttachment.getPath());
				activity.setAttachmentName(getFileAttachmentFileName());
				activity.setAttachmentUrl(attachmentSavePath);
			}else{
				addActionError("附件格式不支持，只能上传zip格式的打包文件");
				return INPUT;
			}
		}else{
			activity.setAttachmentName("nothing");//待修改
			activity.setAttachmentUrl("noUrl");
		}
		Date date = new Date();//创建时间
		activity.setReleaseTime(date);				
		String organizationId =(String)ServletActionContext.getContext().getSession().get("Organization_id");
		activity.setOrganizationId(new ObjectId(organizationId));//session中获取		
		String organizationName=(String)ServletActionContext.getContext().getSession().get("Organization_Name");
		activity.setOrganizationName(organizationName);//session获取
		activity.setOnlyTeam(getChooseway());				
		DaoImpl.InsertWholeBean(activity);  //插入
		
		//获得tableInfo表的数据,这里复制
		if(getChooseway()==0||getChooseway()==1){		
			//向tableInfo中写数据
			TableInfo info = new TableInfo();
			info.set_id(new ObjectId());
			info.setName(name+"报名表");
			info.setType(0);//0——报名表
			info.setOrganizationId(new ObjectId(organizationId));//组织机构ID，从session中获取;
			info.setActivityId(id);
			info.setCreateTime(date);
			ArrayList<TableInfoColumn> column = new ArrayList<TableInfoColumn>();
			//添加必要信息
			TableInfoColumn infoColumn1 = new TableInfoColumn();
			infoColumn1.setName("姓名");
			infoColumn1.setChoose(true);
			infoColumn1.setLength(5);
			column.add(infoColumn1);
			TableInfoColumn infoColumn2 = new TableInfoColumn();
			infoColumn2.setName("学号");
			infoColumn2.setChoose(true);
			infoColumn2.setLength(10);
			column.add(infoColumn2);
			
			ArrayList<Integer> numList = new ArrayList<Integer>();
			if(chooseList!=null){
				String [] str = chooseList.split(",");				 
				for(int i = 0; i< str.length ; i++){
					numList.add(Integer.parseInt((str[i].trim()))-3);			
				}
			}
			//存入添加的信息,待测试
			if(nameList!=null&&chooseList==null){
			for(int i =0 ;i< nameList.size() ;i++){
				TableInfoColumn infoColumn = new TableInfoColumn();
				infoColumn.setName(nameList.get(i));
				infoColumn.setChoose(false);
				infoColumn.setLength(Integer.parseInt(lengthList.get(i)));
				column.add(infoColumn);
			}}
			if(nameList!=null){
				for(int i =0 ;i< nameList.size() ;i++){
					TableInfoColumn infoColumn = new TableInfoColumn();
					infoColumn.setName(nameList.get(i));
					if(numList.contains(i)){
						infoColumn.setChoose(true);
					}else{
						infoColumn.setChoose(false);
					}
					infoColumn.setLength(Integer.parseInt(lengthList.get(i)));
					column.add(infoColumn);
				}
			}			
			info.setTableInfoColumn(column);
			DaoImpl.InsertWholeBean(info);
		}				
		return SUCCESS;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public Date getDeadLine() {
		return deadLine;
	}
	public void setDeadLine(Date deadLine){
		this.deadLine = deadLine;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public int getChooseway() {
		return chooseway;
	}
	public void setChooseway(int chooseway) {
		this.chooseway = chooseway;
	}

	public List<String> getNameList() {
		return nameList;
	}

	public void setNameList(List<String> nameList) {
		this.nameList = nameList;
	}

	public List<String> getLengthList() {
		return lengthList;
	}

	public void setLengthList(List<String> lengthList) {
		this.lengthList = lengthList;
	}

	public String getChooseList() {
		return chooseList;
	}

	public void setChooseList(String chooseList) {
		this.chooseList = chooseList;
	}

	public File getFilePicture() {
		return filePicture;
	}

	public void setFilePicture(File filePicture) {
		this.filePicture = filePicture;
	}

	public String getFilePictureContentType() {
		return filePictureContentType;
	}

	public void setFilePictureContentType(String filePictureContentType) {
		this.filePictureContentType = filePictureContentType;
	}

	public String getFilePictureFileName() {
		return filePictureFileName;
	}

	public void setFilePictureFileName(String filePictureFileName) {
		this.filePictureFileName = filePictureFileName;
	}

	public File getFileAttachment() {
		return fileAttachment;
	}

	public void setFileAttachment(File fileAttachment) {
		this.fileAttachment = fileAttachment;
	}

	public String getFileAttachmentContentType() {
		return fileAttachmentContentType;
	}

	public void setFileAttachmentContentType(String fileAttachmentContentType) {
		this.fileAttachmentContentType = fileAttachmentContentType;
	}

	public String getFileAttachmentFileName() {
		return fileAttachmentFileName;
	}

	public void setFileAttachmentFileName(String fileAttachmentFileName) {
		this.fileAttachmentFileName = fileAttachmentFileName;
	}

	@SuppressWarnings("deprecation")
	public String getAttachmentSavePath() {
		return ServletActionContext.getRequest().getRealPath(attachmentSavePath);
	}

	public void setAttachmentSavePath(String attachmentSavePath) {
		this.attachmentSavePath = attachmentSavePath;
	}	
}
