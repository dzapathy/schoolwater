<%--<%@page import="javax.persistence.Basic"--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="com.mongodb.BasicDBObject,com.dao.*,bean.*,com.mongodb.client.MongoCursor,org.bson.Document" %>
<%@ page import="staticData.*,java.text.*,org.bson.types.ObjectId" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
<link rel="shortcut icon" href="inf/img/logo/logo.ico" />
<link rel="stylesheet" href="../css/announce.css" />

</head>
<style>
body{
    font-family:"微软雅黑";
	height:1000px;
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
<div id="announce-fa">
    <div id="announce-top">
	    <div id="top-title">&nbsp;&nbsp;公告通知</div>
	</div>
	<div id="announce-end">
	    <div id="announce-content">
	     <table width="100%"  border="0" cellspacing="0" cellpadding="0">
			 
	    	<%
	    		//获取总页数
	    		SystemNotice sn=new SystemNotice();
	    		sn.setReceiver(0);//学校公告
	    		BasicDBObject q=CreateQueryFromBean.EqualObj(sn);
	    		int totalNum=(int)DaoImpl.GetSelectCount(SystemNotice.class, q);
	    		if(totalNum%pageSize==0){
	    			pageCount=totalNum/pageSize;
	    		}
	    		else{
	    			pageCount=(totalNum/pageSize)+1;
	    		}
	    		
	    		//当前页数
	    		
	    		if(request.getAttribute("pageNu")==null){
	    			pageNu=1;
	    		}
	    		else{
	    			pageNu=(Integer)request.getAttribute("pageNu");
	    		}
	    		//投影
	    		BasicDBObject projection=new BasicDBObject();
	    		projection.put(StaticString.SystemNotice_Content,1);
	    		projection.put(StaticString.SystemNotice_Publisher, 1);
	    		projection.put(StaticString.SystemNotice_ReleaseTime, 1);
	    		projection.put(StaticString.SystemNotice_Title, 1);
	    		//获取数据
	    		ArrayList<Document> list=new ArrayList();
	    		BasicDBObject sort=new BasicDBObject();
	    		MongoCursor<Document> mc=null;
	    		if(pageNu==1){
	    			flag=true;
	    			sort.put(StaticString.SystemNotice_id, -1);//按id降序
	    			mc=DaoImpl.GetSelectCursor(SystemNotice.class, q,sort, pageSize,projection);
	    		}
	    		else{
	    			CreateAndQuery cq=new CreateAndQuery();
	    			
	    			pageTag=(Integer)request.getAttribute("pageTag");
	    			//上一页
	    			if(pageTag==0){
	    				oIdfirst=new ObjectId((String)request.getAttribute("oIdfirst"));
	    				sort.put(StaticString.SystemNotice_id,1);//按id升序
	    				SystemNotice sn1=new SystemNotice();
	    				sn1.set_id(oIdfirst);
	    				SystemNotice sn2=new SystemNotice();
	    				sn2.setReceiver(0);
	    				BasicDBObject q1=CreateQueryFromBean.GtObj(sn1);
	    				BasicDBObject q2=CreateQueryFromBean.EqualObj(sn2);
	    				cq.Add(q1);
	    				cq.Add(q2);
	    				mc=DaoImpl.GetSelectCursor(SystemNotice.class, cq.GetResult(), sort,pageSize, projection);
	    				flag=false;
	    			}
	    			//下一页
	    			else{
	    				oIdlast=new ObjectId((String)request.getAttribute("oIdlast"));
	    				sort.put(StaticString.SystemNotice_id,-1);//按id降序
	    				SystemNotice sn2=new SystemNotice();
	    				SystemNotice sn1=new SystemNotice();
	    				sn1.set_id(oIdlast);
	    				sn2.setReceiver(0);
	    				BasicDBObject q1=CreateQueryFromBean.LtObj(sn1);
	    				BasicDBObject q2=CreateQueryFromBean.EqualObj(sn2);
	    				cq.Add(q1);
	    				cq.Add(q2);
	    				mc=DaoImpl.GetSelectCursor(SystemNotice.class, cq.GetResult(),sort, pageSize, projection);
	    				flag=true;
	    			}
	    			
	    		}
	    		while(mc.hasNext()){
    				list.add(mc.next());
    			}
	    		if(list!=null&&!list.isEmpty()&&flag){
	    			for(int i=0;i<list.size();i++){
	    				Document d=list.get(i);
	    				if(i==0){
	    					oIdfirst=(ObjectId)d.get(StaticString.SystemNotice_id);
	    				}
	    				else if(i==list.size()-1)
	    				{	
	    					oIdlast=(ObjectId)d.get(StaticString.SystemNotice_id);
	    				}
	    				
	    				String publisher=(String)d.get(StaticString.SystemNotice_Publisher);
	    				Date time=(Date)d.get(StaticString.SystemNotice_ReleaseTime);
	    				String rtime=new SimpleDateFormat("yyyy-MM-dd").format(time);
	    				String content=(String)d.get(StaticString.SystemNotice_Content);
	    		%>
	    		<tr>
	    		<td style="list-style-type:none;">
	    		    <span style="float:left;"><a class="a1" href="bulletinAction?_id=<%=d.get(StaticString.SystemNotice_id)%>">
	    		         <%= d.get(StaticString.SystemNotice_Title)%></a></span>
	    			<span style="float:right;"><%=rtime %></span>
	    		</td>
	    		</tr>
	    		<% 	}}
		    		else{
		    			for(int i=list.size()-1;i>=0;i--){
	    				Document d=list.get(i);
	    				if(i==0){
	    					oIdlast=(ObjectId)d.get(StaticString.SystemNotice_id);
	    				}
	    				else if(i==list.size()-1)
	    				{	
	    					oIdfirst=(ObjectId)d.get(StaticString.SystemNotice_id);
	    				}
	    				
	    				String publisher=(String)d.get(StaticString.SystemNotice_Publisher);
	    				Date time=(Date)d.get(StaticString.SystemNotice_ReleaseTime);
	    				String rtime=new SimpleDateFormat("yyyy-MM-dd").format(time);
	    				String content=(String)d.get(StaticString.SystemNotice_Content);
	    		%>
	    		
	    		<tr>
	    		
	    		<td style="list-style-type:none;">
	    		    <span style="float:left;"><a class="a1" href="bulletinAction?_id=<%=d.get(StaticString.SystemNotice_id)%>">
	    		    <%= d.get(StaticString.SystemNotice_Title)%>
	    		        </a></span>
	    			<span style="float:right;"><%=rtime %></span>
	    		</td>
	    		
	    		</tr>
	    		<% 	}}%>
		
		  
		
	  	<tr>
	  	<td>
	  	
	  	    <span style="float:right;font-size:12px;">共<%=pageCount%>页 | 第<%=pageNu%>页	
	  	    &nbsp;&nbsp;&nbsp;&nbsp;
	    	<%if(pageNu>1&&oIdfirst!=null){%>
	    	<a class="a2" href="bulletinPreNextAction?pageNu=<%=pageNu-1%>&oIdfirst=<%=oIdfirst%>&pageTag=0" >上一页</a><%} %>   	
	    	<%if(pageNu<pageCount&&oIdlast!=null) {%>
	    	<a class="a2"" href="bulletinPreNextAction?pageNu=<%=pageNu+1%>&oIdlast=<%=oIdlast%>&pageTag=1" >下一页</a><%} %>  
	    	</span>  	
	    </tr>
	    
	    </table>
	  	</div> 
	</div>
	
	    
</div>
<script type="text/javascript">
$(function(){
	$("#announce-content").find("tr").bind("mouseover",function(){
		$(this).css("background-color","#f7f7f7");
	});
	$("#announce-content").find("tr").bind("mouseout",function(){
		$(this).css("background-color","#fff");
	});
    $("#announce-content").find("tr:last").find("td").each(function(){
	    $(this).css("border-bottom","1px solid #eee");
	});
})

</script>
</body>
</html>
<%--
<% 	
    	listId.clear(); //重新提交请求把listid清空；  	
    	//获取总数，计算总页数
    	SystemNotice notice = new SystemNotice();
    	notice.setReceiver(0);
    	BasicDBObject query=CreateQueryFromBean.EqualObj(notice);
    	int num =(int)DaoImpl.GetSelectCount(SystemNotice.class, query);
    	if(num%pageSize==0){
    		pageCount=num/pageSize;
    	}else{	
    	pageCount=num/pageSize+1;}
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
			SystemNotice notice1 = new SystemNotice();
    		notice1.setReceiver(0);
    		BasicDBObject q=CreateQueryFromBean.EqualObj(notice);
			BasicDBObject sort=new BasicDBObject();
			sort.put(StaticString.SystemManager_id, -1);
			MongoCursor<Document> mc=DaoImpl.GetSelectCursor(SystemNotice.class, q, sort,pageSize, projection);
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
    	    	listId.add((ObjectId)d.get(StaticString.SystemNotice_id));}			
    	    	Date time=(Date)d.get(StaticString.SystemNotice_ReleaseTime);
    	    	String t= new SimpleDateFormat("yyyy-MM-dd").format(time);
    %> 
		    
		    <li>
		       <a href="bulletinAction?_id=<%=d.get(StaticString.SystemNotice_id)%>"><%=d.get(StaticString.SystemNotice_Title) %></a>
		       <br><%=t%>      
		    </li>
		<%
	    	}
    	}else{
    	 for(int i=(list.size()-1);i>=0;i--){
    	    	Document d=list.get(i);
    	    	if(i==0||i==(list.size()-1)){   
    	    	listId.add((ObjectId)d.get(StaticString.SystemNotice_id));}		
    	    	Date time=(Date)d.get(StaticString.SystemNotice_ReleaseTime);
    	    	String t= new SimpleDateFormat("yyyy-MM-dd").format(time);
    %>    
		   <li>
		       <a href="bulletinAction?_id=<%=d.get(StaticString.SystemNotice_id)%>"><%=d.get(StaticString.SystemNotice_Title) %></a>
		       <br><%=t%>      
		    </li>
		    <%}} %> 
		</ol>
		
		<table>
	    <tr><td>共<%=pageCount%>页</td><td>第<%=pageNu%>页</td>
	    	<%if(pageNu!=1&&listId!=null&&listId.size()!=0){%>
	    	<td><a href="bulletinPreAction?pageNu=<%=pageNu %>&noticeidF=<%=listId.get(0)%>&noticeidL=<%=listId.get((listId.size()-1))%>&pageTag=0" name="prePage">上一页</a></td><%} %>	    	
	    	<%if(pageNu!=pageCount&&listId!=null&&listId.size()!=0) {%>
	    	<td><a href="bulletinNexAction?pageNu=<%=pageNu %>&noticeidF=<%=listId.get(0)%>&noticeidL=<%=listId.get((listId.size()-1))%>&pageTag=1" name="nexPage">下一页</a></td><%} %>    	
	    </tr>
--%>