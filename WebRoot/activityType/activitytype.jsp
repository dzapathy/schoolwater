<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="staticData.StaticString"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="bean.School"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
		<link rel="stylesheet" href="../css/activitytype.css" />
		<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
		
		<script type="text/javascript" src="../js/activitytype.js"></script>
		<script type="text/javascript">
		
			
		</script>
</head>
<style>
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}
#activitytype-fa{
    position:absolute;
	left:0px;
	top:0px;
	width:100%;
	height:1000px;
	z-index:1;
}




#activitytype-addtype1{
    position:relative;
	width:100px;
	float:right;
	margin-right:25px;
	height:25px;
	top: 35%;
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
#activitytype-top{
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
#activitytype-content{
    position:absolute;
	left:0%;
	top:80px;
	width:100%;
	height:900px;
	z-index:2;
}

#activitytype-content td{
    border-top:1px solid #ddd;
    height:80px;
    line-height:80px;
    width:100%;
}
#typetable{
    
}
.changetext{
    float:left;
    padding-left:125px;
    height:100%;
    
}

.deletype{
    position:relative;
    display:none;cursor:pointer;
    float:right;
    width:25px;
    top:30px;
   height:20px;
   margin-right:50px;
}
.changetype{
position:relative;
   width:25px;
   cursor:pointer;
   height:25px;
   float:right;
   top:30px;
   display:none;
   cursor:pointer;
   margin-right:100px;
}

