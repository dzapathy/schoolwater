<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="staticData.StaticString"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="bean.InActivity"%>
<%@page import="org.bson.types.ObjectId"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
<link rel="stylesheet" href="../css/omnipotentT.css" />
<script src="../js/omnipotentT.js"></script>
</head>
<style>
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}
#omnipotentT-top{
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
#omnipotentT-title{
    position:relative;
    width:300px;
    float:left;
    margin-left:20px;
    border-left:5px solid #1C90F2;
    height:30px;
    line-height:30px;
    margin-top:25px;
}
#omnipotentT-chooseinf{
    positive:relative;
    padding-top:25px;
    width:100%;
    clear:both;
    height:730px;
}
#omnipotentT-solotable td{
    height:80px;
    font-size:15px;
    border-top:1px solid #ddd;
}
#omnipotentT-solotable   input[type=text],input[type=password],textarea{border:1px solid #ccc;padding:2px;border-radius:1px;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset;outline:medium none;line-height:25px;
     -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    font-family:"Microsoft YaHei",Verdana,Arial;
    font-size:14px;
    vertical-align:top;
    height:35px;
	width:400px;
	color:#515151;
	text-align:center;
    }


#omnipotentT-addsoloinfo{
    position:absolute;
    font-size:15px;
    width:100%;
    height:30px;
    line-height:30px;
    background:#ddd;
    text-align: center;
    color:#1C90F2;
    cursor:pointer;
}
</style>
<body>
<div id="omnipotentT-fa">
       <div id="omnipotentT-top">
	         <div id="top-title">&nbsp;&nbsp;创建表单</div>
	    </div>
	    <div id="omnipotentT-title1">
		    &nbsp;&nbsp;&nbsp;&nbsp;温馨提示：<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 单表建立可用于建立任意数据表，可绑定活动类型，可自由选择最多8个字段。
			 只有当输入表格名称后才能创建表格。
		</div>
		<form action="omnipotentT" method="get">
		<div id="omnipotentT-content1">
		     <table width="100%" height="100%"  border="0" cellspacing="0" cellpadding="0">
		     <tr>
		         <td  align="left" style="width:15%;height:5%;">
		                 <div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;表格名称：</div></td></td>
			     <td  align="left" style="width:85%;height:5%;">
			       <input type="text" name="tableName" id="tableName"/>		      
			     </td>
			 </tr>
			 <tr>
		         <td  align="left" style="width:15%;height:5%;">
		             <div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;关联活动：</div></td>
			     <td  align="left" style="width:85%;height:5%;">
			       <select name="select">
			       		<!-- 从数据库获取数据 -->
			       		<option selected="selected">不绑定活动</option>
			       		<%
			       			//绑定
			       			String organizationId=(String) session.getAttribute("Organization_id");
			       			InActivity activity = new InActivity();
			       			activity.setOrganizationId(new ObjectId(organizationId));
			       			BasicDBObject query = CreateQueryFromBean.EqualObj(activity);
			       			BasicDBObject basicDBObject = new BasicDBObject();
			       			basicDBObject.put(StaticString.InActivity_Name, 1);
			       			MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(InActivity.class, query, basicDBObject);
			       			while(cursor.hasNext()){
			       				Document document = cursor.next();
			       		%>	
			       			<option ><%=document.get("Name") %></option>
			       		<%} %>
			       </select>	      
			     </td>
			 </tr>
			 </table>
		</div>
		<div id="omnipotentT-content2">
		    <!-- 信息表字段 -->
		    <div id="omnipotentT-title">&nbsp;&nbsp;数据表字段设置(可增加5个自选项)：</div>
		    <input type="submit" disabled id="omnipotentT-createT" value="确认创建">
		    <div id="omnipotentT-chooseinf">
		    <table width="100%" height="100%"  border="0" cellspacing="0" cellpadding="0" id="omnipotentT-solotable">
		    <tr>
		       <td  align="center" style="width:10%;">
			       序号
		       </td>
			   <td  align="center" style="width:80%;">
			       需填信息名称		      
			 </td>
			    <td  align="center" style="width:20%;display: none;">
				   设置信息长度
		       </td>
			   <td  align="center" style="width:10%;display: none;">
				   是否必填
		       </td>
			   <td  align="center" style="width:10%;">
				   删除
		       </td>
		    </tr>
			<tr>
		       <td  align="center" style="width:10%;">
			       1
		       </td>
			   <td  align="center" style="width:80%;">
			       姓名		      
			 </td>
			    <td  align="center" style="width:20%;display: none;">
				   1
		       </td>
			   <td  align="center" style="width:10%;display: none;">
				   <input name="" type="checkbox" disabled value="" checked style = "width:20px;height:20px" />
		       </td>
			   <td  align="center" style="width:10%;">
				   <img src="activityimg/delesolo1.png" style="width:20px;height:20px;" class="omnipotentT-delesoloinfo"/>
		       </td>
			</tr>
			<tr>
		       <td  align="center" style="width:10%;">
			       2
		       </td>
			   <td  align="center" style="width:80%;">
			       学号		      
			 </td>
			    <td  align="center" style="width:20%;display: none;">
				   1
		       </td>
			   <td  align="center" style="width:10%;display: none;">
				   <input name="" type="checkbox" disabled value="" checked style = "width:20px;height:20px"/>
		       </td>
			   <td  align="center" style="width:10%;">
				   <img src="activityimg/delesolo1.png" style="width:20px;height:20px;" class="omnipotentT-delesoloinfo"/>
		       </td>
			</tr>
		    </table>
		    </div>
		</div>
		
	</form>
</div>

<script>
    $(function(){
    	$("#omnipotentT-content1").find("tr:last").find("td").each(function(){
    		$(this).css("border-bottom","1px solid #ddd");
    	});
    	
    	$("#tableName").keyup(function(event) {
    		/* Act on the event */
    		var txtVal=$(this).val();
    		if (txtVal==="") {
    		    $("#omnipotentT-createT").attr("disabled",true); 
    		    $("#omnipotentT-createT").css("border","1px solid #ccc");
    		    $("#omnipotentT-createT").css("background","#ccc");
    		    $("#omnipotentT-createT").css("cursor","default");
    		}else{
    		    $("#omnipotentT-createT").attr("disabled",false);  
    		    $("#omnipotentT-createT").css("border","1px solid #1C90F2");
    		    $("#omnipotentT-createT").css("background","#1C90F2");
    		    $("#omnipotentT-createT").css("cursor","pointer");
    		}
    	});
    });
    
    $(function(){
    	$("#omnipotentT-solotable").find("tr:gt(0)").live("mouseover",function(){
    		$(this).css("background-color","#f7f7f7");
    	});
    	$("#omnipotentT-solotable").find("tr:gt(0)").live("mouseout",function(){
    		$(this).css("background-color","#fff");
    	});
    });
</script>
</body>
</html>
