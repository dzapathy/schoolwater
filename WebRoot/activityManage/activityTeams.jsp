<%@page import="staticData.StaticString"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="bean.TeamInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
<link rel="stylesheet" href="../css/actmanageallteam.css" />
<script src="../js/actmanageallteam.js"></script>
</head>
<style>
body{
	height:950px;
	font-family:"微软雅黑";
	color:#515151;
}
#actmanageallteam-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:950px;
}

#actmanageallteam-content1{
    position:absolute;
	width:965px;
	left: 30px;
	top: 10px;
	height:100px;
	border-bottom:1px solid #CCC;
}
#actmanageallteam-content1 td{
    
}
#actmanageallteam-content1 select{
     -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    height:30px;
    vertical-align:top;
	width:270px;
	 border-radius:5px; /*some css3*/
    -moz-border-radius:5px;
    -webkit-border-radius:5px;
    box-shadow:0 2px 2px rgba(0,0,0, .1);
    -moz-box-shadow:0 2px 2px rgba(0,0,0, .1);
    -webkit-box-shadow:0 2px 2px rgba(0,0,0, .1);
 }
 #dosearch{
    position:relative;
	text-align:center;
	margin-left:30%;
	height:25px;
	line-height:25px;
	width:100px;
    color: #336699;
	border:1px solid #CCCCCC;
	font-size:14px;
}
#dosearch:hover{
    background:#E1E1E1;
	cursor:pointer;
}
 #doout{
    position:relative;
	text-align:center;
	margin-left:30%;
	height:25px;
	line-height:25px;
	width:100px;
    color: #336699;
	border:1px solid #CCCCCC;
	font-size:14px;
}
#doout:hover{
    background:#E1E1E1;
	cursor:pointer;
}

#actmanageallteam-content3{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:950px;
	z-index:1;
}
#actmanageallteam-content3 td{
    border-top:1px solid #ddd;
    height:80px;
    font-size:15px;
}



.searchmemberinfo {
    position:relative;
	text-align:center;
	height:25px;
	line-height:25px;
	width:50px;
    color: #336699;
	border:1px solid #ccc;
	font-size:14px;
	float:left;
	margin-left:10%;
}
.searchmemberinfo:hover{
    background:#E1E1E1;
	cursor:pointer;
}

.delememberinfo {
    position:relative;
	text-align:center;
	height:25px;
	line-height:25px;
	width:50px;
    color: #336699;
	border:1px solid #ccc;
	font-size:14px;
	float:right;
	margin-right:10%;
}
.delememberinfo:hover{
    background:#E1E1E1;
	cursor:pointer;
}

#actmanageallteam-memberinfo{
    position:absolute;
	width:0px;
	left:99.5%;
	top: 80px;
	height:530px;
	border:1px solid #CCC;
	background:#FFF;
	z-index:10;
}
#actmanageallteam-memberinfo-close{
    position:absolute;
	width:20px;
	left:830px ;
	top: 0px;
	height:20px;
	text-align:center;
	line-height:20px;
	cursor:pointer;
}

