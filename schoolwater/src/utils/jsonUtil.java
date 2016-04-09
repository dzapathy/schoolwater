package utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCursor;

public class jsonUtil {
	
	public static JSONArray ListToJSONArray(List<Map<String, Object>> list) {
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			JSONObject jsonobject = MapToJSONObject(map);
			jsonArray.put(jsonobject);
		}
		return jsonArray;
	}

	public static List<Map<String, Object>> JsonArrayToList(String json) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		JSONArray jsonArray = null;

		try {

			jsonArray = new JSONArray(json);

		} catch (JSONException e) {

			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int iSize = jsonArray.length();

		System.out.println(iSize);

		for (int i = 0; i < iSize; i++) {
			JSONObject jsonObj = null;
			try {
				jsonObj = (JSONObject) jsonArray.getJSONObject(i);

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			list.add(JsonObjToMap(jsonObj));
		}
		return list;
	}

	public static Map<String, Object> JsonObjToMap(JSONObject jsonObj) {
		Map<String, Object> map = new HashMap<String, Object>();
		@SuppressWarnings("rawtypes")
		Iterator it = jsonObj.keys();
		// 遍历jsonObject数据，添加到Map对象
		while (it.hasNext()) {
			String key = String.valueOf(it.next());
			Object value = null;
			try {
				value = (Object) jsonObj.get(key);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			map.put(key, value);
		}
		return map;
	}

	public static JSONObject MapToJSONObject(Map<String, Object> map) {
		return new JSONObject(map);
	}
	
	@SuppressWarnings("unchecked")
	public static JSONObject ParaFromDocument(Document doc){
		
		BasicDBObject obj1=new BasicDBObject(doc);
		JSONObject jso=new JSONObject(obj1.toMap());
		try{
			if(doc.containsKey("Major")){

				ArrayList<Document> list=(ArrayList<Document>)doc.get("Major");
				JSONArray array=new JSONArray();
				for(int i=0;i<list.size();i++){
					BasicDBObject obj2=new BasicDBObject(list.get(i));
					JSONObject jso2=new JSONObject(obj2.toMap());
					array.put(jso2);
				}
				jso.put("Major", array);
			}
			if(doc.containsKey("Member")){
				ArrayList<Document> list=(ArrayList<Document>)doc.get("Member");
				JSONArray array=new JSONArray();
				for(int i=0;i<list.size();i++){
					BasicDBObject obj2=new BasicDBObject(list.get(i));
					JSONObject jso2=new JSONObject(obj2.toMap());
					array.put(jso2);
				}
				jso.put("Member", array);
			}
			if(doc.containsKey("TableContentColumn")){
				ArrayList<Document> list=(ArrayList<Document>)doc.get("TableContentColumn");
				JSONArray array=new JSONArray();
				for(int i=0;i<list.size();i++){
					BasicDBObject obj2=new BasicDBObject(list.get(i));
					JSONObject jso2=new JSONObject(obj2.toMap());
					array.put(jso2);
				}
				jso.put("TableContentColumn", array);
			}
			if(doc.containsKey("TableInfoColumn")){
				ArrayList<Document> list=(ArrayList<Document>)doc.get("TableInfoColumn");
				JSONArray array=new JSONArray();
				for(int i=0;i<list.size();i++){
					BasicDBObject obj2=new BasicDBObject(list.get(i));
					JSONObject jso2=new JSONObject(obj2.toMap());
					array.put(jso2);
				}
				jso.put("TableInfoColumn", array);
			}
			if(doc.containsKey("Manager")){
				ArrayList<Document> list=(ArrayList<Document>)doc.get("Manager");
				JSONArray array=new JSONArray();
				for(int i=0;i<list.size();i++){
					BasicDBObject obj2=new BasicDBObject(list.get(i));
					JSONObject jso2=new JSONObject(obj2.toMap());
					array.put(jso2);
				}
				jso.put("Manager", array);
			}
			if(doc.containsKey("InActivityCategoty")){
				ArrayList<Document> list=(ArrayList<Document>)doc.get("InActivityCategoty");
				JSONArray array=new JSONArray();
				for(int i=0;i<list.size();i++){
					BasicDBObject obj2=new BasicDBObject(list.get(i));
					JSONObject jso2=new JSONObject(obj2.toMap());
					array.put(jso2);
				}
				jso.put("InActivityCategoty", array);
			}
		}catch(Exception e){
			
		}		
		return jso;
	}
	
	public static JSONArray ParaFromMongoCursor(MongoCursor<Document> cursor){
		
		JSONArray array=new JSONArray();
		
		while (cursor.hasNext()) {
			
			Document obj=cursor.next();
			
			JSONObject json=jsonUtil.ParaFromDocument(obj);
			
			array.put(json);
		}
		return array;
		
	}
}
