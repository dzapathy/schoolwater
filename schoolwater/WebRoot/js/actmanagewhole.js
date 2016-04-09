// JavaScript Document
$(function() {
	
	$("#actmanagewhole-qdTable").click(function() {
		$("#actmanagewhole-frame").attr("src", "activitySign.jsp");
	});
	$("#actmanagewhole-allAct").click(function() {
		$("#actmanagewhole-frame").attr("src", "activityTeams.jsp");
	});

	$("#actmanagewhole-sendNews").click(function() {
		$("#actmanagewhole-frame").attr("src", "activityNews.jsp");
	});
	$("#actmanagewhole-deleAct").click(function() {
		$("#actmanagewhole-frame").attr("src", "activityDelete.jsp");
	});
	$("#actmanagewhole-changeAct").click(function() {
		$("#actmanagewhole-frame").attr("src", "activityUpdate.jsp");
	});
	$("#actmanagewhole-creNewTable").click(function() {
		$("#actmanagewhole-frame").attr("src", "activityNewTable.jsp");
	});
	$("#actmanagewhole-tongji").bind("click",function(){
		//location.href="activityCount.action?activityId="+$("#activityId").text();
		$("#actmanagewhole-frame").attr("src", "activityCount.action?activityId="+$("#activityId").text());
	});
});