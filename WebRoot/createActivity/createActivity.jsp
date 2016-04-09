<%@page import="org.bson.types.ObjectId"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="staticData.StaticString"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="bean.* , com.dao.*" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<head>
    <title>创建活动</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <!-- 引入富文本编辑器 -->
    <script type="text/javascript" charset="utf-8" src="ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>
    
	<!-- 后导入的 -->
	<link type="text/css" href="../jquery/choosetime/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
    <link type="text/css" href="../jquery/choosetime/jquery-ui-timepicker-addon.css" rel="stylesheet" />
	<link rel="stylesheet" href="../css/activitycreate.css" />
    <script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../jquery/choosetime/jquery-ui-1.8.17.custom.min.js"></script>
	<script type="text/javascript" src="../jquery/choosetime/jquery-ui-timepicker-addon.js"></script>
    <script type="text/javascript" src="../jquery/choosetime/jquery-ui-timepicker-zh-CN.js"></script>
    <script type="text/javascript" src="../js/activitycreate.js"></script>

</head>
<style>
body{
	height:1200px;
	font-family:"微软雅黑";
	color:#515151;
}
#activitycreate-titletop{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:80px;
}
#top-title{
    position:absolute;
	width:50%;
	float:left;
	left:2%;
	top: 30%;
	bottom:30%;
	line-height:32px;
	font-size:15px;
	font-weight:600;
	color:#515151;
	border-left:5px solid #ddd;
}
#activitycreate-top-inf{
    position:relative;
	width:100%;
	left: 0px;
	top: 80px;
	height:1000px;
}
#activitycreate-top-inf td{
    border-top:1px solid #ddd;
    font-size:15px;
    height:60px;
    padding-left:20px;
}
#activitycreate-top-inf    input[type=text],input[type=password],textarea{border:1px solid #ccc;padding:2px;border-radius:1px;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset;outline:medium none;line-height:25px;
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
#activitycreate-top-inf    input[type=text]:focus,input[type=password]:focus,textarea:focus{/*border-color:rgba(82,168,236,0.8);*/border-color:#52a8ec;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset,0 0 5px rgba(82,168,236,0.6);outline:0 none;}
#activitycreate-top-inf select{
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
 
 /* CSS Document */

#activitycreate-fa{
	position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:1000px;
}
#activitycreate-top{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:60%;
}
#activitycreate-end{
    position:absolute;
	width:100%;
	left: 0px;
	top: 5%;
	height:40%;
	
}


#activitycreate-top-warning1{
    position:relative;
	width:100%;
	top:70px;
	height:30px;
}




.bechosenactivity-inf td{
	
}

.bechosenactivity-title-1{
    position:relative;
	width:30%;
	left: 0px;
	height:5px;
	margin-left:20px;
	height:30px;
	line-height:30px;
	border-left:5px solid #1C90F2;
}
.bechosenactivity-inf-1{
    position:relative;
    padding-top:25px;
    width:100%;
    height:630px;
	
}
#solotable td{
    height:70px;
    font-size:15px;
    border-top:1px solid #ddd;
}
#solotable   input[type=text],input[type=password],textarea{border:1px solid #ccc;padding:2px;border-radius:1px;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset;outline:medium none;line-height:25px;
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

#activityteam-end-chooseinf{
    position:relative;
	width:100%;
	left: 0px;
	top: 1100px;
	height:60px;
}
#activityteam-end-con{
    position:relative;
    margin-left:20px;
    margin-right:20px;
    height:100%;
	border:1px dashed #336699;
	line-height:30px;
	font-size:14px;
}

#activitycreate-end-sumbit{
    position:relative;
	width:100px;
	float:right;
	margin-right:20px;
	top:32%;
	height:30px;
	color:#fff;
    background-color:#1C90F2;
    border:1px solid #1C90F2;
    cursor:pointer;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
}

#activitysolo-end-all{
	position:relative;
	left: 0px;
	width:100%;
	top: 1120px;
	height:680px;
	font-size:15px;
}

#addsoloinfo{
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
<%! int activityClassNum = 0;  
	ArrayList<Document> activityList = null;	//获取活动类型存储于activityList
 %>
