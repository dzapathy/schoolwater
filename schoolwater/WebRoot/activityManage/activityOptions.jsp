<%@page import="com.dao.CreateAndQuery"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="bean.TableInfo"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<script type="text/javascript"
	src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
<link rel="stylesheet" href="../css/actmanagewhole.css" />
<script type="text/javascript" src="../js/actmanagewhole.js" charset="utf-8"></script>
</head>
<style>
/* CSS Document */
body{
	height:1180px;
	font-family:"微软雅黑";
	color:#515151;
}
#actmanagewhole-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:1180px;
}

#actmanagewhole-name{
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

#actmanagewhole-top{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:180px;
}

#actmanagewhole-option{
    position:relative;
    top:80px;
    height:80px;
    width:100%;
    border-top:1px solid #ddd;
    border-bottom:1px solid #ddd;
}
#actmanagewhole-creTable{
    position:relative;
	width:100px;
	left: 0px;
	height:100%;  
	float:left;
    overflow:hidden;   
}
#actmanagewhole-qdTable{
    position:relative;
	width:100px;
	left:10px;
	height:100%;
	float:left; 
    overflow:hidden;
}
#actmanagewhole-sendNews{
    position:relative;
	width:100px;
	left: 20px;
	height:100%;
	float:left; 
    overflow:hidden;
}
#actmanagewhole-deleAct{
    position:relative;
	width:100px;
	left:30px;
	height:100%;
	float:left; 
    overflow:hidden;
}
#actmanagewhole-changeAct{
    position:relative;
	width:100px;
	left: 40px;
	height:100%;
	float:left; 
    overflow:hidden;
}
#actmanagewhole-creNewTable{
    position:relative;
	width:100px;
	left: 50px;
	height:100%;
	float:left;   
    overflow:hidden;
}
#actmanagewhole-allAct{
    position:relative;
	width:100px;
	left: 60px;
	height:100%;
	float:left; 
    overflow:hidden;
}
#actmanagewhole-tongji{
	position:relative;
	width:100px;
	left: 70px;
	height:100%;
	float:left;
    overflow:hidden;
}
.actmanagewhole-topwhole{
	cursor:pointer;
	font-size:14px;
	line-height:80px;
}


#actmanagewhole-bottom{
    position:absolute;
	width: 100%;
	left: 0px;
	top: 180px;
	height:980px;
}
</style>
<body>

	<div id="actmanagewhole-fa">
		<div id="actmanagewhole-top">
		    <div id="actmanagewhole-name">
	         <div id="top-title">&nbsp;&nbsp;<%=session.getAttribute("SelectedActivityName") %></div>
	          </div>
	        <div id="actmanagewhole-option">
				<div id="actmanagewhole-creTable" align="center" 
					class="actmanagewhole-topwhole">报名表</div>
				<div id="actmanagewhole-qdTable" align="center" 
					class="actmanagewhole-topwhole">签到表</div>
				<div id="actmanagewhole-sendNews" align="center" 
					class="actmanagewhole-topwhole">群发信息</div>
				<div id="actmanagewhole-deleAct" align="center"
					class="actmanagewhole-topwhole">取消活动</div>
				<div id="actmanagewhole-changeAct" align="center" 
					class="actmanagewhole-topwhole">修改活动</div>
				<div id="actmanagewhole-creNewTable" align="center" 
					class="actmanagewhole-topwhole">创建其他信息表</div>
				<div id="actmanagewhole-allAct" align="center" 
					class="actmanagewhole-topwhole">报名团队</div>
				<div id="actmanagewhole-tongji" align="center" 
					class="actmanagewhole-topwhole">统计分析</div>
			</div>
		</div>
		<div id="actmanagewhole-bottom">
			<iframe
				src="activityDetail.jsp"
				id="actmanagewhole-frame" frameborder="0" scrolling="auto" 
				width="100%" height="100%"  >
			</iframe>
		</div>
	</div>
<script>
    $("#actmanagewhole-creTable").click(function() {
    
		$.get("activityCreateOrNot.action",function(data){
			var isHave=data;
			if(isHave =="0"){
            	$("#actmanagewhole-frame").attr("src", "activityCreateT1.jsp");
       		 }else{
        		$("#actmanagewhole-frame").attr("src", "activityEnroll.jsp");
        	}
		});

	});
    
    $(function(){
    	var allwidth = $("#actmanagewhole-fa").width();
    	var eachwidth = (allwidth-70 ) / 8; 
    	$(".actmanagewhole-topwhole").each(function(){
    		$(this).css("width",eachwidth+"px");
    	});
    	
    	var havenclick = -1;
    	$(".actmanagewhole-topwhole").bind("mouseover",function(){
    		$(this).css("border-top","2px solid #1C90F2");
    		$(this).css("color","#1C90F2");
    		$(this).css("font-size","15px");
    	});
    	$(".actmanagewhole-topwhole").bind("mouseout",function(){
    		if($(this).index() != havenclick){
    			$(this).css("border","0px solid #ccc");
        		$(this).css("color","#515151");
        		$(this).css("font-size","14px");
    		}
    	});
    	$(".actmanagewhole-topwhole").bind("click",function(){
    		$(this).css("border-top","2px solid #1C90F2");
    		$(this).css("color","#1C90F2");
    		$(this).css("font-size","15px");
    		havenclick = $(this).index();
    		$(".actmanagewhole-topwhole").each(function(){
    			if($(this).index() != havenclick){
        			$(this).css("border","0px solid #ccc");
            		$(this).css("color","#515151");
            		$(this).css("font-size","14px");
        		}
    		});
    	});
    });
</script>
</body>
</html>

