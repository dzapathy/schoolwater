<%@page import="staticData.StaticString"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="bean.TableInfo"%>
<%@page import="org.bson.Document"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
<link rel="stylesheet" href="../css/actmanagenewT.css" />
<script src="../js/actmanagenewT.js"></script>
</head>
<style>
body{
	height:940px;
	font-family:"微软雅黑";
	color:#515151;
}
#actmanagenewT-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:940px;
}
#actmanagenewT-title{
    position:absolute;
	width:96%;
	left: 2%;
	top: 0px;
	height:60px;
	border:1px dashed #336699;
	line-height:30px;
	font-size:14px;
}
#actmanagenewT-content1{
    position:absolute;
	width:100%;
	left: 0px;
	top: 80px;
	height:200px;
}

#actmanagenewT-choseT{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:300px;
}
#actmanagenewT-table2 td{
    border-top:1px solid #ddd;
}
#actmanagenewT-table1 td{
    border-top:0px solid #ddd;
}
#actmanagenewT-table2    input[type=text],input[type=password],textarea{border:1px solid #ccc;padding:2px;border-radius:1px;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset;outline:medium none;line-height:25px;
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
#actmanagenewT-table2    input[type=text]:focus,input[type=password]:focus,textarea:focus{/*border-color:rgba(82,168,236,0.8);*/border-color:#52a8ec;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset,0 0 5px rgba(82,168,236,0.6);outline:0 none;}
#actmanagenewT-table2 select{
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
#actmanagenewT-title2{
    position:absolute;
	width:100%;
	left: 0px;
	top: 330px;
	height:75px;
}

<!-- 字段内容显示 -->
#actmanagenewT-content2{
    position:relative;
	width:100%;
	left: 0px;
	top: 470px;
	height:350px;
}
#actmanagenewT-show{
    position:relative;
	width:100%;
	left: 0px;
	top: 460px;
	height:150px;
}
#actmanagenewT-table3 td{
    height:60px;
	border-top:1px solid #ddd;
	text-align:center;
	font-size:15px;
	word-break:keep-all;/* 不换行 */  
    white-space:nowrap;/* 不换行 */ 
	overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */  
    text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/ 
}
#actmanagenewT-table3{
    table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */ 
}
#actmanagenewT-show input[type=text]{
    text-align:center;
    -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    font-family:"Microsoft YaHei",Verdana,Arial;
    font-size:14px;
    vertical-align:top;
    height:35px;
    color:#515151;
}
.deleinfo {
    position:relative;
	text-align:center;
	height:25px;
	line-height:25px;
	margin-left:40%;
	width:50px;
    color: #336699;
	border:1px solid #ccc;
	font-size:14px;
}
.deleinfo:hover{
    background:#E1E1E1;
	cursor:pointer;
}

#addtext{
    position:relative;
    width:100px;
	height:25px;
	color:#fff;
	margin-left:20px;
    background-color:#1C90F2;
    border:1px solid #1C90F2;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
    font-size:14px;
    cursor:pointer;
}
#savetext{
    position:relative;
    width:100px;
	height:25px;
	color:#fff;
    background-color:#1C90F2;
    border:1px solid #1C90F2;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
    font-size:14px;
    cursor:pointer;
}
#docreate{
    position:relative;
    width:100px;
	height:25px;
	color:#fff;
	float:right;
	margin-right:20px;
    background-color:#1C90F2;
    border:1px solid #1C90F2;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
    font-size:14px;
    cursor:pointer;
}
</style>
<%
	//初始化通知群体表
	ArrayList<Document> tableList = null;
	//查询该活动的所关联的表
	String activity_id = (String) session.getAttribute("SelectedActivityId");
	TableInfo tableInfo = new TableInfo();
	tableInfo.setActivityId(new ObjectId(activity_id));
	BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);
	BasicDBObject projection = new BasicDBObject();
	MongoCursor<Document> mc = DaoImpl.GetSelectCursor(TableInfo.class, query, projection);
	tableList = new ArrayList<Document>();
	while(mc.hasNext()) {
		tableList.add(mc.next());
	}
	ArrayList<Document> tableInfoColumn = new ArrayList<Document>();
	String tableColumnName = "";
	String tableColumnLength ="";
	String tableColumnChoose="";
	for(int i = 0; i < tableList.size(); i++){
		tableInfoColumn = (ArrayList<Document>)tableList.get(i).get("TableInfoColumn");	
		for(int j = 0; j < tableInfoColumn.size(); j++) {
			tableColumnName += "," + (String)tableInfoColumn.get(j).get("Name");
			tableColumnLength += "," + (String)tableInfoColumn.get(j).get("Length").toString();
			tableColumnChoose += "," + (String)tableInfoColumn.get(j).get("Choose").toString();
		}
		tableColumnName += ";";
		tableColumnLength+=";";
		tableColumnChoose +=";";
		tableInfoColumn.clear();
	}
	

 %>

