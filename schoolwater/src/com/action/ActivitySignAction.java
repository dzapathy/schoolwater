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
import org.json.JSONArray;
import org.json.JSONObject;

import staticData.StaticString;
import utils.Util;
import bean.InActivity;
import bean.TableContentColumn;
import bean.TableContentInfo;
import bean.TableInfo;

import com.dao.CreateAndQuery;
import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ActivitySignAction extends ActionSupport {
	private String idCard;
	private String activityContent_id;

	private String lastContentId;
	private String columnName;
	
	public String sign() throws Exception {
		System.out.println(idCard);
		System.out.println(activityContent_id);

		ArrayList<TableContentColumn> list = new ArrayList<TableContentColumn>();
		// 查找原来的数据
		TableContentInfo tableContentInfo = new TableContentInfo();
		tableContentInfo.setTableId(new ObjectId(activityContent_id));
		tableContentInfo.setIdCard(idCard);

		TableContentColumn tableContentColumn = new TableContentColumn();
		tableContentColumn.setName("SignIn");
		list.add(tableContentColumn);
		tableContentInfo.setTableContentColumn(list);

		ArrayList<TableContentColumn> list1 = new ArrayList<TableContentColumn>();
		TableContentInfo tableContentInfo1 = new TableContentInfo();
		TableContentColumn tableContentColumn1 = new TableContentColumn();
		tableContentColumn1.setContent("1");
		list1.add(tableContentColumn1);
		tableContentInfo1.setTableContentColumn(list1);

		DaoImpl.update(CreateQueryFromBean.EqualObj(tableContentInfo),
				tableContentInfo1, true);

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().print("签到成功！");
		return null;
	}

	public String search() throws Exception {
		System.out.println(lastContentId);
		System.out.println(Util.DoGetString(columnName.substring(1,
				columnName.length() - 1)));

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		String[] columnNames = null;
		if (columnName.length() != 0) {
			columnName = Util.DoGetString(columnName.substring(1,
					columnName.length() - 1));
			columnNames = columnName.split(",");
		}

		// 根据tableId查询tableContent
		TableContentInfo tableContentInfo = new TableContentInfo();
		tableContentInfo.setTableId(new ObjectId(activityContent_id));
		BasicDBObject query = CreateQueryFromBean.EqualObj(tableContentInfo);

		// 根据id查询最后一条的时间
		TableContentInfo tableContentInfo2 = new TableContentInfo();
		tableContentInfo2.set_id(new ObjectId(lastContentId));
		BasicDBObject query2 = CreateQueryFromBean.EqualObj(tableContentInfo2);
		BasicDBObject p = new BasicDBObject();
		p.put("CreateTime", 1);
		MongoCursor<Document> mCursor = DaoImpl.GetSelectCursor(
				TableContentInfo.class, query2, p);
		Document d = null;
		while (mCursor.hasNext()) {
			d = mCursor.next();
		}

		TableContentInfo tableContentInfo3 = new TableContentInfo();
		tableContentInfo3.setCreateTime((Date) d.get("CreateTime"));
		BasicDBObject query3 = CreateQueryFromBean.LtObj(tableContentInfo3);

		// 合并查询条件query和query3
		CreateAndQuery createAndQuery = new CreateAndQuery();
		createAndQuery.Add(query);
		createAndQuery.Add(query3);

		BasicDBObject projection = new BasicDBObject();
		projection.put("TableContentColumn", 1);
		projection.put("_id", 1);
		BasicDBObject sort = new BasicDBObject();
		sort.put("CreateTime", -1);
		int limit = 1;
		MongoCursor<Document> mongoCursor = DaoImpl.GetSelectCursor(
				TableContentInfo.class, createAndQuery.GetResult(), sort,
				limit, projection);
		ArrayList<Document> tableContentList = new ArrayList<Document>();
		while (mongoCursor.hasNext()) {
			tableContentList.add(mongoCursor.next());
		}

		// 如果不为空则转换为JSONArray
		if (tableContentList != null && tableContentList.size() != 0) {
			System.out.println("table");
			JSONArray data = new JSONArray();
			for (int i = 0; i < tableContentList.size(); i++) {
				ArrayList<Document> document = (ArrayList<Document>) tableContentList
						.get(i).get("TableContentColumn");
				// 每个学生
				JSONObject jsonObject = new JSONObject();
				for (int j = 0; j < columnNames.length; j++) {
					for (int k = 0; k < document.size(); k++) {
						String name = (String) document.get(k).get("Name");
						if (columnNames[j].trim().equals(name)) {
							jsonObject
									.put(name, document.get(k).get("Content"));
							break;
						}
						if (name.equals("SignIn")) {
							jsonObject.put("SignIn",
									document.get(k).get("Content"));
							break;
						}
					}
				}
				jsonObject.put("id", tableContentList.get(i).get("_id"));
				data.put(jsonObject);
			}

			response.getWriter().print(data.toString());
		} else {
			response.getWriter().print("error");
		}
		return null;
	}

	public String export() throws Exception {

		String activity_id = (String) ServletActionContext.getContext()
				.getSession().get("SelectedActivityId");
		// 查找表头
		TableInfo tableInfo = new TableInfo();
		tableInfo.setActivityId(new ObjectId(activity_id));
		tableInfo.setType(0);
		BasicDBObject query = CreateQueryFromBean.EqualObj(tableInfo);
		BasicDBObject projection = new BasicDBObject();
		projection.put("_id", 1);
		projection.put("Name", 1);
		projection.put("TableInfoColumn", 1);
		MongoCursor<Document> mc = DaoImpl.GetSelectCursor(TableInfo.class,
				query, projection);
		Document document = null;
		while (mc.hasNext()) {
			document = mc.next();
		}
		//活动名称
		InActivity inActivity = new InActivity();
		inActivity.set_id(new ObjectId(activity_id));
		BasicDBObject query2 = CreateQueryFromBean.EqualObj(inActivity);
		BasicDBObject project2 = new BasicDBObject();
		project2.put(StaticString.InActivity_Name, 1);
		MongoCursor<Document> cur = DaoImpl.GetSelectCursor(InActivity.class,
				query2, project2);
		Document document2 = cur.next();

		String activityName = (String) document2
				.get(StaticString.InActivity_Name);
			// 获取表头
			ArrayList<String> columnName = new ArrayList<String>();
			ArrayList<Document> documents = (ArrayList<Document>) document
					.get("TableInfoColumn");
			columnName.clear();
			for (int i = 0; i < documents.size(); i++) {
				columnName.add((String) documents.get(i).get("Name"));
				System.out.println(documents.get(i).get("Name"));
			}
			// 获取数据
			ObjectId contentId = (ObjectId) document.get("_id");
			System.out.println(contentId);

			TableContentInfo tableContentInfo = new TableContentInfo();
			tableContentInfo.setTableId(contentId);
			BasicDBObject q = CreateQueryFromBean.EqualObj(tableContentInfo);
			BasicDBObject p = new BasicDBObject();

			MongoCursor<Document> cursor = DaoImpl.GetSelectCursor(
					TableContentInfo.class, q, p);
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
				tableContent = (ArrayList<Document>) tableContentInfos.get(i)
						.get("TableContentColumn");
				ArrayList<String> content = new ArrayList<String>();
				content.clear();
				for (int j = 0; j < columnName.size(); j++) {
					System.out.println(j);
					for (int k = 0; k < tableContent.size(); k++) {
						if (columnName.get(j).equals(
								(String) tableContent.get(k).get("Name"))) {
							content.add((String) tableContent.get(k).get(
									"Content"));
							System.out.println(tableContent.get(k).get(
									"Content"));
						}
					}
				}
				contextColumns.add(content);
			}

			for (int i = 0; i < contextColumns.size(); i++) {
				for (int j = 0; j < contextColumns.get(i).size(); j++) {
					System.out.println(contextColumns.get(i).get(j));
				}
			}
			// 建立excel流
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet();
			HSSFRow row = sheet.createRow(0);
			HSSFCell cell = null;
			for (int i = 0; i < columnName.size(); i++) {
				cell = row.createCell(i);
				cell.setCellValue(columnName.get(i));
				sheet.setColumnWidth(i, (1 + columnName.get(i).length())*2*256);
			}
			// 追加数据
			for (int i = 1; i < contextColumns.size() + 1; i++) {
				System.out.println(contextColumns.size() + 1);
				HSSFRow nextRow = sheet.createRow(i);
				HSSFCell c = null;
				for (int j = 0; j < contextColumns.get(i - 1).size(); j++) {
					System.out.println(contextColumns.get(i - 1).size());
					c = nextRow.createCell(j);
					c.setCellValue(contextColumns.get(i - 1).get(j));
					System.out.println(contextColumns.get(i - 1).get(j));
				}
			}

			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("application/vnd.ms-excel"); // 改成输出excel文件
			response.setHeader("Content-disposition", "attachment; filename="
					+ Util.DoGetExportName(activityName+"签到表")+ ".xls");
			System.out.println(activityName);
			OutputStream output = response.getOutputStream();
			BufferedOutputStream bufferedOutPut = new BufferedOutputStream(
					output);
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

	public String getActivityContent_id() {
		return activityContent_id;
	}

	public void setActivityContent_id(String activityContent_id) {
		this.activityContent_id = activityContent_id;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getLastContentId() {
		return lastContentId;
	}

	public void setLastContentId(String lastContentId) {
		this.lastContentId = lastContentId;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

}