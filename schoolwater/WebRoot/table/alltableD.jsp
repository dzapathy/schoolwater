<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="staticData.StaticString"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="bean.TableInfo"%>
<%@page import="utils.Util"%>
<%@page import="bean.TableContentColumn"%>
<%@page import="bean.TableInfoColumn"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/alltableD.css" />
</head>
<style>
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}
#alltableD-top{
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
#alltableD-title{
    position:absolute;
	width:96%;
	left: 2%;
	top: 80px;
	height:60px;
	border:1px dashed #336699;
	line-height:30px;
	font-size:14px;
}
#alltableD-dosome{
    position:relative;
	width:100%;
	margin-top:170px;
	height:30px;
}
#alltableD-members{
    position:relative;
	width:100%;
	margin-top:20px;
	height:500px;
}

#alltableD-delesome{
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
#alltableD-daochu{
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
#alltableD-addsome{
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
#alltableD-membertable{
    table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */ 
}
#alltableD-membertable td{
    border-top:1px solid #ddd;
	height:50px;
	line-height:50px;
	font-size:15px;
	word-break:keep-all;/* 不换行 */  
    white-space:nowrap;/* 不换行 */ 
	overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */  
    text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/  
}
#alltableD-membertable input[type=text]{
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

<%!
  	ArrayList<ArrayList<TableContentColumn>> contextList = null;
  	String columnNames ="";
%>
<body>
<div id="alltableD-fa">
        <div id="alltableD-top">
	         <div id="top-title">&nbsp;&nbsp;<%=Util.DoGetString((String)request.getAttribute("tableName"))%>表单</div>
	    </div>
	    <div id="alltableD-title">&nbsp;&nbsp;&nbsp;&nbsp;温馨提示：<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			此处可以对数据表的内容进行操作，可以新增、删除、修改、导出表格内容</div>
		<div id="alltableD-dosome">&nbsp;&nbsp;&nbsp;
	       <input type="button" value="删除选中项" id="alltableD-delesome"/>
		   <input type="button" id="alltableD-daochu" value="导出数据表" onclick="window.location.href='tableDaoAction?_id=<%=request.getAttribute("tableId")%>&listName=<%=request.getAttribute("tableName")%>'"/>
		   <input type="button" value="新增成员" id="alltableD-addsome"/>
		   <input type="hidden" id="tabId" value=<%=request.getAttribute("tableId") %> >
	 	</div>
		<div id="alltableD-members">
		<table width="100%"  border="0" cellspacing="0" cellpadding="0" id="alltableD-membertable">
		<tbody align="center">
    	<tr> 
    		<td  align="center" style="width:10%;cursor:pointer;">全选</td>
		    <td  align="center" style="width:10%;">序号</td>   	
    	<%
    		columnNames ="";	
			TableInfo info = new TableInfo();
			info.set_id(new ObjectId( (String)request.getAttribute("tableId")));
			BasicDBObject query = CreateQueryFromBean.EqualObj(info);
			BasicDBObject p = new BasicDBObject();
			p.put(StaticString.TableInfo_TableInfoColumn, 1);
							
			MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(TableInfo.class, query, p);
			ArrayList<Document> arrayList = new ArrayList<Document>();
			while(cursor.hasNext()){
			      Document document = cursor.next();
			      arrayList =(ArrayList<Document>)document.get("TableInfoColumn");
			}
			//session.setAttribute("TableInfoColumnsllz", arrayList);  //如果错了，在改回来
			for(int i = 0 ;i<arrayList.size();i++){
				columnNames +=arrayList.get(i).get("Name")+",";
			%>
				<td  align="center" style="width:10%;"><%=arrayList.get(i).get("Name") %></td>
			<%}%> 
			<td align="center" style="width:50px;">
					    操作
					</td>
    	</tr>
    	<%contextList=(ArrayList<ArrayList<TableContentColumn>>)request.getAttribute("tableContextList");    	  
    	  for(int i = 0 ;i<contextList.size() ;i++){
    		%><tr class='addmember2'>
    			<td  align='center' style='width:10%;'>
					<input name='' type='checkbox' value='' style = 'width:20px;height:20px' />
				</td>  
				<td id='tag' myid='<%=contextList.get(i).get(0).getContent() %>' align='center' style='width:10%;height:5%;'><%=i+1 %></td>
    		<%for (int j = 1; j < contextList.get(i).size(); j++){%>
    			<td align="center" style="width:10%;"><%=contextList.get(i).get(j).getContent()%></td>   			
    		<% }%> 
    			<td  align='center' style='width:50px;'>
					<div class='changememberinfo'>编辑</div>
					<div class='savememberinfo' style="display:none;">保存</div>
					<div class='nochange' style="display:none;">取消</div>
				</td>
    		</tr>  	
    	<% }%>
    	</tbody>
		</table>
		<input type="hidden" id="num" value=<%=arrayList.size()%>>
		<div id ="columnNames" style="display: none;"><%=columnNames %></div>
		<div id ="searchmore">加载更多</div>
		</div>
	</div>
