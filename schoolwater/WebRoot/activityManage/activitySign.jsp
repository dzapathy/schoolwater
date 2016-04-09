<%@page import="bean.TableContentColumn"%>
<%@page import="bean.TableContentInfo"%>
<%@page import="bean.TableInfoColumn"%>
<%@page import="staticData.StaticString"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="bean.TableInfo"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
	<script type="text/javascript"
	src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/actmanageqd.css" />
	<script src="../js/actmanageqd.js"></script>
</head>
<style>
body{
	height:950px;
	font-family:"微软雅黑";
	color:#515151;
}
#searchMore{
    margin-left:40%;
	height: 30px;
	cursor: pointer;
	background-color: #ddd;
	width:20%;
	font-size:15px;
	color:#336699;
	line-height:30px;
	text-align: center;
}
#actmanageqd-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:950px;
}
#actmanageqd-dosome{
     position:relative;
	width:100%;
	margin-top:10px;
	height:30px;
}
#activitySignExport{
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
#actmanageqd-members{
    position:absolute;
	width:100%;
	left: 0px;
	top: 50px;
	height:900px;
}
#actmanageqd-membertable{
    table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */ 
}
#actmanageqd-membertable td{
    border-top:1px solid #ddd;
	height:50px;
	line-height:50px;
	font-size:15px;
	word-break:keep-all;/* 不换行 */  
    white-space:nowrap;/* 不换行 */ 
	overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */  
    text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/ 
}

</style>
<%
	ArrayList<String> columnName = new ArrayList<String>();
%>
<body>
	<div id="actmanageqd-fa">
		
		<div id="actmanageqd-dosome">
			&nbsp;&nbsp;&nbsp;  <input type="button" value="导出签到表"
				id="activitySignExport" />
		</div>
		<%
			String activityContentId = "";
			String activity_id = (String) session
					.getAttribute("SelectedActivityId");
			TableInfo tableInfo = new TableInfo();
			tableInfo.setActivityId(new ObjectId(activity_id));
			tableInfo.setType(0);
			BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);
			BasicDBObject projection = new BasicDBObject();
			projection.put("TableInfoColumn", 1);
			
			MongoCursor<Document> mc = DaoImpl.GetSelectCursor(TableInfo.class,
					query, projection);
			//如果没有签到表
			if (!mc.hasNext()) {

			} else {
		%>
		<div id="actmanageqd-members">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				id="actmanageqd-membertable">
				<tr>
					<td align="center" style="width:10%;">序号</td>
					<%
						//存在签到表
						Document document = mc.next();
						ArrayList<Document> documents = (ArrayList<Document>) document
						     		.get(StaticString.TableInfo_TableInfoColumn);
						//绘制表头
						for (int i = 0; i < documents.size(); i++) {
						columnName.add((String) documents.get(i).get("Name"));
					%>
						<td align="center" style="width:20%;"><%=documents.get(i).get("Name")%></td>
					<%
						}
					%>
						<td align="center" style="width:5%;">签到</td>
					</tr>
					<%
					//TableInfo的id
					ObjectId contentId = (ObjectId) document.get("_id");
					activityContentId = contentId.toString();
					
					TableContentInfo tableContentInfo = new TableContentInfo();
					tableContentInfo.setTableId(contentId); 
					BasicDBObject q = CreateQueryFromBean.EqualObj(tableContentInfo);
					BasicDBObject p = new BasicDBObject();
					p.put("TableContentColumn", 1);
					p.put("_id", 1); 
					//按创建时间排序
					BasicDBObject sort = new BasicDBObject();
					sort.put("CreateTime", -1);
					//限制返回条数
					int limit = 1;
					MongoCursor<Document> mc2 = DaoImpl.GetSelectCursor(TableContentInfo.class, q, sort, limit, p);
					ArrayList<Document> tableContentInfos = new ArrayList<Document>();
					ArrayList<Document> tableContentColumns = new ArrayList<Document>();
					while (mc2.hasNext()) {
						tableContentInfos.add(mc2.next());
					}
					for (int j = 0; j < tableContentInfos.size(); j++) {
						Document d = tableContentInfos.get(j);
					%>
					<tr>
					<td align="center" style="width:10%;" id=<%=d.get("_id") %> ><%=j + 1%></td>
					<%						
						tableContentColumns.clear();
						tableContentColumns = (ArrayList<Document>) d.get(StaticString.TableContentInfo_TableContentColumn);

						for (int k = 0; k < columnName.size(); k++) {
							for (int i = 0; i < tableContentColumns.size(); i++) {
								if (columnName.get(k).equals((String) tableContentColumns.get(i).get("Name"))) {
					%>
					<td align="center" style="width:20%;"><%=tableContentColumns.get(i)
										.get("Content")%></td>
					<%
						}}}
						for(int i = 0; i < tableContentColumns.size(); i++) {
							if("SignIn".equals((String) tableContentColumns.get(i).get("Name"))) {
								if(tableContentColumns.get(i).get("Content").equals("1")) {
					%>
					<td align="center" style="width:5%;">已签到</td>

					<%
						} else {
					%>
					<td align="center" style="width:5%;" class="sss" ><input name="" class="signButton"
						type="button" value="为他签到" style="width:20px;height:20px"
						class="checkedqd" /></td>

					<%
					}}}
					%>
				</tr>
				<%
					}
				%>
			</table>
			<div id="searchMore">加载更多</div>
		</div>
		<%
			}
		%>
		<div style="display:none;">
			<input type="text" value=<%=activityContentId%>
				id="activityContentIdValue" />
		</div>
		<div style="display: none;" id="columnName"><%=columnName %></div>
	</div>
