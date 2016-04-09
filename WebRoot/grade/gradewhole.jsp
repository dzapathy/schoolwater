<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/gradewhole.css" />
	<script src="../js/gradewhole.js"></script>
</head>
<style>
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}
#gradewhole-top{
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


#gradewhole-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:900px;
}
#gradewhole-content1{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:80px;
	border-bottom:1px solid #ddd;
}
#gradewhole-content2{
    position:absolute;
	width:100%;
	left: 0px;
	top: 80px;
	height:1050px;
}
#gradewhole-addgrade{
    position:absolute;
	width:100px;
	left:62%;
	top:37%;
	height:22.5px;
	border:1px solid #90EE90;
	text-align:center;
	cursor:pointer;
	background-color:#90EE90;
	color:#fff;
	-moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px; 
}
#gradewhole-searchgradesolo{
    position:absolute;
	width:120px;
	left: 73%;
	top: 37%;
	height:22.5px;
	border:1px solid #90EE90;
	text-align:center;
	cursor:pointer;
	background-color:#90EE90;
	color:#fff;
	-moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px; 
}
#gradewhole-searchgradetype{
    position:absolute;
	width:120px;
	left: 86%;
	top: 37%;
	height:22.5px;
	border:1px solid #90EE90;
	text-align:center;
	cursor:pointer;
	background-color:#90EE90;
	color:#fff;
	-moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
}

</style>
<body>
<div id="gradewhole-fa">
    <div id="gradewhole-top">
	         <div id="top-title">&nbsp;&nbsp;积分管理</div>
	    </div>
    <div id="gradewhole-content1">
        <div id="gradewhole-addgrade" align="center">录入积分</div>
		<div id="gradewhole-searchgradesolo" align="center">单个积分统计表</div>
		<div id="gradewhole-searchgradetype" align="center">分类积分统计表</div>
    </div>
    <div id="gradewhole-content2">
        <iframe src="gradewarning.jsp" id="gradewhole-frame" frameborder="0" scrolling="auto" width="100%" height="100%" onload="autoHeight();"></iframe>
    </div>
</div>

<script>
$(function(){
	$("#gradewhole-addgrade").live("mouseover",function(){
		$(this).css("background-color","#3CB371");
		$(this).css("border","1px solid #3CB371");
	});
	$("#gradewhole-searchgradesolo").live("mouseover",function(){
		$(this).css("background-color","#3CB371");
		$(this).css("border","1px solid #3CB371");
	});
	$("#gradewhole-searchgradetype").live("mouseover",function(){
		$(this).css("background-color","#3CB371");
		$(this).css("border","1px solid #3CB371");
	});
	$("#gradewhole-addgrade").live("mouseout",function(){
		$(this).css("background-color","#90EE90");
		$(this).css("border","1px solid #90EE90");
	});
	$("#gradewhole-searchgradesolo").live("mouseout",function(){
		$(this).css("background-color","#90EE90");
		$(this).css("border","1px solid #90EE90");
	});
	$("#gradewhole-searchgradetype").live("mouseout",function(){
		$(this).css("background-color","#90EE90");
		$(this).css("border","1px solid #90EE90");
	});
});
</script>
</body>
</html>