<body>
<div id="actmanagenewT-fa">
    <div id="actmanagenewT-title">&nbsp;&nbsp;&nbsp;&nbsp;温馨提示：<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			根据活动创建新的表单，可以依据现有的表单，在此基础上添加删除，也可以完全手动录入新信息。</div>
	<div id="actmanagenewT-content1">
	    
		<div id="actmanagenewT-choseT">
		     <table width="100%" height="100%"  border="0" cellspacing="0" cellpadding="0" id="actmanagenewT-table2">
		        <tr>
		            <td align="left" style="width:20%;"><div style="position:relative;margin-left:20px;height:32px;line-height:32px;border-left:5px solid #90EE90">
                         &nbsp;&nbsp;录入方式：</div></td>
                    <td align="left" style="width:80%;">
                         <table width="100%" height="100%"  border="0" cellspacing="0" cellpadding="0" id="actmanagenewT-table1">
		       				 <tr>
			        			<td  align="left" style="width:5%;"><input type="radio" name="choseway" checked="checked" id="oldtable" /></td>
		            			<td  align="left" style="width:45%;">利用现有表格数据</td>
								<td  align="left" style="width:5%;"><input type="radio" name="choseway" id="newtable" /></td>
		            			<td  align="left" style="width:45%;">全部录入新数据</td>
		       				 </tr>
						</table>
                    </td>
		        </tr>
		        <tr>
			        <td  align="left" style="width:20%;"><div style="position:relative;margin-left:20px;height:32px;line-height:32px;border-left:5px solid #90EE90">
						&nbsp;&nbsp;选择表单：</div></td>
		            <td  align="left" style="width:80%;">
		            <select name="select" id="actmanagenewT-select">
		            <option onclick ="f" value=<%=activity_id+";-1" %>>请选择...</option>
		            <% 
				   	for (int i = 0 ;i < tableList.size() ;i++){ 
				   		%>
				   		<option onclick="f" value=<%=tableList.get(i).get("_id")+";"+i %>><%=tableList.get(i).get("Name")%></option>
				   <%} %>
				   </select>
				   </td>
				</tr>
				 <tr>
			        <td  align="left" style="width:20%;border-bottom:1px solid #ddd;"><div style="position:relative;margin-left:20px;height:32px;line-height:32px;border-left:5px solid #90EE90">
						&nbsp;&nbsp;新表名称：</div></td>
		            <td  align="left" style="width:80%;border-bottom:1px solid #ddd;"><input id="tableName" type="text" /></td>
				</tr>
			</table>
		</div>
		<div id="actmanagenewT-title2">
		    <input type="button" value="新增字段" id="addtext" />
			<input type="button" value="保存修改" id="savetext"/>
			
			&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;&nbsp;表格现有字段(最多设置8项)&nbsp;&nbsp;]：
			<input type="button" value="确认创建" id="docreate"/>
		</div>
	</div>
	<div id="actmanagenewT-content2">
	    <div id="actmanagenewT-show">
	     <table width="100%" height="100%"  border="0" cellspacing="0" cellpadding="0" id="actmanagenewT-table3">
		       <tr>
		       <td  align="center" style="width:40%;">字段名称</td>
		       <td  align="center" style="width:20%;display:none;">设置字段长度</td>
		       <td  align="center" style="width:20%;display:none;">是否必填</td>
		       <td  align="center" style="width:20%;">操作</td>
		       </tr>
		       <tr>
		       <td  align="center" style="width:40%;">姓名</td>
		       <td  align="center" style="width:20%;display:none;">5</td>
		       <td  align="center" style="width:20%;display:none;"><input name="" type="checkbox" disabled value="" checked style = "width:20px;height:20px" /></td>
		       <td  align="center" style="width:20%;"></td>
		       </tr>
		       <tr>
		       <td  align="center" style="width:40%;">学号</td>
		       <td  align="center" style="width:20%;display:none;">10</td>
		       <td  align="center" style="width:20%;display:none;"><input name="" type="checkbox" disabled value="" checked style = "width:20px;height:20px" /></td>
		       <td  align="center" style="width:20%;"></td>
		       </tr>
			</table>
			</div>
	</div>
	<div style="display: none;" id = "tableColumnDetail"><%=tableColumnName %></div>
	<div style="display: none;" id = "tableColumnLength"><%=tableColumnLength%></div>
	<div style="display: none;" id = "talbeColumnChoose"><%=tableColumnChoose%></div>	
