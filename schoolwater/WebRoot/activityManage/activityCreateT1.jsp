<%@page import="com.dao.CreateAndQuery"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="bean.TableInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html charset= utf-8" />
<title>无标题文档</title>
<script type="text/javascript"
	src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
<link rel="stylesheet" href="../css/actmanagecreT1.css" />
<script src="../js/actmanagecreT1.js"></script>

</head>
<style>
body{
	height:940px;
	font-family:"微软雅黑";
	color:#515151;
}
#actmanagecreT1-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:940px;
}
#actmanagecreT1-titletop{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:32px;
}
#top-title{
    position:absolute;
	width:50%;
	float:left;
	left:2%;
	height:100%;
	line-height:32px;
	font-size:15px;
	font-weight:600;
	color:#515151;
	border-left:5px solid #ddd;
}
#actmanagecreT1-chooseinf{
    position:relative;
    top:50px;
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
#actmanagecreT1-submit{
    position:relative;
	width:100px;
	float:right;
	margin-right:20px;
	height:30px;
	color:#fff;
    background-color:#1C90F2;
    border:1px solid #1C90F2;
    cursor:pointer;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
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

<body>
	<div id="actmanagecreT1-fa">
		<%
			String activity_id = (String) session
					.getAttribute("SelectedActivityId");
						
		%>
		<div id="actmanagecreT1-titletop">
	         <div id="top-title">&nbsp;&nbsp;创建报名表</div>
	         <input type="button" value="确认创建" id="actmanagecreT1-submit" />
	    </div>
		<div id="actmanagecreT1-chooseinf" class="actmanagecreT1-inf-1">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				id="solotable">
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
				   	<img src="../createActivity/activityimg/delesolo1.png" style="width:20px;height:20px;" class="delesoloinfo"/>
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
				   <img src="../createActivity/activityimg/delesolo1.png" style="width:20px;height:20px;" class="delesoloinfo"/>
		       	</td>
				</tr>
			</table>
		</div>
		<div style="display:none;">
			<input type="text" value=<%=activity_id%> id="activityIdValue" />
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#actmanagecreT1-submit").click(
					function() {

						var tdContent = "";
						var activity_id = $("#activityIdValue").val();
						$("#solotable tr").each(
								function() {
									if ($(this).find("td").eq(1).text() == "") {

										tdContent += $(this).find("input")
												.eq(0).val()
												+ ","
												+ $(this).find("input").eq(1)
														.val() + ",";
										if ($(this).find("[type='checkbox']")
												.attr("checked")) {
											tdContent += "1;";
										} else {
											tdContent += "0;";
										}
									} else {
										tdContent += $(this).find("td").eq(1)
												.text()
												+ ","
												+ $(this).find("td").eq(2)
														.text() + ",";
										if ($(this).find("[type='checkbox']")
												.attr("checked")) {
											tdContent += "1;";
										} else {
											tdContent += "0;";
										}

									}
								});

						$.get("activityCreateT1.action", {
							"message" : tdContent
							
						}, function(data) {
							alert(data);
							window.location.href="activityEnroll.jsp";
						});
						tdContent = "";
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
	            $("#solotable").find("tr:last").after("<tr><td  align='center' style='width:10%;'>"+num+"</td><td  align='center' style='width:80%;'><input type='text' name='nameList' value=''/> </td><td  align='center' style='width:20%;display: none;'><input type='text' name='lengthList' value='1' /></td><td  align='center' style='width:10%;display: none;'><input name='chooseList' type='checkbox' value='"+num+"' checked style = 'width:20px;height:20px'/></td><td  align='center' style='width:10%;'><img src='../createActivity/activityimg/delesolo2.png' style='width:20px;height:20px;' class='delesoloinfo'/></td></tr>");
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
	    
		var delenum;
		$(function() {
			$(".delesoloinfo:gt(1)").live('click', function() {
				delenum = $(this).parent().parent().index();
				$("#solotable tr").eq(delenum).remove();
				num--;
				delenum--;
				$("#solotable tr:gt(" + delenum + ")").each(function(i) {
					var tempcontent = $(this).children("td:first").html() - 1;
					$(this).children("td:first").html(tempcontent);

				});
			});
		});

	</script>
</body>

</html>
