<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="staticData.StaticString"%>
<%@page import="bean.School"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="bean.InActivity"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<link rel="stylesheet" href="../css/actmanagechangeact.css" />

<!-- 引入富文本编辑器 -->
<script type="text/javascript" charset="utf-8" src="ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>
    
<!-- 引入jQuery库 
<script src="http://libs.baidu.com/jquery/1.9.0/jquery.js" type="text/javascript"></script>
 -->  
<!-- 后导入的 -->
<link type="text/css" href="../jquery/choosetime/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
<link type="text/css" href="../jquery/choosetime/jquery-ui-timepicker-addon.css" rel="stylesheet" />
	
<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../jquery/choosetime/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="../jquery/choosetime/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../jquery/choosetime/jquery-ui-timepicker-zh-CN.js"></script>
<script type="text/javascript" src="../js/activitycreate.js"></script>

</head>
<style>
body{
	height:940px;
	font-family:"微软雅黑";
	color:#515151;
}
#actmanagechangeact-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:940px;
}

#actmanagechangeact-content1{
    position:absolute;
	width:100%;
	left: 0px;
	top: 50px;
	height:890px;
}

#actmanagechangeact-content1 td{
    border-top:1px solid #ddd;
    font-size:15px;
    padding-left:20px;
	height:90px;
	line-height:90px;
}

#actmanagechangeact-content1    input[type=text],input[type=password],textarea{border:1px solid #ccc;padding:2px;border-radius:1px;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset;outline:medium none;line-height:25px;
     -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    font-family:"Microsoft YaHei",Verdana,Arial;
    font-size:14px;
    vertical-align:top;
    height:30px;
	width:380px;
	padding-left:15px;
	color:#515151;
    }
#actmanagechangeact-content1    input[type=text]:focus,input[type=password]:focus,textarea:focus{/*border-color:rgba(82,168,236,0.8);*/border-color:#52a8ec;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset,0 0 5px rgba(82,168,236,0.6);outline:0 none;}
#actmanagechangeact-content1 select{
      -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    font-family:"Microsoft YaHei",Verdana,Arial;
    font-size:14px;
    vertical-align:top;
    height:35px;
	width:400px;
	padding-left:15px;
	color:#515151;
 }
 


#actmanagechangeact-titletop{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:32px;
}
#top-title{
    position:absolute;
	width:50%;
	float:left;
	left:2%;
	height:100%;
	line-height:32px;
	font-size:15px;
	font-weight:600;
	color:#515151;
	border-left:5px solid #ddd;
}

#actmanagechangeact-end-sumbit{
    position:relative;
	width:100px;
	float:right;
	margin-right:20px;
	height:30px;
	color:#fff;
    background-color:#1C90F2;
    border:1px solid #1C90F2;
    cursor:pointer;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
}
</style>
<body>
<%
	String activity_id = (String)session.getAttribute("SelectedActivityId");
	
	int activityClassNum = 0;
	ArrayList<Document> activityList = null;
	InActivity inActivity = new InActivity();
	inActivity.set_id(new ObjectId(activity_id));
	BasicDBObject query = CreateQueryFromBean.EqualObj(inActivity);
	BasicDBObject projection = new BasicDBObject();
	
	MongoCursor<Document> mc = DaoImpl.GetSelectCursor(InActivity.class, query, projection);
	Document document = null;
	while(mc.hasNext()) {
		document = mc.next();
	}
	
	String imgUrl = (String)document.get("ImgUrl");
	String attactmentName = (String)document.get("AttachmentName");
	String oldAttachmentUrl = (String)document.get("AttachmentUrl");
	
	
	Date deadLine = (Date)document.get("DeadLine");
	DateFormat formatdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String dLine = formatdate.format(deadLine);
	
	String runTime = (String)document.get("RunTime");
	String[] rTime = runTime.split("~");
	
	SimpleDateFormat ctsFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy", Locale.US);
	Date d1 = ctsFormat.parse(rTime[0]);
	Date d2 = ctsFormat.parse(rTime[1]);

	String rTime1 = formatdate.format(d1);
	String rTime2 = formatdate.format(d2);
	
	//获取活动类别名称
	ObjectId schoolId = (ObjectId)ServletActionContext.getContext().getSession().get("Organization_SchoolId");
	School school = new School();
	school.set_id(schoolId);
	BasicDBObject q = CreateQueryFromBean.EqualObj(school);
	BasicDBObject p = new BasicDBObject();
	p.put(StaticString.School_InActivityCategoty,1);
	MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(School.class, q, p);
	if(cursor.hasNext()){
		Document d = cursor.next();
		activityList = (ArrayList<Document>)d.get("InActivityCategoty");
		if(activityList!=null&&activityList.size()>0){
			activityClassNum= activityList.size();
		}
	}
	
 %>