</div>

<script>
var nowtrnum = 0;
$(function(){
    $("#addtext").click(function(){
    	nowtrnum = $("#actmanagenewT-table3").find("tr").size();
    	var hastext = 0
    	if($("#actmanagenewT-table3").find("[type='text']").is(":visible")){
    		hastext = 1;
    	}
    	if(nowtrnum < 8 && hastext == 0){
    		$("#actmanagenewT-table3 tr:last").after("<tr>"+
    	    		"<td  align='center' style='width:40%;'><input type='text' /></td>"+
    	    		"<td  align='center' style='width:20%;display:none;'><input type='text' value='1' /></td>"+
    	    		"<td  align='center' style='width:20%;display:none;'>"+
    	    		"<input name='' type='checkbox' checked value='' style = 'width:20px;height:20px'/></td>"+
    	    		"<td  align='center' style='width:20%;'><div class='deleinfo'>删 除</div></td></tr>");
    	    changeLine();
    	}else{
    		alert("数量已到上限或者有未保存项");
    	}
	    
	});
});

$(function(){
    $(".deleinfo").live("click",function(){
	    $(this).parent().parent().remove();
	    changeLine();
	});
});

$(function(){
    $("#savetext").click(function(){
    	var istext = 0
	    $("#actmanagenewT-table3 td").each(function(){
		    if($(this).find("[type='text']").is(":visible")){
			    var temp = $(this).find("[type='text']").val();
				if(temp != ""){
					$(this).html(temp);
				}
				else
				{
					istext = 1;
					
				}
			}
		});
    	if(istext == 1){
    		alert("请填写完整再保存，否则请删除");
    	}
	});
});

$(function(){
$("#newtable").click(function(){
    $("#actmanagenewT-select").attr("disabled","disabled");
    $("#actmanagenewT-select option:first").prop("selected", 'selected');
    $("#actmanagenewT-table3 tr").remove();
	$("#actmanagenewT-table3").append("<tr><td  align='center' style='width:40%;'>字段名称</td><td  align='center' style='width:20%;'>设置字段长度</td><td  align='center' style='width:20%;'>是否必填</td><td  align='center' style='width:20%;'>操作</td></tr>");
	$("#actmanagenewT-table3").append("<tr><td  align='center' style='width:40%;'>姓名</td><td  align='center' style='width:20%;'>5</td><td  align='center' style='width:20%;'><input name='' type='checkbox' disabled value='' checked style = 'width:20px;height:20px' /></td><td  align='center' style='width:20%;'></td></tr>");
	$("#actmanagenewT-table3").append("<tr><td  align='center' style='width:40%;'>学号</td><td  align='center' style='width:20%;'>10</td><td  align='center' style='width:20%;'><input name='' type='checkbox' disabled value='' checked style = 'width:20px;height:20px' /></td><td  align='center' style='width:20%;'></td></tr>");    
});
});

$(function(){
$("#oldtable").click(function(){
    $("#actmanagenewT-select").attr("disabled",false);
});
});

