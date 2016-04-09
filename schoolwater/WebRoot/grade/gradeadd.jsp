	<%@page import="bean.TableInfo"%>
<%@page import="org.bson.Document"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.action.CreateActivityAction"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="bean.InActivity"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="bean.ActivityIntegralTable"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<script type="text/javascript"
		src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/gradeadd.css" />
	<script src="../js/gradeadd.js" charset='utf-8'></script>
</head>
<style>
/* CSS Document */
body{
	height:800px;
	font-family:"微软雅黑";
	color:#515151;
}
#gradeadd-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:800px;
}

#gradeadd-content1{
    position:absolute;
	width:100%;
	left:0%;
	top: 100px;
	height:300px;
}
#gradeadd-choseT{
    position:absolute;
	width:100%;
	left: 0px;
	top: 5px;
	height:300px;
}
#gradeadd-table2 td{
    border-top:1px solid #ddd;
}
#gradeadd-table2    input[type=text],input[type=password],textarea{border:1px solid #ccc;padding:2px;border-radius:1px;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset;outline:medium none;line-height:25px;
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
#gradeadd-table2    input[type=text]:focus,input[type=password]:focus,textarea:focus{/*border-color:rgba(82,168,236,0.8);*/border-color:#52a8ec;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset,0 0 5px rgba(82,168,236,0.6);outline:0 none;}
#gradeadd-table2 select{
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
#gradeadd-title2{
    position:absolute;
	width:100%;
	left: 0px;
	top: 330px;
	height:75px;
}
<!-- 字段内容显示 -->
#gradeadd-content2{
    position:relative;
	width:100%;
	left: 0px;
	top: 470px;
	height:350px;
	
}
#gradeadd-show{
    position:relative;
	width:100%;
	left: 0px;
	top: 470px;
	height:350px;
}

#gradeadd-delesome{
    position:relative;
    margin-left:20px;
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
#gradeadd-addsome{
    position:relative;
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
#gradeadd-savesome{
    position:relative;
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
#gradeadd-submit{
    position:relative;
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
#gradeadd-membertable{
    table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */
}
#gradeadd-membertable td{
    border-top:1px solid #ddd;
    height:50px;
    font-size:15px;
    word-break:keep-all;/* 不换行 */  
    white-space:nowrap;/* 不换行 */ 
	overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */  
    text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/
}

#gradeadd-membertable input[type=text]{
    text-align:center;
    -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    font-family:"Microsoft YaHei",Verdana,Arial;
    font-size:14px;
    vertical-align:top;
    height:35px;
    color:#515151;
}

#gradeadd-search{
    position:relative;
    width:100px;
	height:25px;
	margin-top:5px;
	margin-left:50px;
	color:#fff;
    background-color:#1C90F2;
    border:1px solid #1C90F2;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
    font-size:14px;
    cursor:pointer;
}

#gradeadd-title{
    position:absolute;
	width:96%;
	left: 2%;
	top: 20px;
	height:60px;
	border:1px dashed #336699;
	line-height:30px;
	font-size:14px;
}
</style>

