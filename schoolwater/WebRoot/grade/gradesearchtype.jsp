<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="staticData.StaticString"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="bean.School"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/gradesearchtype.css" />
	<script src="../js/gradesearchtype.js"></script>
	
</head>
<style>
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}


#gradesearchtype-title{
    position:absolute;
	width:96%;
	left: 2%;
	top: 10px;
	height:60px;
	border:1px dashed #336699;
	line-height:30px;
	font-size:14px;
}

#gradesearchtype-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:600px;
}

#gradesearchtype-content1{
    position:absolute;
	width:100%;
	left: 0px;
	top: 80px;
	height:250px;
}
#gradesearchtype-content1 td{
    border-top:1px solid #ddd;
    padding-left:20px;
    height:80px;
}

#gradesearchtype-content1 select{
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
 #dosearch{
    position:relative;
	text-align:center;
	margin-left:20%;
	line-height:25px;
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
 #doout{
    position:relative;
	text-align:center;
	margin-left:20%;
	line-height:25px;
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

#gradesearchtype-content3{
    position:absolute;
	width:100%;
	left:0px;
	top: 320px;
	height:600px;
}
#gradesearchtype-content3 td{
    border-top:1px solid #ddd;
    height:50px;
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
}
.searchmemberinfo:hover{
    background:#E1E1E1;
	cursor:pointer;
}


#gradesearchtype-memberinfo{
    position:absolute;
	width:450px;
	left: 550px;
	top: 320px;
	height:400px;
	border:1px solid #ccc;
}
#gradesearchtype-memberinfo-close{
    position:relative;
	width:20px;
	float:right;
	top: 0px;
	height:20px;
	text-align:center;
	line-height:20px;
	cursor:pointer;
}

#gradesearchtype-memberinfo-content1{
    position:absolute;
	width:90%;
	left:5%;
	top: 30px;
	height:100px;
	text-align:center;
	line-height:20px;

}
#gradesearchtype-memberinfo-content1 td{
    border-top:1px solid #ccc;
    text-align:center;
    font-size:14px;
    height:30px;
}
#gradesearchtype-memberinfo-content2{
    position:absolute;
	width:90%;
	left:5%;
	top: 150px;
	text-align:center;

}

.delememberinfo {
    position:relative;
	text-align:center;
	width:40px;
    color: #336699;
	border:1px solid #CCCCCC;
	font-size:14px;
}
.delememberinfo:hover{
    background:#E1E1E1;
	cursor:pointer;
}

#gradesearchtype-memberinfo-content2 td{
    border-top:1px solid #ccc;
    text-align:center;
    font-size:14px;
    height:30px;
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
<%
	 String levelId = (String)session.getAttribute("LevelTopId");
	 Calendar calendar = Calendar.getInstance();
	 int year = calendar.get(Calendar.YEAR);//获取当前年份
 %>