$(function(){
$("#actmanagenewT-select").change(function(){		
	var tableColumnDetail =$("#tableColumnDetail").text();
	var tableColumnLength = $("#tableColumnLength").text();
	var talbeColumnChoose = $("#talbeColumnChoose").text();
	$("#actmanagenewT-table3 tr").remove();
	$("#actmanagenewT-table3").append("<tr><td  align='center' style='width:40%;'>字段名称</td><td  align='center' style='width:20%;display:none;'>设置字段长度</td><td  align='center' style='width:20%;display:none;'>是否必填</td><td  align='center' style='width:20%;'>操作</td></tr>");
	var tableColumn = tableColumnDetail.split(";");
	var arrayTableColumnLength =tableColumnLength.split(";");
	var arrayTalbeColumnChoose =talbeColumnChoose.split(";");
	if($(this).children("option:selected").val().split(";")[1] == -1){
		$("#actmanagenewT-table3").append("<tr><td  align='center' style='width:40%;'>姓名</td><td  align='center' style='width:20%;display:none;'>5</td><td  align='center' style='width:20%;display:none;'><input name='' type='checkbox' disabled value='' checked style = 'width:20px;height:20px' /></td><td  align='center' style='width:20%;'></td></tr>");
		$("#actmanagenewT-table3").append("<tr><td  align='center' style='width:40%;'>学号</td><td  align='center' style='width:20%;display:none;'>10</td><td  align='center' style='width:20%;display:none;'><input name='' type='checkbox' disabled value='' checked style = 'width:20px;height:20px' /></td><td  align='center' style='width:20%;'></td></tr>");    
	}else{
		var columnName = tableColumn[Number($(this).children("option:selected").val().split(";")[1])].split(",");
		var columnLength = arrayTableColumnLength[Number($(this).children("option:selected").val().split(";")[1])].split(",");
		var columnChoose = arrayTalbeColumnChoose[Number($(this).children("option:selected").val().split(";")[1])].split(",");
		for(var i = 1; i < columnName.length; i++){
			if(columnName[i] == "姓名" || columnName[i] == "学号"){
				$("#actmanagenewT-table3").append("<tr><td align=\"center\" style=\"width:40%;\">"+columnName[i]+"</td><td  align=\"center\" style=\"width:20%;display:none;\">"+columnLength[i]+"</td><td  align=\"center\" style=\"width:20%;display:none;\"><input name='' type='checkbox' disabled value='' checked style = 'width:20px;height:20px' /></td><td  align=\"center\" style=\"width:20%;\"></td></tr>");
			}else{
				if(columnChoose[i]=="true"){
				$("#actmanagenewT-table3").append("<tr><td  align=\"center\" style=\"width:40%;\">"+columnName[i]+"</td><td  align=\"center\" style=\"width:20%;display:none;\">"+columnLength[i]+"</td><td  align=\"center\" style=\"width:20%;display:none;\"><input name='' type='checkbox'  value='' checked style = 'width:20px;height:20px' /></td><td  align=\"center\" style=\"width:20%;\"><div class='deleinfo'>删 除</div></td></tr>");
				}else{
					$("#actmanagenewT-table3").append("<tr><td  align=\"center\" style=\"width:40%;\">"+columnName[i]+"</td><td  align=\"center\" style=\"width:20%;display:none;\">"+columnLength[i]+"</td><td  align=\"center\" style=\"width:20%;display:none;\"><input name='' type='checkbox'  value='' style = 'width:20px;height:20px' /></td><td  align=\"center\" style=\"width:20%;\"><div class='deleinfo'>删 除</div></td></tr>");		
				}
			}
		}
	}
	changeLine();
});
});

$(function(){
	var tdContent = "";
	var tdLength = "";
	var tdChoose ="";
    $("#docreate").click(function(){
    if($("#actmanagenewT-table3 input:text").length != 0){
    	alert("请先保存修改！！");
    }else if($("#tableName").val() =="" ){
    	alert("请输入表名！！");
    }else{
    	$("#actmanagenewT-table3 tr").each(
    		function(){
    			tdContent += $(this).find("td").eq(0).html()+";";
    			tdLength += $(this).find("td").eq(1).html()+";";
    			tdChoose += $(this).find("td").eq(2).children().is(':checked')+";";
    		}    	
    	);
		window.location.href="activityNewTable.action?select="+$("#actmanagenewT-select").children("option:selected").val()
		+"&tableName="+$("#tableName").val()
		+"&tdContent="+tdContent
		+"&tdLength="+tdLength
		+"&tdChoose="+tdChoose;					    
	}});
});



//颜色变换
$(function(){
	$("#actmanagenewT-table3").find("tr:gt(0)").live("mouseover",function(){
		$(this).css("background-color","#f7f7f7");
	});
	$("#actmanagenewT-table3").find("tr:gt(0)").live("mouseout",function(){
		$(this).css("background-color","#fff");
	});
	
	changeLine();
});

function changeLine(){
	var allsize = $("#actmanagenewT-table3").find("tr").size()-1;
    $("#actmanagenewT-table3").find("tr:lt("+allsize+")").each(function(){
    	$(this).find("td").each(function(){
			$(this).css("border-bottom","0px solid #ddd");
    	});
	});
    $("#actmanagenewT-table3").find("tr:last").find("td").each(function(){
		$(this).css("border-bottom","1px solid #ddd");
	});
}
</script>
</body>
</html>
