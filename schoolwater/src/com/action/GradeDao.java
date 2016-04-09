package com.action;

import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import utils.Util;
import bean.ActivityIntegral;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class GradeDao extends ActionSupport{
	private String id;
	private String tableName;
	@Override
	public String execute() throws Exception {
		
		ActivityIntegral integral = new ActivityIntegral();
		integral.setTableId(new ObjectId(id));
		BasicDBObject query = CreateQueryFromBean.EqualObj(integral);
		BasicDBObject projection = new BasicDBObject();	
		
		ArrayList<ActivityIntegral> integrals = new ArrayList<ActivityIntegral>();
		MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(ActivityIntegral.class, query, projection);
		while(cursor.hasNext()){
			Document document = cursor.next();
			ActivityIntegral activityIntegral = new ActivityIntegral();
			activityIntegral.setName(document.getString("Name"));
			activityIntegral.setIdCard(document.getString("IdCard"));
			activityIntegral.setMajor(document.getString("Major"));
			activityIntegral.setLevel(document.getString("Level"));
			activityIntegral.setScope(document.getString("Scope"));
			activityIntegral.setThingName(document.getString("ThingName"));
			activityIntegral.setGrade(document.getDouble("Grade"));
			activityIntegral.setRemark(document.getString("Remark"));
			integrals.add(activityIntegral);
		}
		
		//建立excel流
		HSSFWorkbook workbook=new HSSFWorkbook();
		HSSFSheet sheet=workbook.createSheet();
		HSSFRow row=sheet.createRow(0);
		HSSFCell cell=null;
		
		cell=row.createCell(0);//第一行的第i个单元格
		cell.setCellValue("序号");//设置单元格数据
		sheet.setColumnWidth(0, 2*2*256);//设置表头宽度
		cell=row.createCell(1);
		cell.setCellValue("姓名");
		sheet.setColumnWidth(1, 2*2*256);
		cell=row.createCell(2);
		cell.setCellValue("学号");
		sheet.setColumnWidth(2, 2*2*256);
		cell=row.createCell(3);
		cell.setCellValue("专业");
		sheet.setColumnWidth(3, 3*2*256);
		cell=row.createCell(4);
		cell.setCellValue("获奖类型");
		sheet.setColumnWidth(4, 4*2*256);
		cell=row.createCell(5);
		cell.setCellValue("获奖级别");
		sheet.setColumnWidth(5, 4*2*256);
		cell=row.createCell(6);
		cell.setCellValue("获奖名称");
		sheet.setColumnWidth(6, 4*2*256);
		cell=row.createCell(7);
		cell.setCellValue("获得积分");
		sheet.setColumnWidth(7, 4*2*256);
		cell=row.createCell(8);
		cell.setCellValue("备注信息");
		sheet.setColumnWidth(8, 4*2*256);
		
		//追加数据
		for(int i = 1 ; i<(integrals.size()+1) ; i++){
			HSSFRow nextRow=sheet.createRow(i);
			HSSFCell cell1= null;
			//数据
			cell1=nextRow.createCell(0);
			cell1.setCellValue(i);
			cell1=nextRow.createCell(1);
			cell1.setCellValue(integrals.get(i-1).getName());
			cell1=nextRow.createCell(2);
			cell1.setCellValue(integrals.get(i-1).getIdCard());
			cell1=nextRow.createCell(3);
			cell1.setCellValue(integrals.get(i-1).getMajor());
			cell1=nextRow.createCell(4);
			cell1.setCellValue(integrals.get(i-1).getScope());
			cell1=nextRow.createCell(5);
			cell1.setCellValue(integrals.get(i-1).getLevel());
			cell1=nextRow.createCell(6);
			cell1.setCellValue(integrals.get(i-1).getThingName());
			cell1=nextRow.createCell(7);
			cell1.setCellValue(integrals.get(i-1).getGrade());
			cell1=nextRow.createCell(8);
			cell1.setCellValue(integrals.get(i-1).getRemark());
		}
		HttpServletResponse response= ServletActionContext.getResponse();
		response.setContentType("application/vnd.ms-excel");        //改成输出excel文件
		response.setHeader("Content-disposition","attachment; filename="+Util.DoGetString(tableName)+".xls" );
		OutputStream output =response.getOutputStream();  
		BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);   	
		try {		
			workbook.write(bufferedOutPut);
		} catch (Exception e) {
			System.out.print(e.getMessage());
		}finally{
			workbook.close();
			bufferedOutPut.close();
		}
		return null;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
}
