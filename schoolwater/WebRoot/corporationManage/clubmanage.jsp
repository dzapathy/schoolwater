<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="staticData.StaticString"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="bean.Organization"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>社团管理</title>
	<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../js/maxlength.js"></script>
	<link rel="stylesheet" href="../css/clubmanage.css"/>
	<script src="../js/clubmanage.js"></script>
</head>
<style>
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}
#clubmanage-top{
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

#clubmanage-content1{
    position:absolute;
	width:100%;
	left: 0%;
	margin-top: 80px;
	height:150px;
    border-bottom:1px solid #eee;
}
#clubmanage-title1-1{
    position:relative;
	width:96%;
	left: 2%;
	top: 0px;
	height:40px;
	font-size:14px;
	line-height:40px;
	border:1px dashed #336699;
}
#clubmanage-title1-2{
    position:relative;
	width:200px;
	left: 2%;
	top: 25px;
	height:22.5px;
	border-left:5px solid #90EE90;
	border-top:0px;
	border-right:0px;
	border-bottom:0px;
	text-align:left;
	font-size:15px;
}

#clubmanage-addclub{
    position:relative;
	width:100px;
	left:87%;
	top: 0px;
	height:22.5px;
	border:1px solid #90EE90;
	text-align:center;
	cursor:pointer;
	background-color:#90EE90;
	color:#fff;
	-moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px; 
}
.clubmanage-nowallclub{
    position:absolute;
	left:5%;
	margin-top:20px;
	top:150px;
	width:13%;
	height:40px;
	line-height:30px;
}
.changeclubtext{
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
    cursor:pointer;
    font-size:14px;
    white-space:nowrap; /*禁止换行*/
	text-overflow:ellipsis; /*文本超出隐藏*/
	-o-text-overflow:ellipsis;/*跟上面一样，只是为了兼容其他浏览器*/ 
	overflow: hidden; /*隐藏，跟text-overflow配合使用*/
}
.deletclub{
}
.changeclub{
}

#clubmanage-delesome{
    position:relative;
    width:100px;
	float:left;
	top: 0px;
	height:25px;
	font-size:15px;
	border:1px solid #90EE90;
	text-align:center;
	line-height:25px;
	cursor:pointer;
	background-color:#90EE90;
	color:#fff;
	-moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px; 
}

#clubmanage-dosome {
	position:relative;
	top:245px;
	left:75%;
	width:250px;
	height:30px;
}
#clummanage-addper{
    position:relative;
    width:100px;
	float:right;
	margin-right:25px;
	top: 0px;
	height:25px;
	line-height:25px;
	font-size:15px;
	border:1px solid #90EE90;
	text-align:center;
	cursor:pointer;
	background-color:#90EE90;
	color:#fff;
	-moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px; 
}
#addpersonllz{
    text-decoration:none;
}

#clubmanage-members {
	position:relative;
	top:280px;
	left:0px;
	width:100%;
	height:500px;
}
#clubmanage-members td{
    height:80px;
    font-size:14px;
}

<!-- 以下是content2 -->




#clubmanage-content2 {
	position:relative;
	top:250px;
	width:100%;
	height:200px;
}
#clubmanage-title2-2 {
	position:relative;
	top:270px;
	left:2%;
	width:200px;
	height:22.5px;
    border-left:5px solid #90EE90;
	border-top:0px;
	border-right:0px;
	border-bottom:0px;
	text-align:left;
	font-size:15px;
}

#quxiaodiv{
    cursor:pointer;
    position:relative;
    width:100px;
	float:left;
	margin-left:25px;
	top: 25px;
	height:25px;
	font-size:15px;
	border:1px solid #CCC;
	text-align:center;
	line-height:25px;
	cursor:pointer;
	background-color:#CCC;
	color:#fff;
	-moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px; 
}
#addtext{
    position:relative;margin-top:15px;
    margin-right:20px;
    float:right;
    border:1px solid #ccc;padding:2px;border-radius:1px;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset;outline:medium none;line-height:25px;
    -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    font-family:"Microsoft YaHei",Verdana,Arial;
    font-size:14px;
	width:300px;
	padding-left:15px;
	color:#515151;
    }

