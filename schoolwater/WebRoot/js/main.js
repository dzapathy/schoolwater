// JavaScript Document
$(function(){
    //根据span中的文字个数，变化infheadL的宽度
    var str1 = $("span:first").html();
	$("#infheadL").width(str1.length*40+"px");
	
	//根据infheadL的width和left来调整infheadM的left值
    var numleft = $("#infheadL").width() + $("#infheadL").position().left + 35;
	$("#infheadM").css("left",numleft+"px");
})

var clickedtr;//被点击的tr的索引值
$(function(){
    $(".tr-shrink").find("td").each(function(){
	    $(this).css("border-top","1px solid #eee");
	});
	$(".tr-shrink:last").find("td").each(function(){
	    $(this).css("border-bottom","1px solid #eee");
	});
	$(".tr-shrink:eq(2)").find("td").each(function(){
	    $(this).css("border-bottom","1px solid #eee");
	});
	$(".tr-shrink:eq(8)").find("td").each(function(){
	    $(this).css("border-bottom","1px solid #eee");
	});
    $(".tr-shrink").bind("mouseover",function(){
	        $(this).css("cursor","pointer");
		    $(this).find("td:first").css("border-left","5px solid #1C90F2");
			$(this).css("background-color","#f7f7f7");
			$(this).find("td:last").css("color","#1C90F2")
	});
	$(".tr-shrink").bind("mouseout",function(){
	        if($(this).index() != clickedtr){
		        $(this).find("td:first").css("border-left","0px solid #1C90F2");
			    $(this).css("background-color","#fff");
			    $(this).find("td:last").css("color","#515151");
			}
	});
	$(".tr-shrink").bind("click",function(){
	        clickedtr = $(this).index();
		    $(this).find("td:first").css("border-left","5px solid #1C90F2");
			$(this).css("background-color","#f7f7f7");
			$(this).find("td:last").css("color","#1C90F2");
			
			$(".tr-shrink").each(function(){
			    if($(this).index() != clickedtr){
				    $(this).find("td:first").css("border-left","0px solid #1C90F2");
			        $(this).css("background-color","#fff");
			        $(this).find("td:last").css("color","#515151");
				}
			});
	});
})


 function autoHeight(){
        var iframe = document.getElementById("Iframe");
        if(iframe.Document){//ie自有属性
            iframe.style.height = iframe.Document.documentElement.scrollHeight;
        }else if(iframe.contentDocument){//ie,firefox,chrome,opera,safari
            iframe.height = iframe.contentDocument.body.offsetHeight ;
        }
    }
	
     $(document).ready(function(){
    	 $("#list9").css("background","#72b6eb");
 		 $("#lists9").css("color","#FFFFFF");
     });
	
	$(function(){
		$(".LList").click(function(){
			$(this).css("background","#72b6eb");
			$(this).find("td").css("color","#FFFFFF");
			var LListindex = $(this).index();
			$(".LList").each(function(){
				if($(this).index() != LListindex){
					$(this).css("background","#FFFFFF");
					$(this).find("td").css("color","#222222");
				}
			});
		});
	});
	
	
	function changeiframeH(){
		$("#infinsertR").load(function() {
 		    var clientHeight = $("#infinsertR").contents().find("body").height();
 		    $("#infinsertR").css("height",clientHeight);
 		 });
	}
	
	function changeToCreActivity(){
	    document.getElementById("infinsertR").src="../createActivity/createActivity.jsp";
	}
	function changeToActivityManage(){
		document.getElementById("infinsertR").src="../activityManage/activityList.jsp";
	}
	function changeToActivityType(){
		document.getElementById("infinsertR").src="../activityType/activitytype.jsp";
	}
	function changeToStudentList(){
		document.getElementById("infinsertR").src="../studentList/jr.jsp";
	}
	function changeToCorManage(){
		document.getElementById("infinsertR").src="../corporationManage/clubmanage.jsp";
	}
	function changeToGradeWhole(){
		document.getElementById("infinsertR").src="../grade/gradewhole.jsp";
	}
	function changeToFeedback(){
		document.getElementById("infinsertR").src="../feedback/feedback.jsp";
	}
	function changeToAnnounce(){
		document.getElementById("infinsertR").src="../login/announce.jsp";
	}
	function changeToTable(){
		document.getElementById("infinsertR").src="../table/alltable.jsp";
	}
	function changeToOmnipotent(){
		document.getElementById("infinsertR").src="../omnipotent/omnipotentT.jsp";
	}
	function changeToSchInfo(){
		document.getElementById("infinsertR").src="../changeSchInfo/changeSchoInfo.jsp";
	}