<script type="text/javascript">
$(function() {
	$("#activitySignExport").click(
			function() {
				var activity_id = $("#activityIdValue").val();
				window.location.href = "activitySignExport.action";
			});
});

$(function() {
	$(".signButton").live("click", function() {
		var activityContent_id = $("#activityContentIdValue").val();
		var idCard = $(this).parent().parent().find("td:eq(2)").html();
		$.get("activitySignSign.action", {
			"idCard" : idCard,
			"activityContent_id" : activityContent_id
		}, function(data) {
			alert(data);
		});
		$(this).parent().html("已签到");
	});
});

$(function(){
	$("#searchMore").click(function(){
		var columnName = $("#columnName").html();
		$.get("activitySignSearchMore.action",{
			"columnName":columnName,
			"lastContentId":$("#actmanageqd-membertable tr:last td:eq(0)").attr("id"),
			"activityContent_id":$("#activityContentIdValue").val()	
		},function(data){
			if(data == "error"){
				alert("已经到底了！");		
			} else{
				var jsonData = JSON.parse(data);
				var $column = $("#actmanageqd-membertable tr:first td");
				$.each(jsonData, function(i, item){
					$("#actmanageqd-membertable tr:last").after($("#actmanageqd-membertable tr:last").clone(true));
					$("#actmanageqd-membertable tr:last td:eq(0)").attr("id", item.id);
					var j = 0;
					var trLength = $("#actmanageqd-membertable tr").length;
					$("#actmanageqd-membertable tr:last").find("td").each(function(){
						if(j == 0){
							$(this).html(trLength-1);
						} else{
							var key = $column.eq(j).html();
							$(this).html(item[key]);						
						}
						j = j+1;
					});
					if(item.SignIn == "1") {
						$("#actmanageqd-membertable tr:last td:last").html("已签到");
					} else {
						$("#actmanageqd-membertable tr:last td:last").html("<input name='' class='signButton'"+
							"type='button' value='为他签到' style='width:20px;height:20px' class='checkedqd' />");					
					}
					
					$("#actmanageqd-membertable").find("tr").each(function(){
						$(this).find("td").each(function(){
							$(this).css("border-bottom","0px solid #ddd");
						});						
					})
					$("#actmanageqd-membertable").find("tr:last").find("td").each(function(){
						$(this).css("border-bottom","1px solid #ddd");
					});
					
				});
				
			}
				
		});
	});
});
        
        
        
//相应的添加时加横线操作
$(function(){
	$("#actmanageqd-membertable").find("tr:last").find("td").each(function(){
		$(this).css("border-bottom","1px solid #ddd");
	});
});
//颜色变换
$(function(){
	$("#actmanageqd-membertable").find("tr:gt(0)").live("mouseover",function(){
		$(this).css("background-color","#f7f7f7");
	});
	$("#actmanageqd-membertable").find("tr:gt(0)").live("mouseout",function(){
		$(this).css("background-color","#fff");
	});
});


//载入页面时，重新规划td大小
$(function(){
	changealltd();
	reorderTd();
});
	
function changealltd(){
	var allsize = $("#actmanageqd-membertable").find("tr:first").find("td").size()-1;
	var allwidth = $("#actmanageqd-membertable").width();
	var eachwidth = (allwidth-200)/allsize;
	
	$("#actmanageqd-membertable").find("tr").each(function(){
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
	$("#actmanageqd-membertable").find("tr:gt(0)").each(function(){
		$(this).find("td:eq(0)").html(reordernum);
		reordernum++;
	});
}
</script>
</body>
</html>
	