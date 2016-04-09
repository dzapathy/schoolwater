<%@page import="com.action.TableListAction"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.dao.DaoImpl"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="bean.StudentInfo"%>
<%@page import="bean.School"%>
<%@page import="org.bson.types.ObjectId"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" href="../css/countsoloD.css" />
<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../js/highcharts.js"></script>

<script type="text/javascript" src="../js/countsoloD-main.js"></script>


  <style type="text/css">
body{
    height:1000px;
	font-family:"微软雅黑";
}
#jr-fa{
	position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:1000px;
}
#jr-top{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:80px;
}
#jr-end{
    position:absolute;
	width:100%;
	left: 0px;
	top: 100px;
	height:900px;
	border-top:1px solid #ddd;
	border-bottom:1px solid #ddd;
}
#jr-end td{
    text-align:center;
}
#top-title{
    position:absolute;
	width:50%;
	left:2%;
	top: 30%;
	bottom:30%;
	line-height:32px;
	font-size:15px;
	font-weight:600;
	color:#515151;
	border-left:5px solid #ddd;
}
#allstudenttab td{
    height:40px;
}
</style>
</head>
<%
	int count = 5;
	//获取当前年份
	Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	ObjectId schoolId = (ObjectId)session.getAttribute("Organization_SchoolId");
	StudentInfo studentInfo = new StudentInfo();
	studentInfo.setSchoolId(schoolId);
	studentInfo.setGrade(year);
	BasicDBObject query = CreateQueryFromBean.EqualObj(studentInfo);
	
	long num = DaoImpl.GetSelectCount(StudentInfo.class, query);
	Map<Integer, Long> map = new HashMap<Integer, Long>();
	ArrayList<Integer> timeList = new ArrayList<Integer>();
	while(count != 0) {
		if(num != 0) {
			map.put(year, num);
			timeList.add(year);
			//年份减一
			year --;
			studentInfo.setGrade(year);
			query = CreateQueryFromBean.EqualObj(studentInfo);
			num = DaoImpl.GetSelectCount(StudentInfo.class, query);
			//count重置
			count = 5;
		}else {
			year --;
			studentInfo.setGrade(year);
			query = CreateQueryFromBean.EqualObj(studentInfo);
			num = DaoImpl.GetSelectCount(StudentInfo.class, query);
			count --;
		}
	}
    String data = "";
    int allnum = 0;
    for( ; allnum < timeList.size(); allnum ++) {
    	data += "[\'" + timeList.get(allnum) + "级\'," + map.get(timeList.get(allnum)) +"],";
    }
    
    
 %>  
  <body>
      <div id="jr-fa">
          <div id="jr-top">
	         <div id="top-title">&nbsp;&nbsp;学生注册量</div>
	    </div>
      <div id="jr-end">
      <table width="100%" height="300px"  border="0" cellspacing="0" cellpadding="0" id="tab1"> 
          <tr>
             <td width="50%;" style="padding:20px;">
                 <div id="chart_1" class="chart" style="position:relative;width:100%;height:100%;"></div>
             </td>
             <td width="50%;">
          	<table width="100%"   border="0" cellspacing="0" cellpadding="0" id="allstudenttab" > 
          		<tr>
          			<td>入学年份</td>
          			<td style="text-align:left;">人数</td>
          		</tr>  
          		<tr>
          			<td>&nbsp;</td>
          			<td style="text-align:left;">&nbsp;</td>
          		</tr> 
          		<%
          		
          		for(int i = 0; i < timeList.size(); i ++) {
          			int key = timeList.get(i);
         	 	%>
          		<tr>
          			<td><%=key+"级" %></td>
          			<td style="text-align:left;"><%=map.get(key) %></td>
          		</tr>
          		<%}%>
          	</table>
          	</td>
          </div>
          
      
      
<script type="text/javascript">
	// Two charts definition
	var chart1;

	// Once DOM (document) is finished loading
	$(document).ready(function() {

    

    // Second chart initialization (pie chart)
    chart1 = new Highcharts.Chart({
        chart: {
            renderTo: 'chart_1',
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: true,
            height: 400
        },
        colors:[
        	'#058DC7',
        	'#50B432',
        	'#ED561B', 
        	'#DDDF00', 
        	'#24CBE5', 
        	'#64E572', 
        	'#FF9655', 
			'#FFF263', 
			'#6AF9C4'
    	],
        title: {
            text: '年级分布比例'
        },
        tooltip: {
            pointFormat: '<b>{point.percentage}%</b>',
            percentageDecimals: 1
        },
        plotOptions: {
            pie: {
            	size:'90%',
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
         series: [{
         	type: 'pie',
            name: 'Dev #1',
            data:[         
               <%=data%>
            ]
         }]
    });
 });

	var allnum = <%=allnum %>
	$(function(){
		$("#tab1").css("height",(allnum+1)*40*2+"px");
		$("#jr-end").css("height",(allnum+2)*40*2+"px");
	})
</script>
      </div>
  </body>
</html>
