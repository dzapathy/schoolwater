// JavaScript Document
var oldvalue = new Array(7);//保存旧信息
<!-- 删除选中人员 -->
$(function(){
    $("#actmanageB-delesome").live('click', function() {
	    $("#actmanageB-membertable tr").each(function(){
		     if($(this).find("[type='checkbox']").attr("checked")){
			     $(this).remove();
				  if($("#actmanageB-members").find("td:first").html() == "取消"){
	                 $("#actmanageB-members").find("td:first").html("全选");
		          }
			 }
		});
	});
});

<!-- 全选 -->
$(function(){
    $("#actmanageB-members").find("td:first").live('click', function() {
	    //全选bug修补
		var isall = 0
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


<!-- 新增报名表成员 -->
$(function(){
    $("#actmanageB-addsome").click(function(){
	   var isHaveNew = 0;
	   $("#actmanageB-membertable").find("td").each(function(){
	       if($(this).find("[type='text']").is(":visible") == true){
		       isHaveNew = 1;
		   }
	   });
	   if(isHaveNew == 1){
	       alert("请先保存新增的成员信息");
	   }else{
	   		$("#actmanageB-membertable").find("tr:last").after("<tr class='addmember2'><td  align='center' style='width:10%;height:5%;'><input name='' type='checkbox' value='' style = 'width:20px;height:20px' /></td> <td  align='center' style='width:10%;height:5%;'>1</td><td  align='center' style='width:10%;height:5%;'><input type='text' style='width:100px;' visible='true'/></td><td  align='center' style='width:10%;height:5%;'><input type='text' style='width:100px;' /></td><td  align='center' style='width:10%;height:5%;'><input type='text' style='width:100px;' /></td><td  align='center' style='width:10%;height:5%;'><input type='text' style='width:100px;' /></td><td  align='center' style='width:10%;height:5%;'><div class='changememberinfo' style='display:none;'>编辑</div><div class='savememberinfo' >保存</div><div class='nochange'>取消</div></td></tr>");
			//旧值清零
			for(var j = 0; j < 7; j++){
			    oldvalue[j] = 0;
			}
	   }
	});
});

<!-- 确定新增成员 -->
$(function(){
    $(".savememberinfo").live('click', function() {
	    var isFull = 0;
		$(this).parent().parent().find("[type='text']").each(function(){
		    if($(this).val() == "" || $(this).val() == null){
			    isFull = 1;
			}
		})
		
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
			//旧值清零
			for(var j = 0; j < 7; j++){
			    oldvalue[j] = 0;
			}
		}
	});
});





<!-- 编辑成员 -->
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
		
	    	$("#actmanageB-membertable tr").eq(temp).find("td:gt(1):lt(4)").each(function(){
		    	if($(this).find("[type='text']").length == 0){
			   	 	var addelem = $("<input type='text' style='width:100px;' visible='true'/>");
					var addval = $(this).html();
				
					//向oldvalue中保存
				
					oldvalue[i] = addval;
					i++;
				
					$(this).html("");
					$(this).append(addelem);
					$(this).find("[type='text']").val(addval);
				}
			});
		
		//显示保存和取消
		
		}
	});
});

//取消按钮
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
			//旧值清零
			for(var j = 0; j < 7; j++){
			    oldvalue[j] = 0;
			}
		}
	});
});