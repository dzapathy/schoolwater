package com.action;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;

import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.bson.types.ObjectId;

import utils.Util;
import bean.ActivityIntegral;
import bean.InActivity;
import bean.InActivityCategoty;
import bean.School;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.opensymphony.xwork2.ActionSupport;


@SuppressWarnings("serial")
public class ChangeSchInfo {
	private String newname;
	private String newprovince;
	private String newcity;
	private String newtel;
	
	public String changeInfo() throws Exception {
		if(newname!=""&&newprovince!=""&&newcity!=""&&newtel!=""){
			School sch = null;
			ObjectId orgaId = (ObjectId)ServletActionContext.getContext().getSession().get("Organization_SchoolId");
			
	  		
			try{
			    sch = new School();
                //编码转换
			    sch.set_id(orgaId);
			    BasicDBObject q =CreateQueryFromBean.EqualObj(sch);
			    newname = new String(newname.getBytes("iso-8859-1"), "utf-8");
			    newtel = new String(newtel.getBytes("iso-8859-1"), "utf-8");
			    newprovince = URLDecoder.decode(newprovince, "UTF-8");
			    newcity = URLDecoder.decode(newcity, "UTF-8");
			    
			    sch.setName(newname);
			    sch.setAddressP(newprovince);
			    sch.setAddressC(newcity);
			    sch.setTel(newtel);
			    DaoImpl.update(q, sch, false);
			}catch(Exception e){
				return "error";
			}
			return "success";
		}
		
		return "error";
	}

	public String getNewname() {
		return newname;
	}

	public void setNewname(String newname) {
		this.newname = newname;
	}

	public String getNewprovince() {
		return newprovince;
	}

	public void setNewprovince(String newprovince) {
		this.newprovince = newprovince;
	}

	public String getNewcity() {
		return newcity;
	}

	public void setNewcity(String newcity) {
		this.newcity = newcity;
	}

	public String getNewtel() {
		return newtel;
	}

	public void setNewtel(String newtel) {
		this.newtel = newtel;
	}
	
	
}
