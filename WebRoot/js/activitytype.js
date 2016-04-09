// JavaScript Document
 		
var num = 1;
var isHasNull=0;   //添加是否有空div标记

$(function(){
    $("#activitytype-addtype1").click(function(){ 	
	    if(num <= 10 && isHasNull==0){      
	    	$("#typetable").find("tr:first").after("<tr><td>"+
			        //"<div class='changetype'  style='position:absolute;display:none;cursor:pointer;top:0%;left:0%'>*</div>"+
					"<div class='changetext' ><span id='actname'></span><span id='actid' style='display:none;'></span></div>"+
					"<div class='deletype'><img src='img/typedele.jpg' style='width:100%;height:100%;'/></div>"+
					"<div  class='changetype' ><img src='img/typechange.jpg' style='width:100%;height:100%;'/></div></td>"+
					"</tr>"
					
			       //"</div>"
			       );
			num++;
			
			//出现dialogdiv
			$.ShowDIV('DialogDiv');
			
        } else{
        	alert("数量已达上限或者有空类型，无法新增");
        }
	    
	    
	    
		$.addtypeid();
		
		//lyl添加：判断和控制div
		$(".changetext").find("#actname").each(function(){
	    	if($(this).html()==""){
	    		isHasNull = 1;
	    	}
	    });
		
		});
});





//删除按钮的响应事件
$(function(){
    $(".deletype").live('click', function() {
        var $parent = $(this).parent().parent();
        var data = $(this).parent().parent().find(".changetext").children("#actid").html();
        
        if(data==""){$(this).parent().parent().remove();}else{
        	
	        $.get("deleteType.action",{deleteType:data},function(data){
	            if(data=="true"){
	            	$parent.remove();
		            alert("删除成功");   
	            }else{
		            alert("删除失败，其他活动已绑定此类型");
	            }
	        }); 
        } 
        $.addtypeid();        
	});	
});

$.extend({'addtypeid':function(){
	    isHasNull = 0;
		$(".changetext").css("width","60%");
		num = $("#typetable").find("tr").size()-1;
}})




