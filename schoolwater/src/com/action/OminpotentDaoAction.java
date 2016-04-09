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

import staticData.StaticString;
import utils.Util;
import bean.TableContentColumn;
import bean.TableContentInfo;
import bean.TableInfo;
import bean.TableInfoColumn;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class OminpotentDaoAction extends ActionSupport{
	private String id ;
	private String tableName;
	
	private ArrayList<TableInfoColumn> infoColumns;
	private ArrayList<ArrayList<TableContentColumn>> contextColumns;
	@Override
	public String execute() throws Exception {
		
		TableInfo tableInfo = new TableInfo();
		tableInfo.set_id(new ObjectId(getId()));//待修改
		BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);				
		BasicDBObject projection = new BasicDBObject();
		projection.put(StaticString.TableInfo_TableInfoColumn, 1);
		MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(TableInfo.class, query, projection);	
		infoColumns = new ArrayList<TableInfoColumn>();
		Document document = null;
		while(cursor.hasNext()){
			document = cursor.next();
			@SuppressWarnings("unchecked")
			ArrayList<Document> documents =(ArrayList<Document>)document.get("TableInfoColumn");
			for(int i =0 ; i< documents.size(); i++){
				TableInfoColumn infoColumn = new TableInfoColumn();
				infoColumn.setName((String)documents.get(i).get("Name"));
				infoColumn.setChoose((Boolean)documents.get(i).get("Choose"));
				infoColumn.setLength((Integer)documents.get(i).get("Length"));
				infoColumns.add(infoColumn);
			}
		}		
		//获取表内数据
		TableContentInfo tableContentInfo = new TableContentInfo();
		tableContentInfo.setTableId(new ObjectId(getId()));	//待修改
		BasicDBObject query1 = CreateQueryFromBean.EqualObj(tableContentInfo);		
		BasicDBObject projection1 = new BasicDBObject();
		projection1.put(StaticString.TableContentInfo_TableContentColumn, 1);		
		MongoCursor<Document> cursor2 =DaoImpl.GetSelectCursor(TableContentInfo.class, query1, projection1);
		contextColumns = new ArrayList<ArrayList<TableContentColumn>>();
		Document document2 = null;
		while(cursor2.hasNext()){
		document2 = cursor2.next();
			@SuppressWarnings("unchecked")
			ArrayList<Document> documents =(ArrayList<Document>)document2.get("TableContentColumn");
			if(documents==null){System.out.println("documents为空");}
			ArrayList<TableContentColumn> tableContentColumn = new ArrayList<TableContentColumn>();
			for(int i = 0 ; i <documents.size(); i++){
				TableContentColumn column = new TableContentColumn();
				column.setName(documents.get(i).getString("Name"));
				column.setContent(documents.get(i).getString("Content"));
				tableContentColumn.add(column);
			}
			contextColumns.add(tableContentColumn);
		}		
		//建立excel流
		HSSFWorkbook workbook=new HSSFWorkbook();
		HSSFSheet sheet=workbook.createSheet();
		sheet.autoSizeColumn(1, true); //自适应内容
		HSSFRow row=sheet.createRow(0);
		HSSFCell cell=null;
		//int width = 0; //设置单元格的宽度
		for (int i = 0; i < infoColumns.size(); i++) {
			cell=row.createCell(i);//第一行的第i个单元格
			cell.setCellValue(infoColumns.get(i).getName());//设置单元格数据
			sheet.setColumnWidth(i, infoColumns.get(i).getName().length()*2*256);
		}
		//追加数据
		for(int i = 1 ; i<(contextColumns.size()+1) ; i++){
			HSSFRow nextRow=sheet.createRow(i);
			HSSFCell cell1= null;
			for(int j = 0; j < contextColumns.get(i-1).size() ; j++){
				cell1=nextRow.createCell(j);
				cell1.setCellValue(contextColumns.get(i-1).get(j).getContent());
			}
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

	public ArrayList<TableInfoColumn> getInfoColumns() {
		return infoColumns;
	}

	public void setInfoColumns(ArrayList<TableInfoColumn> infoColumns) {
		this.infoColumns = infoColumns;
	}

	public ArrayList<ArrayList<TableContentColumn>> getContextColumns() {
		return contextColumns;
	}

	public void setContextColumns(
			ArrayList<ArrayList<TableContentColumn>> contextColumns) {
		this.contextColumns = contextColumns;
	}
}
