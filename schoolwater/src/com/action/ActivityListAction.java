package com.action;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ActivityListAction extends ActionSupport {
	
	private int pageNu=1;//默认第1页
	private int pageTag;//标记上一页-0，下一页-1	
	private String oIdfirst;
	private String oIdlast;
	public static final int pageSize=10;//一页中显示的通知数量
	
	//下一页,上一页响应函数
	public String execute(){		
		ServletActionContext.getRequest().setAttribute("pageNu", pageNu);
		ServletActionContext.getRequest().setAttribute("oIdfirst", oIdfirst);
		ServletActionContext.getRequest().setAttribute("oIdlast", oIdlast);
		ServletActionContext.getRequest().setAttribute("pageTag", pageTag);
		return SUCCESS;
	}
	
	public int getPageNu() {
		return pageNu;
	}
	public void setPageNu(int pageNu) {
		this.pageNu = pageNu;
	}
	
	public int getPageTag() {
		return pageTag;
	}
	public void setPageTag(int pageTag) {
		this.pageTag = pageTag;
	}
	
	public String getOIdfirst() {
		return oIdfirst;
	}
	public String getOIdlast() {
		return oIdlast;
	}
	public void setOIdfirst(String oIdfirst) {
		this.oIdfirst = oIdfirst;
	}
	public void setOIdlast(String oIdlast) {
		this.oIdlast = oIdlast;
	}
}