<body>
<div id="gradesearchtype-fa">
	    <div id="gradesearchtype-title">&nbsp;&nbsp;&nbsp;&nbsp;温馨提示：<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			此处可以对积分表进行分类查看，只能进行查看导出操作</div>
	<div id="gradesearchtype-content1">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="gradesearchtype-table2">
		        <tr>
			        <td  align="left" style="width:15%;"><div style="position:relative;margin-left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;积分类别：</div></td>
		            <td  align="left" style="width:45%;"><select name="select" id="gradesearchtype-selecttype">
		            		<%	//查询活动,专业
		            			School school = new School();
		            		 	school.set_id((ObjectId)session.getAttribute("Organization_SchoolId"));
		            			BasicDBObject query = CreateQueryFromBean.EqualObj(school);
		            			BasicDBObject projection = new BasicDBObject();
		            			projection.put(StaticString.School_InActivityCategoty, 1);
		            			projection.put(StaticString.School_Major, 1);
		            			MongoCursor<Document> cursor= DaoImpl.GetSelectCursor(School.class, query, projection);
		            			ArrayList<Document> list = new ArrayList<Document>();//活动类型列表
		            			ArrayList<Document> majorList = new ArrayList<Document>();
		            			while(cursor.hasNext()){
		            				Document document = cursor.next();
		            				list =(ArrayList<Document>)document .get("InActivityCategoty");
		            				majorList = (ArrayList<Document>)document .get("Major");
		            			}	
		            			if(list!=null){
		            			for(int i =0; i< list.size();i++){		            				
		            		%>
		            			<option><%=list.get(i).get("Name")%></option>
		            		<%	}} %>
		            	</select></td>
		            	<td align="left" style="width:20%;"></td>
		            	<td align="left" style="width:20%;"></td>
				</tr>
				<tr>
					<td  align="left" style="width:15%;"><div style="position:relative;margin-left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;年级选择：</div></td>
					<td  align="left" style="width:45%;"><select name="select" id="gradesearchtype-selectgrade">
		            	<option ><%=year%></option>
		            	<option ><%=year-1%></option>
		            	<option ><%=year-2%></option>
		            	<option ><%=year-3%></option>
		            	<option ><%=year-4%></option>
		            	<option ><%=year-5%></option>
		            	<option ><%=year-6%></option>
		            	<option ><%=year-7%></option>
		            	<option ><%=year-8%></option>
					</select></td>
					<td align="left" style="width:20%;"></td>
		            	<td align="left" style="width:20%;"></td>
				</tr>
				<tr id="majortr" style="display:none;">
					<td  align="left" style="width:15%;"><div style="position:relative;margin-left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;专业选择：</div></td>
					<td  align="left" style="width:45%;"><select name="select" id="gradesearchtype-selectmajor">
		            		<option selected="selected">不区分专业</option>
		            	<%	//for循环,查询专业,默认不区分专业
		            		if(majorList!=null){
		            		for(int i = 0;i<majorList.size();i++){
		            		%>
		            		<option><%=majorList.get(i).get("Name")%></option>
		            	<%}} %>
					</select></td>
					<td align="left" style="width:10%;"></td>
		            <td align="left" style="width:10%;"></td>
				</tr>
				 <tr>
			        <td  align="left" style="width:15%;"><div style="position:relative;margin-left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;时间区间：</div></td>
		            <td  align="left" style="width:45%;"><select name="select" id="gradesearchtype-selecttime">
		            	<!-- 此处待修改 -->
		            	<option ><%=year%>-<%=year+1%></option>
		            	<option ><%=year-1%>-<%=year%></option>
		            	<option ><%=year-2%>-<%=year-1%></option>
		            	<option ><%=year-3%>-<%=year-2%></option>
		            	<option ><%=year-4%>-<%=year-3%></option>
		            	<option ><%=year-5%>-<%=year-4%></option>
		            	<option ><%=year-6%>-<%=year-5%></option>
					</select>
					    
					    
					</td>
					<td align="left" style="width:20%;"><div id="dosearch">开始查询</div></td>
		            <td align="left" style="width:20%;"><div id="doout">导出积分表</div></td>
				</tr>
			</table>
	</div>
	
	<div id="gradesearchtype-content3">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0" id="gradesearchtype-membertable">
		        <tr>
		            <td  align="center" style="width:5%;">序号</td>
			        <td  align="center" style="width:20%;">姓名</td>
			        <td  align="center" style="width:20%;">学号</td>
			        <td  align="center" style="width:20%;">总积分</td>
			        <td  align="center" style="width:15%;">排名</td>
					<td  align="center" style="width:10%;">详细</td>
		        </tr>			
			</table>
			<div id ="searchmore" style="display: none;">加载更多</div>
	</div>
	<div id="gradesearchtype-memberinfo" style=" display:none;">
	    <div id="gradesearchtype-memberinfo-close">
	        <img src="img/deleinfo.png" width="100%" height="100%" />
	    </div>
	      
		<div id="gradesearchtype-memberinfo-content1">
		     <table width="100%"  border="0" cellspacing="0" cellpadding="0">
		        <tr>
			        <td  align="center" style="width:30%;">姓名</td>
		            <td  align="" style="width:70%;" id="named">小米</td>
			    </tr>
				<tr>
			        <td  align="center" style="width:30%;">学号</td>
		            <td  align="" style="width:70%;" id="stuidd">201311111</td>
			    </tr>
				<tr>
			        <td  align="center" style="width:30%;border-bottom:1px solid #ccc;">总积分</td>
		            <td  align="" style="width:70%;border-bottom:1px solid #ccc;" id="scored">18</td>
			    </tr>
			</table>
		</div>
		
		<div id="gradesearchtype-memberinfo-content2">
		     <table width="100%"  border="0" cellspacing="0" cellpadding="0">
		        <tr>
				    <td  align="" style="width:10%;">序号
					</td>
			        <td  align="center" style="width:70%;">信息</td>
		            <td  align="" style="width:20%;">积分</td>					
			    </tr>
			</table>
		</div>
	</div>	
