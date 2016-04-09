package com.dao;

import java.util.ArrayList;

import com.mongodb.BasicDBObject;

public class CreateOrQuery {
	private BasicDBObject query;
	private ArrayList<BasicDBObject> list;
	public CreateOrQuery (){
		query=new BasicDBObject();
		list=new ArrayList<BasicDBObject>();
	}
	public CreateOrQuery (BasicDBObject query){
		this.query=query;
		list=new ArrayList<BasicDBObject>();
	}
	public void Add(BasicDBObject obj){
		list.add(obj);
	}
	public BasicDBObject GetResult(){
		this.query.put("$or", this.list);
		return this.query;
	}
}
