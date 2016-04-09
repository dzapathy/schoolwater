<%@page import="org.bson.Document"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="bean.InActivity"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
	<script type="text/javascript"
		src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/actmanagedele.css" />
	<script src="../js/actmanagedele.js"></script>
</head>
<style>
body{
	height:940px;
	font-family:"微软雅黑";
	color:#515151;
}
#actmanagedele-fa{
    position:absolute;
	width:1005px;
	left: 0px;
	top: 0px;
	height:700px;
}
#actmanagedele-top{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:32px;
}
#top-title{
    position:absolute;
	width:50%;
	left:2%;
	height:100%;
	line-height:32px;
	font-size:15px;
	font-weight:600;
	color:#515151;
	border-left:5px solid #ddd;
}
#actmanagedele-title1{
    position:absolute;
	width:96%;
	left: 2%;
	top: 50px;
	height:60px;
	border:1px dashed #336699;
	line-height:30px;
	font-size:14px;
}

#actmanagedele-chose{
    position:absolute;
	width:30px;
	left: 30px;
	top: 0px;
	height:30px;
	border-bottom:1px solid #CCCCCC;
}
#actmanagedele-sure{
    position:relative;
	width:100px;
	float:right;
	height:30px;
	margin-right:20px;
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
	<div id="actmanagedele-fa">
	<div id="actmanagedele-top">
	         <div id="top-title">&nbsp;&nbsp;确认取消</div>
	         <input type="button" value="确认取消" id="actmanagedele-sure" />
	    </div>
	    <div id="actmanagedele-title1">
		    &nbsp;&nbsp;&nbsp;&nbsp;温馨提示：<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 一旦取消该活动，则无法通过任何方法恢复，请妥善选择。若确定取消该活动，点击确认取消按钮即可。
		</div>
			
				
				
			
	</div>
	
	<script>
	$(function(){
		$("#actmanagedele-sure").click(function(){
				$.get("activityDelete.action",function(data){
					if(data=="true"){
						alert("已经成功取消该活动！");
						window.parent.location.reload();
						window.parent.location.href="activityList.jsp";
					}else{
						alert("删除失败");
					}
				});
		});
	});	
	</script>
</body>
</html>