</div>
<div id="levelId" style="display: none;"><%=levelId%></div>
<script type="text/javascript">
	//设置权限
	$(function(){
		var levelId = $("#levelId").text();
		if(levelId=="000000000000000000000000"){
			$("#majortr").show();
			var temptop = $("#gradesearchtype-content1").height()+160;
			$("#gradesearchtype-content3").css("top",temptop+"px");
			$("#gradesearchtype-memberinfo").css("top",temptop+"px");
		}else{
			$("#majortr").remove();
		}
	});

	//加载更多
	$(function(){
		$("#searchmore").live("click",function(){
			var $num = $("#gradesearchtype-membertable tr:last").index();
			if($num<=30){
				alert("无更多");
			}else{
				alert("数据量过大，请点击‘导出积分表’查看");
			}
		});
	});
	
    //查询出的每个积分都保存在二维数据中
    var detailitems = []; 
    
	$(function(){
		//查询
		$("#dosearch").bind("click",function(){
			var selectActi =$("#gradesearchtype-selecttype").val();
			var selectTi= $("#gradesearchtype-selecttime").val();
			var selectGr =$("#gradesearchtype-selectgrade").val();
			var selectMajor =$("#gradesearchtype-selectmajor").val();
			$.get("search.action",{"major":selectMajor,"activityName":selectActi,"timeStr":selectTi,"gradeInt":selectGr,"levelId":$("#levelId").text()},function(data){
				//alert(data);
				var dataObj = JSON.parse(data);				
				$("#gradesearchtype-membertable tr:not(':first')").remove();
				if(dataObj.length==0){
					alert("没有喽~");
				}else{
				$.each(dataObj,function(i,item){
					//列表
					var $tr="<tr id='tdClone'>"
					+"<td  align='center' style='width:10%;'>"+(i+1)+"</td>"
			        +"<td  align='center' style='width:20%;'>"+item.name+"</td>"
			        +"<td  align='center' style='width:20%;'>"+item.idCard+"</td>"
			        +"<td  align='center' style='width:20%;'>"+item.score+"</td>"
			        +"<td  align='center' style='width:15%;'>"+(i+1)+"</td>"
					+"<td  align='center' style='width:10%;'>"
					+"<div class='searchmemberinfo'>查看</div></td></tr>";					
					$("#gradesearchtype-membertable tr:last").after($tr);
					
					//每次循环创建一个隐藏div，并为其赋值,点击查看显示对应的div的内容
					$.each(item.detail,function(j,value){
					    if(j == 0){
						    detailitems[i] = [j+1,value.context,value.score];	
					    }
					    else{
					        var len = detailitems[i].length;
					        detailitems[i][len] = j+1;
					        detailitems[i][len+1] = value.context;
					        detailitems[i][len+2] = value.score;
					        //alert(detailitems[i].length);
					    }
					});					
				});
				if($("#levelId").text()=="000000000000000000000000"){
					$("#searchmore").show();
					
				}
				}	
				
				
				$("#gradesearchtype-membertable").find("tr:first").find("td").each(function(){
					$(this).css("border-bottom","0px solid #ddd");
				});
				$("#gradesearchtype-membertable").find("tr:last").find("td").each(function(){
					$(this).css("border-bottom","1px solid #ddd");
				});
			});
		});
		
		//导出
		$("#doout").bind("click",function(){
			var selectActi =$("#gradesearchtype-selecttype").val();
			var selectTi= $("#gradesearchtype-selecttime").val();
			var selectGr =$("#gradesearchtype-selectgrade").val();
			var selectMajor =$("#gradesearchtype-selectmajor").val();
			location.href="typedao.action?activityName="+selectActi+"&timeStr="+selectTi+"&gradeInt="+selectGr+"&major="+selectMajor;
		});
	});
	
	//<!-- 查看成员积分详细信息 -->
	//<!-- 标记隐藏div -->
	
	var havenanimate = 0;
	$(function(){
	    $(".searchmemberinfo").live("click",function(){
		    if(havenanimate == 0){
			    havenanimate = 1;	
		        $("#gradesearchtype-content3").animate({width: '-=465px'}, 'slow');
				setTimeout(function(){
				    $("#gradesearchtype-memberinfo").show();
				    var infowidth = $("#gradesearchtype-fa").width() - $("#gradesearchtype-content3").width()-4;
					$("#gradesearchtype-memberinfo").css("left",$("#gradesearchtype-content3").width()+"px");
					$("#gradesearchtype-memberinfo").css("width",infowidth+"px");
				},1000);
				
				
				
				//找到名字和学号
				var findindex = $(this).parent().parent().index()-1;
				var findname = $(this).parent().parent().find("td").eq(1).html();
				var findstuid = $(this).parent().parent().find("td").eq(2).html();
				var findscore = $(this).parent().parent().find("td").eq(3).html();
				$("#named").html(findname);
				$("#stuidd").html(findstuid);
				$("#scored").html(findscore);
				
				$("#gradesearchtype-memberinfo-content2").find("tr").each(function(){
					if($(this).index() != 0)
						$(this).remove();
				});
				
				for(var k = 0; k < detailitems[findindex].length; k++){
				    var $show="<tr>"
				    +"<td  align='' style='width:10%;'>"+detailitems[findindex][k++]+"</td>"
			        +"<td  align='center' style='width:70%;'>"+detailitems[findindex][k++]+"</td>"
		            +"<td  align='' style='width:20%;'>"+detailitems[findindex][k]+"</td></tr>";					
					$("#gradesearchtype-memberinfo-content2 tr:last").after($show);
				}
			}
		});
	});

	//<!-- 关闭查看详细信息 -->
	$(function(){
	    $("#gradesearchtype-memberinfo-close").live("click",function(){
		    if(havenanimate == 1){
			    havenanimate = 0;	
				$("#gradesearchtype-memberinfo").hide(); 
				$("#gradesearchtype-content3").animate({width: '+=465px'}, 'slow');	
			}
		});
	});
	
	
	//相应的添加时加横线操作
    $(function(){
    	$("#gradesearchtype-content3").find("tr:last").find("td").each(function(){
    		$(this).css("border-bottom","1px solid #ddd");
    	});
    });
    //颜色变换
    $(function(){
    	$("#gradesearchtype-content3").find("tr:gt(0)").live("mouseover",function(){
    		$(this).css("background-color","#f7f7f7");
    	});
    	$("#gradesearchtype-content3").find("tr:gt(0)").live("mouseout",function(){
    		$(this).css("background-color","#fff");
    	});
    });
	
	//将序号重新排序
    function reorderTd(){
    	var reordernum = 1;
    	$("#gradesearchtype-content3").find("tr:gt(0)").each(function(){
    		$(this).find("td:eq(0)").html(reordernum);
    		reordernum++;
    	});
    }

	
	//进入查看时，根据tr个数调整memberinfo高度
	$(function(){
		$(".searchmemberinfo").live("click",function(){
			//进入查看时，将content2最后一个tr加横线
			$("#gradesearchtype-memberinfo-content2").find("tr:last").find("td").each(function(){
				$(this).css("border-bottom","1px solid #ccc");
			});
			
			var infosize = $("#gradesearchtype-memberinfo-content2").find("tr").size()-1;//减去开头
			if(infosize <= 7){
				$("#gradesearchtype-memberinfo").css("height","400px");
			}else{
				var tempheight = 400+(30*infosize-7);
				$("#gradesearchtype-memberinfo").css("height",tempheight+"px");
			}
		});
	});
	
	
	
</script>
</body>
</html>
