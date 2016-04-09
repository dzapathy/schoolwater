package utils;

public class Util {
	public static String DoGetString(String str) throws Exception{
		//byte [] bs = str.getBytes("ISO8859-1");
		//return new String(bs,"UTF-8");
		return str;
	}
	
	public static String DoGetExportName(String str) throws Exception {
		return new String(str.getBytes("gb2312"),"iso8859-1");
	}
	
	public static String GetOutActivityCategory(String x){
		if(x=="1"){
			return "讲座";
		}
		if(x=="2"){
			return "比赛";
		}
		if(x=="3"){
			return "公益";
		}
		if(x=="4"){
			return "志愿";
		}
		if(x=="5"){
			return "other";
		}
		return "";
	}
}