#actmanageallteam-memberinfo-content1{
    position:absolute;
	width:98%;
	left:1%;
	top: 30px;
	height:50px;
	
	line-height:20px;

}
#actmanageallteam-memberinfo-dosome{
    position:relative;
	top:10px;
	left:10px;
	height:50px;
	width:100%;
	
}
#actmanageallteam-memberinfo-membertable td{
	border-top:1px solid #ddd;
    height:50px;
    font-size:14px;
}

			   
.actmanageallteam-memberinfo-button{
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
</style>
<%
	String activityId = (String)session.getAttribute("SelectedActivityId");
	
	TeamInfo teamInfo = new TeamInfo();
	teamInfo.setActivityId(new ObjectId(activityId));
	BasicDBObject query = CreateQueryFromBean.EqualObj(teamInfo);
	BasicDBObject projection = new BasicDBObject();
	projection.put("_id", 1);
	projection.put("Name", 1);
	projection.put("LeaderName", 1);
	projection.put("Abstract", 1);
	projection.put("Need", 1);
	
	MongoCursor<Document> mongoCursor = DaoImpl.GetSelectCursor(TeamInfo.class, query, projection);
	ArrayList<Document> teamInfos = new ArrayList<Document>();
	while(mongoCursor.hasNext()) {
		teamInfos.add(mongoCursor.next());
	}
 %>

<body>
<div id="actmanageallteam-fa">
	<div id="actmanageallteam-content3">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0" id="actmanageallteam-membertable">
		        <tr>
		            <td  align="center" style="width:5%;">序号</td>
			        <td  align="center" style="width:20%;">团队名</td>
			        <td  align="center" style="width:20%;">负责人</td>
					<td  align="center" style="width:20%;">简介</td>
					<td  align="center" style="width:20%;">需要</td>
					<td  align="center" style="width:15%;">详细</td>
		        </tr>
		        
		        <%
		        	if(teamInfos.size() != 0 && teamInfos != null) {
		        		for(int i = 0; i < teamInfos.size(); i++) {
		        			Document document = teamInfos.get(i);
		        		%>
							<tr>
		            			<td  align="center" style="width:5%;"><%=i+1 %></td>
			       				<td  align="center" style="width:20%;"><%=document.get("Name") %></td>
			        			<td  align="center" style="width:20%;"><%=document.get("LeaderName") %></td>
								<td  align="center" style="width:20%;"><%=document.get("Abstract") %></td>
								<td  align="center" style="width:20%;"><%=document.get("Need") %></td>
								<td  style="width:15%;">
					    			<div class="searchmemberinfo" id=<%=document.get("_id") %>>查看</div>
					    			<div class="delememberinfo" id=<%=document.get("_id") %>>删除</div>
								</td>
		    			    </tr>
		        		<%
		        		}
		        	}
		         %>
		        
				
			
				
			</table>
	</div>
	<div id="actmanageallteam-memberinfo" style=" display:none;">
	    <div id="actmanageallteam-memberinfo-close">
			<img src="img/deleinfo.png" width="100%" height="100%" />
		</div>
		<div id="actmanageallteam-memberinfo-content1">
		    <div id="actmanageallteam-memberinfo-dosome">
	           <input type="button" value="删除选中项" id="actmanageallteam-memberinfo-delesome" class="actmanageallteam-memberinfo-button"/>
		    </div>
		   <div id="actmanageallteam-memberinfo-members">
		     <table width="100%"  border="0" cellspacing="0" cellpadding="0" id="actmanageallteam-memberinfo-membertable">
		        <tr>
			        <td  align="center" style="cursor:pointer;width:10%;">全选</td>
		            <td  align="center" style="width:10%;">序号</td>
			        <td  align="center" style="width:15%;">姓名</td>
			        <td  align="center" style="width:15%;">学号</td>
			        <td  align="center" style="width:15%;">专业</td>
			        <td  align="center" style="width:15%;">电话</td>
					<td  align="center" style="width:10%;">学历</td>
					<td  align="center" style="width:10%;">申请状态</td>
		        </tr>
			</table>
		  </div>
		</div>

		</div>
</div>
</body>
<script type="text/javascript">
var havenanimate = 0;
$(function(){
    $(".searchmemberinfo").live("click",function(){
	    if(havenanimate == 0){
		    havenanimate = 1;
		    $.get("activityTeamsSearch.action",{
		    	"teamInfoId":$(this).attr("id")
		    	},function(data){
		    		var dataObj = JSON.parse(data);
		    		$("#actmanageallteam-memberinfo-membertable tr:not(':first')").remove();
		    		$.each(dataObj,function(i, item){
		    			var tempState = item.State;
		    			if(tempState == 0){
		    				tempState = "待审核";
		    			}else{
		    				tempState = "审核通过";
		    			}
		    			$("#actmanageallteam-memberinfo-membertable tr:last").after(
		    				"<tr><td  align='center' style='width:10%;'><input name='' type='checkbox' value='' style = 'width:20px;height:20px' /></td>"+
		            		"<td  align='center' style='width:10%;'>"+(i+1)+"</td>"+
			        		"<td  align='center' style='width:15%;'>"+item.Name+"</td>"+
			        		"<td  align='center' style='width:15%;'>"+item.IdCard+"</td>"+
			         		"<td  align='center' style='width:15%;'>"+item.MajorName+"</td>"+
			               	"<td  align='center' style='width:15%;'>"+item.Phone+"</td>"+
			        		"<td  align='center' style='width:10%;'>"+item.Degree+"</td>"+
			        		"<td  align='center' style='width:10%;'>"+tempState+"</td></tr>"
		    			);
		    		
		    		});
					
		    		$("#actmanageallteam-memberinfo-members").find("tr").each(function(){
			        	$(this).find("td").each(function(){
			        		$(this).css("border-bottom","0px solid #ddd");
			        	});
			        });
			        $("#actmanageallteam-memberinfo-members").find("tr:last").find("td").each(function(){
			        	$(this).css("border-bottom","1px solid #ddd");
			        });
		    
			      //进入查看时，根据tr个数调整memberinfo高度

					
					var infosize = $("#actmanageallteam-memberinfo-members").find("tr").size()-1;//减去开头
					if(infosize <= 7){
						$("#actmanageallteam-memberinfo").css("height","530px");
					}else{
						var tempheight = 530+(50*infosize-7);
						$("#actmanageallteam-memberinfo").css("height",tempheight+"px");
					}
		    });
		    
			$("#actmanageallteam-memberinfo").show();
	        $("#actmanageallteam-memberinfo").animate(
			    {
				    width: '+=850px',
					left: '-=850px'
				}, 'slow');
			
		   
		}
	});
});

//<!-- 关闭查看详细信息 -->
$(function(){
    $("#actmanageallteam-memberinfo-close").live("click",function(){
	    if(havenanimate == 1){
		    havenanimate = 0;	
			//<!-- 删除没保存的东西 -->
			if($("#actmanageallteam-memberinfo-membertable").find("[type='text']").is(":visible")){
			    $("#actmanageallteam-memberinfo-membertable tr:last").remove();
			}
			$("#actmanageallteam-memberinfo").animate(
			    {
				    width: '0px',
					left: '+=850px'
				}, 'slow');
			setTimeout(function(){
			    $("#actmanageallteam-memberinfo").hide();
			},500);
			 
		}
	});
});

//<!-- 删除选中人员 -->
$(function(){
    $("#actmanageallteam-memberinfo-delesome").live('click', function() {
	    $("#actmanageallteam-memberinfo-membertable tr").each(function(){
		     if($(this).find("[type='checkbox']").attr("checked")){
		     	var flag = true;
		     	if($(this).find("[type='text']").is(":visible")) {
					flag = false;		     	
		     	}
		     	if(flag) {
		     		alert($(this).find("td").eq(3).html());
		     		$.get("activityTeamsDelMember.action",{
		     			delIdCard:$(this).find("td").eq(3).html()
		     		},function(data){
		     			alert(data);
		     			
		     			//横线位置调整
		     			$("#actmanageallteam-memberinfo-members").find("tr").each(function(){
				        	$(this).find("td").each(function(){
				        		$(this).css("border-bottom","0px solid #ddd");
				        	});
				        });
				        $("#actmanageallteam-memberinfo-members").find("tr:last").find("td").each(function(){
				        	$(this).css("border-bottom","1px solid #ddd");
				        });
		     		});
		     	
		     	}
		     
		     
			     $(this).remove();
				  if($("#actmanageallteam-memberinfo-members").find("td:first").html() == "取消"){
	                 $("#actmanageallteam-memberinfo-members").find("td:first").html("全选");
		          }
			 }
		});
		var num = 0;
		$("#actmanageallteam-memberinfo-membertable tr:gt(0)").each(function(){
		    num++;
		    $(this).find("td:eq(1)").html(num);
		});
	});
});



//<!-- 全选 -->
$(function(){
    $("#actmanageallteam-memberinfo-members").find("td:first").live('click', function() {
	    if($(this).html() == "全选"){
	        $(this).html("取消");
		}
		else{
		    $(this).html("全选");
		}
	    $("#actmanageallteam-memberinfo-membertable tr").find("td:first").each(function(){
		    if($(this).find("[type='checkbox']").attr("checked")){
		         $(this).find("[type='checkbox']").attr("checked", false);
			 }
			 else{
			     $(this).find("[type='checkbox']").attr("checked", true);
			 }
			
		});
	});
});

$(function(){
    $(".delememberinfo").live("click",function(){
    	$(this).parent().parent().remove();
    	var num = 0;
		$("#actmanageallteam-membertable tr:gt(0)").each(function(){
		    num++;
		    $(this).find("td:eq(0)").html(num);
		});
		$.get("activityTeamsDel",{
			"teamInfoId":$(this).attr("id")
		},function(data){
			alert(data);
		});	    	
    });
    
});

$(function(){
	$("#actmanageallteam-membertable").find("tr:last").find("td").each(function(){
		$(this).css("border-bottom","1px solid #ddd");
	});
});



//颜色变换1
$(function(){
	$("#actmanageallteam-membertable").find("tr:gt(0)").live("mouseover",function(){
		$(this).css("background-color","#f7f7f7");
	});
	$("#actmanageallteam-membertable").find("tr:gt(0)").live("mouseout",function(){
		$(this).css("background-color","#fff");
	});
});

//颜色变换2membinfo
$(function(){
	$("#actmanageallteam-memberinfo-membertable").find("tr:gt(0)").live("mouseover",function(){
		$(this).css("background-color","#f7f7f7");
	});
	$("#actmanageallteam-memberinfo-membertable").find("tr:gt(0)").live("mouseout",function(){
		$(this).css("background-color","#fff");
	});
});




	
</script>
</html>