<body>
	<%
	ArrayList<Document> inActivityList = new ArrayList<Document>();
	String organizationId = (String)ServletActionContext.getContext().getSession().get("Organization_id");
	InActivity inActivity = new InActivity();
	inActivity.setOrganizationId(new ObjectId(organizationId));
	BasicDBObject query = CreateQueryFromBean.EqualObj(inActivity);
	BasicDBObject projection = new BasicDBObject();
	MongoCursor<Document> mc = DaoImpl.GetSelectCursor(InActivity.class, query, projection);
	while(mc.hasNext()) {
			inActivityList.add(mc.next());
	}
 %>
	<div id="gradeadd-fa">
	    <div id="gradeadd-title">&nbsp;&nbsp;&nbsp;&nbsp;温馨提示：<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			积分录入操作，既可以单独录入，也可以关联活动表格，并在此基础上添加人员等操作。</div>
		<div id="gradeadd-content1">
			<div id="gradeadd-choseT">

				<table width="100%" height="100%" border="0" cellspacing="0"
					cellpadding="0" id="gradeadd-table2">
                    <tr>
                         <td><div style="position:relative;margin-left:20px;height:32px;line-height:32px;border-left:5px solid #90EE90">
                         &nbsp;&nbsp;录入方式：</div></td>
                         <td>
                         	<table width="100%" height="100%" border="0" cellspacing="0"
								cellpadding="0" id="gradeadd-table1">
							<tr>
								<td align="left" style="width:5%;"><input type="radio"
									name="choseway" value="0" checked="checked" id="oldact">
								</td>
								<td align="left" style="width:45%;">本部门活动</td>
								<td align="left" style="width:5%;"><input type="radio"
									name="choseway" value="1" id="newact">
								</td>
								<td align="left" style="width:45%;">全部录入新数据</td>
							</tr>
							</table>
                         </td>
                    </tr>
					<tr>
						<td align="left" style="width:30%;"><div style="position:relative;margin-left:20px;height:32px;line-height:32px;border-left:5px solid #90EE90">
						&nbsp;&nbsp;选择活动：</div></td>
						<td align="left" style="width:70%;"><select
							name="selectActivity" id="gradeadd-select1">
								<option value="-1">请选择...</option>
								<%
		            	for(int i = 0; i < inActivityList.size(); i++){
		             %>
								<option value=<%=inActivityList.get(i).get("_id") %>><%=inActivityList.get(i).get("Name") %></option>
								<%} %>
						</select>
						</td>
					</tr>

					<tr>
						<td align="left" style="width:30%;"><div style="position:relative;margin-left:20px;height:32px;line-height:32px;border-left:5px solid #90EE90">
						&nbsp;&nbsp;选择表格：</div></td>
						<td align="left" style="width:70%;"><select
							name="selectTable" id="gradeadd-select2">
							<option value="-1">请选择...</option>
								<%
		            	if(inActivityList.size() == 0){
		            	}
		            	else
		            	{
		            		TableInfo tableInfo = new TableInfo();
		            		tableInfo.setActivityId((ObjectId)inActivityList.get(0).get("_id"));
		            		query = CreateQueryFromBean.EqualObj(tableInfo);
		            		MongoCursor<Document> mCursor = DaoImpl.GetSelectCursor(TableInfo.class, query, projection);
		            		ArrayList<Document> tableList = new ArrayList<Document>();
		            		while(mCursor.hasNext()){
		            			tableList.add(mCursor.next());
		            		}
		            		for(int i =0 ; i < tableList.size(); i++){
		            			Document d = tableList.get(i);
		            			
		             %>
								<option value=<%=d.get("_id") %>><%=d.get("Name") %></option>
								<%}} %>
						</select>
						
						<input id="gradeadd-search" type="submit" value="查&nbsp;&nbsp;&nbsp;&nbsp;询" />
						</td>
					</tr>
					<tr>
						<td align="left" style="width:30%;"><div style="position:relative;margin-left:20px;height:32px;line-height:32px;border-left:5px solid #90EE90">
						&nbsp;&nbsp;新表名称：</div></td>
						<td align="left" style="width:70%;"><input id = "gradeTableName" type="text" />
						</td>
					</tr>
				</table>

			</div>
			<div id="gradeadd-title2">
				<input type="button" value="删除选中项" id="gradeadd-delesome" /> <input
					type="button" value="新增成员" id="gradeadd-addsome" /> <input
					type="button" value="保存修改" id="gradeadd-savesome" /> <input
					type="button" value="提&nbsp;&nbsp;&nbsp;&nbsp;交" id="gradeadd-submit" />
			</div>
		</div>
		<div id="gradeadd-content2">
			<div id="gradeadd-show">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="gradeadd-membertable">
					<tr>
						<td align="center" style="width:5%;cursor:pointer;">全选</td>
						<td align="center" style="width:5%;">序号</td>
						<td align="center" style="width:9%;">姓名</td>
						<td align="center" style="width:9%;">学号</td>
						<td align="center" style="width:9%;">专业</td>
						<td align="center" style="width:9%;">年级</td>
						<td align="center" style="width:9%;">获奖类别</td>
						<td align="center" style="width:9%;">获奖级别</td>
						<td align="center" style="width:9%;">事项名称</td>
						<td align="center" style="width:9%;">积分类别</td>
						<td align="center" style="width:9%;">积分数</td>
						<td align="center" style="width:9%;">备注</td>
					</tr>
					
				</table>
			</div>
		</div>
		
	</div>
