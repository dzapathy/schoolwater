<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="com.mongodb.BasicDBObject,com.dao.*,bean.*,com.mongodb.client.MongoCursor,org.bson.Document" %>
<%@ page import="staticData.*,java.text.*,org.bson.types.ObjectId" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>留言反馈</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <!-- 引入jQuery -->
    <script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
  </head>
  <style type="text/css">
body{
    height:1000px;
	font-family:"微软雅黑";
}
#feedback-fa{
	position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:1000px;
}
#feedback-top{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:80px;
}
#feedback-end{
    position:absolute;
	width:100%;
	left: 0px;
	top: 220px;
	height:760px;
	
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
#tijiaocontext{
    position:absolute;
    width:100px;
    right:2%;
	top: 30%;
	bottom:30%;
	color:#fff;
    background-color:#1C90F2;
    border:1px solid #1C90F2;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
    cursor:pointer;
}

#feedback-mid{
    position:absolute;
    margin-top:80px;
    width:100%;
    height:100px;
}
#textcon{
    position:relative;
    margin-left:2%;
    margin-right:2%;
    width:96%;
    height:100%;
    resize: none;
    color:#999;
    font-size:14px;
    font-family:"微软雅黑";
}

#feedback-end td{
    border-top:1px solid #eee;
    height:85px;
    padding-left:20px;
    padding-right:20px;
    color:#515151;
    font-size:14px;
}
#feedback-end tr:hover{
    background-color:#f7f7f7;
}

.feedback-a{
    text-decoration:none;
    color:#1C90F2;
    cursor:pointer;
}
</style>

