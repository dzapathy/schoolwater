<%@page import="java.text.SimpleDateFormat"%>
<%@page import="staticData.StaticString"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="bean.ActivityIntegral"%>
<%@page import="bean.ActivityIntegralTable"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/gradesearchsolo.css" />
	<script src="../js/gradesearchsolo.js"></script>
	
</head>
<style>
body{
	height:900px;
	font-family:"微软雅黑";
	color:#515151;
}
#gradesearchsolo-content{
    position:relative;
	width:100%;
	margin-top: 0px;
	height:900px;
}
#gradesearchsolo-content td{
    height:90px;
    border-top:1px solid #ddd;
    font-size:15px;
    color:#515151;
}

.gradesearchsolo-a1{
    text-decoration:none;
    color:#515151;
    font-size:14px;
    cursor:pointer;
}
.gradesearchsolo-a1:hover{
    text-decoration:none;
    color:#1C90F2;
}
#searchmore{
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
</style>
<body>
<%
	String levelId = (String)session.getAttribute("LevelTopId");
	int num = 10;//每次加载数据条数
 %>
<div id="gradesearchsolo-fa">
	<div id="gradesearchsolo-content">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0" id="gradesearchsolo-actsTable">
		    <tr>
		        <td  align="center" style="width:10%;">序号</td>
			  	<td  align="center" style="width:60%;">数据表名称</td>
			    <td  align="center" style="width:20%;">创建时间</td>
		    </tr>
			<%	
				if(!levelId.equals("000000000000000000000000")){ //普通管理员
					ActivityIntegralTable table = new ActivityIntegralTable();
					String organization_id =(String)session.getAttribute("Organization_id");				
					table.setOrganizationId(new ObjectId(organization_id));
					BasicDBObject query = CreateQueryFromBean.EqualObj(table);
					BasicDBObject projection = new BasicDBObject();
					projection.put(StaticString.ActivityIntegralTable_CreateTime, 1);
					projection.put(StaticString.ActivityIntegralTable_Name, 1);
					projection.put(StaticString.ActivityIntegralTable_id, 1);
					BasicDBObject sort = new BasicDBObject();
					sort.put(StaticString.ActivityIntegralTable_id, -1);
					MongoCursor<Document> curser = DaoImpl.GetSelectCursor(ActivityIntegralTable.class, query,sort,num, projection);
					int i = 0;
					while(curser.hasNext()){
						i++;		
						Document document = curser.next();
						Date time=(Date)document.get(StaticString.ActivityIntegralTable_CreateTime);
	    	    		String t= new SimpleDateFormat("yyyy-MM-dd").format(time);
			%>
				<tr>
				     <td  align="center" style="width:10%;"><%=i%></td>
					 <td  align="center" style="width:60%;"><a class="gradesearchsolo-a1" myid=<%=document.get("_id")%> style='text-decoration:none;' href="getSearchContext.action?id=<%=document.get("_id")%>&tableName=<%=document.get("Name") %>"><%=document.get("Name")%></a></td>
					 <td  align="center" style="width:20%;"><%=t%></td>
				</tr>
		    <%}}else{	//超级管理员
		    		ActivityIntegralTable table = new ActivityIntegralTable();
		    		ObjectId schoolId =(ObjectId)session.getAttribute("Organization_SchoolId");
		   			table.setSchoolId(schoolId);
		    		BasicDBObject query = CreateQueryFromBean.EqualObj(table);
					BasicDBObject projection = new BasicDBObject();
					projection.put(StaticString.ActivityIntegralTable_CreateTime, 1);
					projection.put(StaticString.ActivityIntegralTable_Name, 1);
					projection.put(StaticString.ActivityIntegralTable_id, 1);
					BasicDBObject sort = new BasicDBObject();
					sort.put(StaticString.ActivityIntegralTable_id, -1);
					MongoCursor<Document> curser = DaoImpl.GetSelectCursor(ActivityIntegralTable.class, query,sort,num, projection);
					int i = 0;
					while(curser.hasNext()){
						i++;		
						Document document = curser.next();
						Date time=(Date)document.get(StaticString.ActivityIntegralTable_CreateTime);
	    	    		String t= new SimpleDateFormat("yyyy-MM-dd").format(time);
			%>
				<tr>
				     <td  align="center" style="width:10%;"><%=i%></td>
					 <td  align="center" style="width:60%;"><a class="gradesearchsolo-a1" myid=<%=document.get("_id")%> style='text-decoration:none;' href="getSearchContext.action?id=<%=document.get("_id")%>&tableName=<%=document.get("Name") %>"><%=document.get("Name")%></a></td>
					 <td  align="center" style="width:20%;"><%=t%></td>
					 <td  align="center" style="width:10%;"><div style="cursor: pointer;" id="deleteT" myid=<%=document.get("_id")%>>删除</div></td>
				</tr>
		    <%}}%>
		</table>
		<div id ="searchmore">加载更多</div>
	</div>
	<div id ="levelId" style="display: none;"><%=levelId%></div>
</div>
<script type="text/javascript">
	$(function(){
		//加载更多按钮
		$("#searchmore").bind("click",function(){
			var levelId = $("#levelId").text();
			var lastTableId = $("tr:last td:eq(1) a").attr("myid");
			$.get("searchMoreTable",{"levelId":levelId,"lastTableId":lastTableId},function(data){
				var dataObj = JSON.parse(data);
				if(dataObj.length==0){
					alert("没有喽");
				}else{
					var num = $("tr:last").index()+1;
					$.each(dataObj,function(i,item){
						var $tr ="<tr>"+
					     "<td align='center' style='width:10%;height:5%;'>"+(num++)+"</td>"+
						 "<td align='center' style='width:60%;height:5%;'>"+
						 "<a myid='"+item._id+"' style='text-decoration:none;' href='getSearchContext.action?id="+item._id+"&tableName="+item.name+"'>"+item.name+"</a>"+
						 "</td>"+
						 "<td align='center' style='width:20%;height:5%;'>"+item.createTime+"</td>"+
						 "<td  align='center' style='width:10%;height:5%;'><div style='cursor: pointer;' id='deleteT' myid='"+item._id+"' >删除</div></td>"+
						 "</tr>";
						 $("#gradesearchsolo-actsTable tr:last").after($tr);	
					});
				}
			});
		});
	});
	
	$(function(){
		$("#gradesearchsolo-actsTable").find("tr:gt(0)").bind("mouseover",function(){
			$(this).find("td").each(function(){
				$(this).css("background-color","#f7f7f7");
			});
		});
		$("#gradesearchsolo-actsTable").find("tr:gt(0)").bind("mouseout",function(){
			$(this).find("td").each(function(){
				$(this).css("background-color","#fff");
			});
		});
		$("#gradesearchsolo-actsTable").find("tr:last").find("td").each(function(){
			$(this).css("border-bottom","1px solid #ddd");
		});
	});
</script>
</body>
</html>
