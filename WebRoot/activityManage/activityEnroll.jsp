<%@page import="bean.TableContentColumn"%>
<%@page import="bean.TableContentInfo"%>
<%@page import="bean.TableInfoColumn"%>
<%@page import="staticData.StaticString"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="bean.TableInfo"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	
	<title>报名表</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/actmanageB.css" />	
	
</head>
<style>
body{
	height:950px;
	font-family:"微软雅黑";
	color:#515151;
}
#actmanageB-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:950px;
}
#actmanageB-dosome{
    position:relative;
	width:100%;
	margin-top:10px;
	height:30px;
}
#actmanageB-delesome{
    position:relative;
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
#activitySignExport{
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
#actmanageB-addsome{
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
#actmanageB-members{
    position:absolute;
	width:100%;
	left: 0px;
	top: 50px;
	height:900px;
}

#actmanageB-membertable{
    table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */ 
}
#actmanageB-membertable td{
    border-top:1px solid #ddd;
	height:50px;
	line-height:50px;
	font-size:15px;
	word-break:keep-all;/* 不换行 */  
    white-space:nowrap;/* 不换行 */ 
	overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */  
    text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/ 
}
#actmanageB-membertable input[type=text]{
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

.changememberinfo {
    position:relative;
	text-align:center;
	height:25px;
	line-height:25px;
	width:50px;
    color: #336699;
	border:1px solid #ccc;
	font-size:14px;
}
.changememberinfo:hover{
    background:#E1E1E1;
	cursor:pointer;
}
.savememberinfo{
    position:relative;
	text-align:center;
	height:25px;
	line-height:25px;
	width:50px;
    color: #336699;
    margin-left:20px;
    float:left;
	border:1px solid #ccc;
	font-size:14px;
}
.savememberinfo:hover{
    background:#E1E1E1;
	cursor:pointer;
}

