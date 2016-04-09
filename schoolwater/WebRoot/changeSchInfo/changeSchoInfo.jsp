<%@page import="com.dao.DaoImpl"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="staticData.StaticString"%>
<%@page import="com.dao.CreateQueryFromBean"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="bean.School"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8"> 
    <title>修改学校信息</title>
<script type="text/javascript" src="../jquery/choosetime/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.form.js"></script>

</head>
<script type="text/javascript">
// JavaScript Document

var china=[['海淀区','东城区','西城区','丰台区','朝阳区','石景山区','门头沟区','昌平区','房山区','大兴区','通州区','顺义区','平谷区','怀柔区'],
['和平区','河东区','河西区','南开区','河北区','红桥区','滨海新区','东丽区','津南区','西青区','东丽区','津南区','北辰区','武清区','宝坻区','蓟县'],
['黄浦区','徐汇区','长宁区','静安区','普陀区','闸北区','虹口区','杨浦区','闵行区','宝山区','嘉定区','浦东新区','金山区','松江区','青浦区','奉贤区','崇明县'],
['渝中区','大渡口区','江北区','沙坪坝区','九龙坡区','南岸区','北碚区','渝北区','巴南区','城市发展新区','渝东北生态涵养发展区'],
['石家庄', '唐山市', '邯郸市', '秦皇市岛', '保市定', '张家市口', '承德市', '廊坊市', '沧州市', '衡水市', '邢台市'],
['太原市','大同市','阳泉市','长治市','晋城市','朔州市','晋中市','运城市','忻州市','临汾市','吕梁市'],
['沈阳市','大连市','鞍山市','抚顺市','本溪市','丹东市','锦州市','营口市','阜新市','辽阳市','盘锦市','铁岭市','朝阳市','葫芦岛市'],
['长春市','吉林市','四平市','辽源市','通化市','白山市','松原市','白城市','延边州','长白山管委会'],
['哈尔滨市','齐齐哈尔市','大庆市','佳木斯市','牡丹江市','七台河市','双鸭山市','黑河市','鸡西市','伊春市','绥化市','鹤岗市','加格达奇市'],
['南京市','苏州市','无锡市','常州市','南通市','扬州市','镇江市','泰州市','盐城市','连云港市','宿迁市','淮安市','徐州市'],
['杭州市','宁波市','温州市','嘉兴市','湖州市','绍兴市','金华市','衢州市','舟山市','台州市','丽水市'],
['合肥市','芜湖市','蚌埠市','淮南市','马鞍山市','淮北市','铜陵市','安庆市','黄山市','滁州市','阜阳市','宿州市','巢湖市','六安市','亳州市','池州市','宣城市'],
['福州市','厦门市','莆田市','三明市','泉州市','漳州市','南平市','龙岩市','宁德市'],
['南昌市','景德镇市','萍乡市','九江市','新余市','鹰潭市','赣州市','吉安市','宜春市','抚州市','上饶市'],
['济南市','青岛市','淄博市','枣庄市','东营市','烟台市','潍坊市','济宁市','泰安市','威海市','日照市','莱芜市','临沂市','德州市','聊城市','滨州市','菏泽市'],
['郑州市','开封市','洛阳市','平顶山市','安阳市','鹤壁市','新乡市','焦作市','濮阳市','许昌市','漯河市','三门峡市','南阳市','商丘市','信阳市','周口市','驻马店市'],
['武汉市','黄石市','十堰市','荆州市','宜昌市','襄樊市','鄂州市','荆门市','孝感市','黄冈市','咸宁市','随州市'],
['长沙市','株洲市','湘潭市','衡阳市','邵阳市','岳阳市','常德市','张家界市','益阳市','郴州市','永州市','怀化市','娄底市'],
['广州市','深圳市','珠海市','汕头市','韶关市','佛山市','江门市','湛江市','茂名市','肇庆市','惠州市','梅州市','汕尾市','河源市','阳江市','清远市','东莞市','中山市','潮州市','揭阳市','云浮市'],
['文昌市','琼海市','万宁市','五指山市','东方市','儋州市'],
['成都市','自贡市','攀枝花市','泸州市','德阳市','绵阳市','广元市','遂宁市','内江市','乐山市','南充市','眉山市','宜宾市','广安市','达州市','雅安市','巴中市','资阳市'],
['贵阳市','六盘水市','遵义市','安顺市'],
['昆明市','曲靖市','玉溪市','保山市','昭通市','丽江市','普洱市','临沧市'],
['西安市','铜川市','宝鸡市','咸阳市','渭南市','延安市','汉中市','榆林市','安康市','商洛市'],
['兰州市','金昌市','白银市','天水市','嘉峪关市','武威市','张掖市','平凉市','酒泉市','庆阳市','定西市','陇南市'],
['西宁市','格尔木市','玉树','果洛','海东','海西','海南','海北'],
['台北市','高雄市','基隆市','台中市','台南市','新竹市','嘉义市'],
['南宁市','柳州市','桂林市','梧州市','北海市','防城港市','钦州市','贵港市','玉林市','百色市','贺州市','河池市','来宾市','崇左市'],
['呼和浩特市','包头市','乌海市','赤峰市','通辽市','鄂尔多斯市','呼伦贝尔市','巴彦淖尔市','乌兰察布市'],
['拉萨市','昌都市','日喀则市','林芝市','山南地区','那曲地区','阿里地区'],
['银川市','石嘴山市','吴忠市','固原市','中卫市'],
['乌鲁木齐市','克拉玛依市'],
['中西区','湾仔区','东区','南区','油尖旺区','深水埗区','九龙城区','黄大仙区','观塘区北区','大埔区','沙田区','西贡区','荃湾区','屯门区','元朗区','葵青区','离岛区'],
['花地玛堂区','圣安多尼堂区','大堂区','望德堂区','风顺堂区','嘉模堂区','圣方济各堂区']];

