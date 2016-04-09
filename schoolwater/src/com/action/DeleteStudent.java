package com.action;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.bson.types.ObjectId;

import bean.StudentInfo;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.opensymphony.xwork2.ActionSupport;

public class DeleteStudent extends ActionSupport implements Serializable{
	private HttpServletRequest request;
	private StudentInfo de;
	private String result = "success";
	
	public void setServletRequest(HttpServletRequest request){
		this.request = request;
	}
	
	
	public String execute() throws Exception{
		
		HttpServletRequest req1 = ServletActionContext.getRequest();
	    String[] n = req1.getParameterValues("delstu");
		try{
		    if(n != null){
			    for(int i = 0; i < n.length; i++){
				    de = new StudentInfo();
				    de.set_id(new ObjectId(n[i]));
				    DaoImpl.DeleteDocment(StudentInfo.class, CreateQueryFromBean.EqualObj(de));
			    }
		    }
		}catch(Exception e){
			result = "error";
		}
		return result;
	}
}
