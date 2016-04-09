// JavaScript Document
<!-- 删除选中人员 -->
$(function(){
    $("#actmanagenewTD-delesome").live('click', function() {
	    $("#actmanagenewTD-membertable tr").each(function(){
		     if($(this).find("[type='checkbox']").attr("checked")){
			     $(this).remove();
				  if($("#actmanagenewTD-membertable").find("td:first").html() == "取消"){
	                 $("#actmanagenewTD-membertable").find("td:first").html("全选");
		          }
			 }
		});
	});
});

<!-- 全选 -->
$(function(){
    $("#actmanagenewTD-membertable").find("td:first").live('click', function() {
	    if($(this).html() == "全选"){
	        $(this).html("取消");
		}
		else{
		    $(this).html("全选");
		}
	    $("#actmanagenewTD-membertable tr").find("td:first").each(function(){
		    if($(this).find("[type='checkbox']").attr("checked")){
		         $(this).find("[type='checkbox']").attr("checked", false);
			 }
			 else{
			     $(this).find("[type='checkbox']").attr("checked", true);
			 }
			
		});
	});
});

<!-- 新增成员 -->
$(function(){
    $("#actmanageTD-addsome").click(function(){
	    $("#actmanagenewTD-membertable tr:last").after("<tr><td  align='center' style='width:5%;height:5%;'><input name='' type='checkbox' value='' style = 'width:20px;height:20px' /></td><td  align='center' style='width:10%;height:5%;'>1</td><td  align='center' style='width:20%;height:5%;'><input type='text'/></td><td  align='center' style='width:20%;height:5%;'><input type='text'/></td><td  align='center' style='width:20%;height:5%;'><input type='text'/></td><td  align='center' style='width:20%;height:5%;'><input type='text'/></td></tr>")
	});
});

<!-- 保存修改 -->
$(function(){
    $("#actmanagenewTD-savesome").click(function(){
	    $("#actmanagenewTD-membertable td").each(function(){
			    if($(this).find("[type='text']").is(":visible")){
				    var temp = $(this).find("[type='text']").val();
					if(temp != ""){
					    
						$(this).html(temp);
					    $(this).find("[type='text']").remove();
					}
				}
			});
	});
});