function chinaChange(province, city) {
	var pv, cv;
	var i, ii;
	pv = province.selectedIndex -1;
	cv = city.value;
	city.length = 1;
	
	if (typeof (china[pv]) == 'undefined') return;

	for (i = 0; i < china[pv].length; i++) { 
		ii = i + 1;
		city.options[ii] = new Option();
		city.options[ii].text = china[pv][i];
		city.options[ii].value = china[pv][i];
	}
	city.options[0].text = "请选择市区";

};

window.onload=function(){
	
	var  oldPro=document.getElementById("oldPro").innerHTML;
	var  oldCity=document.getElementById("oldCity").innerHTML;
	//alert(oldPro+oldCity);

	var selectCity=document.getElementById("schcity");
	var selectPro=document.getElementById("schprovince").options;
	var index;
	for(var i=0;i<selectPro.length;i++){
		//alert(selectPro[i].value+oldPro);
		if(selectPro[i].value==oldPro){
			selectPro[i].selected=true;
			index=i;
			break;
		}
	}
	var selectProArray=china[index-1];//得到选中的省份对应的城市数组
	var city=document.createElement('option');
	city.value=oldCity;
	city.text=oldCity;
	city.selected=true;
	selectCity.appendChild(city);
	for(var j=0;j<selectProArray.length;j++){
		if(selectProArray[j]!=oldCity){
			var city=document.createElement('option');
			city.value=selectProArray[j];
			city.text=selectProArray[j];
			city.selected=false;
			selectCity.appendChild(city);
		}
	}
	
}
		
</script>
<script type="text/javascript">
//上传文件操作

