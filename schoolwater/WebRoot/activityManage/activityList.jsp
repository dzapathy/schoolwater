<%@page import="org.apache.struts2.components.Else"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page
	import="com.mongodb.BasicDBObject,com.dao.*,bean.*,com.mongodb.client.MongoCursor,org.bson.Document"%>
<%@ page import="staticData.*,java.text.*,org.bson.types.ObjectId"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<script type="text/javascript"
		src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/actmanageallact.css" />
	<script src="../js/actmanageallact.js"></script>
</head>
<style>
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}
#actmanageallact-top{
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

#actmanageallact-content{
    position:relative;
	width:100%;
	margin-top: 80px;
	height:900px;
}
#actmanageallact-content td{
    height:90px;
    border-top:1px solid #ddd;
    font-size:15px;
    color:#515151;
}

.actmanageallact-a1{
    text-decoration:none;
    color:#515151;
    font-size:14px;
    cursor:pointer;
}
.actmanageallact-a1:hover{
    text-decoration:none;
    color:#1C90F2;
}
.actmanageallact-a2{
    text-decoration:none;
    color:#1C90F2;
    font-size:14px;
    cursor:pointer;
}
</style>
<%!
	int pageNu=1;
	final int pageSize=10;
	ObjectId oIdfirst=null;
	ObjectId oIdlast=null;
	int pageTag=1;
	int pageCount;
	Boolean flag;//是否需要倒序输出
 %>
<body>
	<div id="actmanageallact-fa">
		<div id="actmanageallact-top">
	         <div id="top-title">&nbsp;&nbsp;活动管理</div>
	    </div>
		<div id="actmanageallact-content">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				id="actmanageallact-actsTable">
				<tr>
					<td align="center" style="width:10%;">序号</td>
					<td align="center" style="width:70%;">活动名称</td>
					<td align="center" style="width:20%;">创建时间</td>
				</tr>
				<%
					//获取总数，计算总页数
			    	BasicDBObject query=new BasicDBObject();
			    	int suggestionNum=(int)DaoImpl.GetSelectCount(InActivity.class, query);//请求数
			    	if(suggestionNum%pageSize==0){
			    		pageCount=suggestionNum/pageSize;
			    	}else{	
			    		pageCount=suggestionNum/pageSize+1;}
			        //判断是第几页
			        if((request.getAttribute("pageNu"))==null){
			        	pageNu=1;
			        }else{
			        	pageNu=(Integer)request.getAttribute("pageNu");
			             
			        }
					
					//获取数据
					ArrayList<Document> list = new ArrayList<Document>();
					//投影
		    		BasicDBObject projection=new BasicDBObject();
		    		projection.put(StaticString.InActivity_Name, 1);
		    		projection.put(StaticString.InActivity_ReleaseTime,1);
		    		//获取数据
		    		BasicDBObject sort=new BasicDBObject();
		    		BasicDBObject q=new BasicDBObject();
		    		InActivity activity=new InActivity();
		    		MongoCursor<Document> mc=null;
		    		
		    		if(pageNu==1){
		    			flag=true;
		    			sort.put(StaticString.InActivity_id, -1);//按id降序
		    			mc=DaoImpl.GetSelectCursor(InActivity.class, q,sort, pageSize,projection);
		    		}
		    		else{
		    			pageTag=(Integer)request.getAttribute("pageTag");
			    		if(pageTag==0){
			         	//上一页
			        		oIdfirst=new ObjectId((String)request.getAttribute("oIdfirst"));
			        		activity.set_id(oIdfirst);
			        		q=CreateQueryFromBean.GtObj(activity);
			        		sort.put(StaticString.InActivity_id, 1);
			        		flag=false;
			        	}
						else{
						//下一页
							oIdlast=new ObjectId((String)request.getAttribute("oIdlast"));
							activity.set_id(oIdlast);
							q=CreateQueryFromBean.LtObj(activity);
							sort.put(StaticString.InActivity_id, -1);
							flag=true;
						}
		        }
		        mc=DaoImpl.GetSelectCursor(InActivity.class, q, sort,pageSize, projection);
	        	while(mc.hasNext()){
	        		list.add(mc.next());
	        	}
		        if(list!=null&&list.size()!=0&&flag){
		    	    for(int i=0;i<list.size();i++){
		    	    	Document d=list.get(i);
		    	    	if(i==(list.size()-1)){  
		    	    		oIdlast=(ObjectId)d.get(StaticString.InActivity_id);
		    	    		
		    	    	}else if(i==0){
		    	    		oIdfirst=(ObjectId)d.get(StaticString.InActivity_id);
		    	    	}
		    	    	Date time = (Date) d.get(StaticString.InActivity_ReleaseTime);
						String rtime = new SimpleDateFormat("yyyy-MM-dd").format(time);
				%>	
				<tr>
					<td align="center" style="width:10%;"><%=i+1%></td>
					<td align="center" style="width:70%;">
						<a class="actmanageallact-a1" href="activityAction?_id=<%=d.get(StaticString.InActivity_id)%>"><%=d.get(StaticString.InActivity_Name) %></a></td>
					<td align="center" style="width:20%;"><%=rtime %></td>
				</tr>
				<%
			    	}
		    	}
		    	else{
		    	    int index=0; //序号
			    	for(int i=list.size()-1;i>=0;i--){
			    	    index++;
		    	    	Document d=list.get(i);
		    	    	if(i==(list.size()-1)){  
		    	    		oIdfirst=(ObjectId)d.get(StaticString.InActivity_id);
		    	    		
		    	    	}else if(i==0){
		    	    		oIdlast=(ObjectId)d.get(StaticString.InActivity_id);
		
		    	    	}		
		    	    	Date time = (Date) d.get(StaticString.InActivity_ReleaseTime);
						String rtime = new SimpleDateFormat("yyyy-MM-dd").format(time);
		    %>   
				<tr>
					<td align="center" style="width:10%;"><%=index%></td>
					<td align="center" style="width:70%;">
						<a class="actmanageallact-a1" href="activityAction?_id=<%=d.get(StaticString.InActivity_id)%>"><%=d.get(StaticString.InActivity_Name) %></a></td>
					<td align="center" style="width:20%;"><%=rtime %></td>
				</tr>
				<%
					}
					}
				%>
			</table>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0" id="pagetable">
				<tr>
					<td align="right" style="padding-right:20px;font-size:14px;">
					共<%=pageCount%>页 | 第<%=pageNu%>页
					&nbsp;&nbsp;&nbsp;&nbsp;
					<%if(pageNu>1&&oIdfirst!=null){%>
					<td><a class="actmanageallact-a2"
						href="activityPreNextAction?pageNu=<%=pageNu-1%>&oIdfirst=<%=oIdfirst%>&pageTag=0">上一页</a>
					<% }%>
					<%if(pageNu<pageCount&&oIdlast!=null) {%>
					<td><a class="actmanageallact-a2"
						href="activityPreNextAction?pageNu=<%=pageNu+1%>&oIdlast=<%=oIdlast%>&pageTag=1">下一页</a></td>
					<% }%>
				</tr>
			</table>
		</div>
	</div>
	<script>
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
	