<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="com.mongodb.BasicDBObject,com.dao.*,bean.*,com.mongodb.client.MongoCursor,org.bson.Document" %>
<%@ page import="staticData.*,java.text.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>公告具体通知内容</title>
</head>	
<style>
body{
    font-family:"微软雅黑";
	height:1000px;
}
html { overflow-x:hidden; }
#announceD-top{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:80px;
}
#top-title{
    position:absolute;
	width:96%;
	left:2%;
	top: 30%;
	bottom:30%;
	line-height:32px;
	font-size:15px;
	font-weight:600;
	color:#515151;
	border-left:5px solid #ddd;
}
#announceD-content{
    position:absolute;
    top:100px;
    width:80%;
    left:10%;
    font-size:15px;
    color:#515151;
}
#announceD-time{
    position:relative;
    width:auto;
    float:right;
    top: 30%;
	bottom:30%;
	line-height:32px;
	font-size:15px;
	color:#515151;
	border-right:5px solid #ddd;
	margin-right:2%;
	padding-right:20px;
}
</style>		
<body >
	<%		
  		MongoCursor<Document>mc=(MongoCursor<Document>)request.getAttribute("announcementdetail");
  		if(mc!=null&&!mc.equals("")){
  		Document d=mc.next();
  		Date time=(Date)d.get(StaticString.SystemNotice_ReleaseTime);
   	    String t= new SimpleDateFormat("yyyy-MM-dd").format(time);
  	%>	
<!--公告内容-->
    	<div id="announceD-top">
	         <div id="top-title">&nbsp;&nbsp;<%=d.get(StaticString.SystemNotice_Title) %></div>
	         <div id="announceD-time">
					<%=d.get(StaticString.SystemNotice_Publisher) %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%=t %>
		     </div>
	    </div>

		<div id="announceD-content"><%=d.get(StaticString.SystemNotice_Content) %></div>
	<%} %>
</body>
</html>
