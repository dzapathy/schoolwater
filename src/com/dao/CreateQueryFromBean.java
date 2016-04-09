package com.dao;

import java.util.Iterator;
import java.util.Map.Entry;
import java.util.Set;

import com.mongodb.BasicDBObject;

public class CreateQueryFromBean {
	public static BasicDBObject EqualObj(Object object) throws Exception {
		BasicDBObject obj=JsonBeanUtil.getQueryFromBean(object);
		return obj;
	}

	public static BasicDBObject NotEqualObj(Object object) throws Exception{//不等于
		BasicDBObject obj=JsonBeanUtil.getQueryFromBean(object);
		if(obj==null){
			return null;
		}		
		return Creator(object,"$ne");

	}
	
	public static BasicDBObject LtObj(Object object) throws Exception// 小于
	{
		BasicDBObject obj=JsonBeanUtil.getQueryFromBean(object);
		if(obj==null){
			return null;
		}
		return Creator(object,"$lt");

	}

	public static BasicDBObject LteObj(Object object) throws Exception{// 小于等于
		BasicDBObject obj=JsonBeanUtil.getQueryFromBean(object);
		if(obj==null){
			return null;
		}
		return Creator(object,"$lte");

	}

	public static BasicDBObject GtObj(Object object) throws Exception {// 大于
		BasicDBObject obj=JsonBeanUtil.getQueryFromBean(object);
		if(obj==null){
			return null;
		}
		return Creator(object,"$gt");

	}

	public static BasicDBObject GteObj(Object object) throws Exception {// 大于等于
		BasicDBObject obj=JsonBeanUtil.getQueryFromBean(object);
		if(obj==null){
			return null;
		}
		return Creator(object,"$gte");
		
	}

	public static BasicDBObject Creator(Object object,String type) throws Exception{
		BasicDBObject obj=JsonBeanUtil.getQueryFromBean(object);
		if(obj==null){
			return null;
		}
		BasicDBObject result=new BasicDBObject();
		Set<Entry<String,Object>> set=obj.entrySet();
		Iterator<Entry<String, Object>> i = set.iterator();         
		while(i.hasNext()){      
			
             Entry<String, Object> entry1=(Entry<String, Object>)i.next();
             
             if(entry1.getKey().equals("Major")||entry1.getKey().equals("InActivityCategoty")||entry1.getKey().equals("Manager")||entry1.getKey().equals("TableInfoColumn")||entry1.getKey().equals("TableContentColumn")||entry1.getKey().equals("Member")){
            	 result.put(entry1.getKey(),  PassaArray(entry1.getValue(),type));
             }
             else{
            	 result.put(entry1.getKey(), new BasicDBObject(type,entry1.getValue()));
             }    
        }
		return result;
	}
	
	public static BasicDBObject PassaArray(Object object,String type) throws Exception{
		BasicDBObject resu=new BasicDBObject();		
		BasicDBObject ob=(BasicDBObject)object;
		BasicDBObject ob1=(BasicDBObject)ob.get("$elemMatch");
   	 	Set<Entry<String,Object>> setarray=ob1.entrySet();
  		Iterator<Entry<String, Object>> j = setarray.iterator();         
		while(j.hasNext()){  
			Entry<String, Object> entry22=(Entry<String, Object>)j.next();
			String aa=entry22.getKey();
			BasicDBObject ob3=new BasicDBObject(type,entry22.getValue());
			resu.put(aa, ob3);
		}
		return new BasicDBObject("$elemMatch",resu);
	}
}
