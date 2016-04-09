<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>校园时光-商家登陆</title>
	<link rel="shortcut icon" href="img/logo/logo.ico" />
	<link rel="stylesheet" href="assets/css/reset.css" />
	<link rel="stylesheet" href="assets/css/supersized.css" />
	<link rel="stylesheet" href="assets/css/style.css" />
	<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	
</head>
<script>
$(function(){
    var obsH = $(window).height();
	if(obsH > 600){
		var tempH = obsH-60;
	  // $("#lo-mid").height(obsH+"px");
	  // $("#BgDiv").height(tempH+"px");
	}else{
	    
	}
	
	window.onresize=function(){
	    var obsH = $(window).height();
		if(obsH > 600){
			var tempH = obsH-60;
			  // $("#lo-mid").height(obsH+"px");
			   //$("#BgDiv").height(tempH+"px");
		}else{
	    
		}
	}
	
	$("#lo-head").css("width",window.screen.width);
	$("#lo-mid").css("height",window.screen.height);
	$("#BgDiv").css("height",window.screen.height-60);
	$("#lo-mid").css("width",window.screen.width);
	$("#login-content").css("left",window.screen.width*0.42);
	$("#content-input").css("left",window.screen.width*0.43);
	$("#content-title").css("left",window.screen.width*0.47);
	$("#content-title").css("width",window.screen.width*0.1);
	
	
	$("#login-button").bind("click",function(){
		$("#BgDiv").fadeIn();
		$("#login-content").fadeIn();
		$("#content-title").fadeIn();
		$("#content-input").fadeIn();
		
		$("#login-button").fadeOut();
	});
	$("#close-content").bind("click",function(){
		$("#BgDiv").fadeOut();
		$("#login-content").fadeOut();
		$("#content-title").fadeOut();
		$("#content-input").fadeOut();
		
		$("#login-button").fadeIn();
	});
	
	$("#login-button").bind("mouseover",function(){
	    $(this).css("background-color","#336699");
	});
	$("#login-button").bind("mouseout",function(){
	    $(this).css("background-color","#1C90F2");
	});
	
	$("#link-us").bind("mouseover",function(){
	    $(this).css("border","1px solid #1C90F2");
		$(this).css("color","#1C90F2");
	});
	$("#link-us").bind("mouseout",function(){
	    $(this).css("border","1px solid #ccc");
		$(this).css("color","#000");
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
	height:60px;
	top:0px;
	left:0px;
	z-index:2;
	background-color:#FFFFFF;
	opacity:0.90;filter: alpha(opacity=90);-moz-opacity: 0.90;
}
#lo-mid{
    position:absolute;
	top:0px;
	left:0px;
	width:100%;
	height:600px;
	z-index:1;
	background-color:#000;
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
#login-button{
    position:absolute;
	top:65%;
	width:200px;
	height:35px;
	background-color:#1C90F2;
	color:#FFFFFF;
	font-size:14px;
	text-align:center;
	line-height:35px;
	left:45%;
	 -moz-border-radius: 4px;      /* Gecko browsers */
    -webkit-border-radius: 4px;   /* Webkit browsers */
    border-radius:4px;    
	cursor:pointer;
}
#login-title{
    position:absolute;
	top:30%;
	width:500px;
	height:350px;
	left:35%;
}
#link-us{
    position:relative;
	width:130px;
	 -moz-border-radius: 4px;      /* Gecko browsers */
    -webkit-border-radius: 4px;   /* Webkit browsers */
    border-radius:4px;    
	cursor:pointer;
	color:#000;
	font-size:14px;
	height:30px;
	line-height:30px;
	text-align:center;
	border:1px solid #ccc;
}

#BgDiv{background-color:#000; position:absolute; z-index:99; left:0; top:60px; display:none; width:100%; height:540px;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}


#login-content{
    position:absolute;
	top:200px;
	width:300px;
	height:300px;
	left:42%;
	background-color:#000;
	opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;
	display:none;
	z-index:200;
}
#content-title{
    position:absolute;
	top:230px;
	left:47%;
	height:30px;
	width:10%;
	color:#FFFFFF;
	font-size:18px;
	text-align:center;
	line-height:30px;
	z-index:220;
	display:none;
	opacity:1;filter: alpha(opacity=100);-moz-opacity: 1;
}

#content-input{
    position:absolute;
	top:280px;
	width:275px;
	height:280px;
	left:43%;
	z-index:220;
	display:none;
}
#content-input td{
    text-align:center;
    height:50px;
}
#content-input input[type=text],input[type=password],textarea{border:1px solid #ccc;padding:2px;border-radius:1px;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset;outline:medium none;line-height:20px;
     -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    font-family:"Microsoft YaHei",Verdana,Arial;
    font-size:14px;
    vertical-align:top;
    height:35px;
	width:80%;
	padding-left:15px;
	color:#515151;
    }
#content-input    input[type=text]:focus,input[type=password]:focus,textarea:focus{/*border-color:rgba(82,168,236,0.8);*/border-color:#52a8ec;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset,0 0 5px rgba(82,168,236,0.6);outline:0 none;}

#content-input input[type=submit]{
    font-size:16px;
	font-weight:600;
	text-align:center;
	background-color:#1C90F2;
	color:#fff;
	width:80%;
	height:35px;
	border:1px solid #1C90F2;
	 -moz-border-radius: 4px;      /* Gecko browsers */
    -webkit-border-radius: 4px;   /* Webkit browsers */
    border-radius:4px;
	cursor:pointer;
}
</style>
<body>
<div id="lo-head">
     <table  height="100%" width="90%" style="margin-left:5%;"  border="0" cellpadding="10" id="title-table">
	    <tr>
		    <td>N次方LOGO&nbsp;&nbsp; &nbsp; | &nbsp;&nbsp; &nbsp;校方登陆</td>
			<td align="right"><div id="link-us">加入我们</div></td>
		</tr>
	</table>
</div>
<div id="lo-mid">
    <img src="mainimg/img/5.jpg" width="100%" height="100%" style="margin-left:0%;z-index:10;opacity:0.9;filter: alpha(opacity=90);-moz-opacity: 0.9;"/>
	<div id="login-title"><img src="mainimg/img/title.png" width="100%" height="100%" /></div>
	<div id="login-button">登&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;录</div>
	
</div>
<div id="BgDiv"> </div>


<div id="login-content"><div id="close-content" style="position:relative;cursor:pointer;float:right;line-height:20px;text-align:center;width:20px;height:20px;color:#fff;">x</div></div>
<div id="content-title">校方登陆</div>
<div id="content-input">
    <form action="loginAction" method="post" >
    <table  height="100%" width="100%" style="margin-left:0%;"  border="0" cellpadding="0" id="content-table">
	    <tr>
		    <td>
			    <input type="text" placeholder="用户名" name="userId" class="username"/>
			</td>
		</tr>
		<tr>
		    <td>
			    <input type="password" placeholder="密码" name="pwd" class="password"/>
			</td>
		</tr>
		<tr>
		    <td>&nbsp;<s:actionerror></s:actionerror></td>
		</tr>
		<tr>
		    <td>
			    <input type="submit" value="登    录"/>
			</td>
		</tr>
	</table>
	</form>
</div>
<script>
$(function(){
		$("input:submit").bind("click",function(){
			var name =$("input[name=userId]").val();
			var pass =$("input[name=pwd]").val();
			if(name!=""&&pass!=""){
				return true;
			}else{
				alert("请输入完整信息");
				return false;
			}
		});
	});
</script>
</body>
</html>