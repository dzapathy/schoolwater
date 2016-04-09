<%@page import="utils.Util"%>
<%@page import="bean.ActivityIntegral"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="../css/gradesearchsoloD.css" />
	<script src="../js/gradesearchsoloD.js"></script>

</head>
<style>
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}
#gradesearchsoloD-top{
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
#gradesearchsoloD-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:700px;
}

#gradesearchsoloD-content1{
    position:absolute;
	width:100%;
	left: 0px;
	top: 150px;
	height:70px;
	line-height:60px;
}
#gradesearchsoloD-content2{
    position:absolute;
	width:100%;
	left: 0px;
	top: 220px;
	height:430px;
}
#gradesearchsoloD-membertable{
    table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */
}
#gradesearchsoloD-membertable td{
	text-align:center;
	height:50px;
	font-size:15px;
	border-top:1px solid #ddd;
	word-break:keep-all;/* 不换行 */  
    white-space:nowrap;/* 不换行 */ 
	overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */  
    text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/
    
}
#gradesearchsoloD-membertable input[type=text]{
    text-align:center;
    -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    font-family:"Microsoft YaHei",Verdana,Arial;
    font-size:14px;
    vertical-align:top;
    width:80%;
    height:35px;
    color:#515151;
}
.changememberinfo {
    position:relative;
    margin-left:20%;
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
    color: #336699;
	border:1px solid #ccc;
	font-size:14px;
}
.nochange:hover{
    background:#E1E1E1;
	cursor:pointer;
}

.havensubmit{
    position:relative;
	text-align:center;
	margin-left:15px;
	width:60px;
    color: #009900;
	border:1px solid #CCCCCC;
	font-size:14px;
}

#gradesearchsoloD-title{
    position:absolute;
	width:96%;
	left: 2%;
	top: 80px;
	height:60px;
	border:1px dashed #336699;
	line-height:30px;
	font-size:14px;
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

#gradesearchsoloD-delesome{
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

#gradesearchsoloD-addsome{
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

#gradesearchsoloD-daochu{
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

#gradesearchsoloD-submit{
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
</style>
<%!
	ArrayList<ActivityIntegral> integrals = null;
 %>
