<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="bean.TableInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" href="../css/actmanagesendnews.css" />
<!-- 引入富文本编辑器 -->
    <script type="text/javascript" charset="utf-8" src="../createActivity/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../createActivity/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="../createActivity/lang/zh-cn/zh-cn.js"></script>
</head>
<style>
body{
	height:940px;
	font-family:"微软雅黑";
	color:#515151;
}
#actmanagesendnews-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:940px;
}

#actmanagesendnews-content1{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:300px;
}
#actmanagesendnews-content1 td{
	height:80px;
	padding-left:20px;
	font-size:15px;
	color:#515151;
	border-bottom:1px solid #ddd;
}

#actmanagesendnews-content1    input[type=text],input[type=password],textarea{border:1px solid #ccc;padding:2px;border-radius:1px;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset;outline:medium none;line-height:25px;
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
#actmanagesendnews-content1 input[type=text]:focus,input[type=password]:focus,textarea:focus{/*border-color:rgba(82,168,236,0.8);*/border-color:#52a8ec;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset,0 0 5px rgba(82,168,236,0.6);outline:0 none;}
#actmanagesendnews-content1 select{
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
 
 #actmanagesendnews-content2{
    position:absolute;
	width:100%;
	left:0px;
	top: 300px;
	height:250px;
}

#suretosent{
    position:relative;
	width:100px;
	float:right;
	height:30px;
	color:#fff;
    background-color:#1C90F2;
    border:1px solid #1C90F2;
    cursor:pointer;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
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
	projection.put("_id", 1);
	projection.put("Name", 1);
	MongoCursor<Document> mc = DaoImpl.GetSelectCursor(TableInfo.class, query, projection);
	tableList = new ArrayList<Document>();
	while(mc.hasNext()) {
		tableList.add(mc.next());
	}
 %>

<body>
<div id="actmanagesendnews-fa">
	<form action="activityNews.action" method="post" enctype="multipart/form-data" >
    
	<div id="actmanagesendnews-content1">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="actmanagesendnews-membertable">
		        <tr>
			        <td  align="left" style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;通知标题：</div></td>
		            <td  align="left" style="width:85%;">
					    <input name = "name"  type="text"  />
					</td>
		        </tr>
				<tr>
			        <td  align="left" style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;通知群体：</div></td>
		            <td  align="left" style="width:85%;">
					    <select name="tableId">
				   	<%
				   	int i = 0;
				   	for (i = 0 ;i < tableList.size() ;i++){ %>
				   		<option value=<%=tableList.get(i).get("_id") %>><%=tableList.get(i).get("Name")%></option>
				   <%} %>
				   </select>
					</td>
		        </tr>
				<tr>
			        <td  align="left" style="width:15%;"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;通知内容：</div></td>
		            <td  style="width:85%;padding-right:20px;" align="right" >
					    <input type="submit" value="确认发送" id="suretosent" />
					</td>
		        </tr>
		</table>
	</div>
	<div id="actmanagesendnews-content2">
	    <script id="editor" type="text/plain" style="width:99.8%;height:300px;  "></script>
	    <input type="hidden" name="content" id="content"/>
	</div>
	</form>
</div>
<script type="text/javascript">
	
    //实例化富文本编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
    //时时获取富文本编辑器里面的内容
    var int=self.setInterval("getContent()",1000);
    function getContent(){
        var context=UE.getEditor('editor').getContent();
      	document.getElementById("content").value= context;    	
    }  
    
    $(function(){
    	$("#editor").css("height","200px");
    });
</script>
</body>
</html>