var thisfilename;

      $(function(){
          $("input:file:first").on("change",function(event){
		      if($("#fileactContentList").is(":visible") == true){
		    	  alert("请先保存活动logo");
		    	  $("#textfield").val("");
		      }else{
		    	//for(var i = 0; i < event.target.files.length; i++){
                  var file = event.target.files[0];
                  if(file){
                	  $("#changeSchInfo-content3").css("top","450px");
                      var r = new FileReader();
                      r.file = file;
                      r.readAsDataURL(file);
                      r.onload = function(e){
                          var contents = e.target.result;
                          var thisfile = this.file;
						  $("#changeSchInfo-content2").find("tr:eq(1)").find("td:first").html("预览图片");
						  $("#fileContentList").show();
						  $("#fileContentList").empty();
                          $("#fileContentList").append("<img src='"+contents+"' style='width:96%;height:96%;margin:2%;border:1px solid #CCC;'><br>");
                      }
                  }else{
                      alert("失败");
                  }
             // }
		      }
		      
              
          });
          
		  $("input:file:last").on("change",function(event){
			  if($("#fileContentList").is(":visible") == true){
		    	  alert("请先保存学校logo");
		    	  $("#textactfield").val("");
		      }else{
                  var file = event.target.files[0];
                  if(file){
                      var r = new FileReader();
                      r.file = file;
                      r.readAsDataURL(file);
                      r.onload = function(e){
                          var contents = e.target.result;
                          var thisfile = this.file;
						  $("#changeSchInfo-content3").find("tr:eq(1)").find("td:first").html("预览图片");
						  $("#fileactContentList").show();
						  $("#fileactContentList").empty();
                          $("#fileactContentList").append("<img src='"+contents+"' style='width:96%;height:96%;margin:2%;border:1px solid #CCC;'><br>");
                      }
                  }else{
                      alert("失败");
                  }
             // }
		  }
          });
      
      });
	  
	$(function(){
	    $("#noimg").click(function(){
	    	$("#changeSchInfo-content3").css("top","250px");
		    $("#fileContentList").hide();
			$("#changeSchInfo-content2").find("tr:eq(1)").find("td:first").html("");
			$("#textfield").val("");
		});
	    
	    $("#noactimg").click(function(){
		    $("#fileactContentList").hide();
			$("#changeSchInfo-content3").find("tr:eq(1)").find("td:first").html("");
			$("#textactfield").val("");
		});
	});
	
	//校验电话号码 座机或手机号
	function checkPhone(str){
    	var isPhone = /^0\d{2,3}-?\d{7,8}$/;
    	var isMob=/^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$/;
	    if(isMob.test(str)||isPhone.test(str)){
	        return true;
	    }else{
	        return false;
	    }
	}
	
	$(function(){
		$("#changebutton").click(function(){
			var newname = $("#schname").val();
			var newprovince = encodeURI($("#schprovince").val());
			var newcity = encodeURI($("#schcity").val());
			var newtel = $("#schtel").val();
			//校验电话号码
			if(!checkPhone(newtel)){
				alert("请按照：正确的座机或手机号码格式，正确输入电话号码！");
				return;
			}
		
			$.get(
				"changeinfo.action",
				{
					"newname":newname,
					"newprovince":newprovince,
					"newcity":newcity,
					"newtel":newtel
				},
				function(data){
				    alert("修改成功");
				    parent.location.reload();
			    }
			);
		});
	});

	//上传学校logo
	$(function(){
		$("#sureimg").click(function(){
			if($("#textfield").val()==""){
				alert("请选择一张图片");
			}else{
				
			    var options = {
						url : "upimg.action",
						type : "POST",
						dataType : "script",
						success : function(msg) {
							alert("上传成功");
						}
					};
					$("#upimgform").ajaxSubmit(options);
					$("#fileContentList").hide();
					$("#changeSchInfo-content2").find("tr:eq(1)").find("td:first").html("");
					$("#changeSchInfo-content3").css("top","250px");
				    return false;
			}
			});
		});
	
	
	//上传活动logo
	$(function(){
		$("#sureactimg").click(function(){
			if($("#textactfield").val()==""){
				alert("请选择一张图片");
			}else{
				
			    var options = {
						url : "upactimg.action",
						type : "POST",
						dataType : "script",
						success : function(msg) {
							alert("上传成功");
						}
					};
					$("#upactimgform").ajaxSubmit(options);
					$("#fileactContentList").hide();
					$("#changeSchInfo-content3").find("tr:eq(1)").find("td:first").html("");
				    return false;
			}
			});
		});
	
</script>
<style type="text/css">
body{
	height:1000px;
	font-family:"微软雅黑";
	color:#515151;
}
#changeSchInfo-top{
    position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:80px;
}
#top-title{
    position:relative;
    float:left;
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
#changeSchInfo-fa{
	position:absolute;
	width:100%;
	left: 0px;
	top: 0px;
	height:1000px;
}
#changeSchInfo-content1{ 
	position:absolute;
	width:55%;
	top: 80px;
	
	height:450px;
}
#changeSchInfo-content1 td{
	text-align:center;
	border-top:1px solid #ddd;
	height:90px;
	font-size:15px;
}
#changeSchInfo-content1 input[type=text],input[type=password],textarea{border:1px solid #ccc;padding:2px;border-radius:1px;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset;outline:medium none;line-height:25px;
     -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    font-family:"Microsoft YaHei",Verdana,Arial;
    font-size:14px;
    vertical-align:top;
    height:35px;
	width:400px;
	padding-left:15px;
	color:#515151;
    }
