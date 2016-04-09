<%@ page language="java" import="java.util.*,com.action.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>校园时光</title>
<link rel="shortcut icon" href="inf/img/logo/logo.ico" />
<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
<link rel="stylesheet" href="../css/main.css" />
<script src="../js/main.js"></script>

</head>
<style>
body{
    font-family:"微软雅黑";
	
}
</style>
<%
	String schoolName =  (String)session.getAttribute("School_Name");
	String schoolLogoUrl = (String)request.getAttribute("schoolLogoUrl");
 %>



<body onLoad="initlistscolor()">


<div id="infmid">
<div id="infheadL">
  <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="20%" align="center"><img src="mainimg/img/schoollogo.jpg" width="50px" height="50px"/></td>
      <td width="80%"><span style="font-size:30px;color:#515151;font-weight:500;"><%=schoolName %>活动管理</span></td>
    </tr>
  </table>
</div>
<div id="infheadM">
     N次方
</div>
<div id="infheadR">
  <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="70%" align="center" style="border-left:5px solid #ddd;" ><span style="font-size:14px;color:#515151;">欢迎您，<%=session.getAttribute("Manager_Name") %></span></td>
      <td width="30%" align="center" style="border-left:1px solid #ddd;"><span style="font-size:14px;color:#72b6eb;"><a href="login.jsp">退 出</a></span></span></td>
    </tr>
  </table>
</div>
</div>


<div id="infcontent1">
	    <div id="infinsertL">
		
	      <table width="100%" height="850px" border="0" cellspacing="0" cellpadding="0" id="inf-table1">
            <tr>
              <td class="insertLtL" align="center"><img src="mainimg/img/gongneng.png" width="50%" height="50%"/></td>
              <td class="insertLtRT"><span style="font-weight:600;font-size:18;">功&nbsp;&nbsp;能</span></td>
            </tr>
            <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToStudentList();">学生注册量</td>
			</tr>
			 <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToCorManage();">社团管理</td>
			</tr>
			 <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToSchInfo();">信息修改</td>
			</tr>
            <tr>
              <td class="insertLtL" align="center"><img src="mainimg/img/guanli.png" width="50%" height="50%"/></td>
              <td class="insertLtRT"><span style="font-weight:600;font-size:18;">管&nbsp;&nbsp;理</span></td>
            </tr>
			 <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToActivityType();">活动类型</td>
			</tr>
			 <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToCreActivity();">创建活动</td>
			</tr>
			 <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToActivityManage();">活动管理</td>
			</tr>
			 <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToGradeWhole();">积分管理</td>
			</tr>
			 <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToTable();">所有表单</td>
			</tr>
			 <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToOmnipotent();">创建表单</td>
			</tr>
            <tr>
              <td class="insertLtL" align="center"><img src="mainimg/img/guanyu.png" width="50%" height="50%"/></td>
              <td class="insertLtRT"><span style="font-weight:600;font-size:18;">关&nbsp;&nbsp;于</span></td>
            </tr>
             <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToFeedback();">反馈留言</td>
			</tr>
			 <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT" onClick="changeToAnnounce();">公告通知</td>
			</tr>
			 <tr class="tr-shrink"> 
			    <td class="insertLtL"></td>
				<td class="insertLtRT">开放平台</td>
			</tr>
          </table>
	    </div>
		<div id="frameBox">
		    <iframe src="../login/announce.jsp" marginheight="0" marginwidth="0" frameborder="0" scrolling="auto"  name="infinsertR " id="infinsertR"></iframe>
		</div>
	
</div>
<div id="infend">
    <div id="end-content">
      <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>Copyright&nbsp;@&nbsp;2015.4 LYL</td>
          <td class="endtext">关于我们</td>
		  <td>|</td>
          <td class="endtext">服务协议</td>
		  <td>|</td>
          <td class="endtext">运营规范</td>
		  <td>|</td>
          <td class="endtext">客服中心</td>
		  <td>|</td>
          <td class="endtext">投诉建议</td>
        </tr>
      </table>
    </div>
</div>


<script type="text/javascript">



$(function(){
	
    //根据span中的文字个数，变化infheadL的宽度
    var str1 = $("span:first").html();
	$("#infheadL").width(str1.length*40+"px");
	
	//根据infheadL的width和left来调整infheadM的left值
    var numleft = $("#infheadL").width() + $("#infheadL").position().left + 35;
	$("#infheadM").css("left",numleft+"px");
})

var clickedtr = 13;//被点击的tr的索引值
$(function(){

    //倒数第二个为初始
	$(".tr-shrink:eq(10)").find("td:first").css("border-left","5px solid #1C90F2");
	$(".tr-shrink:eq(10)").css("background-color","#f7f7f7");
	$(".tr-shrink:eq(10)").find("td:last").css("color","#1C90F2");
	

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

$(function(){
	$("#end-content").find("td").bind("mouseover",function(){
		var index1 = $(this).index();
		if(index1==1||index1==3||index1==5||index1==7||index1==9){
			$(this).css("color","#1C90F2");
			$(this).css("cursor","pointer");
		}
	});
	$("#end-content").find("td").bind("mouseout",function(){
			$(this).css("color","#CCC");
	});
})
 
</script>
</body>
</html>