.nochange{
    position:relative;
	text-align:center;
	height:25px;
	line-height:25px;
	width:50px;
	float:right;
	margin-right:20px;
    color: #336699;
	border:1px solid #ccc;
	font-size:14px;
}
.nochange:hover{
    background:#E1E1E1;
	cursor:pointer;
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
	ArrayList<String> columnName = new ArrayList<String>();
	ObjectId contentId = null;
	ObjectId lastId=null;
    int tNum = 0;	
    int pageSize=10;
%>

<body>

<div id="actmanageB-fa">
	 <div id="actmanageB-dosome">&nbsp;&nbsp;&nbsp;
	       <input type="button" value="删除选中项" id="actmanageB-delesome"/>
		   <input type="button" value="导出数据表" id="activitySignExport" />
		   <input type="button" value="新增成员" id="actmanageB-addsome"/>
	   </div>
	  <%
	   		String activityContentId = "";
			String activity_id = (String) session
				.getAttribute("SelectedActivityId");
			TableInfo tableInfo = new TableInfo();
			tableInfo.setActivityId(new ObjectId(activity_id));
			tableInfo.setType(0);
			BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);
			BasicDBObject projection = new BasicDBObject();
			projection.put("TableInfoColumn", 1);

			MongoCursor<Document> mc = DaoImpl.GetSelectCursor(TableInfo.class,
				query, projection);
			if (!mc.hasNext()) {

			} else {
		%>
	   <div id="actmanageB-members">
		    <table width="100%"  border="0" cellspacing="0" cellpadding="0" id="actmanageB-membertable">
		        <tr>
			        <td  align="center" style="cursor:pointer;">全选</td>
		            <td  align="center" style="">序号</td>
		            <%
		            	Document document = mc.next();
		            	//取到document.size()
		            	
						ArrayList<Document> documents = (ArrayList<Document>) document
								.get(StaticString.TableInfo_TableInfoColumn);
						columnName.clear();
						
						tNum = documents.size(); 
						for (int i = 0; i < documents.size(); i++) {
							columnName.add((String) documents.get(i).get("Name"));
					%>
			        <td  align="center" style=""><%=documents.get(i).get("Name")%></td>
			        <%
						}
						//表单字段集合和学校id 存入session中
						session.setAttribute("TableInfoColumnName", columnName);
						//session.setAttribute("Organization_SchoolId",document.get(StaticString.TableInfo_OrganizationId));
					%>
					<td width="120px"></td>
		        </tr>
		        <%			
							//tableInfo id
							
							contentId = (ObjectId) document.get("_id");
							activityContentId = contentId.toString();
																	
							TableContentInfo tableContentInfo = new TableContentInfo();
							tableContentInfo.setTableId(contentId); 
							tableContentInfo.setTableType(0);
							BasicDBObject q = CreateQueryFromBean.EqualObj(tableContentInfo);
							BasicDBObject p = new BasicDBObject();
							BasicDBObject sort=new BasicDBObject();
							sort.put(StaticString.InActivity_id,-1);
							//p.put("TableContentColumn", 1);
							MongoCursor<Document> mc2 = DaoImpl.GetSelectCursor(TableContentInfo.class,
									q, sort, pageSize, p);
								ArrayList<Document> tableContentInfos = new ArrayList<Document>();
								ArrayList<Document> tableContentColumns = new ArrayList<Document>();
								
								while (mc2.hasNext()) {
									tableContentInfos.add(mc2.next());//取出每一个学生的信息
								}
								for (int j = 0; j < tableContentInfos.size(); j++) {
				%>
				<tr class='addmember1'>
			        <td  align="center" style="width:10%;height:5%;">
					    <input name="" type="checkbox" value="" style = "width:20px;height:20px" />
					</td>
		            <td  align="center"><%=j + 1%></td>
		            <%
						Document d = tableContentInfos.get(j);//学生信息
						if(j==tableContentInfos.size()-1){
							lastId=(ObjectId)(d.get(StaticString.TableContentInfo_id));
						}
						tableContentColumns.clear();
						tableContentColumns = (ArrayList<Document>) d
									.get(StaticString.TableContentInfo_TableContentColumn);

						for (int k = 0; k < columnName.size(); k++) {
							for (int i = 0; i < tableContentColumns.size(); i++) {

								if (columnName.get(k).equals(
										(String) tableContentColumns.get(i).get(
												"Name"))) {
	%>
					<td  align="center"><%=tableContentColumns.get(i).get("Content")%></td>
					<%
						}
						}
						
						}																													
					%>
					<td  align="center" >
					    <div class="changememberinfo">编辑</div>
						<div class="nochange" style="display:none;">取消</div>
						<div class="savememberinfo" style="display:none;">保存</div>
					</td>
		        </tr>
					<%
								}
								
					%>				
			</table>
			<div id ="searchmore" align="center">加载更多</div>
			
		    <div style="display: none;" id="lastId"><%=lastId %></div>
		</div>
		<%
			}
		%>
		<div style="display:none;">
			<input type="text" value=<%=activityContentId%>
				id="activityContentIdValue" />

		</div>
		<div style="display: none;" id="tableId"><%=contentId %></div>
		
		
	</div>
	
	<script type="text/javascript" charset="utf-8">
	
		 // 加载更多
	  $(function(){
		//加载更多按钮
		$("#searchmore").bind("click",function(){
			var lastId = $("#lastId").text();
			var tableId=$("#tableId").text();
			//alert(lastId+" "+tableId);
			$.get("activityGetMoreMember",{"lastId":lastId,"tableId":tableId},function(data){
				var dataObj = JSON.parse(data);
				if(dataObj.length==0){
					alert("暂无更多成员信息");
				}else{
					alert("success");
					//var num = $("tr:last").index()+1;
					//$.each(dataObj,function(i,item){
						// var $tr ="<tr>"+
						//"<td  align="center">"+(num++)+"</td>"+
						//"<td  align="center">"+item.+"</td>"+
						/*var $tr ="<tr>"+
					     "<td align='center' style='width:10%;height:5%;'>"+(num++)+"</td>"+
						 "<td align='center' style='width:60%;height:5%;'>"+
						 "<a myid='"+item._id+"' style='text-decoration:none;' href='getSearchContext.action?id="+item._id+"&tableName="+item.name+"'>"+item.name+"</a>"+
						 "</td>"+
						 "<td align='center' style='width:20%;height:5%;'>"+item.createTime+"</td>"+
						 "<td  align='center' style='width:10%;height:5%;'><div style='cursor: pointer;' id='deleteT' myid='"+item._id+"' >删除</div></td>"+
						 "</tr>";
						 $("#gradesearchsolo-actsTable tr:last").after($tr);	
						 */
				//	});
					reorderTd();
				}
			});
		});
	});
	
		$(function() {
			$("#activitySignExport")
					.click(
							function() {
								// window.location.href =
								// "activitySignExport.action?activity_id="
								window.location.href = "activityEnrollExport.action?tableId="+$("#activityContentIdValue").val();
							});
		});
		
	    $(function(){
	    	sendTNum(<%=tNum %>);
	    });

	    var oldvalue = new Array(7);// 保存旧信息


	  // <!-- 全选 -->
	  $(function(){
	      $("#actmanageB-members").find("td:first").live('click', function() {
	  	    // 全选bug修补
	  		var isall = 0;
	  	    if($(this).html() == "全选"){
	  	        $(this).html("取消");
	  			isall = 1;
	  		}
	  		else{
	  		    $(this).html("全选");
	  			isall = 0;
	  		}
	  	    $("#actmanageB-membertable tr").find("td:first").each(function(){
	  		    if(isall == 0){
	  		         $(this).find("[type='checkbox']").attr("checked", false);
	  			 }
	  			 else{
	  			     $(this).find("[type='checkbox']").attr("checked", true);
	  			 }
	  			
	  		});
	  	});
	  });

	  var tNum = 0;
	  // 取得字段个数：
	  function sendTNum(num){
	  	tNum = num;
	  }
	  // <!-- 新增报名表成员 -->
	  $(function(){
	      $("#actmanageB-addsome").click(function(){
	      
	      $("#searchmore").hide();
	  	   var isHaveNew = 0;
	  	   $("#actmanageB-membertable").find("td").each(function(){
	  	       if($(this).find("[type='text']").is(":visible") == true){
	  		       isHaveNew = 1;
	  		   }
	  	   });
	  	   if(isHaveNew == 1){
	  	       alert("请先保存新增的成员信息");
	  	   }else{
	  		    var addtr = "";
	  		    for(var k = 0; k < tNum; k++){
	  		    	addtr += "<td  align='center' ><input type='text' style='width:80%;' /></td>";
	  		    }	  		    
	  	   		$("#actmanageB-membertable").find("tr:first").after("<tr class='addmember2'><td  align='center' style='height:5%;'><input name='' type='checkbox' value='' style = 'height:20px' /></td><td  align='center' style='height:5%;'>1</td>"+ addtr +"<td  align='center' style='width:120px;height:5%;'><div class='changememberinfo' style='display:none;'>编辑</div><div class='savememberinfo' >保存</div><div class='nochange'>取消</div></td></tr>");
	  			// 旧值清零
	  			oldClear();
	  			reorderTd();
	  	   }
	  	});
	  });

	  // <!-- 编辑成员 -->
	  $(function(){
	      $(".changememberinfo").live('click', function() {
	  	    var isHaveNew = 0;
	  	   $("#actmanageB-membertable").find("td").each(function(){
	  	       if($(this).find("[type='text']").is(":visible") == true){
	  		       isHaveNew = 1;
	  		   }
	  	   });
	  	   if(isHaveNew == 1){
	  	       alert("请先保存新增的成员信息");
	  		}else{
	  	    	$(this).hide();
	  	    	$(this).parent().find(".savememberinfo").show();
	  			$(this).parent().find(".nochange").show();
	  		
	  			var i = 0;
	  	    	var temp = $(this).parent().parent().index();
	  		
	  	    	$("#actmanageB-membertable tr").eq(temp).find("td:gt(1):lt("+tNum+")").each(function(){
	  		    	if($(this).find("[type='text']").length == 0){
	  			   	 	var addelem = $("<input type='text' style='width:80%;' visible='true'/>");
	  					var addval = $(this).html();
	  				
	  					// 向oldvalue中保存
	  				
	  					oldvalue[i] = addval;
	  					i++;
	  				
	  					$(this).html("");
	  					$(this).append(addelem);
	  					$(this).find("[type='text']").val(addval);
	  				}
	  			});
	  		
	  		// 显示保存和取消
	  		
	  		}
	  	});
	  });

	  // 取消按钮
	  $(function(){
	      $(".nochange").live("click",function(){
	  	    var canold = 0;
	  		if(oldvalue[0] == 0){
	  			    canold = 1;
	  	    }
	  			  		
	  		if(canold == 1){
	  		    alert("新增成员不能取消");
	  		}else{
	  	        var i = 0; 
	  	   	    $(this).hide();
	  	    	$(this).parent().find(".changememberinfo").show();
	  			$(this).parent().find(".savememberinfo").hide();
	  	    	var temp = $(this).parent().parent().index();
	  	    	$("#actmanageB-membertable tr").eq(temp).find("td").each(function(){
	  		    	if($(this).find("[type='text']").is(":visible") == true){
	  				    	$(this).html(oldvalue[i]);
	  						i++;
	  				}
	  			});
	  			// 旧值清零
	  			oldClear();
	  			reorderTd()
	  		}
	  	});
	  });

	  function oldClear(){
	  	for(var j = 0; j < 7; j++){
	  	    oldvalue[j] = 0;
	  	}
	  }
	  
	  // <!-- 保存新增成员 -->
	    $(function(){
	        $(".savememberinfo").live('click', function() {
	    	    var isFull = 0;
	    		$(this).parent().parent().find("[type='text']").each(function(){
	    		    if($(this).val() == "" || $(this).val() == null){
	    			    isFull = 1;
	    			}
	    		});
	    		
	    		if(isFull == 1){
	    		    alert("填写完整再保存");
	    		}else{
	    	    	$(this).hide();
	    	    	$(this).parent().find(".changememberinfo").show();
	    			$(this).parent().find(".nochange").hide();
	    	    	var temp = $(this).parent().parent().index();
	    	    	$("#actmanageB-membertable tr").eq(temp).find("td").each(function(){
	    		    	if($(this).find("[type='text']").is(":visible") == true){
	    			    	if($(this).find("[type='text']").val() != ""){
	    			        	var temp = $(this).find("[type='text']").val();
	    				    	$(this).find("[type='text']").hide();
	    				    	$(this).html(temp);
	    					}
	    				}
	    			});
	    			
	    			// 取得姓名学号 用ajax传saveNameId用，间隔
	    			var oldNameID="";
	    			var saveNameID="";
	    			oldNameID = oldvalue[1];
	    			
	    			// 旧值清零
	    			oldClear();
	    			for(var p = 2; p < tNum+2; p++){
	    				saveNameID += $("#actmanageB-membertable tr").eq(temp).find("td:eq("+p+")").html()+",";
	    			}
	    			// alert(saveNameID);
	    			// alert(oldNameID);
	    			$.get("activityEnrollAdd.action",{"tableId":$("#activityContentIdValue").val(),"oldvalues":oldNameID,"newvalues":saveNameID},function(data){
	    				alert(data);
	    			});	    	
	    		}
	    	});
	    });
	    
	    
	    
	  // <!-- 删除选中人员 -->
	    $(function(){
	        $("#actmanageB-delesome").live('click', function() {
	        	// 删除的都保存在deleNameId中，ajax传值，以,分割名字和Id,多行之间以;分割
	        	var deleNameId = "";
	    	    $("#actmanageB-membertable tr").each(function(){
	    		     if($(this).find("[type='checkbox']").attr("checked")){
	    		    	 if((!($(this).find("[type='text']").is(":visible") == true))){
	    		    	     deleNameId += $(this).find("td").eq(3).html()+",";
	    		    	 }
	    			     $(this).remove();
	    				  if($("#actmanageB-members").find("td:first").html() == "取消"){
	    	                 $("#actmanageB-members").find("td:first").html("全选");
	    		          }
	    			 }
	    		});
	    		// alert(deleNameId);
	    		$.get("activityEnrollDel",{"tableId":$("#activityContentIdValue").val(),"deletevalues":deleNameId},function(data){
	    			alert(data);
	    		});
	    		reorderTd();
	    	})
	    	});

	    
	    
	  //相应的添加时加横线操作
        $(function(){
        	$("#actmanageB-membertable").find("tr:last").find("td").each(function(){
        		$(this).css("border-bottom","1px solid #ddd");
        	});
        });
        //颜色变换
        $(function(){
        	$("#actmanageB-membertable").find("tr:gt(0)").live("mouseover",function(){
        		$(this).css("background-color","#f7f7f7");
        	});
        	$("#actmanageB-membertable").find("tr:gt(0)").live("mouseout",function(){
        		$(this).css("background-color","#fff");
        	});
        });
        
 
        //载入页面时，重新规划td大小
        $(function(){
        	changealltd();
        });
        	
        function changealltd(){
        	var allsize = $("#actmanageB-membertable").find("tr:first").find("td").size()-1;
        	var allwidth = $("#actmanageB-membertable").width();
        	var eachwidth = (allwidth-200)/allsize;
        	
        	$("#actmanageB-membertable").find("tr").each(function(){
        		$(this).find("td:last").css("width","200px");
        		$(this).find("td:lt("+allsize+")").each(function(){
        			$(this).css("width",eachwidth+"px");
        		});
        		$(this).find("[type='text']").each(function(){
        			$(this).css("width","80%");
        		});
        	});
        }
        
        //将序号重新排序
        function reorderTd(){
        	var reordernum = 1;
        	$("#actmanageB-membertable").find("tr:gt(0)").each(function(){
        		$(this).find("td:eq(1)").html(reordernum);
        		reordernum++;
        	});
        }
	</script>
</body>
</html>