<%
	//查询活动类型
	ObjectId schoolId =(ObjectId)session.getAttribute("Organization_SchoolId");
	School school = new School();
	school.set_id(schoolId);
	BasicDBObject query = CreateQueryFromBean.EqualObj(school);
	BasicDBObject projection=new BasicDBObject();
	projection.put(StaticString.School_InActivityCategoty,1);
	MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(School.class, query, projection);
	while(cursor.hasNext()){
		Document document = cursor.next();
		activityList = (ArrayList<Document>)document.get("InActivityCategoty");
	}
	if(activityList!=null&&activityList.size()>0){
			activityClassNum= activityList.size();
	}
 %>
<body>
<div id="activitycreate-fa">
	<div><s:actionerror></s:actionerror></div>
	<form action="createActivity" method="post" enctype="multipart/form-data" onsubmit="return CASubmit(true)" id="CAForm">
    <div id="activitycreate-top">
	    <div id="activitycreate-titletop">
	         <div id="top-title">&nbsp;&nbsp;创建活动</div>
	         <input type="submit"  value="确认创建"  id="activitycreate-end-sumbit"/>
	    </div>
	    <!-- 总提交按钮 -->
		
		     
		<div id="activitycreate-top-inf">
		    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		       <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;活动名称：</div></td>	  
			   <td style="width:85%;">
				   <input name="name" id="name" type="text" /> 
		       </td>
		    </tr>
		   
			<tr>
			 <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;活动类别：</div> </td>	  
			   <td style="width:85%;">
				   <select name="categoryName">
				   <%if(activityList!=null&&!"".equals(activityList)){
				   for (int i =0 ;i<activityList.size() ;i++){ %>
				   		<option><%=activityList.get(i).get("Name")%></option>				   		
				   <%}} %>
				   </select>
		       </td>
		    </tr>
			<tr>
		       <td style="width:15%;" ><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;报名截止：</div> </td>	  
			   <td style="width:85%;">
				   <input type="text" name="deadLine" class="ui_timepicker" id="deadLine" value=""/>
		       </td>
		    </tr>
			<tr>
		       <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;活动开始：</div> </td>	  
			   <td style="width:85%;">
				    <input type="text" name="startTime" class="ui_timepicker" value="" id="startTime">
		       </td>
		    </tr>
			<tr>
		       <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;活动结束：</div> </td>	  
			   <td style="width:85%;">
				    <input type="text" name="endTime" class="ui_timepicker" id="endTime"  value=""> 
		       </td>
		    </tr>
		    <tr>
		       <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;选择图片：</div> </td>	  
			   <td style="width:85%;">
				    <input type="file" name="filePicture"> 
		       </td>
		    </tr>
		    <tr>
		       <td style="width:15%;;height:400px;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;活动详情：</div> </td>	  
			   <td style="width:85%;height:400px;">
				    <script id="editor" type="text/plain" style="width:99.8%;height:80%;  "></script> 
		       </td>
		    </tr>
		    <tr>
		       <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;选择附件：</div> </td>	  
			   <td style="width:85%;">
				    <input type="file" name="fileAttachment"> 
				    <input type="hidden" name="content" id="content">
		       </td>
		    </tr>	
		    <tr>
		       <td style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;报名要求：</div> </td>	  
			   <td style="width:85%;">
				    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" id="chosewaytable">
		    			<tr>
		       				<td>
			       				<input type="radio" name="chooseway" value="2"  class="activityradio"/>
			       				&nbsp;&nbsp;无需App报名
		       				</td>
			   				<td>
			       				<input type="radio" name="chooseway" value="1" checked="checked" class="activityradio" />
			       				&nbsp;&nbsp;团队报名
		       				</td>
			    			<td>
				   				<input type="radio" name="chooseway" value="0" class="activityradio"/>
				   				&nbsp;&nbsp;个人报名
		       				</td>
		    			</tr>
					</table>
		       </td>
		    </tr>		      
		</table>
		
	  	</div >
	</div>
	
	
		
    
    <!-- 团队报名信息表 -->
		<div id="activityteam-end-chooseinf" class="bechosenactivity-inf">
		    <div id="activityteam-end-con">
		        &nbsp;&nbsp;&nbsp;&nbsp;温馨提示：<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 团队选项已经包含必填项：名称、口号、队长姓名、队长学号、
			 团队简介、团队需要、验证口令、团队成员。
		    </div>
		</div>
		
		
		<!-- 个人报名信息表 -->
		<div id="activitysolo-end-all">
			<div id="activitysolo-end-title"  class="bechosenactivity-title-1">
		                	&nbsp;&nbsp;个人报名表信息(可增加5个自选项)：</div>
			<div id="activitysolo-end-chooseinf"  class="bechosenactivity-inf-1">
		    	<table width="100%"  border="0" cellspacing="0" cellpadding="0" id="solotable">
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
				   	<img src="activityimg/delesolo1.png" style="width:20px;height:20px;" class="delesoloinfo"/>
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
				   <img src="activityimg/delesolo1.png" style="width:20px;height:20px;" class="delesoloinfo"/>
		       	</td>
				</tr>
			</table>
			</div>
		</div>
		
	
		
	</form>	
