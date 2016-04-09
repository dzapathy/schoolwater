// JavaScript Document
//<!-- 删除选中人员 -->

$(function(){
	$("#gradeadd-select1").change(
		function(){
			var inActivityId = $(this).children("option:selected").val();
			var time = new Date().getFullYear();
			var tableName =time+ "\"" +$(this).children("option:selected").text()+"\"" +"积分表";
			
			$("#gradeadd-membertable tr:not(':first')").remove();
			$("#gradeTableName").attr("value", tableName);
			$.get("searchTable.action",{
				"inActivityId":inActivityId
			},function(data){
				if(data == "error"){
					$("#gradeTableName").attr("value","");
					$("#gradeadd-select1").attr("value","-1");
   					$("#gradeadd-select2").attr("value","-1");
   					 
					alert("当前活动已经录入过积分信息，如需添加或修改请到单个积分统计表！");
				} else{
				var jsonData = JSON.parse(data);
				
				$("#gradeadd-select2").empty();
				
				$.each(jsonData,function(i,item){
					$("#gradeadd-select2").append("<option value="+item.id+">"+item.Name+"</option>");
				});
				}
			});
			
	});
			
			
});
$(function(){
	$("#gradeadd-search").click(
		function(){
			var tableId = $("#gradeadd-select2").children("option:selected").val();
			
			$.get("searchTableContent.action",{
				"tableId":tableId
			},function(data){
			
				var jsonData = JSON.parse(data);
				$("#gradeadd-membertable tr:not(':first')").remove();
				$.each(jsonData,function(i,item){
					$("#gradeadd-membertable tr:last").after(
				"<tr><td  align='center' style='width:5%;><input name='' type='checkbox' value='' style = 'width:20px;height:20px' /></td>"+
    		        "<td  align='center' style='width:5%;'>"+(i+1)+"</td>" +
					"<td  align='center' style='width:9%;'>"+item.Name+"</td>" +
					"<td  align='center' style='width:9%;'>"+item.IdCard+"</td>" +
					"<td  align='center' style='width:9%;'>"+item.MajorName+"</td>" +
					"<td  align='center' style='width:9%;'>"+item.Grade+"</td>" +
					"<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
					"<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
					"<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
					"<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
					"<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td>" +
					"<td  align='center' style='width:9%;'><input type='text' style='width:80%;'/></td></tr>");
				});
			});
		}
		
	);
});




$(function(){
$("#newact").click(function(){
    $("#gradeadd-select1").attr("disabled","disabled");
    $("#gradeadd-select2").attr("disabled","disabled");
    $("#gradeTableName").attr("value","");
    $("#gradeadd-select1").attr("value","-1");
    $("#gradeadd-select2").attr("value","-1");
    $("#gradeadd-membertable tr:not(':first')").remove();
});
});
$(function(){
$("#oldact").click(function(){
    $("#gradeadd-select1").attr("disabled",false);
    $("#gradeadd-select2").attr("disabled",false);
});
});


