<%@page import="bean.TableContentInfo"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="bean.TableInfo"%>
<%@page import="org.bson.types.ObjectId"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<script type="text/javascript"
		src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/actmanagecreT2.css" />
	<script type="text/javascript"
		src="../js/actmanagecreT2.js"></script>
</head>
<style>
body{
	height:880px;
	font-family:"微软雅黑";
	color:#515151;
}

#actmanagecreT2-title{
    position:absolute;
	width:96%;
	left: 2%;
	top: 0px;
	height:60px;
	border:1px dashed #336699;
	line-height:30px;
	font-size:14px;
}
#actmanagecreT2-dosome{
    position:relative;
	width:100%;
	margin-top:80px;
	height:30px;
}
#actmanagecreT2-members{
    position:absolute;
	width:100%;
	left:0px;
	margin-top:20px;
	height:450px;
}
#actmanagecreT2-membertable{
    table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */ 
}
#actmanagecreT2-membertable td{
    border-top:1px solid #ddd;
	height:50px;
	line-height:50px;
	font-size:15px;
	word-break:keep-all;/* 不换行 */  
    white-space:nowrap;/* 不换行 */ 
	overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */  
    text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/  
}
#actmanagecreT2-membertable input[type=text]{
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
#actmanagecreT2-delesome{
    position:relative;
    width:100px;
	height:25px;
	color:#fff;
    background-color:#bbb;
    border:1px solid #bbb;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
    font-size:14px;
    cursor:pointer;
}
#actmanagecreT2-export{
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
#actmanagecreT2-addsome{
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


.savememberinfo{
    position:relative;
	text-align:center;
	height:25px;
	line-height:25px;
	width:50px;
    color: #336699;
    margin-left:40%;
    float:left;
	border:1px solid #ccc;
	font-size:14px;
}
.savememberinfo:hover{
    background:#E1E1E1;
	cursor:pointer;
}
</style>
<%
	ObjectId tableInfo_id = (ObjectId)request.getAttribute("TableInfo_id");
	String oldTableInfo_id = (String)request.getAttribute("OldTableInfo_id");
	ArrayList<String> nameOrder = new ArrayList<String>();
%>
<body>
	<div id="actmanagecreT2-fa">
	    <div id="actmanagecreT2-title">&nbsp;&nbsp;&nbsp;&nbsp;温馨提示：<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			此处可以对数据表的内容进行操作，可以新增、删除、修改、导出表格内容</div>
		<div id="actmanagecreT2-dosome">
			&nbsp;&nbsp;&nbsp; <input type="button" value="删除选中项"
				id="actmanagecreT2-delesome" /> <input type="button" value="导出签到表" id="actmanagecreT2-export"/>
			<input type="button" value="新增成员" id="actmanagecreT2-addsome" />
		</div>

		<div id="actmanagecreT2-members">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				id="actmanagecreT2-membertable">
				<tr>
					<td align="center" style="width:10%;cursor:pointer;">全选</td>
					<td align="center" style="width:10%;">序号</td>
					<%
						TableInfo tableInfo = new TableInfo();
						tableInfo.set_id(tableInfo_id);
						BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);
						BasicDBObject projection = new BasicDBObject();
						MongoCursor<Document> mc = DaoImpl.GetSelectCursor(TableInfo.class, query, projection);
						Document d = mc.next();
						ArrayList<Document> columnName = new ArrayList<Document>();
						columnName = (ArrayList<Document>)d.get("TableInfoColumn");
						for(int i = 0; i < columnName.size(); i++) {
							String name = (String)columnName.get(i).get("Name");
							nameOrder.add(name);
					%>
					<td align="center" style="width:10%;"><%=columnName.get(i).get("Name")%></td>
					<%
						}
					%>
					<td align="center" style="width:5%;">操作</td>
				</tr>

				<%
					if(oldTableInfo_id.equals("-1")){
								}else{
								TableContentInfo tableContentInfo = new TableContentInfo();
								tableContentInfo.setTableId(new ObjectId(oldTableInfo_id));
								query = CreateQueryFromBean.EqualObj(tableContentInfo);
								MongoCursor<Document> mongoCursor = DaoImpl.GetSelectCursor(TableContentInfo.class, query, projection);
								int count = 1;
								while(mongoCursor.hasNext()){
									Document document = mongoCursor.next();
									ArrayList<Document> columnContent = new ArrayList<Document>();
									columnContent = (ArrayList<Document>)document.get("TableContentColumn");
				%>
				<tr class='addmember1'>
					<td align="center" style="width:10%;"><input name=""
						type="checkbox" value="" style="width:20px;height:20px" />
					</td>
					<td align="center" style="width:10%;"><%=count++%></td>
					<%
						for(int i = 0; i < nameOrder.size(); i ++){
											boolean flag = false;
											for(int j = 0; j < columnContent.size(); j++) {
												Document document2 = columnContent.get(j); 
												if(nameOrder.get(i).equals((String)document2.get("Name"))){
													flag = true;
					%>
					<td align="center" style="width:10%;"><input
						type='text' value=<%=document2.get("Content")%>
						style='width:100px;' visible='true' />
					</td>

					<%
						}											
											}
											if(!flag) {
					%>
					<td align="center" style="width:10%;"><input
						type='text' style='width:100px;' visible='true' />
					</td>
					<%
						}										
										}
					%>
					<td align="center" style="width:5%;">
					<div class='savememberinfo' style="">保存</div>
					</td>
				</tr>
				<%
					}}
				%>
			</table>
		</div>
	</div>
	<input type="hidden" value=<%=tableInfo_id%> id="tableInfo_id" />
	<script type="text/javascript">
