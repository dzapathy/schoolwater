// JavaScript Document
$(function () {
        $(".ui_timepicker").datetimepicker({
            //showOn: "button",
            //buttonImage: "./css/images/icon_calendar.gif",
            //buttonImageOnly: true,
            showSecond: true,
            timeFormat: 'hh:mm:ss',
            stepHour: 1,
            stepMinute: 1,
            stepSecond: 1
        });
    })
	
	
	
	
	var setsubmitH;
	$(function(){
	    $(":radio").click(function(){
		    var item = $(this).val();  
		    
		    if(item == '2'){
				$("#activityteam-end-chooseinf").hide();
				 $("#activitysolo-end-all").hide();
				
		    } 
		    else if(item == '1'){
		         $("#activityteam-end-chooseinf").show();
				 $("#activitysolo-end-all").show();
		    }
			else{
				 $("#activityteam-end-chooseinf").hide();
				 $("#activitysolo-end-all").show();
			}
		});
	});
	
	
	
	
	






		