#addtext{
    position:relative;margin-top:15px;
    float:right;
    margin-right:20px;
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
<body>
	<%
		//lyl添加获取管理员id,把LevelTopId转换成String
	    String levelId = (String)session.getAttribute("LevelTopId");
	 %>
	<%
		//遍历查找活动类型，存入activityList中
		String activityNameList ="";
		String activityIdList="";
  		School school = new School();
  		ObjectId orgaId = (ObjectId)session.getAttribute("Organization_SchoolId");
  		school.set_id(orgaId);
  		BasicDBObject q =CreateQueryFromBean.EqualObj(school);
		BasicDBObject p=new BasicDBObject();
		p.put(StaticString.School_InActivityCategoty, 1);
		MongoCursor<Document> m =DaoImpl.GetSelectCursor(School.class, q, p);
		Document doc = null;
		while(m.hasNext()){
			doc = m.next();
		}
		ArrayList<Document> list=(ArrayList<Document>)doc.get("InActivityCategoty");
		for(int i = 0; i<list.size(); i++){
			activityNameList+= ((String)list.get(i).get("Name"))+"~";
			activityIdList+=(String)list.get(i).get("_id").toString()+"~";
		}
  	 %>
 	<div style="display: none;" id ="levelId"><%=levelId %></div>
	<div id="activitytype-fa">
	    <div id="activitytype-top">
	         <div id="top-title">&nbsp;&nbsp;活动类型</div>
	         <div id="activitytype-addtype1">增加类型</div>
	    </div>
		<div id="activitytype-content">
			<table id="typetable" width="100%" border="0" cellspacing="0" cellpadding="0">
			    <tr>
			        <td style="display:none;"></td>
			    </tr>
			</table>		 
		</div>
	</div>
	<input type="hidden" id="actilist" value=<%=activityNameList %>>
	<input type="hidden" id="actiIdlist" value=<%=activityIdList %>>
	
	<div id="BgDiv"></div>
		<div id="DialogDiv" style="display:none">
			<div>
			  <input name ="oldType" type="hidden" id="oldTypeId" value=""/>
			  <div id="bgdiv-text">新类型名：</div>
		      <input name="addType" id="addtext" type="text" />
		      <div id = "quxiaodiv" >取&nbsp;&nbsp;消</div>
		      <div id = "closediv" >确&nbsp;&nbsp;定 </div>
			</div>
		</div>
	<script type="text/javascript">
		var actlist = $("#actilist").val();
		var actIdList =$("#actiIdlist").val();
		var array = new Array();
		array = actlist.split("~");
		var array1 = new Array();
		array1 = actIdList.split("~");
		for(var i = 0 ; i< array.length ;i++){
			if(array[i]!=""){
			$("#typetable").find("tr:first").after("<tr><td>"+
			        //"<div class='changetype'  style='position:absolute;display:none;cursor:pointer;top:0%;left:0%'>*</div>"+
					"<div class='changetext' ><span id='actname'>"+array[i]+"</span><span id='actid' style='display:none;'>"+array1[i]+"</span></div>"+
					"<div class='deletype'><img src='img/typedele.jpg' style='width:100%;height:100%;'/></div>"+
					"<div  class='changetype' ><img src='img/typechange.jpg' style='width:100%;height:100%;'/></div></td>"+
					"</tr>"
					
			       //"</div>"
			       );
		     $.addtypeid();  
		         
		    } 
			
		} 
		//lyl添加：设置权限
		$(function(){
			var isSurManager=$("#levelId").text();
			if(isSurManager != "000000000000000000000000"){
				//remove()
				$("#activitytype-addtype1").remove();
				$(".changetype").each(function(){
					$(this).remove();
				});
				$(".deletype").each(function(){
					$(this).remove();
				});
			}
		});		
		
		
		$(function(){
 			$("#activitytype-addtype1").live("mouseover",function(){
 				$(this).css("background-color","#3CB371");
 				$(this).css("border","1px solid #3CB371");
 			});
			$("#activitytype-addtype1").live("mouseout",function(){
				$(this).css("background-color","#90EE90");
				$(this).css("border","1px solid #90EE90");
			});
			
			
				$("#typetable").find("tr").live("mouseover",function(){
					$(this).css("background-color","#f7f7f7");
					$(this).find(".deletype").show();
					$(this).find(".changetype").show();
				});
				
				$("#typetable tr").live("mouseout",function(){
					$(this).find(".deletype").hide();
					$(this).find(".changetype").hide();
					$(this).css("background-color","#fff");
				});
				$("#typetable").find("tr:last").find("td").each(function(){
					$(this).css("border-bottom","1px solid #ddd");
				});
 		})
 		
 		
 		
 		
 		
 		

 		//lyl将删除按钮的ajax时间放到activitytype.js中了
			//更新，插入按钮的点击事件
			
			
			
			var show_index;
			var show_content;
			$(function(){
			    $(".changetype").live('click', function() {  
					var ind = $(this).parent().parent().index();
					show_index = ind;
					var parent = $(this).parent().parent();
					var data1 = parent.find(".changetext").children("#actid").text();
					$("#oldTypeId").val(data1);
					$.ShowDIV('DialogDiv');
				});
			});
			
			
			
			$(function(){
				$("#closediv").bind("click",function(){
					var oldType =$("#oldTypeId").val();
					var addType =$("#addtext").val();
					oldType = oldType.trim(oldType);
					addType =addType.trim(addType);
					if(addType==""){
						alert("请输入更改值再确定");
					}else{
						//lyl添加
						$.closeDiv('DialogDiv');
						$.showText();
						$.get("addType.action",{"oldType":oldType,"addType":addType},function(data){
							alert(data);
						});
					}
					//回归为""
					$("#oldTypeId").val("");
				});
			});
			
			



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

			$.extend({'ShowDIV':function(thisObjID){ 
			    $("#BgDiv").css({ display: "block", height: $(document).height() });
			    var yscroll = document.documentElement.scrollTop;
			    $("#" + thisObjID).css("top", "100px");
			    $("#" + thisObjID).css("display", "block");
			    $("#addtext").val(" ");
			    document.documentElement.scrollTop = 0;
			}});

			$.extend({'closeDiv':function(thisObjID){ 
				show_content = $("#addtext").val();
			    $("#BgDiv").css("display", "none");
			    $("#" + thisObjID).css("display", "none");
			}});

			$.extend({'quxiaodiv':function(thisObjID){ 
			    $("#BgDiv").css("display", "none");
			    $("#" + thisObjID).css("display", "none");
			    
			}});

			$.extend({'showText':function(){ 
				//如果是""证明是新加的类型取消
		    	var isoldnull = $("#oldTypeId").val();
				if(isoldnull != ""){
					$("#typetable").find("tr").eq(show_index).find(".changetext").html(show_content);
				}else{
					$("#typetable").find("tr").eq(1).find(".changetext").html(show_content);	
				}
			}});
			
			
			
			//button变色
			$(function(){
 			$("#quxiaodiv").live("mouseover",function(){
 				$(this).css("background-color","#A1A1A1");
 				$(this).css("border","1px solid #A1A1A1");
 			});
 			$("#closediv").live("mouseover",function(){
 				$(this).css("background-color","#3CB371");
 				$(this).css("border","1px solid #3CB371");
 			});
 			$("#quxiaodiv").live("mouseout",function(){
				$(this).css("background-color","#CCC");
				$(this).css("border","1px solid #CCC");
			});
			$("#closediv").live("mouseout",function(){
				$(this).css("background-color","#90EE90");
				$(this).css("border","1px solid #90EE90");
			});
 		})
	</script>
</body>
</html>