</div>
<script type="text/javascript">
	
    //实例化富文本编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
    //时时获取富文本编辑器里面的内容
    //var int=self.setInterval("getContent()",1000);
    //function getContent(){
    //    var context=UE.getEditor('editor').getContent();
    //  	document.getElementById("content").value= context;    	
    //}  
    
    $(function(){
    	$("input:submit").bind("click",function(){
    		if($("#name").val()==""||UE.getEditor('editor').getContent()==""){
    			alert("活动名称,活动类型,活动内容为必填信息");
    			return false;
    		}else{
    			var context=UE.getEditor('editor').getContent();
    			$("#content").val(context);
    			//return false;
    			return true;
    		}
    	});
    });   
    
    
    $(function(){
    	$("#activitycreate-top-inf").find("tr").eq(8).find("td").each(function(){
    		$(this).css("border-bottom","1px solid #ddd");
    	});
    	
    	$("#activitycreate-top-inf").find("tr:lt(8):gt(5)").find("td").each(function(){
    		$(this).css("border-top","0px solid #ddd");
    	});
    	
    	$("#chosewaytable").find("tr").each(function(){
    		$(this).find("td").each(function(){
    			$(this).css("border","0px solid #ddd");
    		});
    	});
    });
    
    
    var num = 2;
    $(function(){
        
        $("#solotable").find("tr:last").after("<div id='addsoloinfo'>+</div>"
    	);
    	 
    });
    $(function(){
        $("#addsoloinfo").live('click', function() {
    	    if(num < 7){
    		num++;
            $("#solotable").find("tr:last").after("<tr><td  align='center' style='width:10%;'>"+num+"</td><td  align='center' style='width:80%;'><input type='text' name='nameList' class='nameList' value=''/> </td><td  align='center' style='width:20%;display: none;'><input type='text' name='lengthList' value='1' /></td><td  align='center' style='width:10%;display: none;'><input name='chooseList' type='checkbox' value='"+num+"' checked style = 'width:20px;height:20px'/></td><td  align='center' style='width:10%;'><img src='activityimg/delesolo2.png' style='width:20px;height:20px;' class='delesoloinfo'/></td></tr>");
    		}else{
    			alert("数量已达上限噢");
    		}
        });	
    	
    });
    
    //变化颜色
    $(function(){
    	$("#solotable").find("tr:gt(0)").live("mouseover",function(){
    		$(this).css("background-color","#f7f7f7");
    	});
    	$("#solotable").find("tr:gt(0)").live("mouseout",function(){
    		$(this).css("background-color","#fff");
    	});
    });
    
    //删除按钮
    var delenum;
    $(function(){
        $(".delesoloinfo:gt(1)").live('click', function() {
    	    delenum = $(this).parent().parent().index();
    		$("#solotable tr").eq(delenum).remove();
    		num--;
    		delenum--;
    		$("#solotable tr:gt("+delenum+")").each(function(i){
                  var tempcontent = $(this).children("td:first").html()-1;
    			  $(this).children("td:first").html(tempcontent);
              
            });
    	});
    });	
    
    //空值提交提醒
    //这个方法只是用来做个掩护,没有这个掩护是不行的!  
	function CASubmit(flag){  
    	return flag;  
	}  
	$("#CAForm").submit(function(){  
		var isnull = 0;
		$(".nameList").each(function(){
    		if($(this).val().trim() == ""){
    			isnull = 1;
    		}
    	});
	    if(isnull == 0){  
	        return CASubmit(true);  
	    }else{  
	    	alert("信息表字段不能有空值");
	        return CASubmit(false);  
	    }  
	});  
    
    		
</script>
</body>
</html>
