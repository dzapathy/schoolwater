package utils;

import java.util.ArrayList;

import org.bson.Document;
import org.bson.types.ObjectId;
import org.json.JSONArray;
import org.json.JSONObject;

import staticData.StaticString;
import bean.SearchTableContent;
import bean.TableContentInfo;

import com.dao.CreateAndQuery;
import com.dao.CreateQueryFromBean;
import com.dao.DaoImpl;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;

public class LoadMore {
	/**
	 * 形参存储于SearchTableContent 该javabean中
	 * @param searchTableContent
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static String searchMore(SearchTableContent searchTableContent) throws Exception{
		
		TableContentInfo  tableContentInfo1 = new TableContentInfo(); //tableId
		tableContentInfo1.setTableId(new ObjectId(searchTableContent.getTableId()));
		
		TableContentInfo tableContentInfo2=new TableContentInfo();//lastContentId
		tableContentInfo2.set_id(new ObjectId(searchTableContent.getLastContentId()));
		
		CreateAndQuery andQuery=new CreateAndQuery();//条件合并
		andQuery.Add(CreateQueryFromBean.EqualObj(tableContentInfo1));
		andQuery.Add(CreateQueryFromBean.LtObj(tableContentInfo2));
		BasicDBObject query=andQuery.GetResult();
		
		BasicDBObject sort=new BasicDBObject(); //降序排序
		sort.put(StaticString.TableContentInfo_id, -1);
		
		BasicDBObject projection=new BasicDBObject();//显示字段
		projection.put(StaticString.TableContentInfo_TableContentColumn, 1);
		projection.put(StaticString.TableContentInfo_id, 1);
		
		ArrayList<Document> list = new ArrayList<Document>(); //存于ArrayList<Document>
		MongoCursor<Document> cursor=DaoImpl.GetSelectCursor(TableContentInfo.class, 
				query, sort, searchTableContent.getLimit(), projection);
		while(cursor.hasNext()){//获取数据
			list.add(cursor.next());
		}
		
		String [] columnNames = searchTableContent.getColumnNames();//获取字段头
		JSONArray data = new JSONArray();//转换为JSONArray
		if(list!=null && list.size()>0) {
			ArrayList<Document> document = new ArrayList<Document>();
			for(int i = 0;i<list.size();i++){
				document.clear();
				document = (ArrayList<Document>)list.get(i).get("TableContentColumn");
				JSONObject jsonObject = new JSONObject();
				for(int j = 0; j < columnNames.length; j ++) {
					for(int k = 0; k < document.size(); k++) {
						String name = (String)document.get(k).get("Name");
						if(columnNames[j].trim().equals(name)) {
							jsonObject.put(name,document.get(k).get("Content"));
							break;
						}
						if(name.equals("SignIn")) {
							jsonObject.put("SignIn", document.get(k).get("Content"));
							break;
						}
					}
				}
				jsonObject.put("_id", list.get(i).get("_id"));
				data.put(jsonObject);
			}
		}
		return data.toString();
	}
}