$(function(){
    $("#actmanagecreT2-export").live('click', function() {
				var tableInfo_id = $("#tableInfo_id").val();
				//alert(tableInfo_id);
				window.location.href="activityNTDetailExport.action?tableInfo_id="+tableInfo_id;
			});
		});
		
		
		
$(function(){
    $("#actmanagecreT2-members").find("td:first").live('click', function() {
	    if($(this).html() == "全选"){
	        $(this).html("取消");
	        $("#actmanagecreT2-membertable tr").find("td:first").each(function(){
				     $(this).find("[type='checkbox']").attr("checked", true);
			});
		}
		else{
		    $(this).html("全选");
		    $("#actmanagecreT2-membertable tr").find("td:first").each(function(){
			     $(this).find("[type='checkbox']").attr("checked", false);
		});
		}
	    
	});
});





$(function(){
    $("#actmanagecreT2-addsome").click(function(){
    	if($("#actmanagecreT2-membertable").find("[type='text']").is(":visible")){
    		alert("先保存再新增");
    	}else{
    		var columnLength = $("#actmanagecreT2-membertable tr:last td").length;
    	
    		$("#actmanagecreT2-membertable").find("tr:last").after("<tr class='addmember2'><td  align='center' style='width:10%;'><input name='' type='checkbox' value='' style = 'width:20px;' /></td> <td id='tag' align='center' style='width:10%;'>"+($("#actmanagecreT2-membertable tr").length)+"</td><td  align='center' style='width:10%;'><div class='savememberinfo'>保存</div></td></tr>");
    		for(var i = 2; i < columnLength-1; i++){
    			$("#actmanagecreT2-membertable tr:last #tag").after("<td  align='center' style='width:10%;height:5%;'><input type='text' style='width:100px;' visible='true'/></td>");
    		}
    		settrlint();
    		reorderTd();
    		changealltd();
    	}
	});
});

$(function() {
	$(".savememberinfo").live(
			'click',
			function() {
				var temp = $(this).parent().parent().index();
				var flag = true;
				var addContent = "";
				var tableInfo_id = $("#tableInfo_id").val();
				$("#actmanagecreT2-membertable tr").eq(temp).find("td")
						.each(
								function() {
									if ($(this).find("[type='text']")
											.is(":visible")) {
										var temp = $(this).find(
												"[type='text']").val();
										if (temp == "") {
											alert("请填充数据！！");
											flag = false;
											return false;
										} else {

										}
									}
								});
				if (flag) {
					$("#actmanagecreT2-membertable tr").eq(temp).find(
							"td").each(
							function() {
								if ($(this).find("[type='text']").is(
										":visible")) {
									var temp = $(this).find(
											"[type='text']").val();
									addContent += temp + ";";
									$(this).find("[type='text']")
											.hide();
									$(this).html(temp);
								}
								
					}						
			);
			$.get("activityNTDetailSave", {
									"tableInfo_id" : tableInfo_id,
									"addContent" : addContent
								}, function(data) {
									alert(data);
								});
			addContent = "";
			
			}
	
							

});

});

$(function(){
    $("#actmanagecreT2-delesome").live('click', function() {
    	var tableInfo_id = $("#tableInfo_id").val();
	    $("#actmanagecreT2-membertable tr").each(function(){
	    	var delContent = "";
		     if($(this).find("[type='checkbox']").attr("checked")){
		     	var flag = true;
		     	$(this).find("td").each(function(){
		     		if ($(this).find("[type='text']").is(":visible")){
						flag = false;
						return false;						
					} 
		     	});
		     	if(flag){
		     		delContent = $(this).find("td").eq(3).html();
		     		$.get("activityNTDetailDel.action", {
									"tableInfo_id" : tableInfo_id,
									"delContent" : delContent
								}, function(data) {
									alert(data);
								});
					delContent = "";
		     	}
			    $(this).remove();
				if($("#actmanagecreT2-members").find("td:first").html() == "取消"){
	                $("#actmanagecreT2-members").find("td:first").html("全选");
		        }
				settrlint();
				reorderTd();
			 }
		});
	});

});   
    
    $(function(){
    	settrlint();
    });
    
    function settrlint(){
		$("#actmanagecreT2-membertable").find("tr").each(function(){
			$(this).find("td").each(function(){
				$(this).css("border-bottom","0px solid #ddd");
			});
		});
	
		$("#actmanagecreT2-membertable").find("tr:last").find("td").each(function(){
			$(this).css("border-bottom","1px solid #ddd");
		});
	}
		
  //颜色变换
    $(function(){
    	$("#actmanagecreT2-membertable").find("tr:gt(0)").live("mouseover",function(){
    		$(this).css("background-color","#f7f7f7");
    	});
    	$("#actmanagecreT2-membertable").find("tr:gt(0)").live("mouseout",function(){
    		$(this).css("background-color","#fff");
    	});
    });
  
  //载入页面时，重新规划td大小
    $(function(){
    	changealltd();
    });
    	
    function changealltd(){
    	var allsize = $("#actmanagecreT2-membertable").find("tr:first").find("td").size()-1;
    	var allwidth = $("#actmanagecreT2-membertable").width();
    	var eachwidth = (allwidth-200)/allsize;
    	
    	$("#actmanagecreT2-membertable").find("tr").each(function(){
    		$(this).find("td:last").css("width","200px");
    		$(this).find("td:lt("+allsize+")").each(function(){
    			$(this).css("width",eachwidth+"px");
    		});
    		$(this).find("[type='text']").each(function(){
    			$(this).css("width","80%");
    		});
    	});
    }
    
	//将序号重新排序
    function reorderTd(){
    	var reordernum = 1;
    	$("#actmanagecreT2-membertable").find("tr:gt(0)").each(function(){
    		$(this).find("td:eq(1)").html(reordernum);
    		reordernum++;
    	});
    };
	</script>
</body>
</html>
