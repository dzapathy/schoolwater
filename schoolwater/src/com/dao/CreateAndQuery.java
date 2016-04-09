package com.dao;

import java.util.Iterator;
import java.util.Set;
import java.util.Map.Entry;
import com.mongodb.BasicDBObject;

public class CreateAndQuery {
	private BasicDBObject query;
	public CreateAndQuery (){
		query=new BasicDBObject();
	}
	public void Add(BasicDBObject obj){

		Set<Entry<String,Object>> set=obj.entrySet();
		Iterator<Entry<String, Object>> i = set.iterator();         
		while(i.hasNext()){      
             Entry<String, Object> entry1=(Entry<String, Object>)i.next();
             
             if(query.containsField(entry1.getKey())==true){
            	 
            	 BasicDBObject temp=(BasicDBObject)query.get(entry1.getKey());
 
            	Set<Entry<String,Object>> setN=((BasicDBObject)(entry1.getValue())).entrySet();
         		Iterator<Entry<String, Object>> j = setN.iterator();         
         		while(j.hasNext()){
         			Entry<String, Object> entry2=(Entry<String, Object>)j.next();
         			temp.put(entry2.getKey(), entry2.getValue());
         		} 
            	 
            	 query.put(entry1.getKey(), temp);
             }
             else{
            	 query.put(entry1.getKey(), entry1.getValue());
             }
             
        }
	}
	public BasicDBObject GetResult(){
		return this.query;
	}
}
