<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="org.bson.Document" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
  <head>    
    <title>职务列表</title>
  <script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
</head>

<script>
$(function(){
    var obsH = $(window).height();
	if(obsH > 600){
	   var tempH = obsH - 50;
	   $("#lo-mid").height(tempH+"px");
	   $("#BgDiv").height(obsH);
	}else{
	    
	}
	
	window.onresize=function(){
	    var obsH = $(window).height();
		if(obsH > 600){
	   		var tempH = obsH - 50;
	   		$("#lo-mid").height(tempH+"px");
		}else{
	    
		}
	}
	
	//动态添加td
	$("#lo-content").css("width",window.screen.width);
	$("#lo-title").css("width",window.screen.width);
	$("#lo-head").css("width",window.screen.width);
	$("#lo-mid").css("width",window.screen.width);
	
	$("#job-table").find("td").live("mouseover",function(){
	    $(this).css("border","5px solid #1C90F2");
	    
	});
	$("#job-table").find("td").live("mouseout",function(){
	    $(this).css("border","5px solid #fff");
	});
	
	//加载效果
	$("#job-table").find("td").live("click",function(){
	    $("#BgDiv").show();
		$(".spinner").show();
	});
});

</script>
<style>
body{
    
	font-family:"微软雅黑";
	overflow-x:hidden;
}
#lo-head{
    position:absolute;
	width:100%;
	height:50px;
	top:0px;
	left:0px;
}
#lo-mid{
    position:absolute;
	top:50px;
	left:0px;
	width:100%;
	height:550px;
	background-color:#20455e;
}
#lo-title{
    position:relative;
	top:10%;
	left:0px;
	width:100%;
	height:10%;
	font-size:20px;
	text-align:center;
	color:#fff;
}
#lo-content{
    position:relative;
	top:5%;
	left:0px;
	width:100%;
	height:75%;
	text-align:center;
}
#job-table{
    margin:auto;
}
#job-table td{
    border:5px solid #fff;
	width:250px;
	background-color:#FFFFFF;
	cursor:pointer;
	vertical-align:top;
	text-align:center;
}
#lo-footer{
    position:relative;
	top:5%;
	left:0px;
	width:100%;
	height:10%;
	font-size:14px;
	text-align:center;
	color:#1C90F2;
}
.con-img{
    position:relative;
	margin-top:5%;
	margin-left:5%;
	width:90%;
	height:200px;
	background-color:#336699;
}
.con-name{
    position:relative;
	margin-top:25%;
	margin-left:5%;
	width:90%;
	height:30px;
	text-align:center;
	line-height:30px;
	color:#515151;
	font-size:18px;
}
#title-table td{
    font-size:14px;
	color:#515151;
}
.lo-a1{
    text-decoration:none;
	color:#515151;
}
.lo-a1:hover{
    color:#1C90F2;
}
.lo-a2{
    text-decoration:none;
	color:#1C90F2;
}
#BgDiv{background-color:#20455e; position:absolute; z-index:99; left:0; top:0; display:none; width:100%; height:600px;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}






.spinner {
  position:absolute;
  margin: 300px 40% 0 48%;
  width: 50px;
  height: 60px;
  text-align: center;
  font-size: 10px;
  display:none;
  z-index:100;
}
 
.spinner > div {
  background-color: #67CF22;
  height: 100%;
  width: 6px;
  display: inline-block;
   
  -webkit-animation: stretchdelay 1.2s infinite ease-in-out;
  animation: stretchdelay 1.2s infinite ease-in-out;
}
 
.spinner .rect2 {
  -webkit-animation-delay: -1.1s;
  animation-delay: -1.1s;
}
 
.spinner .rect3 {
  -webkit-animation-delay: -1.0s;
  animation-delay: -1.0s;
}
 
.spinner .rect4 {
  -webkit-animation-delay: -0.9s;
  animation-delay: -0.9s;
}
 
.spinner .rect5 {
  -webkit-animation-delay: -0.8s;
  animation-delay: -0.8s;
}
 
@-webkit-keyframes stretchdelay {
  0%, 40%, 100% { -webkit-transform: scaleY(0.4) } 
  20% { -webkit-transform: scaleY(1.0) }
}
 
@keyframes stretchdelay {
  0%, 40%, 100% {
    transform: scaleY(0.4);
    -webkit-transform: scaleY(0.4);
  }  20% {
    transform: scaleY(1.0);
    -webkit-transform: scaleY(1.0);
  }
}
</style>
<body>
<div id="lo-head">
    <table  height="100%" border="0" width="90%" style="margin-left:5%;" cellpadding="10" id="title-table">
	    <tr>
		    <td>N次方LOGO&nbsp;&nbsp; &nbsp; | &nbsp;&nbsp; &nbsp;校方登陆</td>
			<td align="right"><a href="#" class="lo-a2">联系我们</a>&nbsp;&nbsp; &nbsp;|&nbsp;&nbsp;&nbsp; <a href="login.jsp" class="lo-a1">退出</a></td>
		</tr>
	</table>
</div>
<div id="lo-mid">
    <div id="lo-title">选择职位</div>
    <div id="lo-content">
	    <table  height="100%"  border="0" cellspacing="30"  id="job-table">
  			<tr>
			    <%	int num =0;
		    	if(request.getAttribute("organizationlist")!=null){		       
    			ArrayList<Document> list= (ArrayList<Document>)request.getAttribute("organizationlist");
		        num = list.size();
		        String[] thisurl = new String[list.size()];
     			for (int i=0 ;i <list.size() ;i++){
     				thisurl[i] = "loginListAction?orId=" + list.get(i).get("_id");
     		     %>
				 <td><a class="lo-a1" href="loginListAction?orId=<%=list.get(i).get("_id")%>&userId=${requestScope.userId}">
				     <div class="con-img"><img src="" style="position:relative;width:100%;height:100%;top:0px;left:0px;" /></div>
					 <div class="con-name"><%=list.get(i).get("Name") %></div>
				    </a>	
				</td>
				 <%} }%>
    			
  			</tr>
		</table>
	</div>
	<div id="lo-footer">每个账号可绑定5个职位</div>
</div>
<div id="BgDiv"> </div>
<div class="spinner">
  		<div class="rect1"></div>
  		<div class="rect2"></div>
  		<div class="rect3"></div>
  		<div class="rect4"></div>
  		<div class="rect5"></div>
	</div>
<script>
    $(function(){    
    	$(".con-img").each(function(){
    		var temp = $(this).parent().parent().index()+1;
    		$(this).find("img").attr("src","mainimg/img/dlut"+temp+".jpg");
    	});
    });
</script>
</body>
</html>