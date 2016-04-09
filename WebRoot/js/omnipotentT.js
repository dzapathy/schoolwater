// JavaScript Document
var num = 2;
$(function(){
    
    $("#omnipotentT-solotable").find("tr:last").after("<div id='omnipotentT-addsoloinfo'>+</div>"
	);
	 
});



$(function(){
    $("#omnipotentT-addsoloinfo").live('click', function() {
	    if(num < 7){
		num++;
        $("#omnipotentT-solotable").find("tr:last").after("<tr><td  align='center' style='width:10%;'>"+num+"</td><td  align='center' style='width:80%;'><input type='text' name='nameList' value=''/> </td><td  align='center' style='width:20%;display: none;'><input type='text' name='lengthList' value='1' /></td><td  align='center' style='width:10%;display: none;'><input name='chooseList' type='checkbox' value='"+num+"' checked style = 'width:20px;height:20px'/></td><td  align='center' style='width:10%;'><img src='activityimg/delesolo2.png' style='width:20px;height:20px;' class='omnipotentT-delesoloinfo'/></td></tr>");
		}else{
			alert("数量已达上限噢");
		}
    });	
	
});

var delenum;
$(function(){
    $(".omnipotentT-delesoloinfo:gt(1)").live('click', function() {
	    delenum = $(this).parent().parent().index();
		$("#omnipotentT-solotable tr").eq(delenum).remove();
		num--;
		delenum--;
		$("#omnipotentT-solotable tr:gt("+delenum+")").each(function(i){
              var tempcontent = $(this).children("td:first").html()-1;
			  $(this).children("td:first").html(tempcontent);
          
        });
	});
});	


//<!-- 确认创建 -->
$(function(){
    $("#omnipotentT-createT").click(function(){
	    location.href="omnipotentTD.jsp";
	});
});