<script type="text/javascript">
	$(function(){
		$("#gradeadd-table1").find("tr").each(function(){
			$(this).find("td").each(function(){
				$(this).css("border","0px solid #CCC");
			});
		});
		
		$("#gradeadd-table2").find("tr:last").find("td").each(function(){
			$(this).css("border-bottom","1px solid #CCC");
		});
	});
	
	//<!-- 新增成员 -->
	$(function(){
	    $("#gradeadd-addsome").click(function(){
	    	if($("#gradeadd-membertable").find("[type='text']").is(":visible")){
	    		alert("请先保存再添加");
	    	}else{
	    		var len = $("#gradeadd-membertable tr").length;
			    $("#gradeadd-membertable tr:last").after(
			    			"<tr><td  align='center' style='width:5%;'><input name='' type='checkbox' value='' style = 'width:20px;height:20px' /></td>"+
			    		         "<td  align='center' style='width:5%;'>"+len+"</td>" +
			    		         "<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
			    		         "<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
			    		         "<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
			    		         "<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
			    		         "<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
			    		         "<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
			    		         "<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
			    		         "<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
			    		         "<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
			    				"<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td></tr>");
		      
			    reorderTd();
			    
			    var allsize = $("#gradeadd-membertable").find("tr").size()-1;
			    $("#gradeadd-membertable").find("tr:lt("+allsize+")").each(function(){
			    	$(this).find("td").each(function(){
						$(this).css("border-bottom","0px solid #ddd");
			    	});
				});
			    $("#gradeadd-membertable").find("tr:last").find("td").each(function(){
					$(this).css("border-bottom","1px solid #ddd");
				});
	    	}
	    });
	    
	});
	
	//<!-- 保存修改 -->
	$(function(){
	    $("#gradeadd-savesome").click(function(){
		    $("#gradeadd-membertable td").each(function(){
				    if($(this).find("[type='text']").is(":visible")){
					    var temp = $(this).find("[type='text']").val();
						if(temp != ""){					    
							$(this).html(temp);
							reorderTd();
						    $(this).find("[type='text']").remove();
						}
					}else if($(this).find("select").is(":visible")){
				        var temp = $(this).find("select").val();
						$(this).html(temp);
						reorderTd();
					    $(this).find("select").remove(); 
					}
				});
		});
	});
	
	$(function(){
		$("#gradeadd-delesome").live('click', function() {
		    $("#gradeadd-membertable tr").each(function(){
		    	if($(this).find("td").eq(0).find("[type='checkbox']").attr("checked") )
		    	{
		    		 if($(this).find("td").eq(0).find("[type='checkbox']").attr("disabled"))
		    		 {
		    		 }
		    		 else
		    		 {
		    		 	$(this).remove();
		    		 	reorderTd();
		    		 	var allsize = $("#gradeadd-membertable").find("tr").size()-1;
					    $("#gradeadd-membertable").find("tr:lt("+allsize+")").each(function(){
					    	$(this).find("td").each(function(){
								$(this).css("border-bottom","0px solid #ddd");
					    	});
						});
					    $("#gradeadd-membertable").find("tr:last").find("td").each(function(){
							$(this).css("border-bottom","1px solid #ddd");
						});
		    		 }
		    	
		    	}
			    
			});
		});
		});
	
	
	
	$(function(){
		$("#gradeadd-membertable").find("tr:last").find("td").each(function(){
			$(this).css("border-bottom","1px solid #ddd");
		});
	});
	
	 //全选
	$(function(){
	    $("#gradeadd-membertable").find("td:first").live('click', function() {
		    if($(this).html() == "全选"){
		        $(this).html("取消");
			}
			else{
			    $(this).html("全选");
			}
		    $("#gradeadd-membertable tr").find("td:first").each(function(){
			    if($(this).find("[type='checkbox']").attr("checked")){
			         $(this).find("[type='checkbox']").attr("checked", false);
				 }
				 else{
				     $(this).find("[type='checkbox']").attr("checked", true);
				 }
				
			});
		});
	});
	
	//颜色变换
    $(function(){
    	$("#gradeadd-membertable").find("tr:gt(0)").live("mouseover",function(){
    		$(this).css("background-color","#f7f7f7");
    	});
    	$("#gradeadd-membertable").find("tr:gt(0)").live("mouseout",function(){
    		$(this).css("background-color","#fff");
    	});
    });
	
	//将序号重新排序
    function reorderTd(){
    	var reordernum = 1;
    	$("#gradeadd-membertable").find("tr:gt(0)").each(function(){
    		$(this).find("td:eq(1)").html(reordernum);
    		reordernum++;
    	});
    }
	
	
	
	
	
	//提交
	$(function(){
	$("#gradeadd-submit").click(
		function(){
			var wholeData = new Array();
			$("#gradeadd-membertable tr:not(':first')").each(
				function(){
					 if($(this).find("[type='text']").is(":visible")) {
					 	return true;
					 }
					 else {
					 	var row = $(this).find("td");
						
						var trData = {
							"name":row.eq(2).html(),
							"idCard":row.eq(3).html(),
							"major":row.eq(4).html(),
							"year":row.eq(5).html(),
							"scope":row.eq(6).html(),
							"level":row.eq(7).html(),
							"thingName":row.eq(8).html(),
							"categoryName":row.eq(9).html(),
							"grade":row.eq(10).html(),
							"remark":row.eq(11).html(),
						};
						wholeData.push(trData);				
					 }
				}
			);
			if((wholeData.length != 0) && ($("#gradeTableName").val().trim() != "")){
				var dataString = JSON.stringify(wholeData);
				var inActivityId = $("#gradeadd-select1").children("option:selected").val();
				var tableName = $("#gradeTableName").val();
				$.get("saveActivityIntegral.action",{
							"tableName":tableName,
							"inActivityId":inActivityId,
							"data":dataString
						},function(data){
							alert(data);
							window.parent.location.href="gradewhole.jsp";
						});
			}else{
				alert("表名不能为空或者内容不能为空")
			}
			
			
			
		}
		);

	});
</script>


</body>
</html>