#changeSchInfo-content1   input[type=text]:focus,input[type=password]:focus,textarea:focus{/*border-color:rgba(82,168,236,0.8);*/border-color:#52a8ec;box-shadow:0 1px 2px rgba(0,0,0,0.1) inset,0 0 5px rgba(82,168,236,0.6);outline:0 none;}
#changeSchInfo-content1 select{
      -webkit-transition:all 0.15s ease-in 0s;
    -moz-transition:all 0.15s ease-in 0s;
    -o-transition:all 0.15s ease-in 0s;
    font-family:"Microsoft YaHei",Verdana,Arial;
    font-size:14px;
    vertical-align:top;
    height:35px;
	width:400px;
	padding-left:15px;
	color:#515151;
 }

#allMA{
    position:absolute;
	width:100%;
	top: 600px;
} 
#allMA td{
    text-align:center;
	border-top:1px solid #ddd;
	font-size:14px;
	padding-right:20px;
	padding-top:20px;
	padding-bottom:20px;
}
#changeSchInfo-content2{ 
	position:absolute;
	width:40%;
	left:60%;
	top: 100px;
	height:300px;
	font-size:14px;
	color:#515151;
}
#changeSchInfo-content2 td{
    height:40px;
    line-height:40px;
    font-size:14px;
}
#changeSchInfo-content3{ 
	position:absolute;
	width:40%;
	left:60%;
	top: 250px;
	height:300px;
	font-size:14px;
	color:#515151;
}
#changeSchInfo-content3 td{
	height:40px;
	line-height:40px;
	font-size:14px;
}
#nochange{
    position:relative;
	width:100px;
	float:right;
	margin-right:20px;
	top:32%;
	height:30px;
	color:#fff;
    background-color:#bbb;
    border:1px solid #bbb;
    cursor:pointer;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
}
#changebutton{
    position:relative;
	width:100px;
	float:right;
	margin-right:20px;
	top:32%;
	height:30px;
	color:#fff;
    background-color:#1C90F2;
    border:1px solid #1C90F2;
    cursor:pointer;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
}
#noimg{
    position:relative;
	width:100px;
	float:right;
	margin-right:20px;
	top:32%;
	height:30px;
	color:#fff;
    background-color:#bbb;
    border:1px solid #bbb;
    cursor:pointer;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
}
#sureimg{
    position:relative;
	width:100px;
	float:right;
	margin-right:20px;
	top:32%;
	height:30px;
	color:#fff;
    background-color:#90EE90;
    border:1px solid #90EE90;
    cursor:pointer;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
}

#allmajor td{
    border:1px solid #CCC;
    height:30px;
    padding-right:0px;
	padding-top:0px;
	padding-bottom:0px;
}
#allact td{
    border:1px solid #CCC;
    height:30px;
    padding-right:0px;
	padding-top:0px;
	padding-bottom:0px;
}


#noactimg{
	
    position:relative;
	width:100px;
	float:right;
	margin-right:15px;
	top:32%;
	height:30px;
	color:#fff;
    background-color:#bbb;
    border:1px solid #bbb;
    cursor:pointer;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
}
#sureactimg{
    position:relative;
	width:100px;
	float:right;
	margin-right:20px;
	top:32%;
	height:30px;
	color:#fff;
    background-color:#90EE90;
    border:1px solid #90EE90;
    cursor:pointer;
    -moz-border-radius:4px;  
    -webkit-border-radius:4px;  
    border-radius:4px;
}