<div id="actmanagechangeact-fa">
	<div><s:actionerror></s:actionerror></div>
	<form action="activityUpdate.action" method="post" enctype="multipart/form-data">
	<div id="actmanagechangeact-titletop">
	         <div id="top-title">&nbsp;&nbsp;修改活动</div>
	         <input type="submit"  value="确认修改"  id="actmanagechangeact-end-sumbit"/>
	    </div>
	<div id="actmanagechangeact-content1">
	     <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		       <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;活动名称：</div> </td>	  
			   <td style="width:85%;">
				   <input name="InActivityName" id="InActivityName" type="text" value=<%=session.getAttribute("SelectedActivityName") %> /> 
		       </td>
		    </tr>
			<tr>
			 <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;活动类别：</div> </td>	  
			   <td style="width:85%;">
				   <select name="select">
				  <%if(activityList!=null&&!"".equals(activityList)){
				   for (int i =0 ;i<activityList.size() ;i++){ %>
				   		<option ><%=activityList.get(i).get("Name")%></option>				   		
				   <%}} %>
				   </select>
		       </td>
		    </tr>
			<tr>
		       <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;报名截止：</div> </td>	  
			   <td style="width:85%;">
			   		<%
			   		if(dLine.equals("1900-01-01 00:00:00")) {
			   		%>
			   			<input type="text" name="deadLine" class="ui_timepicker" value="" />
			   		<%		
			   		} else {
			   		 %>
				   <input type="text" name="deadLine" class="ui_timepicker" value='<%=dLine %>' />
		       		<%} %>
		       </td>
		    </tr>
			<tr>
		       <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;活动开始：</div> </td>	  
			   <td style="width:85%;">
			   	<%
			   		if(dLine.equals("1900-01-01 00:00:00")) {
			   		%>
			   			<input type="text" name="startTime" class="ui_timepicker" value="" />
			   		<%		
			   		} else {
			   		 %>
				   <input type="text" name="startTime" class="ui_timepicker" value='<%=rTime1 %>' />
		       		<%} %>
		       </td>
		    </tr>
			<tr>
		       <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;活动结束：</div> </td>	  
			   <td style="width:85%;">
			   		<%
			   		if(dLine.equals("1900-01-01 00:00:00")) {
			   		%>
			   			<input type="text" name="endTime" class="ui_timepicker" value="" /> 
			   		<%		
			   		} else {
			   		 %>
				   <input type="text" name="endTime" class="ui_timepicker" value='<%=rTime2 %>' /> 
		       		<%} %>
				    
		       </td>
		       
		    </tr>
		    <tr>
		          <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;选择图片：</div>
		          </td>
		          <td style="width:85%;">
		                 <input type="file" name="filePicture" style="position:relative;float:left;top:30%;"/>
		                 <div style="position:relative;float:left;width:70px;height:70px;left:20px;">
		                                                    
		                 <%
	    					if(imgUrl.equals("noUrl")) {
	    					%>		
	    					<img id="oldImg" src= "../login/mainimg/img/defaultImg.jpg" style="width:100%;height:100%;"/>
	    				<% 
	    					} else {
	    				%>
   						<img id="oldImg" src=<%=imgUrl %> style="width:100%;height:100%;"/>
   						<%} %>
   						</div>
   						<input type="hidden" value=<%=imgUrl %>  name="oldPictureUrl" />
		          </td>
		    </tr>  
		    <tr>
		          <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;详细信息：</div>
		          </td>
		          <td style="width:85%;">
		                 <script id="editor" type="text/plain" style="width:99%;height:100px;"></script>
							<input type="hidden" name="content" id="content" /> 
		          </td>
		    </tr>  
		    <tr>
		          <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;附件选择：</div>
		          </td>
		          <td style="width:85%;">
		                
						<input type="hidden" value=<%=oldAttachmentUrl %> name="oldAttachmentUrl" />
						<input type = "file" name="fileAttachment" style="position:relative;float:left;top:40%;"/>
						<div style="position:relative;float:left;left:20px;">原附件：<%=attactmentName %></div>
		          </td>
		    </tr>  
		</table>
	</div>
	</form>
	<div style="display: none;" id = "editorContent"><%=document.get("Content") %></div>
</div>
<script type="text/javascript">
	
    //实例化富文本编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
    //时时获取富文本编辑器里面的内容
    var int=self.setInterval("getContent()",1000);
    function getContent(){
        var context=UE.getEditor('editor').getContent();
      	document.getElementById("content").value= context;    	
    }
    $(function(){
   		var content = $("#editorContent").html();
   		ue.addListener("ready", function(){
   			ue.setContent(content);
   		}); 
    });
      
    $(function(){
    	$("#actmanagechangeact-content1").find("tr:last").find("td").each(function(){
    		$(this).css("border-bottom","1px solid #ddd");
    	});
    	
    	$("#actmanagechangeact-content1").find("tr:gt(5)").find("td").each(function(){
    		$(this).css("border-top","0px solid #ddd");
    	});
    });
</script>
</body>
</html>