<body>
<div id="gradesearchsoloD-fa">
        <div id="gradesearchsoloD-top">
	         <div id="top-title">&nbsp;&nbsp;<%=Util.DoGetString((String)request.getAttribute("tableName"))%>积分表</div>
	    </div>
	    <div id="gradesearchsoloD-title">&nbsp;&nbsp;&nbsp;&nbsp;温馨提示：<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			此处可以对积分表的内容进行操作，可以新增、删除、修改、导出表格内容</div>
	<div id="gradesearchsoloD-content1">&nbsp;&nbsp;&nbsp;
	    <input type="button" value="删除选中项" id="gradesearchsoloD-delesome"/>
		   <input type="button" value="新增成员" id="gradesearchsoloD-addsome"/>
		   <!--<input type="button" value="保存修改" id="gradesearchsoloD-savesome"/>  -->
		   <input type="button" id="gradesearchsoloD-daochu" value="导出积分表" onclick="location.href='jifendao.action?id=<%=request.getAttribute("tableId")%>&tableName=<%=request.getAttribute("tableName") %>>' "/>
		   <input type="button" value="提&nbsp;&nbsp;&nbsp;&nbsp;交"  style="display:none;" id="gradesearchsoloD-submit"/>
		   <!-- 点击td来排序 -->
	</div>
	<div id="tableIddiv" style="display: none;"><%=request.getAttribute("tableId")%></div>
	<div id="gradesearchsoloD-content2">
	    <table width="100%"  border="0" cellspacing="0" cellpadding="0" id="gradesearchsoloD-membertable">
		        <tr>
			        <td  style="width:5%;cursor:pointer;">全选</td>
		            <td  style="width:3%;">序号</td>
			        <td  style="width:9%;">姓名</td>
			        <td  style="width:9%;">学号</td>
			        <td  style="width:9%;">专业</td>
			        <td  style="width:9%;">年级</td>
					<td  style="width:9%;">获奖类型</td>
					<td  style="width:9%;">获奖级别</td>
					<td  style="width:9%;">获奖名称</td>
			        <td  style="width:9%;">获得积分</td>
			        <td  style="width:9%;">备注信息</td>
					<td  style="width:11%;"></td>
		        </tr>
				<%
					integrals = (ArrayList<ActivityIntegral>)request.getAttribute("activityIntegrals");
					if(integrals!=null){
						for(int i = 0 ; i< integrals.size();i++){
				 %>
				<tr>
			        <td  style='width:5%;'>
					    <input name='' type='checkbox' value='' style = 'width:20px;height:20px' />
					</td>
		            <td  style='width:5%;' myid='<%=integrals.get(i).get_id()%>'><%=i+1%></td>
			        <td  style='width:10%;'><%=integrals.get(i).getName()%></td>
			        <td  style='width:10%;'><%=integrals.get(i).getIdCard()%></td>
			        <td  style='width:10%;'><%=integrals.get(i).getMajor()%></td>
			        <td  style='width:10%;'><%=integrals.get(i).getYear()%></td>
					<td  style='width:10%;'><%=integrals.get(i).getScope()%></td>
					<td  style='width:10%;'><%=integrals.get(i).getLevel()%></td>
			        <td  style='width:10%;'><%=integrals.get(i).getThingName()%></td>			        
			        <td  style='width:10%;'><%=integrals.get(i).getGrade()%></td>
			        <td  style='width:10%;'><%=integrals.get(i).getRemark()%></td>
					<td  style='width:10%;'>
					    <div class='changememberinfo'>编辑</div>
						<div class='savememberinfo' style='display:none;'>保存</div>
						<div class='nochange' style='display:none;'>取消</div>
					</td>
		        </tr>
				<%}} %>				
			</table>			
			<div id ="searchmore">加载更多</div>
	</div>
	<script type="text/javascript">
		//加载更多
		$(function(){
			$("#searchmore").bind("click",function(){
				var lastContentId = $("#gradesearchsoloD-membertable tr:last td:eq(1)").attr("myId");
				var tableId =$("#tableIddiv").text();
				var $index = $("#gradesearchsoloD-membertable tr:last").index();
				if($index>0){
					$.get("getMoreGrade",{"lastContentId":lastContentId,"tableId":tableId},function(data){
						//alert(data);
						var jsonData = JSON.parse(data);
						if(jsonData.length!=0){
							$.each(jsonData,function(i,item){
								var $tr = "<tr>"+
										        "<td  style='width:5%;'>"+
												 "   <input name='' type='checkbox' value='' style = 'width:20px;height:20px' />"+
												"</td>"+
									            "<td  style='width:5%;' myid='"+item._id+"'>"+($index+i+1)+"</td>"+
										        "<td  style='width:10%;'>"+item.Name+"</td>"+
										        "<td  style='width:10%;'>"+item.IdCard+"</td>"+
										        "<td  style='width:10%;'>"+item.Major+"</td>"+
										        "<td  style='width:10%;'>"+item.Year+"</td>"+
												"<td  style='width:10%;'>"+item.Scope+"</td>"+
												"<td  style='width:10%;'>"+item.Level+"</td>"+
										        "<td  style='width:10%;'>"+item.ThingName+"</td>"+			        
										        "<td  style='width:10%;'>"+item.Grade+"</td>"+
										        "<td  style='width:10%;'>"+item.Remark+"</td>"+
												"<td  style='width:10%;'>"+
												    "<div class='changememberinfo'>编辑</div>"+
													"<div class='savememberinfo' style='display:none;'>保存</div>"+
													"<div class='nochange' style='display:none;'>取消</div>"+
												"</td>"+
									        "</tr>";
									        
									$("table").append($tr);
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
	
	
		//<!-- 新增成员 -->
	      //是否新增，新增为1，否则为0
			var isnewadd=0;
			$(function(){
			    $("#gradesearchsoloD-addsome").click(function(){
			    	if($("#gradesearchsoloD-membertable").find("[type='text']").is(":visible")){
			    		alert("请先保存再添加");
			    	}else{
			    		isnewadd=1;
			    		$("#gradesearchsoloD-membertable tr:last").after("<tr>"+
			    				"<td  style='width:5%;'>"+
			    				"<input name='' type='checkbox' value='' style = 'width:20px;height:20px' /></td>"+
			    				"<td  style='width:3%;'>1</td><td  style='width:9%;'><input type='text' /></td>"+
			    				"<td  style='width:9%;'><input type='text' /></td>"+
			    				"<td  style='width:9%;'><input type='text' /></td>"+
			    				"<td  style='width:9%;'><input type='text' /></td>"+
			    				"<td  style='width:9%;'><input type='text' /></td>"+
			    				"<td  style='width:9%;'><input type='text' /></td>"+
			    				"<td  style='width:9%;'><input type='text' /></td>"+
			    				"<td  style='width:9%;'><input type='text' /></td>"+
			    				"<td  style='width:9%;'><input type='text' /></td>"+
			    				"<td  style='width:11%;'><div class='changememberinfo' style='display:none;'>编辑</div>"+
								"<div class='savememberinfo' >保存</div>"+
								"<div class='nochange'>取消</div></td></tr>");
						 $.changetextwidth();
						 reorderTd();
						 
						 
						//调整横线位置
							var allsize = $("#gradesearchsoloD-membertable").find("tr").size()-1;
						    $("#gradesearchsoloD-membertable").find("tr:lt("+allsize+")").each(function(){
						    	$(this).find("td").each(function(){
									$(this).css("border-bottom","0px solid #ddd");
						    	});
							});
						    $("#gradesearchsoloD-membertable").find("tr:last").find("td").each(function(){
								$(this).css("border-bottom","1px solid #ddd");
							});
			    	}
				    
				});
			});
			
		//删除
		var deledata="";
		$(function(){
			$("#gradesearchsoloD-delesome").live('click', function() {
	    		$("#gradesearchsoloD-membertable tr").each(function(){
			     	if($(this).find("[type='checkbox']").attr("checked")){
			     		
			     		if($(this).find("[type='text']").length == 0){
					    	//取得姓名和学号为唯一标识，分别加入数组deledata中
					    	for(var i=2;i<11;i++){
					    		deledata +=$(this).find("td").eq(i).html()+",";				    	         
			            	}
			            	deledata+=";";
			            }		     	
				     	$(this).remove();
					  	if($("#gradesearchsoloD-membertable").find("td:first").html() == "取消"){
		                	 $("#gradesearchsoloD-membertable").find("td:first").html("全选");
			          	}
				 	}
				});
				$.get("deleteGrade.action",{"deletevalues":deledata,"tableId":$("#tableIddiv").text()},function(data){
					alert(data);
				});
				deledata="";
				//排序
				reorderTd();
				//调整横线位置
				var allsize = $("#gradesearchsoloD-membertable").find("tr").size()-1;
			    $("#gradesearchsoloD-membertable").find("tr:lt("+allsize+")").each(function(){
			    	$(this).find("td").each(function(){
						$(this).css("border-bottom","0px solid #ddd");
			    	});
				});
			    $("#gradesearchsoloD-membertable").find("tr:last").find("td").each(function(){
					$(this).css("border-bottom","1px solid #ddd");
				});
			});		
		});
		
		//获取旧值
		var oldvalue = "";
		var onlyoneold=[];
		$(function(){
		    $(".changememberinfo").live('click', function() {
		    	if($("#gradesearchsoloD-membertable").find("[type='text']").is(":visible")){
		    		alert("先保存再编辑");
		    	}else{
		    		var temp = $(this).parent().parent().index();
				    var num = $("#num").val();
				    
				  //将这一个的值保存在onlyoneold中
	                var alltdsize = $(this).parent().parent().find("td").size()-1;
	                $(this).parent().parent().find("td:lt("+alltdsize+"):gt(1)").each(function(){
	                	onlyoneold.push($(this).html());
	                });
				    
				    if($("#gradesearchsoloD-membertable tr").eq(temp).find("[type='text']").length == 0){
		            //姓名学号保存在oldvalue中
			  			for(var i =2;i<11;i++){
			  				oldvalue+=$("#gradesearchsoloD-membertable tr").eq(temp).find("td").eq(i).html()+","; 
					    }
					    
					    $("#gradesearchsoloD-membertable tr").eq(temp).find("td:gt(1):lt(9)").each(function(){
						    if($(this).find("[type='text']").length == 0){
							    var addelem = $("<input type='text' visible='true'/>");
								var addval = $(this).html();
								$(this).html("");
								$(this).append(addelem);
								$(this).find("[type='text']").val(addval);
								 $.changetextwidth();
							}
						});
					    

						//编辑按钮消失，保存和取消按钮出现
				    		$(this).parent().find(".nochange").css("display","block");
				    		$(this).parent().find(".savememberinfo").css("display","block");
				    		$(this).parent().find(".changememberinfo").css("display","none");
					}
		    	}
			    
			});
		});
		
		//保存
		var newvalue ="";
		$(function(){
		    $(".savememberinfo").live('click', function() {
			    var temp = $(this).parent().parent().index();
			    
			    //找到所有input都不为空时才能保存！！
			    var nonull = 0;
			    $("#gradesearchsoloD-membertable tr").eq(temp).find("td:lt(10)").each(function(){
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
				    $("#gradesearchsoloD-membertable tr").eq(temp).find("td").each(function(){
					    if($(this).find("[type='text']").is(":visible") == true){
						        var temp = $(this).find("[type='text']").val();
							    $(this).find("[type='text']").hide();
							    $(this).html(temp);
							    //因为可能修改姓名学号，所以都要保存
							    newvalue+=temp+",";
						}
					});
				    $.get("addOrUpdateGrade.action",{"newvalues":newvalue,"oldvalues":oldvalue,"tableId":$("#tableIddiv").text()},function(data){
					    alert(data);
					});
					oldvalue="";
					newvalue="";
					//编辑按钮出现，保存和取消按钮消失
				    $(this).parent().find(".nochange").css("display","none");
				    $(this).parent().find(".savememberinfo").css("display","none");
				    $(this).parent().find(".changememberinfo").css("display","block");
				}else{
					alert("没有空值才能保存");
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
		
		
		
      //<!-- 全选 -->
        $(function(){
            $("#gradesearchsoloD-membertable").find("td:first").live('click', function() {
        	    if($(this).html() == "全选"){
        	        $(this).html("取消");
        		}
        		else{
        		    $(this).html("全选");
        		}
        	    $("#gradesearchsoloD-membertable tr").find("td:first").each(function(){
        		    if($(this).find("[type='checkbox']").attr("checked")){
        		         $(this).find("[type='checkbox']").attr("checked", false);
        			 }
        			 else{
        			     $(this).find("[type='checkbox']").attr("checked", true);
        			 }
        			
        		});
        	});
        });




        //<!-- 修改text的宽度保证页面的一致性 -->
        $.extend({'changetextwidth':function(){
            $("input:text").css("width","90%");
        }});

        //<!-- 确定提交 -->
        $(function(){
            $("#gradesearchsoloD-submit").click(function(){
        	    $("#gradesearchsoloD-membertable tr:gt(0)").each(function(){
        		    if($(this).find("[type='text']").is(":visible")){
        			    
        			}else{
        			    if($(this).find("td:last").find(".savememberinfo").is(":visible")){
        				    $(this).find("td:last").find(".savememberinfo").hide();
        			        $(this).find("td:last").find(".changememberinfo").hide();
        			        $(this).find("td:last").append("<div class='havensubmit'>已提交</div>");
        			    }
        			}
        		});
        	});
        });
		
		
		 //相应的添加时加横线操作
        $(function(){
        	$("#gradesearchsoloD-membertable").find("tr:last").find("td").each(function(){
        		$(this).css("border-bottom","1px solid #ddd");
        	});
        });
        //颜色变换
        $(function(){
        	$("#gradesearchsoloD-membertable").find("tr:gt(0)").live("mouseover",function(){
        		$(this).css("background-color","#f7f7f7");
        	});
        	$("#gradesearchsoloD-membertable").find("tr:gt(0)").live("mouseout",function(){
        		$(this).css("background-color","#fff");
        	});
        });
		
		//将序号重新排序
        function reorderTd(){
        	var reordernum = 1;
        	$("#gradesearchsoloD-membertable").find("tr:gt(0)").each(function(){
        		$(this).find("td:eq(1)").html(reordernum);
        		reordernum++;
        	});
        }
	</script>
</div>
</body>
</html>