<script type="text/javascript">
		//加载更多
		$(function(){
			$("#searchmore").bind("click",function(){
				var lastContentId = $("#alltableD-membertable tr:last td:eq(1)").attr("myId");
				var tableId =$("#tabId").val();
				var columnName =$("#columnNames").text();
				var $index = $("#alltableD-membertable tr:last").index();
				//alert($index);
				if($index>0){
					$.get("getMore",{"lastContentId":lastContentId,"tableId":tableId,"columnName":columnName},function(data){					  
						var trIndex = $("#alltableD-membertable tr:first td").length;
						var dataObj = JSON.parse(data);
						//alert(dataObj.length);
						if(dataObj.length!=0){
						$.each(dataObj,function(i,item){
							var $tr = "<tr class='addmember2'>"+
    									"<td  align='center' style='width:10%;'>"+
											"<input name='' type='checkbox' value='' style = 'width:20px;height:20px' />"+
										"</td>"+
										"<td id='tag' myid='"+item._id +"' align='center' style='width:10%;height:5%;'>"+($index+1+i)+"</td>";
									for(var j = 2 ; j< trIndex-1;j++){
										$tr += "<td align='center' style='width:10%;'>"+item[$("#alltableD-membertable tr:first td").eq(j).text()]+"</td>";
									};
								 $tr += "<td  align='center' style='width:50px;'>"+
											"<div class='changememberinfo'>编辑</div>"+
											"<div class='savememberinfo' style='display:none;'>保存</div>"+
											"<div class='nochange' style='display:none;'>取消</div>"+
										"</td>";
										
								$("#alltableD-membertable").append($tr);
						});
					  }else{
					  	alert("没有喽");
					  }
					});
				}else{
					alert("没有喽");
				}
			});
		});
		
		//新增
		//是否新增，新增为1，否则为0
		var isnewadd=0;
		$(function(){
		    $("#alltableD-addsome").click(function(){
		    	if($("#alltableD-membertable").find("[type='text']").is(":visible")){
		    		alert("先保存再新增");
		    	}else{
		    		isnewadd=1;
			    	var num = $("#num").val();
			    	var $index =$("#alltableD-membertable tr:last").index();
					$("#alltableD-membertable").find("tr:last").after(
						"<tr class='addmember2'>"+
						"<td  align='center' style='width:10%;'>"+
						"<input name='' type='checkbox' value='' style = 'width:20px;height:20px' /></td>"+
						" <td id='tag' align='center' style='width:10%;'>"+$index+
						"</td><td  align='center' style='width:50px;'>"+
						"<div class='changememberinfo' style='display:none;'>编辑</div>"+
						"<div class='savememberinfo' >保存</div>"+
						"<div class='nochange'>取消</div></td></tr>");			  
					for( var i=0; i<num; i++) {
				   		$("tr:last #tag").after("<td  align='center' style='width:10%;height:5%;'><input type='text' style='width:100px;' visible='true'/></td>");
					}
					//去掉第一个tr的下划线
					var trsize = $("#alltableD-membertable").find("tr").size();
					$("#alltableD-membertable").find("tr:lt("+trsize+")").find("td").each(function(){
	        			$(this).css("border-bottom","0px solid #ddd");
	        		});
					//增加最后一个的下划线
					$("#alltableD-membertable").find("tr:last").find("td").each(function(){
	        			$(this).css("border-bottom","1px solid #ddd");
	        		});
					
					//调整td宽度
					changealltd();
					
					//序列重排列
					reorderTd();
		    	}
		 	});
		});			
		//lyl添加：删除选中成员
		var deledata=""; 
		$(function(){
		    $("#alltableD-delesome").live('click', function() {
			    $("#alltableD-membertable tr").each(function(){
				     if($(this).find("[type='checkbox']").attr("checked")){				    	 
				    	 //如果已经保存了，则需要记录标识，不保存的只能前台删除，不能后台删除
		                     if($(this).find("[type='text']").length == 0){
				    	         //取得姓名和学号为唯一标识，分别加入数组deledata中
				    	         deledata +=$(this).find("td").eq(3).html()+",";				    	         
		                     }				    	 
				    	 //前台删除
					     $(this).remove();
						  if($("#alltableD-members").find("td:first").html() == "取消"){
			                 $("#alltableD-members").find("td:first").html("全选");
				          }
					 }
				});
				//获取到删除的内容
				$.get("deletePeople.action",{"deletevalues":deledata,"tableId":$("#tabId").val()},function(data){
					alert(data);
				});
				deledata="";
				
				
				//增加最后一个tr的下划线
				var trsize = $("#alltableD-membertable").find("tr").size();
				if(trsize == 1){
					$("#alltableD-membertable").find("tr:first").find("td").each(function(){
		        		$(this).css("border-bottom","1px solid #ddd");
		        	});
				}else{
					$("#alltableD-membertable").find("tr:last").find("td").each(function(){
		        		$(this).css("border-bottom","1px solid #ddd");
		        	});
				}
				
				//序列重排列
				reorderTd();
				
			});
		});
		
		
		
		//lyl添加：点击一次编辑按钮，就保存旧值，且只用保存姓名学号作为唯一标示，就可以找到要修改的地方了
	    var oldvalue = "";
		var onlyoneold=[];
        $(function(){
            $(".changememberinfo").live('click', function() {
            	if($("#alltableD-membertable").find("[type='text']").is(":visible")){
		    		alert("先保存再编辑");
		    	}else{
	        		var temp = $(this).parent().parent().index();
	       	 		var num = $("#num").val();
	        		
	                //将这一个的值保存在onlyoneold中
	                var alltdsize = $(this).parent().parent().find("td").size()-1;
	                $(this).parent().parent().find("td:lt("+alltdsize+"):gt(1)").each(function(){
	                	onlyoneold.push($(this).html());
	                });
	                
	                //如果已经在编辑中，再点编辑无效，否则可以编辑
	        		if($("#alltableD-membertable tr").eq(temp).find("[type='text']").length == 0){
	            		//姓名学号保存在oldvalue中
	  					oldvalue+=$("#alltableD-membertable tr").eq(temp).find("td").eq(3).html(); 
	            		$("#alltableD-membertable tr").eq(temp).find("td:gt(1):lt("+(num)+")").each(function(){
		            		if($(this).find("[type='text']").length == 0){
			            		var addelem = $("<input type='text' style='width:100px;' visible='true'/>");
				        		var addval = $(this).html();
				        		$(this).html("");
				        		$(this).append(addelem);
				        		$(this).find("[type='text']").val(addval);
			        		}  
		        		});
	                
	            		
	            	
	            	
	            	
	          		//编辑按钮消失，保存和取消按钮出现
			    		$(this).parent().find(".nochange").css("display","block");
			    		$(this).parent().find(".savememberinfo").css("display","block");
			    		$(this).parent().find(".changememberinfo").css("display","none");
	            
			    		
			    		//调整td宽度
						changealltd();	
	        		}
		    	}
	        });
        });
        
        //lyl添加：点击保存时，把oldvalue和newvalue都传给后台
        var newvalue ="";
        $(function(){
		    $(".savememberinfo").live('click', function() {
			    var temp = $(this).parent().parent().index();	//序列
			    
			    //找到所有input都不为空时才能保存！！
			    var nonull = 0;
			    $("#alltableD-membertable tr").eq(temp).find("td").each(function(){
				    if($(this).find("[type='text']").is(":visible") == true){
					    if($(this).find("[type='text']").val() == ""){
					    	nonull = 1;
					    }
				    }
			    });
			    
			    //nonull == 1标识有input为空，不能保存，0则可以保存
			    if(nonull == 0){
			    	isnewadd = 0;//绝对没有新增成员
			    	onlyoneold=[]; //清空保存的值
			        $("#alltableD-membertable tr").eq(temp).find("td").each(function(){
				        if($(this).find("[type='text']").is(":visible") == true){
					        if($(this).find("[type='text']").val() != ""){
					            var tempval = $(this).find("[type='text']").val();
						        $(this).find("[type='text']").hide();
						        $(this).html(tempval);						    
						        //因为可能修改姓名学号，所以都要保存
						        newvalue+=tempval+",";
						    }
					    }				
				    });
					//获取旧值和新值
				    $.get("addPeaple.action",{"newvalues":newvalue,"oldvalues":oldvalue,"tableId":$("#tabId").val()},function(data){
				    	alert(data);
				    });
				    oldvalue="";
				    newvalue="";
				    
				    //编辑按钮出现，保存和取消按钮消失
				    $(this).parent().find(".nochange").css("display","none");
				    $(this).parent().find(".savememberinfo").css("display","none");
				    $(this).parent().find(".changememberinfo").css("display","block");
			    }else{
			    	alert("空值不能保存");
			    }
			});
		});	
        
        
        //取消保存按钮
        $(function(){
        	$(".nochange").live("click",function(){
        		//编辑按钮出现，保存和取消按钮消失
        		if(isnewadd==1){
        			alert("新增不能取消，只能删除和保存");
        		}else{
        			//将onlyoneold值重新放回到td中
        			var i=0;
        			var alltdsize = $(this).parent().parent().find("td").size()-1;
        			$(this).parent().parent().find("td:lt("+alltdsize+"):gt(1)").each(function(){
        				$(this).find("[type='text']").hide();
        				$(this).html(onlyoneold[i]);
        				i++;
        			});
        			
        			$(this).parent().find(".nochange").css("display","none");
    			    $(this).parent().find(".savememberinfo").css("display","none");
    			    $(this).parent().find(".changememberinfo").css("display","block");
    			    onlyoneold=[];//清空保存的值
        		}
			    
        	});
        })
        
        //全选
