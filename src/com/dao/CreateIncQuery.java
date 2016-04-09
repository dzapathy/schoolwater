package com.dao;

import java.util.ArrayList;

import bean.ObjBean;

public class CreateIncQuery {
	private ArrayList<ObjBean> list;
	public CreateIncQuery(){
		this.list=new ArrayList<ObjBean>();
	}
	public void Add(String key,int value){
		
		ObjBean ben=new ObjBean();
		int x=key.indexOf(".");
		if(x>1){
			ben.setName(key.substring(0, x)+".$"+key.substring(x));
		}
		else{
			ben.setName(key);
		}
		ben.setId(value);
		ben.setName(key);
		list.add(ben);
	}
	public ArrayList<ObjBean> getList() {
		return list;
	}
	public void setList(ArrayList<ObjBean> list) {
		this.list = list;
	}
	
}