#bgdiv-text{
    position:relative;
    float:left;
    margin-left:10px;
    margin-top:20px;
    font-size:14px;
    width:100px;
}
#closediv{
    cursor:pointer;
    position:relative;
    width:100px;
	float:right;
	margin-right:20px;
	top: 17px;
	height:25px;
	line-height:25px;
	font-size:15px;
	border:1px solid #90EE90;
	text-align:center;
	cursor:pointer;
	background-color:#90EE90;
	color:#fff;
	-moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px; 
}

</style>
<%!
  	//已获取到下属组织名字存于organizationNameList中
  	String organizationNameList=""; 
  	String organazaitonIdList="";
%>
<body>
<script type="text/javascript">
	//删除下属组织
	$(document).ready(function(){
		$(document).on("click",".deletclub",function(){
			var parent = $(this).parent();
			var data = parent.find(".changeclubtext").children("#clubidllz").text();
			if(data==""){}else{
				$.get("deleteClub.action",{"deleteClub":data},function(data){
					if(data=="true"){
						alert("删除成功");
					}else{
						alert("删除失败");
					}
				});
			}
		});
	});
	//更改或新增组织
	$(document).ready(function(){
	$(document).on("click",".changeclub",function(){
		var parent = $(this).parent();
		var data1 = parent.find(".changeclubtext").children("#clubidllz").text();
		$("#oldClub").val(data1);
	});
	});
</script>
<div id="clubmanage-fa">
    <div id="clubmanage-top">
	         <div id="top-title">&nbsp;&nbsp;社团管理</div>
	    </div>
	<%
    	//查找下属组织
    	organizationNameList="";
    	organazaitonIdList="";
    	String organId =(String)session.getAttribute("Organization_id");
    	Organization organization = new Organization();
	    organization.setLevelTopId(new ObjectId(organId));
	    BasicDBObject basicDBObject = CreateQueryFromBean.EqualObj(organization);
	    BasicDBObject projection = new BasicDBObject();
	    projection.put(StaticString.Organization_Name, 1);
	    projection.put(StaticString.Organization_id, 1);
	    MongoCursor<Document> cursor =DaoImpl.GetSelectCursor(Organization.class, basicDBObject, projection);
	    while(cursor.hasNext()){
	     	Document document = cursor.next();	     		
			organizationNameList += document.get("Name")+"~";
			organazaitonIdList += document.get("_id").toString()+"~";
		}
		//session.setAttribute("mapList", map);
     %>
    <div id="clubmanage-content1">
        <div id="clubmanage-title1-1">&nbsp;&nbsp;&nbsp;&nbsp;注意：您是<%=session.getAttribute("Organization_Name")%>负责人，只能创建您的直接下属机构，
                                                 并直接任命下属负责人。当点击下属机构时，会出现相应的负责人名单</div>
		<div id="clubmanage-title1-2"> &nbsp;&nbsp;当前下属机构</div>
		<div id="clubmanage-addclub">增加部门</div>
	</div>
   <div id="clubmanage-content2"  style="display:none;">
       <div id="clubmanage-title2-2">&nbsp;&nbsp;<span id="bumen"></span>负责人管理</div><span id="bumenid" style="display: none;"></span>
	   
	   <div id="clubmanage-dosome">
	       <div id="clubmanage-delesome" disabled="disabled">删除选中项</div>
		   <a href="clubbond.jsp" id ="addpersonllz" style="display: none;">
		          <div id="clummanage-addper">新增负责人</div></a>
	   </div>	   
	   <div id="clubmanage-members">
		    <table width="100%"  border="0" cellspacing="0" cellpadding="0" id="clubmanage-membertable">
		        <tr>
			        <td  align="center" style="width:100px;cursor:pointer;">全选</td>
		            <td  align="center" style="">序号</td>
			        <td  align="center" style="">负责人姓名</td>
			        <td  align="center" style="">用户名</td>
		        </tr>					
			</table>			
		</div>
    </div>	
