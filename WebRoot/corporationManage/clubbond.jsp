<%@page import="utils.Util"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>新建管理员</title>
	<link rel="stylesheet" href="../css/clubbond.css" />
	<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
</head>
<style>
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}
#clubbond-top{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:80px;
}
#top-title{
    position:absolute;
	width:50%;
	left:2%;
	top: 30%;
	bottom:30%;
	line-height:32px;
	font-size:15px;
	font-weight:600;
	color:#515151;
	border-left:5px solid #ddd;
}
#clubbond-content1{
    position:absolute;
	width:100%;
	left: 0%;
	margin-top: 80px;
	height:100px;
    border-bottom:1px solid #eee;
}
#clubbond-title1-1{
    position:relative;
	width:96%;
	left: 2%;
	top: 0px;
	height:30px;
	font-size:14px;
	border:1px dashed #336699;
	line-height:30px;
}
#clubbond-title1-2{
    position:relative;
	width:200px;
	left: 2%;
	top: 20px;
	height:22.5px;
	border-left:5px solid #90EE90;
	border-top:0px;
	border-right:0px;
	border-bottom:0px;
	text-align:left;
	font-size:15px;
}
#do-dele{
    position:absolute;
	width:250px;
	left:75%;
	top: 50px;
	height:25px;
	line-height:30px;
}
#makeSure{
    position:relative;
    width:100px;
	float:right;
	margin-right:25px;
	top: 0px;
	height:25px;
	line-height:25px;
	font-size:15px;
	border:1px solid #90EE90;
	text-align:center;
	cursor:pointer;
	background-color:#90EE90;
	color:#fff;
	-moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px; 
}
#gobackbutton{
    position:relative;
    width:100px;
	float:left;
	top: 0px;
	height:25px;
	font-size:15px;
	border:1px solid #CCC;
	text-align:center;
	line-height:25px;
	cursor:pointer;
	background-color:#CCC;
	color:#fff;
	-moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px; 
}
</style>
<body>
<div id="clubbond-fa">
    <div id="clubbond-top">
	         <div id="top-title">&nbsp;&nbsp;社团管理</div>
	    </div>
    <div id="clubbond-content1">
        <div id="clubbond-title1-1">&nbsp;&nbsp;&nbsp;&nbsp;注意：您是<%=session.getAttribute("Organization_Name")%>负责人，只能创建您的直接下属机构，并直接任命下属负责人</div>
		<div id="clubbond-title1-2">&nbsp;&nbsp;新增<%=Util.DoGetString((String)request.getParameter("clubname"))%>负责人：</div>
		<div id="organizationId" style="display: none;"><%=request.getParameter("clubid")%></div>
		<div id="do-dele">
		    <div id="makeSure">确定保存</div>
		    <div onclick="" id="gobackbutton">返&nbsp;&nbsp;&nbsp;&nbsp;回</div>
		    <%--input type="button" value="确定保存" id="makeSure" /> --%>
		    <%-- 
			<input type="button" value="返回" onclick="window.open('clubmanage.jsp','_self')"/> <!-- 在本界面打开 -->
			--%>
			<%-- <input type="button" value="返回" onclick="window.history.back()"/> <!-- 在本界面打开 -->--%>
		</div>
    </div>
	<div id="clubbond-idbond">
	    <div id="clubbond-idbondradio"><input type="radio" name="chooseway" value="0" checked="checked" class="" style="margin-left:40%;margin-top:8%;"/>&nbsp;&nbsp;学号绑定</div>
		<div id="clubbond-idbondtext">
		    <table width="100%" height="100%" border="0" cellspacing="10" cellpadding="0"
		        >
	        <tr>
		       <td width="35%">负责人学号：</td> 	  
			   <td>
				   <input name="user" id="user" type="text" /> 
		       </td>		       
		    </tr>
		    </table>
	    </div>
	</div>
	<div id="clubbond-givenbond">
	    <div id="clubbond-givenbondradio"><input type="radio" name="chooseway" value="1" class="" style="margin-left:40%;margin-top:25%;"/>&nbsp;&nbsp;分配账号</div>
	   <div id="clubbond-givenbondtext">
		    <table width="100%" height="100%" border="0" cellspacing="10" cellpadding="0">
		    <tr>
		       <td width="35%">负责人姓名： </td>	  
			   <td>
				   <input name="username" id="username" type="text" />
		       </td>
		    </tr>
	        <tr>
		       <td width="35%">负责人账号：</td>	  
			   <td>
				   <input name="userId" id="userId" type="text" /> 
		       </td>
		    </tr>
			<tr>
		       <td width="35%">负责人密码：</td>	  
			   <td>
				   <input name="password" id="password" type="text" /> 				    
		       </td>
		    </tr>
		    </table>
	    </div>
	</div>
	
	<!-- 写在前面不好使耶 -->
	<script type="text/javascript">		
 		$("#makeSure").click(function(){
 			var username =$("#username").val().trim();
 			var password =$("#password").val().trim();
 			var userId = $("#userId").val().trim();
 			var user =$("#user").val().trim();
 			if(username!=""&&password!=""&&userId!=""&&user==""){ //分配
 				$.get("corporationManageFenpei",
 					{username:username,password:password,userId:userId,orgId:$("#organizationId").text()},function(data){
 					alert(data);
 					if(data=="新建成功"){
 						window.location.href="clubmanage.jsp";
 					}
 				});
 			}else if(username==""&&password==""&&userId==""&&user!=""){ //绑定
 				$.get("corporationManageBangding",{user:user,orgId:$("#organizationId").text()},function(data){
 					alert(data);
 					if(data=="新建成功"){
 						window.location.href="clubmanage.jsp";
 					}
 			}); 
 			}else{
 				alert("请输入完整信息再点击确认");
 			}
 		});
 		//设置不可编辑
 		$(function(){
	 		$("#username").attr("disabled","true");
	 		$("#userId").attr("disabled","true");
	 		$("#password").attr("disabled","true");
 			$("input[value=0]").bind("click",function(){
	 			$("#user").removeAttr("disabled");
	 			$("#username").attr("disabled","true");
	 			$("#userId").attr("disabled","true");
	 			$("#password").attr("disabled","true");
 			});
 			$("input[value=1]").bind("click",function(){
 				$("#user").attr("disabled","true");
	 			$("#username").removeAttr("disabled");
	 			$("#userId").removeAttr("disabled");
	 			$("#password").removeAttr("disabled");
 			});
 		});
 		
 		$(function(){
 			$("#gobackbutton").click(function(){
 				window.history.back();
 			});
 		})
 		
 		$(function(){
 			$("#gobackbutton").live("mouseover",function(){
 				$(this).css("background-color","#A1A1A1");
 				$(this).css("border","1px solid #A1A1A1");
 			});
 			$("#makeSure").live("mouseover",function(){
 				$(this).css("background-color","#3CB371");
 				$(this).css("border","1px solid #3CB371");
 			});
 			$("#gobackbutton").live("mouseout",function(){
				$(this).css("background-color","#CCC");
				$(this).css("border","1px solid #CCC");
			});
			$("#makeSure").live("mouseout",function(){
				$(this).css("background-color","#90EE90");
				$(this).css("border","1px solid #90EE90");
			});
 		})
</script>
</div>
</body>
</html>