$(function(){
    $("#alltableD-members").find("td:first").live('click', function() {
	    if($(this).html() == "全选"){
	        $(this).html("取消");
		}
		else{
		    $(this).html("全选");
		}
	    $("#alltableD-membertable tr").find("td:first").each(function(){
		    if($(this).find("[type='checkbox']").attr("checked")){
		         $(this).find("[type='checkbox']").attr("checked", false);
			 }
			 else{
			     $(this).find("[type='checkbox']").attr("checked", true);
			 }
			
		});
	});
});
        
        
        
        //相应的添加时加横线操作
        $(function(){
        	$("#alltableD-membertable").find("tr:last").find("td").each(function(){
        		$(this).css("border-bottom","1px solid #ddd");
        	});
        });
        //颜色变换
        $(function(){
        	$("#alltableD-membertable").find("tr:gt(0)").live("mouseover",function(){
        		$(this).css("background-color","#f7f7f7");
        	});
        	$("#alltableD-membertable").find("tr:gt(0)").live("mouseout",function(){
        		$(this).css("background-color","#fff");
        	});
        });
        
 
        //载入页面时，重新规划td大小
        $(function(){
        	changealltd();
        });
        	
        function changealltd(){
        	var allsize = $("#alltableD-membertable").find("tr:first").find("td").size()-1;
        	var allwidth = $("#alltableD-membertable").width();
        	var eachwidth = (allwidth-200)/allsize;
        	
        	$("#alltableD-membertable").find("tr").each(function(){
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
        	$("#alltableD-membertable").find("tr:gt(0)").each(function(){
        		$(this).find("td:eq(1)").html(reordernum);
        		reordernum++;
        	});
        }
		</script>
</body>
</html>
