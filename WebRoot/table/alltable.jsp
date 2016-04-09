<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="staticData.StaticString"%>
<%@page import="org.bson.Document"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="bean.TableInfo"%>
<%@page import="org.bson.types.ObjectId"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
<link rel="stylesheet" href="../css/alltable.css" />
<script src="../js/alltable.js"></script>
</head>
<%!int pageNu=1; int pageCount=0; int pageSize=10;//修改一页中的记录数
    	ArrayList<ObjectId> listId=new ArrayList<ObjectId>();
%>
<style>
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}
#alltable-top{
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
#alltable-fa{
	position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:1000px;
}

#alltable-content{
    position:relative;
	width:100%;
	margin-top: 80px;
	height:900px;
}
#alltable-content td{
    height:90px;
    border-top:1px solid #ddd;
    font-size:15px;
    color:#515151;
}

.alltable-a1{
    text-decoration:none;
    color:#515151;
    font-size:14px;
    cursor:pointer;
}
.alltable-a1:hover{
    text-decoration:none;
    color:#1C90F2;
}
.alltable-a2{
    text-decoration:none;
    color:#1C90F2;
    font-size:14px;
    cursor:pointer;
}

.deleteT{
    position:relative;
	text-align:center;
	height:25px;
	line-height:25px;
	width:50px;
    color: #336699;
	border:1px solid #ccc;
	font-size:14px;
}
.deleteT:hover{
    background:#E1E1E1;
	cursor:pointer;
}
</style>
<body>
<div id="alltable-fa">
        <div id="alltable-top">
	         <div id="top-title">&nbsp;&nbsp;所有表格</div>
	    </div>
		<div id="alltable-content">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0" id="actmanageallact-actsTable">
		<tr>
		     <td  align="center" style="width:10%;">序号</td>
			 <td  align="center" style="width:60%;">表格名称</td>
			 <td  align="center" style="width:20%;">创建时间</td>
			 <td  align="center" style="width:10%;">操作</td>
		</tr>
		<% 	
    	listId.clear(); //重新提交请求把listid清空；  	
    	//获取总数，计算总页数
    	TableInfo info = new TableInfo();
    	String organizationId=(String)session.getAttribute("Organization_id");
    	info.setOrganizationId(new ObjectId(organizationId));
    	BasicDBObject query=CreateQueryFromBean.EqualObj(info);//待修改
    	int num =(int)DaoImpl.GetSelectCount(TableInfo.class, query)%pageSize;
    	if(num==0){
    		pageCount=((int)DaoImpl.GetSelectCount(TableInfo.class, query))/pageSize;
    	}else{	
    	pageCount=(int)DaoImpl.GetSelectCount(TableInfo.class, query)/pageSize+1;}
        //判断是第几页
        if((request.getAttribute("pageNu"))==null){
        	pageNu=1;
        	request.setAttribute("pageNu", pageNu);
        }else{
        	pageNu=(Integer)request.getAttribute("pageNu");
        	request.setAttribute("pageNu", pageNu);
        }
        //获取数据
        ArrayList<Document> list=new ArrayList<Document>();
        if(pageNu==1){
        	BasicDBObject projection=new BasicDBObject();
        	projection.put(StaticString.TableInfo_CreateTime, 1);
        	projection.put(StaticString.TableInfo_Name, 1);
        	projection.put(StaticString.TableInfo_id, 1);
			TableInfo info1 = new TableInfo();
	    	String organizationId1=(String)session.getAttribute("Organization_id");
	    	info.setOrganizationId(new ObjectId(organizationId1));
	    	BasicDBObject query1=CreateQueryFromBean.EqualObj(info);
			BasicDBObject sort=new BasicDBObject();
			sort.put(StaticString.TableInfo_id, -1);
			MongoCursor<Document> mc=DaoImpl.GetSelectCursor(TableInfo.class, query1, sort,pageSize, projection);
        	while(mc.hasNext()){
        		list.add(mc.next());
        	}
        }else{	
        	list=(ArrayList<Document>)request.getAttribute("data");
        }
        int pageTag=1;
        if(pageNu==1){
        	pageTag=1;
        }else{
        pageTag=(Integer)request.getAttribute("pageTag");}
        if(list!=null&&list.size()!=0&&pageTag==1){
    	    for(int i=0;i<list.size();i++){
    	    	Document d=list.get(i);
    	    	if(i==0||i==(list.size()-1)){  
    	    	listId.add((ObjectId)d.get(StaticString.TableInfo_id));}			
    	    	Date time=(Date)d.get(StaticString.TableInfo_CreateTime);
    	    	String t= new SimpleDateFormat("yyyy-MM-dd").format(time);
    %>    		        
		<tr>
		      <td  align="center" style="width:10%;"><%=i+1 %></td>
			  <td  align="center" style="width:60%;"><a class="alltable-a1"   href="tableContextAction?_id=<%=d.get(StaticString.TableInfo_id)%>&listName=<%=d.get(StaticString.TableInfo_Name)%>"><%=d.get(StaticString.TableInfo_Name) %></a></td>
			  <td  align="center" style="width:20%;"><%=t%></td>
			  <td  align="center" style="width:10%;"><div style="cursor: pointer;" class="deleteT" myid=<%=d.get(StaticString.TableInfo_id)%> >删除</div></td>			  
		</tr>
	<%
	    	}
    	}else{
    	 for(int i=(list.size()-1),j=1;i>=0;i--,j++){
    	    	Document d=list.get(i);
    	    	if(i==0||i==(list.size()-1)){   
    	    	listId.add((ObjectId)d.get(StaticString.TableInfo_id));}		
    	    	Date time=(Date)d.get(StaticString.TableInfo_CreateTime);
    	    	String t= new SimpleDateFormat("yyyy-MM-dd").format(time);
    %>  
   		<tr>
		     <td  align="center" style="width:10%;"><%=j %></td>
			 <td  align="center" style="width:60%;"><a class="alltable-a1" href="tableContextAction?_id=<%=d.get(StaticString.TableInfo_id)%>&listName=<%=d.get(StaticString.TableInfo_Name)%>"><%=d.get(StaticString.TableInfo_Name) %></a></td>
			 <td  align="center" style="width:20%;"><%=t%></td>
			 <td  align="center" style="width:10%;"><div style="cursor: pointer;" class="deleteT" myid=<%=d.get(StaticString.TableInfo_id)%> >删除</div></td>
		</tr>
    <%}} %>
		</table>
		
		<table width="100%"  border="0" cellspacing="0" cellpadding="0" id="pagetable">
	    <tr>
	    <td align="right" style="padding-right:20px;font-size:14px;">
	                      共<%=pageCount%>页 | 第<%=pageNu%>页
	                      &nbsp;&nbsp;&nbsp;&nbsp;
	    	<%if(pageNu!=1&&listId!=null&&listId.size()!=0){%>
	    	<a class="alltable-a2" href="tablePreAction?pageNu=<%=pageNu %>&noticeidF=<%=listId.get(0)%>&noticeidL=<%=listId.get((listId.size()-1))%>&pageTag=0" name="prePage">上一页</a><%} %>	    	
	    	<%if(pageNu!=pageCount&&listId!=null&&listId.size()!=0) {%>
	    	<a class="alltable-a2" href="tableNexAction?pageNu=<%=pageNu %>&noticeidF=<%=listId.get(0)%>&noticeidL=<%=listId.get((listId.size()-1))%>&pageTag=1" name="nexPage">下一页</a></td><%} %>    	
	    </tr>
	    
	  	</table>
	</div>	
</div>
<script type="text/javascript">
	$(function(){
		//删除table
		$(".deleteT").bind("click",function(){
			var $tableId = $(this).attr("myid");
			//var $parent =$(this).parent().parent();
			$.get("aTableDelete",{"tableId":$tableId},function(data){
				if(data=="true"){
					alert("删除成功");
					location.href="alltable.jsp";
				}else{
					alert("删除失败");
				}
			});
		});
	});
	
	$(function(){
		$("#actmanageallact-actsTable").find("tr:gt(0)").bind("mouseover",function(){
			$(this).find("td").each(function(){
				$(this).css("background-color","#f7f7f7");
			});
		});
		$("#actmanageallact-actsTable").find("tr:gt(0)").bind("mouseout",function(){
			$(this).find("td").each(function(){
				$(this).css("background-color","#fff");
			});
		});
		
		$("#pagetable").find("tr").bind("mouseover",function(){
			$(this).find("td").each(function(){
				$(this).css("background-color","#f7f7f7");
			});
		});
		$("#pagetable").find("tr").bind("mouseout",function(){
			$(this).find("td").each(function(){
				$(this).css("background-color","#fff");
			});
		});
	});
</script>
</body>
</html>