</div>
<s:fielderror name="deleteMsg"></s:fielderror>
<input type="hidden" id="clubList" value=<%=organizationNameList%>>
<input type="hidden" id="clubidList" value=<%=organazaitonIdList%>>
<div id="BgDiv"></div>
<div id="DialogDiv" style="display:none">
<form action="addClub" method="get">
	  <input type="hidden" id="oldClub" name="oldClub">
	  <div id="bgdiv-text">新组织名：</div>
	  <input name="newClub" id="addtext" type="text" data-maxsize="7"/>
	  <div id = "quxiaodiv" >取&nbsp;&nbsp;消</div>
      
      <input  type="submit"  id = "closediv" value="确定修改" />
</form>
</div>
<script type="text/javascript">
	$(function(){
		$(".changeclubtext").live("click",function(){
			if($(this).html()!=""){
				var setsubmitH1 = $("#clubmanage-content1").height()+100+"px";
				var setsubmitH2 = $("#clubmanage-content1").height()+70+"px";
				$("#clubmanage-title2-2").css("top",setsubmitH1);
				$("#clubmanage-dosome").css("top",setsubmitH2);
			$("#clubmanage-content2").show();
			var clubname =$(this).children("#clubnamellz").text();
			var clubid =$(this).children("#clubidllz").text();
			$("#bumen").text(clubname);
			$("#bumenid").text(clubid);
			$("#clubmanage-delesome").removeAttr("disabled");
			$("#addpersonllz").show();
			$("#addpersonllz").attr("href","clubbond.jsp?clubname="+clubname+"&clubid="+clubid);
			var organizationId =$(this).children("#clubidllz").text();
			$.get("getClubManager.action",{"organizationId":organizationId},function(data){				
				var dataObj = JSON.parse(data);
				$("#clubmanage-membertable tr:not(':first')").remove();
				$.each(dataObj,function(i,item){
					var $tr ="<tr>"
							+"<td align='center'>"
							+"<input name='deleteChoose' type='checkbox' value="+i+" style = 'width:20px;height:20px' />"
							+"</td>"
							+"<td  align='center'>"+(i+1)+"</td>"
							+"<td  align='center'>"+item.name+"</td>"
				    		+"<td  align='center'>"+item.userId+"</td>"
				    		+"</tr>";
			     	$("#clubmanage-membertable tr:last").after($tr);
			     	//加线
			     	$("#clubmanage-members").find("tr:last").find("td").each(function(){
						$(this).css("border-bottom","1px solid #eee");
					});
				});
			});
			}else{
				alert("请先输入数据");
			}
		});
	});

	//删除管理员
	 $("#clubmanage-delesome").click(function(){
		var chk_value =[];
		var orgId = $("#bumenid").text(); 
		$('input[name="deleteChoose"]:checked').each(function(){ 
			chk_value.push($(this).parent().parent().children("td:eq(3)").text());	
		});
		if(chk_value.length==0){
			alert("你还没有选择任何内容！");
		}else{
			var deleteStr="";
			for(var i =0;i<chk_value.length;i++){
				deleteStr+=chk_value[i]+"~";
			}
			$.get("clubManager.action",{"chk_value":deleteStr,"orgId":orgId},function(data){
				if(data=="true"){
					var setsubmitH1 = $("#clubmanage-content1").height()+100+"px";
					var setsubmitH2 = $("#clubmanage-content1").height()+70+"px";
					$("#clubmanage-title2-2").css("top",setsubmitH1);
					$("#clubmanage-dosome").css("top",setsubmitH2);
					alert("删除成功");
				}else{
					alert("删除失败");
				}
			});
		} 
	});

    var num=1;
	var clubList = $("#clubList").val();
	var clubIdList = $("#clubidList").val();
	var array = new Array();
	array = clubList.split("~");
	var array1 = new Array();
	array1 = clubIdList.split("~");
	if(array.length==1&&array[0]==""){
	}else{
		for(var i = 0 ; i< array.length;i++){
		if(array[i]!=""){
			 $("#clubmanage-addclub").after("<div id='clubmanage-nowsoloclub"+num+"' class='clubmanage-nowallclub' >"+
                "<div class='changeclub'  style='position:absolute;display:none;cursor:pointer;top:10%;height:80%;left:0%;width:20px;height:24px;'><img src='img/clubmchange.jpg' style='width:100%;height:100%;'/></div>"+
				"<div class='changeclubtext' style='cursor:pointer;position:absolute;width:60%;left:20%;top:10%;height:80%;text-align:center;border:1px solid #CCCCCC;'><span id='clubnamellz'>"+array[i]+"</span><span id='clubidllz' style='display:none;'>"+array1[i]+"</span></div>"+
                "<div class='deletclub' style='position:absolute;display:none;cursor:pointer;top:10%;height:80%;right:0%;width:20px;height:24px;'><img src='img/clubmdele.jpg' style='width:100%;height:100%;'/></div>"+
          "</div>");		  
		  var getnum = $(".clubmanage-nowallclub").size();
		  if(getnum%6 == 0){
		      var setsubmitH = $("#clubmanage-content1").height()+45+"px";
		      $("#clubmanage-content1").css("height",setsubmitH);
			  $("#clubmanage-content2").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-content1").height()+30+"px";
			  $("#clubmanage-dosome").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-content1").height()+80+"px";
			  $("#clubmanage-members").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-content1").height()+10+"px";
			  $("#clubmanage-title2-2").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-fa").height()+45+"px";
			  $("#clubmanage-fa").css("height",setsubmitH);
		  	}		  		 
		  }		 
		}
		$.sortnowallclub();
	}
	
	$(function(){
		$("#clubmanage-members").find("tr:first").find("td").each(function(){
			$(this).css("border-bottom","1px solid #eee");
			$(this).css("border-top","1px solid #eee");
		});
		
		$("#clubmanage-members").find("tr:gt(0)").live("mouseover",function(){
			$(this).css("background-color","#f7f7f7");
		});
		$("#clubmanage-members").find("tr:gt(0)").live("mouseout",function(){
			$(this).css("background-color","#fff");
		});
	})
	
	//增加动态button
	$(function(){
		$("#clubmanage-addclub").live("mouseover",function(){
			$(this).css("background-color","#3CB371");
			$(this).css("border","1px solid #3CB371");
		});
		$("#clubmanage-delesome").live("mouseover",function(){
			$(this).css("background-color","#3CB371");
			$(this).css("border","1px solid #3CB371");
		});
		$("#clummanage-addper").live("mouseover",function(){
			$(this).css("background-color","#3CB371");
			$(this).css("border","1px solid #3CB371");
		});
		$("#clubmanage-addclub").live("mouseout",function(){
			$(this).css("background-color","#90EE90");
			$(this).css("border","1px solid #90EE90");
		});
		$("#clubmanage-delesome").live("mouseout",function(){
			$(this).css("background-color","#90EE90");
			$(this).css("border","1px solid #90EE90");
		});
		$("#clummanage-addper").live("mouseout",function(){
			$(this).css("background-color","#90EE90");
			$(this).css("border","1px solid #90EE90");
		});
	})
	
	
	$(function(){
	    $("#quxiaodiv").live('click', function() {
	    	//如果是""证明是新加的类型取消
	    	var isoldnull = $("#oldTypeId").val();
	    	if(isoldnull == ""){
	    		$("#typetable").find("tr").eq(1).remove();
	    		$.addtypeid();
	    	}
	    	//回归为""
			$("#oldTypeId").val("");
			$.closeDiv('DialogDiv');
		});
	});
	
	
	//点击改变changeclubtext颜色
	$(function(){
		$(".changeclubtext").live("click",function(){
			$(this).css("background-color","#e1e1e1");
			var tempindex = $(this).parent().index();
			$(".changeclubtext").each(function(){
				if($(this).parent().index() != tempindex){
					$(this).css("background-color","#fff");
				}
			});
		});
		
	});
</script>
</body>
</html>
