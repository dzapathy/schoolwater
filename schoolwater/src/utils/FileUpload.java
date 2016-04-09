package utils;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;

public class FileUpload {
	//设置好账号的ACCESS_KEY和SECRET_KEY
	static String ACCESS_KEY = "rgOtSST7pPDCPJ9KRMhPYAvPMeZAnJ8PcHNgJkky";
	static String SECRET_KEY = "bE_AjzQPEGiSrGe0_hTYp49BODEowf912nz6eQYU";
	//要上传的空间
	static String bucketname = "schooltime";
	//域名
	static String yuming = "http://7xo6s1.com1.z0.glb.clouddn.com/";		
	//密钥配置
	static Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
	//创建上传对象
	static UploadManager uploadManager = new UploadManager();
	//简单上传，使用默认策略，只需要设置上传的空间名就可以了
	public static String getUpToken(){
	    return auth.uploadToken(bucketname);
	}
	
	public static String upload(String filepath){
		String path = null;
		try {
	      //调用put方法上传
	      Response res = uploadManager.put(filepath, null, getUpToken());
	      //打印返回的信息      
	      path =yuming+ res.bodyString().substring(9, res.bodyString().indexOf(",")-1);       
	      } catch (QiniuException e) {
	          Response r = e.response;
	          // 请求失败时打印的异常的信息
	          System.out.println(r.toString());
	          try {
	              //响应的文本信息
	            System.out.println(r.bodyString());
	          } catch (QiniuException e1) {
	              //ignore
	          }
	    }
		return path;
	}
	
	
//	//上传附件,返回路径
//	public static String attachmentUpload(File fileAttachment ,String fileAttachmentContentType,String fileAttachmentFileName,String attachmentSavePath ) throws IOException{
//		//判断是否存在该文件夹，若不存在，建立/upload文件夹,此处待更改
//		File f = new  File(attachmentSavePath);	
//		if(!f.exists()){
//			f.mkdir();
//		}
//		if(fileAttachment!=null){
//			FileOutputStream fos=new FileOutputStream(f+"\\"+fileAttachmentFileName);
//			FileInputStream fis=new FileInputStream(fileAttachment);
//			byte [] buffer=new byte[1024];
//			int len=0;
//			while((len=fis.read(buffer))!=-1){
//				fos.write(buffer,0,len);
//			}
//			fis.close();
//			fos.close();
//		}
//		return f+"\\"+fileAttachmentFileName; //暂存于upload下
//	}
//	
//	//上传图片，返回路径
//	public static String pictureUpload(File filePicture) throws IOException{
//		String zoomPath=filePicture.getParentFile()+"\\f"+filePicture.getName();
//		File cutPicture = PictureZoom.cutImage(filePicture,new File(zoomPath));
//		File zoomPicture = PictureZoom.resize(cutPicture, new File(zoomPath), 300, 0, 1f);		
//		String token = Token.createToken(new Date().getTime()+180, 1142528 , "{\"height\":\"h\",\"width\":\"w\",\"s_url\":\"url\"}");
//		String json = PostImage.doUpload(zoomPicture, token);
//		String url=getUrl(json);
//		System.out.println(zoomPicture.delete());
//		return url;
//	}
//	
//	//网站长传图标
//	public static String pictureWebUpload(File filePicture) throws IOException{ 
//		String zoomPath=filePicture.getParentFile()+"\\f"+filePicture.getName();
//		File cutPicture = PictureZoom.cutImageWeb(filePicture,new File(zoomPath));
//		File zoomPicture = PictureZoom.resize(cutPicture, new File(zoomPath), 300, 0, 1f);		
//		String token = Token.createToken(new Date().getTime()+180, 1142528 , "{\"height\":\"h\",\"width\":\"w\",\"s_url\":\"url\"}");
//		String json = PostImage.doUpload(zoomPicture, token);
//		String url=getUrl(json);
//		zoomPicture.delete();
//		return url;
//	}
//	
//	private static String getUrl(String json){
//		net.sf.json.JSONObject jsonObject = net.sf.json.JSONObject.fromObject(json);
//		return jsonObject.getString("url");
//	}
//	
	public static boolean pictureDel(String url) {
		//如果url为null
		if(url == null){			
		}	
		return true;
	}
		
	public static boolean attachmentDel(String url) {
		//如果url为null,说明该活动没有附件 
		if(url == null) {			
		}		
		return true;
	}
}
