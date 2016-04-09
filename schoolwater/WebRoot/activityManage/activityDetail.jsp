<%@page import="org.bson.types.ObjectId"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@ page
	import="com.mongodb.BasicDBObject,com.dao.*,bean.*,com.mongodb.client.MongoCursor,org.bson.Document"%>
<%@ page import="staticData.*,java.text.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>活动具体通知内容</title>
	<script type="text/javascript"
	src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<base target="_blank" />
</head>
<style>
body{
	height:780px;
	width:100%;
}
html { overflow-x:hidden; }
#activityDetail-top{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:30px;
	line-height:30px;
}
#top-title{
    position:absolute;
	width:50%;
	left:2%;
	line-height:32px;
	font-size:15px;
	font-weight:600;
	float:left;
	color:#515151;
	border-left:5px solid #ddd;
}
#activityDetail-content{
    position:absolute;
    top:50px;
    width:80%;
    left:10%;
}
#activityDetail-time{
    position:relative;
    width:100px;
    float:right;
    line-height:32px;
	font-size:15px;
	color:#515151;
	border-right:5px solid #ddd;
	margin-right:2%;
}
</style>
<body>
	<%	
		//String id = request.getParameter("id");
		String id = (String)session.getAttribute("SelectedActivityId");
		InActivity inActivity = new InActivity();
		inActivity.set_id(new ObjectId(id));
		BasicDBObject query =CreateQueryFromBean.EqualObj(inActivity);
		BasicDBObject projection=new BasicDBObject();
		projection.put(StaticString.InActivity_Content, 1);
		
		MongoCursor<Document> mc=DaoImpl.GetSelectCursor(InActivity.class, query, projection);
  		if(mc!=null && !mc.equals("")){
  			Document d=mc.next();
  			//Date time=(Date)d.get(StaticString.InActivity_ReleaseTime);
   	    	//String t= new SimpleDateFormat("yyyy-MM-dd").format(time);
  	%>
	<!--公告内容-->
		<div id="activityDetail-top">
	         <div id="top-title">&nbsp;&nbsp;活动公告内容</div>
	         <div id="activityDetail-time">
			<%=(String)new SimpleDateFormat("yyyy-MM-dd").format((Date)session.getAttribute("SelectedActivityReleaseTime")) %>
		     </div>
	    </div>

		<div id="activityDetail-content"><%=d.get(StaticString.InActivity_Content) %></div>

		
	<%} %>
	
	
	<script>
	</script>
</body>
</html>
