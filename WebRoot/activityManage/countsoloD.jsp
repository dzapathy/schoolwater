<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
	<link rel="stylesheet" href="../css/countsoloD.css" />
	<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../js/highcharts.js"></script>	
	<script type="text/javascript" src="../js/countsoloD-main.js"></script>
</head>
<style>
body{
	height:940px;
	font-family:"微软雅黑";
	color:#515151;
}
#countsoloD-fa{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:940px;
}



#countsoloD-analysis1{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:150px;
	font-size:15px;
}
#countsoloD-title1{
    position:absolute;
	width:12%;
	height:24px;
	cursor:pointer;
	line-height:24px;
	text-align:center;
}
#countsoloD-content1{
    position:absolute;
	width:100%;
	height:150px;
	top:50px;
}
#countsoloD-Table{
    border-top:1px solid #ddd;
	border-bottom:1px solid #ddd;
}
#countsoloD-content1 td{
    text-align:center;
    height:50px;
    width:50%;
}


#countsoloD-analysis2{
    position:absolute;
	width:100%;
	left:0px;
	top: 250px;
	height:300px;
	font-size:15px;
	
}
#countsoloD-title2{
    position:absolute;
	width:12%;
	height:24px;
	cursor:pointer;
	line-height:24px;
	text-align:center;
}
#countsoloD-content2{
    position:absolute;
	width:100%;
	height:400px;
	top:50px;
	text-align:center;
	border-top:1px solid #ddd;
	border-bottom:1px solid #ddd;
}
#countsoloD-content2 td{

}

#chart_1{
    position:absolute;
    top:50px;
    width:30%;
}
#chart_2{
    position:absolute;
    width:30%;
    top:50px;
	left:35%;
}
#chart_3{
    position:absolute;
    width:30%;
    top:50px;
	left:70%;
}


</style>
<%
	//获取值
	String activityName  =(String)session.getAttribute("SelectedActivityName"); //活动名称
	Date activityTime = (Date) session.getAttribute("SelectedActivityReleaseTime"); //活动时间
	String t= new SimpleDateFormat("yyyy-MM-dd").format(activityTime);
	Integer bmCount =(Integer) request.getAttribute("bmCount");	//报名人数
	Integer qdCount =(Integer) request.getAttribute("qdCount");//签到人数
	Integer man =(Integer) request.getAttribute("man");//男生人数
	Integer woman =(Integer) request.getAttribute("woman");//女生人数
	Map<Integer, Integer> map  =(Map<Integer, Integer>) request.getAttribute("map"); //年份集合
 	Integer pjCount =(Integer) request.getAttribute("pjCount");//评价数量
 	Integer pjZhichi =(Integer) request.getAttribute("pjZhichi");//支持人数
 	Integer pjFandui =(Integer) request.getAttribute("pjFandui");//评价反对
 	String str ="";
 	for(Integer key :map.keySet()){
 		str +="['"+key+"',"+map.get(key)+"],";		
 	}
 %>
<body>
<div id="countsoloD-fa">
    
	<div id="countsoloD-analysis1">
	    <div id="countsoloD-title1"><div style="position:relative;margin-left:20px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;分析模块一</div></div>
		<div id="countsoloD-content1">
		     <table width="100%"  border="0" cellspacing="0" cellpadding="" id="countsoloD-Table">
		        <tr>
		            <td>报名总人数：</td>
					<td><%=bmCount %>人</td>
				</tr>
				<tr>
				    <td>签到人数：</td>
					<td><%=qdCount %>人</td>
				</tr>
				 <tr>
		            <td>评论数量：</td>
					<td><%=pjCount %>条</td>
				</tr>
		    </table>
		</div>
	</div>
	<div id="countsoloD-analysis2">
	    <div id="countsoloD-title2"><div style="position:relative;margin-left:20px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;分析模块二</div></div>
		<div id="countsoloD-content2">
		     <div id="chart_1" class="chart"></div>
			 <div id="chart_2" class="chart"></div>
			 <div id="chart_3" class="chart"></div>
		</div>
		<script type="text/javascript">
			// Two charts definition
			var chart1, chart2, chart3;

			// Once DOM (document) is finished loading
			$(document).ready(function() {

    

    // Second chart initialization (pie chart)
    chart1 = new Highcharts.Chart({
        chart: {
            renderTo: 'chart_1',
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            height: 300
        },
        title: {
            text: '报名男女比例'
        },
        tooltip: {
            pointFormat: '<b>{point.percentage}%</b>',
            percentageDecimals: 1
        },
        plotOptions: {
            pie: {
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
                 ['男生', <%=man%>],
                ['女生', <%=woman%>]
            ]
         }]
    });


    chart2 = new Highcharts.Chart({
        chart: {
            renderTo: 'chart_2',
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            height: 300
        },
        title: {
            text: '年级分布比例'
        },
        tooltip: {
            pointFormat: '<b>{point.percentage}%</b>',
            percentageDecimals: 1
        },
        plotOptions: {
            pie: {
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
                <%=str%>
            ]
         }]
    });
	
	
	chart3 = new Highcharts.Chart({
        chart: {
            renderTo: 'chart_3',
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            height: 300
        },
		colors:[
            '#FF611D',//第一个颜色，欢迎加入Highcharts学习交流群294191384
            '#0c62f7',//第二个颜色
		],
        title: {
            text: '支持反对统计'
        },
        tooltip: {
            pointFormat: '<b>{point.percentage}%</b>',
            percentageDecimals: 1
        },
        plotOptions: {
            pie: {
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
                ['支持', <%=pjZhichi%>],
                ['反对', <%=pjFandui%>]
            ]
         }]
    });
   
   
   
   
   
});
		</script>
	</div>	
</div>
</body>
</html>
