// JavaScript Document
var num = 1;
$(function(){
    $("#clubmanage-addclub").click(function(){
    	var hasnulltext = 0;
    	$(".changeclubtext").each(function(){
    		if($(this).html().trim() == ""){
    			hasnulltext = 1;
    		}
    	});
    	if(hasnulltext == 0){
		  $("#clubmanage-addclub").after("<div id='clubmanage-nowsoloclub"+num+"' class='clubmanage-nowallclub' >"+
                "<div class='changeclub'  style='position:absolute;display:block;cursor:pointer;top:10%;height:80%;left:0%;width:20px;height:24px;'><img src='img/clubmchange.jpg' style='width:100%;height:100%;'/></div>"+
				"<div class='changeclubtext' style='position:absolute;width:60%;left:20%;top:10%;height:80%;text-align:center;border:1px solid #CCCCCC;'></div>"+
                "<div class='deletclub' style='position:absolute;display:block;cursor:pointer;top:10%;height:80%;right:0%;width:20px;height:24px;'><img src='img/clubmdele.jpg' style='width:100%;height:100%;'/></div>"+
          "</div>");
		  
		  //增加自适应高度
		  var getnum = $(".clubmanage-nowallclub").size();
		  if(getnum%6 == 0){
		      var setsubmitH = $("#clubmanage-content1").height()+80+"px";
		      $("#clubmanage-content1").css("height",setsubmitH);
			  $("#clubmanage-content2").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-content1").height()+30+"px";
			  $("#clubmanage-dosome").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-content1").height()+80+"px";
			  $("#clubmanage-members").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-content1").height()+10+"px";
			  $("#clubmanage-title2-2").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-fa").height()+45+"px";
			  $("#clubmanage-fa").css("height",setsubmitH);
		  }		  
		  $.sortnowallclub();
		  var setsubmitH1 = $("#clubmanage-content1").height()+100+"px";
			var setsubmitH2 = $("#clubmanage-content1").height()+70+"px";
			$("#clubmanage-title2-2").css("top",setsubmitH1);
			$("#clubmanage-dosome").css("top",setsubmitH2);
			alert("点击新建的空方框左侧铅笔图标可以设置名称！");
    	}else{
    		alert("不能有空机构存在");
    	}  
    	});
    
});


$(function(){
    $(".clubmanage-nowallclub").live('mouseover', function() {
        $(this).find(".changeclub").show();
		$(this).find(".deletclub").show();
    });	
	$(".clubmanage-nowallclub").live('mouseout', function() {
        $(this).find(".changeclub").hide();
		$(this).find(".deletclub").hide();
    });	
});

$(function(){
    $(".deletclub").live('click', function() {
	    $(this).parent().remove();
		
		 //减少自适应高度
		  var getnum = $(".clubmanage-nowallclub").size();
		  if(getnum != 0 && getnum%6 == 0){
		       
		      var setsubmitH = $("#clubmanage-content1").height()-45+"px";
		      $("#clubmanage-content1").css("height",setsubmitH);
			  $("#clubmanage-content2").css("top",setsubmitH);
			  
			   setsubmitH = $("#clubmanage-content1").height()+30+"px";
			  $("#clubmanage-dosome").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-content1").height()+80+"px";
			  $("#clubmanage-members").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-content1").height()+10+"px";
			  $("#clubmanage-title2-2").css("top",setsubmitH);
			  
			  setsubmitH = $("#clubmanage-content1").height()+10+"px";
			  $("#clubmanage-title2-2").css("top",setsubmitH);
			  setsubmitH = $("#clubmanage-fa").height()-45+"px";
			  $("#clubmanage-fa").css("height",setsubmitH);
		  }
		  
		$.sortnowallclub();
		var setsubmitH1 = $("#clubmanage-content1").height()+100+"px";
		var setsubmitH2 = $("#clubmanage-content1").height()+70+"px";
		$("#clubmanage-title2-2").css("top",setsubmitH1);
		$("#clubmanage-dosome").css("top",setsubmitH2);
    });	
});

//<!--无限制狂刷小算法 by lyl -->
$.extend({'sortnowallclub':function(){
    var j = 0;
	var allnum1 = 0;
	var allnum2;
	var allnum3;
    var vertinum = $(".clubmanage-nowallclub").size()/6;
	vertinum = Math.ceil(vertinum);
	for(i = 0; i < $(".clubmanage-nowallclub").size(); i++){
	    if(allnum1%6 == 0){
		  
		    j++;
		}
	    allnum2 = allnum1;
		allnum1++;
		allnum2 = (allnum2 % 6) * 15 + 5;
		if(j > vertinum){
		    break;
		}
		allnum3 = (j - 1)*45 + 75;
        $(".clubmanage-nowallclub").eq(i).css("left",allnum2+"%");
		$(".clubmanage-nowallclub").eq(i).css("top",allnum3+"px");
    }
  
}})

//修改

var show_index;
var show_content;
$(function(){
    $(".changeclub").live('click', function() {
	    //得到index和len，则所点击的activitytype-addtype的值就是2+len-index
	
		show_index = $(this).parent().index()-3;
		$.ShowDIV('DialogDiv');
		
		
	});
});

$(function(){
    $("#closediv").live('click', function() {
		$.closeDiv('DialogDiv');
		$.showText();
	});
});

$.extend({'ShowDIV':function(thisObjID){ 
    $("#BgDiv").css({ display: "block", height: $(document).height() });
    var yscroll = document.documentElement.scrollTop;
    $("#" + thisObjID).css("top", "100px");
    $("#" + thisObjID).css("display", "block");
    $("#addtext").val(" ");
    document.documentElement.scrollTop = 0;
}})

$.extend({'closeDiv':function(thisObjID){ 
	show_content = $("#addtext").val();
    $("#BgDiv").css("display", "none");
    $("#" + thisObjID).css("display", "none");
}})

$.extend({'showText':function(){ 
    $('.changeclubtext').eq(show_index).html(show_content);
	
}})


//删除选中人员 
$(function(){
    $("#clubmanage-delesome").live('click', function() {
	    $("#clubmanage-membertable tr").each(function(){
		     if($(this).find("[type='checkbox']").attr("checked")){
			     $(this).remove();
				 if($("#clubmanage-members").find("td:first").html() == "取消全选"){
	                  $("#clubmanage-members").find("td:first").html("全选");
		          }
			 }
			  
		});
	});
});

//全选
$(function(){
    $("#clubmanage-members").find("td:first").live('click', function() {
	    if($(this).html() == "全选"){
	        $(this).html("取消全选");
		}
		else{
		    $(this).html("全选");
		}
	    $("#clubmanage-membertable tr").each(function(){
		    if($(this).find("[type='checkbox']").attr("checked")){
		         $(this).find("[type='checkbox']").attr("checked", false);
			 }
			 else{
			     $(this).find("[type='checkbox']").attr("checked", true);
			 }
			
		});
	});
});