.txt{ height:30px; border:1px solid #cdcdcd; width:200px;}
.btn{ background-color:#FFF; border:1px solid #CDCDCD;height:30px; width:70px;}
.file{ position:absolute; top:10px; left:318px; height:30px; filter:alpha(opacity:0);opacity: 0;width:70px; }
</style>
<body>
<%
		//lyl添加获取管理员id,把LevelTopId转换成String
	    String levelId = (String)session.getAttribute("LevelTopId");
%>
<%
		String unischool = null;
		int majorindex = 0;
		int actindex = 0;
		//遍历查找活动类型，存入activityList中
		/*
		String activityList ="";
  		School school = new School();
  		ObjectId orgaId = (ObjectId)session.getAttribute("Organization_SchoolId");
  		school.set_id(orgaId);
  		BasicDBObject q =CreateQueryFromBean.EqualObj(school);
		BasicDBObject p=new BasicDBObject();
		*/
		//unischool = "55eba9b5f9526b2310377bf0";
		School school = new School();
		ObjectId orgaId = (ObjectId)session.getAttribute("Organization_SchoolId");
		school.set_id(orgaId);
  		BasicDBObject q =CreateQueryFromBean.EqualObj(school);
		Document major=null;
		Document activity = null;
		
		String[] schOldInfo1 = new String[5];                    //保存前五个信息
		ArrayList<String> schMajor = new ArrayList<String>();    //保存专业
		ArrayList<String> schAct = new ArrayList<String>();       //保存活动
		
		BasicDBObject pro=new BasicDBObject();
		
		pro.put(StaticString.School_Name, 1);
		pro.put(StaticString.School_AddressP, 1);
		pro.put(StaticString.School_AddressC, 1);
		pro.put(StaticString.School_Tel, 1);
		pro.put(StaticString.School_LogoUrl, 1);
		pro.put(StaticString.School_Major, 1);
		pro.put(StaticString.School_InActivityCategoty, 1);
		
		try{
			MongoCursor<Document> cursor= DaoImpl.GetSelectCursor(School.class, q, pro);
			Document doc=cursor.next();
	
			//用schOldInfo1数组保存前五个信息
			schOldInfo1[0] = (String)doc.getString("Name");
			schOldInfo1[1] = (String)doc.getString("AddressP");
			schOldInfo1[2] = (String)doc.getString("AddressC");
			schOldInfo1[3] = (String)doc.getString("Tel");
			schOldInfo1[4] = (String)doc.getString("LogoUrl");
			
			//添加专业，用schMajor保存专业
			ArrayList<Document>  dsd = (ArrayList<Document>)doc.get("Major");
			for(int i = 0 ; i < dsd.size(); i++){
				major = dsd.get(i);
				schMajor.add((String)major.getString("Name"));
			}
			
			//添加活动，用schAct保存活动
			ArrayList<Document>  act = (ArrayList<Document>)doc.get("InActivityCategoty");
			for(int j = 0 ; j < act.size(); j++){
				activity = act.get(j);
				schAct.add(activity.getString("Name"));
			} 
		}
		catch(Exception e){
		}
%>
<div id="oldPro" style="display:none"><%=schOldInfo1[1] %></div>
<div id="oldCity" style="display:none"><%=schOldInfo1[2] %></div>
<div id="changeSchInfo-fa">
    <div id="changeSchInfo-top">
	         <div id="top-title">&nbsp;&nbsp;学校信息修改</div>
	          <input id="changebutton" type="button" value="确认修改"/>
			   &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
			   
			   <input id="nochange" type="button" value="取消修改"/> 
	    </div>
    <div id="changeSchInfo-content1">
		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		       <td><div style="position:relative;left:20px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;学校名称：</div></td>	  
			   <td><input name="" id="schname" type="text" 
			       value="<%=schOldInfo1[0] %>" /></td>
		    </tr>
			<tr>
		       <td><div style="position:relative;left:20px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;所在省份： </div></td>	  
			   <td><!-- <input name="" id="schprovince" type="text" 
			       value="<%=schOldInfo1[1] %>"/>
			        -->
			        
			         <select id="schprovince" onchange="chinaChange(this,document.getElementById('schcity'));">
						<option value ="请选择省份">请选择省份</option>
						<option value ="北京市">
						北京市 </option><option value ="天津市">
						天津市 </option><option value ="上海市">
						上海市 </option><option value ="重庆市">
						重庆市 </option><option value ="河北省">
						河北省 </option><option value ="山西省">
						山西省 </option><option value ="辽宁省">
						辽宁省 </option><option value ="吉林省">
						吉林省 </option><option value ="黑龙江省">
						黑龙江省</option><option value ="江苏省"> 
						江苏省 </option><option value ="浙江省">
						浙江省 </option><option value ="安徽省">
						安徽省 </option><option value ="福建省">
						福建省 </option><option value ="江西省">
						江西省 </option><option value ="山东省">
						山东省 </option><option value ="河南省">
						河南省 </option><option value ="湖北省">
						湖北省 </option><option value ="湖南省">
						湖南省 </option><option value ="广东省">
						广东省 </option><option value ="海南省">
						海南省 </option><option value ="四川省">
						四川省 </option><option value ="贵州省">
						贵州省 </option><option value ="云南省">
						云南省 </option><option value ="陕西省">
						陕西省 </option><option value ="甘肃省">
						甘肃省 </option><option value ="青海省">
						青海省 </option><option value ="台湾省">
						台湾省 </option><option value ="广西壮族自治区">
						广西壮族自治区</option><option value ="内蒙古自治区"> 
						内蒙古自治区</option><option value ="西藏自治区"> 
						西藏自治区</option><option value ="宁夏回族自治区"> 
						宁夏回族自治区 </option><option value ="新疆维吾尔自治区">
						新疆维吾尔自治区</option><option value ="香港特别行政区">
						香港特别行政区</option><option value ="澳门特别行政区">
						澳门特别行政区</option>
						</select>
			        </td>
		    </tr>
			<tr>
		       <td><div style="position:relative;left:20px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;所在城市：</div> </td>	  
			   <td><!--  <input name="" id="schcity" type="text" 
			       value="<%=schOldInfo1[2] %>"/>
			       -->
			       <select name="city" id="schcity" >
					<option value ="请选择市区">请选择市区</option>
					</select>
			       </td>
		    </tr>
			<tr>
		       <td><div style="position:relative;left:20px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;联系电话：</div> </td>	  
			   <td><input name="" id="schtel" type="text" 
			       value="<%=schOldInfo1[3] %>"/></td>
		    </tr>
			<tr>
		       <td style="border-bottom:1px solid #ddd;"><div style="position:relative;left:20px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;学校logo地址：</div> </td>	  
			   <td style="border-bottom:1px solid #ddd;"><input name="" id="" type="text" 
			       value="<%=schOldInfo1[4] %>" readonly="readonly"/></td>
		    </tr>
		    
		</table>
	</div>
	<div id="allMA">
	   <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
		       <td style="width:15%;"><div style="position:relative;left:20px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                    所有专业：</div> </td>	  
			   <td style="width:85%;">
			       <table width="100%" height="100%" border="0" cellspacing="5" cellpadding="0" id="allmajor">
			       <%
			       	   for(int i = 0; i < schMajor.size(); i++){
			       		   if(i%5 == 0){
				        	   out.print("<tr><td>"+schMajor.get(i)+"</td>");
				           }else if(i%5 == 4){
			        	       out.print("<td>"+schMajor.get(i)+"</td></tr>");
			               }else{
			        	       out.print("<td>"+schMajor.get(i)+"</td>");
			               }
			       	   }
			       %>
			       </table>
			   </td>
		    </tr>
			<tr>
		       <td style="width:15%;border-bottom:1px solid #ddd;"><div style="position:relative;left:20px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                    所有活动：</div> </td>	  
			   <td style="width:85%;border-bottom:1px solid #ddd;">
			       <table width="100%" height="100%" border="0" cellspacing="5" cellpadding="0" id="allact">
			       <%
			       	   for(int j = 0; j < schAct.size(); j++){
			       		   if(j%5 == 0){
				        	   out.print("<tr><td>"+schMajor.get(j)+"</td>");
				           }else if(j%5 == 4){
			        	       out.print("<td>"+schMajor.get(j)+"</td></tr>");
			               }else{
			        	       out.print("<td>"+schMajor.get(j)+"</td>");
			               }
			       	   }
			       %>
			       </table>
			   </td>
		    </tr>
		</table>
    </div>
		
	<div id="changeSchInfo-content2">
	    <form id="upimgform" method="post" enctype="multipart/form-data">
	     <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="25">
						<div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;学校logo：</div>
					</td>
					<td>
                         <input type='text' name='textfield' id='textfield' class='txt' readonly="readonly"/>  
                         <input type='button' class='btn' value='浏  览' />
                         <input type="file" name="fileField" class="file" id="fileField" accept="image/*" size="28" onchange="document.getElementById('textfield').value=this.value" />
					</td>
				</tr>
				<tr>
				    <td></td>
					<td><div id="fileContentList" style="width:200px;height:200px;display:none;border:1px solid #CCC;text-align:center;line-height:200px;"></div></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					    <input type="button"  id="noimg" value="取消上传" />
						 &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button"  id="sureimg" value="确定上传" />
					</td>
				</tr>
			</table>
			</form>
	</div>
	
	
	<div id="changeSchInfo-content3">
	    <form id="upactimgform" method="post" enctype="multipart/form-data">
	     <table width="400" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="25"><div style="position:relative;left:0px;height:32px;line-height:32px;border-left:5px solid #1C90F2">
		                     &nbsp;&nbsp;
						活动logo：</div></td>
					<td>
                         <input type='text' name='textactfield' id='textactfield' class='txt' readonly="readonly"/>  
                         <input type='button' class='btn' value='浏  览' />
                         <input type="file" name="fileactField" class="file" id="fileactField" accept="image/*" size="28" onchange="document.getElementById('textactfield').value=this.value" />
					</td>
				</tr>
				<tr>
				    <td></td>
					<td><div id="fileactContentList" style="width:200px;height:200px;display:none;border:1px solid #CCC;text-align:center;line-height:200px;"></div></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<input type="button"  id="noactimg" value="取消上传" />
						 &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
						
						<input type="button"  id="sureactimg" value="确定上传" />
					</td>
				</tr>
			</table>
			</form>
	</div>
	<div style="display: none;" id ="levelId"><%=levelId %></div>
	<div style="display: none;" id ="schOldInfo11"><%=schOldInfo1[1] %></div>
	<div style="display: none;" id ="schOldInfo12"><%=schOldInfo1[2] %></div>
</div>
<script>
$(function(){
	$("#nochange").click(function(){
		
		//$("#schname").val("<%=schOldInfo1[0] %>");
		//$("#schprovince").val("<%=schOldInfo1[1] %>");
		//$("#schcity").val("<%=schOldInfo1[2] %>");
		//$("#schtel").val("<%=schOldInfo1[3] %>");
		location.reload();
		
	});
});

//增加动态button
$(function(){
	$("#sureimg").live("mouseover",function(){
		$(this).css("background-color","#3CB371");
		$(this).css("border","1px solid #3CB371");
	});
	$("#sureimg").live("mouseout",function(){
		$(this).css("background-color","#90EE90");
		$(this).css("border","1px solid #90EE90");
	});
	$("#noimg").live("mouseover",function(){
		$(this).css("background-color","#A1A1A1");
		$(this).css("border","1px solid #A1A1A1");
	});
	$("#noactimg").live("mouseover",function(){
		$(this).css("background-color","#A1A1A1");
		$(this).css("border","1px solid #A1A1A1");
	});
	$("#sureactimg").live("mouseover",function(){
		$(this).css("background-color","#3CB371");
		$(this).css("border","1px solid #3CB371");
	});
	$("#sureactimg").live("mouseout",function(){
		$(this).css("background-color","#90EE90");
		$(this).css("border","1px solid #90EE90");
	});
	$("#noimg").live("mouseout",function(){
		$(this).css("background-color","#bbb");
		$(this).css("border","1px solid #bbb");
	});
	$("#noactimg").live("mouseout",function(){
		$(this).css("background-color","#bbb");
		$(this).css("border","1px solid #bbb");
	});
});

//lyl添加：设置权限
$(function(){
	var isSurManager=$("#levelId").text();
	if(isSurManager != "000000000000000000000000"){
		//信息不能修改，logo不能上传
		$("#changeSchInfo-content1").find("input").each(function(){
			$(this).parent().html($(this).val());
			$(this).remove;
		});
		$("#changeSchInfo-content1").find("select").each(function(){
			$(this).remove;
		});
		$("#changeSchInfo-content1").find("tr:eq(1)").find("td:last").html($("#schOldInfo11").html());
		$("#changeSchInfo-content1").find("tr:eq(2)").find("td:last").html($("#schOldInfo12").html());
		
		$("#changeSchInfo-top").find("input").each(function(){
			$(this).remove();
		});
		$("#changeSchInfo-content2").remove();
		$("#changeSchInfo-content3").remove();
		$("#changeSchInfo-content1").width("100%");
		$("#changeSchInfo-content1").find("td").each(function(){
			$(this).css("text-align","left");
		});
	}
});
</script>
</body>
</html>
