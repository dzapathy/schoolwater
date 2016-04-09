package com.action;

import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.bson.Document;
import org.bson.types.ObjectId;

import utils.Util;
import bean.TableContentColumn;
import bean.TableContentInfo;
import bean.TableInfo;

import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ActivityNTDetailAction extends ActionSupport {

	private String tableInfo_id;
	private String addContent;
	private String delContent;

	// 保存某条数据
	public String save() throws Exception {
		System.out.println("增加");
		System.out.println("addContent::"+addContent);
		String[] tdContent = Util.DoGetString(addContent).split(";");
		TableContentInfo tableContentInfo = new TableContentInfo();
		tableContentInfo.set_id(new ObjectId());
		tableContentInfo.setCreateTime(new Date());
		ObjectId schoolId = (ObjectId) ServletActionContext.getContext()
				.getSession().get("Organization_SchoolId");
		tableContentInfo.setIdCard(tdContent[1]);
		tableContentInfo.setSchoolId(schoolId);
		tableContentInfo.setStuId(new ObjectId("000000000000000000000000"));
		tableContentInfo.setTableType(1);
		tableContentInfo.setTableId(new ObjectId(tableInfo_id));
		TableInfo tableInfo = new TableInfo();
		tableInfo.set_id(new ObjectId(tableInfo_id));
		BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);
		BasicDBObject projection = new BasicDBObject();
		System.out.println("--------------------");
		MongoCursor<Document> mc = DaoImpl.GetSelectCursor(TableInfo.class,
				query, projection);
		Document document = mc.next();
		ArrayList<Document> nameOrder = (ArrayList<Document>) document
				.get("TableInfoColumn");
		ArrayList<TableContentColumn> list = new ArrayList<TableContentColumn>();
		for (int i = 0; i < nameOrder.size(); i++) {
			Document document2 = nameOrder.get(i);
			TableContentColumn tableContentColumn = new TableContentColumn();
			tableContentColumn.setName((String) document2.get("Name"));
			tableContentColumn.setContent(tdContent[i]);
			list.add(tableContentColumn);
		}
		tableContentInfo.setTableContentColumn(list);
		System.out.println("111111111111111111111111");
		DaoImpl.InsertWholeBean(tableContentInfo);
		System.out.println("=======================");
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().print("success");
		return null;
	}

	// 导出excel
	public String export() throws Exception {

		System.out.println(tableInfo_id);
		
		TableInfo tableInfo = new TableInfo();
		tableInfo.set_id(new ObjectId(tableInfo_id));
		BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);
		BasicDBObject projection = new BasicDBObject();
		MongoCursor<Document> mc = DaoImpl.GetSelectCursor(TableInfo.class,
				query, projection);
		Document document = mc.next();
		// 获取活动名称
		String activityName = (String) document.get("Name");
		// 获取表头
		ArrayList<String> columnName = new ArrayList<String>();
		ArrayList<Document> documents = (ArrayList<Document>) document
				.get("TableInfoColumn");
		columnName.clear();
		for (int i = 0; i < documents.size(); i++) {
			columnName.add((String) documents.get(i).get("Name"));
		}

		TableContentInfo tableContentInfo = new TableContentInfo();
		tableContentInfo.setTableId(new ObjectId(tableInfo_id));
		query = CreateQueryFromBean.EqualObj(tableContentInfo);
		MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(
				TableContentInfo.class, query, projection);
		ArrayList<Document> tableContentInfos = new ArrayList<Document>();
		
		while (cursor.hasNext()) {
			tableContentInfos.add(cursor.next());
		}
		// 获取每一行 的数据存到二维数组contextColumns中
		ArrayList<Document> tableContent = new ArrayList<Document>();
		ArrayList<ArrayList<String>> contextColumns = new ArrayList<ArrayList<String>>();

		contextColumns.clear();
		for (int i = 0; i < tableContentInfos.size(); i++) {
			tableContent.clear();
			tableContent = (ArrayList<Document>) tableContentInfos.get(i).get(
					"TableContentColumn");
			ArrayList<String> content = new ArrayList<String>();
			content.clear();
			for (int j = 0; j < columnName.size(); j++) {
				System.out.println(j);
				for (int k = 0; k < tableContent.size(); k++) {
					if (columnName.get(j).equals(
							(String) tableContent.get(k).get("Name"))) {
						content.add((String) tableContent.get(k).get("Content"));
					}
				}
			}
			contextColumns.add(content);
		}

		// 建立excel流
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet();
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = null;
		for (int i = 0; i < columnName.size(); i++) {
			cell = row.createCell(i);
			cell.setCellValue(columnName.get(i));
		}
		// 追加数据
		for (int i = 1; i < contextColumns.size() + 1; i++) {
			HSSFRow nextRow = sheet.createRow(i);
			HSSFCell c = null;
			for (int j = 0; j < contextColumns.get(i - 1).size(); j++) {
				c = nextRow.createCell(j);
				c.setCellValue(contextColumns.get(i - 1).get(j));
			}
		}

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/vnd.ms-excel"); // 改成输出excel文件
		response.setHeader("Content-disposition", "attachment; filename="
				+ Util.DoGetExportName(activityName) + ".xls");
		OutputStream output = response.getOutputStream();
		BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
		try {
			workbook.write(bufferedOutPut);
			bufferedOutPut.flush();
		} catch (Exception e) {
			System.out.print(e.getMessage());
		} finally {
			workbook.close();
			bufferedOutPut.close();
		}

		return null;

	}

	public String del() throws Exception {
		System.out.println(tableInfo_id);
		TableContentInfo tableContentInfo = new TableContentInfo();
		tableContentInfo.setTableId(new ObjectId(tableInfo_id));
		tableContentInfo.setIdCard(delContent);
		BasicDBObject query = CreateQueryFromBean.EqualObj(tableContentInfo);

		DaoImpl.DeleteDocment(TableContentInfo.class, query);

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().print("success");
		return null;
	}

	public String getTableInfo_id() {
		return tableInfo_id;
	}

	public void setTableInfo_id(String tableInfo_id) {
		this.tableInfo_id = tableInfo_id;
	}

	public String getAddContent() {
		return addContent;
	}

	public void setAddContent(String addContent) {
		this.addContent = addContent;
	}

	public String getDelContent() {
		return delContent;
	}

	public void setDelContent(String delContent) {
		this.delContent = delContent;
	}

}
