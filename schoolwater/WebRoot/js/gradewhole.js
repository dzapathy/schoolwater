// JavaScript Document

$(function(){
    $("#gradewhole-addgrade").click(function(){
	    $("#gradewhole-frame").attr("src","gradeadd.jsp");
	});
	$("#gradewhole-searchgradesolo").click(function(){
	    $("#gradewhole-frame").attr("src","gradesearchsolo.jsp");
	});
	$("#gradewhole-searchgradetype").click(function(){
	    $("#gradewhole-frame").attr("src","gradesearchtype.jsp");
	});
});