<%!int pageNu=1; int pageCount=0; int pageSize=10;
    	ObjectId oIdlast=null;
    	ObjectId oIdfirst=null;
    	Boolean flag;
  %>
  <body>
  	<div id="feedback-fa">
    <div id="feedback-top">
	    <div id="top-title">&nbsp;&nbsp;反馈留言</div>
	    <input type="button" value="提&nbsp;&nbsp;交" id ="tijiaocontext">
	</div>     	
    <div id="feedback-mid">
    	<textarea name="content" id="textcon"></textarea>
    </div> 
    <script type="text/javascript">
    	$(function(){
    		$("#tijiaocontext").bind("click",function(){
    			var content =$("[name=content]").val().trim();
    			if(content==""){
    				alert("请输入内容");
    				$("[name=content]").val("");
    			}else{
    			$.post("feedback",{content:content},function(data){
    				if(data=="true"){
    					alert("反馈成功");
    					window.location.href="feedback.jsp";
    				}else{
    					alert("反馈失败");
    				}
    			});
    			}
    		});
    	});
    </script> 
    
    <div id="feedback-end">
    	<table width="100%"  border="0" cellspacing="0" cellpadding="0">   
    <% 	 	
    	//获取总数，计算总页数
    	BasicDBObject query=new BasicDBObject();
    	int suggestionNum=(int)DaoImpl.GetSelectCount(Suggestion.class, query);//请求数
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
        ArrayList<Document> list=new ArrayList<Document>();
        if(pageNu==1){
        	BasicDBObject projection=new BasicDBObject();
			BasicDBObject q=new BasicDBObject();
			BasicDBObject sort=new BasicDBObject();
			sort.put(StaticString.Suggestion_id, -1);
			MongoCursor<Document> mc=DaoImpl.GetSelectCursor(Suggestion.class, q, sort,pageSize, projection);
        	while(mc.hasNext()){
        		list.add(mc.next());
        	}
        	flag=true;
        }else{
        		
        	BasicDBObject projection=new BasicDBObject();

        	Suggestion sg=new Suggestion();
        	int pageTag=(Integer)request.getAttribute("pageTag");
        	BasicDBObject q;
        	BasicDBObject sort=new BasicDBObject();
			
        	if(pageTag==0){
         	//上一页
        		oIdfirst=new ObjectId((String)request.getAttribute("oIdfirst"));
        		sg.set_id(oIdfirst);
        		q=CreateQueryFromBean.GtObj(sg);
        		sort.put(StaticString.Suggestion_id, 1);
        		flag=false;
        	}
			else{
			//下一页
				oIdlast=new ObjectId((String)request.getAttribute("oIdlast"));
				sg.set_id(oIdlast);
				q=CreateQueryFromBean.LtObj(sg);
				sort.put(StaticString.Suggestion_id, -1);
				flag=true;
			}
			
			MongoCursor<Document> mc=DaoImpl.GetSelectCursor(Suggestion.class, q, sort,pageSize, projection);
        	while(mc.hasNext()){
        		list.add(mc.next());
        	}
        }
       
        if(list!=null&&list.size()!=0&&flag){
    	    for(int i=0;i<list.size();i++){
    	    	Document d=list.get(i);
    	    	if(i==(list.size()-1)){  
    	    		oIdlast=(ObjectId)d.get(StaticString.Suggestion_id);
    	    		
    	    	}else if(i==0){
    	    		oIdfirst=(ObjectId)d.get(StaticString.Suggestion_id);

    	    	}		
    	    	Date time=(Date)d.get(StaticString.Suggestion_ReleaseTime);
    	    	String t= new SimpleDateFormat("yyyy-MM-dd").format(time);
    %>  
        <tr>
	    	<td style="list-style-type:none;"> 
	    	<span style="float:left;">
	     		<%=d.get(StaticString.Suggestion_From) %></span>
	     		<label>
	     	<span style="float:right;">
	         	<%=t %>
	        </span> 	
	         	</label><br>
	         
	    		<label>
	    	<span style="float:left;">	
	    		<%=d.get(StaticString.Suggestion_Content)%></label>
	    	</span>
	        </td>
	    </tr>
	    <%
	    	}
    	}
    	else{
	    	for(int i=list.size()-1;i>=0;i--){
    	    	Document d=list.get(i);
    	    	if(i==(list.size()-1)){  
    	    		oIdfirst=(ObjectId)d.get(StaticString.Suggestion_id);
    	    		
    	    	}else if(i==0){
    	    		oIdlast=(ObjectId)d.get(StaticString.Suggestion_id);

    	    	}		
    	    	Date time=(Date)d.get(StaticString.Suggestion_ReleaseTime);
    	    	String t= new SimpleDateFormat("yyyy-MM-dd").format(time);
    %>   
         <tr>
	    	<td style="list-style-type:none;"> 
		   <%=d.get(StaticString.Suggestion_From) %>&nbsp;&nbsp;&nbsp;&nbsp;<label><%=t %></label><br>
		    	<label><%=d.get(StaticString.Suggestion_Content)%></label>
		   </td>
	    </tr>
		    <%
		    	}
    	}
    %>	
    	
    </tr>
 
	  <tr>
	  
	  <td>
	  <span style="float:right;font-size:12px;">
	          共<%=pageCount%>页 | 第<%=pageNu%>页
	          &nbsp;&nbsp;&nbsp;&nbsp;
	    	<%if(pageNu>1&&oIdfirst!=null){
	    	//上一页
	    		int pageTag=0;%>
	    	<a class="feedback-a" href="feedbackPreNext?pageNu=<%=pageNu-1%>&oIdfirst=<%=oIdfirst%>&pageTag=<%=pageTag%>">上一页</a><%} %>	    	
	    	<%if(pageNu<pageCount&&oIdlast!=null) {
	  		//	下一页
	  			int pageTag=1;%>	  	
	    	<a class="feedback-a" href="feedbackPreNext?pageNu=<%=pageNu+1%>&oIdlast=<%=oIdlast%>&pageTag=<%=pageTag%>">下一页</a></td><%} %> 	
	    	</span>  
	    </tr>
	  	</table>     
    </div>
    
    </div>    
  </body>
</html>
