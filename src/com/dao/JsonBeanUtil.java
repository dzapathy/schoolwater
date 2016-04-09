package com.dao;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;

import org.bson.Document;
import org.bson.types.ObjectId;

import bean.City;
import bean.InActivityCategoty;
import bean.Major;
import bean.Manager;
import bean.Member;
import bean.TableContentColumn;
import bean.TableInfoColumn;

import com.mongodb.BasicDBObject;

public class JsonBeanUtil {

	public static Document getDocumentFromBean(Object model) throws Exception {

		BasicDBObject obj = getJsonFromBean(model);
		return new Document(obj);
		
	}

	public static BasicDBObject getJsonFromBean(Object model) throws Exception {
		BasicDBObject map = new BasicDBObject();
		Field[] field = model.getClass().getDeclaredFields(); // 获取实体类的所有属性，返回Field数组
		for (int j = 0; j < field.length; j++) { // 遍历所有属性
			String name = field[j].getName(); // 获取属性的名字
			name = name.substring(0, 1).toUpperCase() + name.substring(1); // 将属性的首字符大写，方便构造get，set方法
			String type = field[j].getGenericType().toString(); // 获取属性的类型
			if (type.equals("class java.lang.Integer")) { // 如果type是类类型，则前面包含"class "，后面跟类名
				Method m = model.getClass().getMethod("get" + name);
				Integer value = (Integer) m.invoke(model); // 调用getter方法获取属性值
				if (value != null) {
					map.put(name, value);
				}
			}

			if (type.equals("class java.lang.String")) { // 如果type是类类型，则前面包含"class "，后面跟类名
				Method m = model.getClass().getMethod("get" + name);
				String value = (String) m.invoke(model); // 调用getter方法获取属性值
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class org.bson.types.ObjectId")) {
				Method m = model.getClass().getMethod("get" + name);
				ObjectId value = (ObjectId) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Short")) {
				Method m = model.getClass().getMethod("get" + name);
				Short value = (Short) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Double")) {
				Method m = model.getClass().getMethod("get" + name);
				Double value = (Double) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Boolean")) {
				Method m = model.getClass().getMethod("get" + name);
				Boolean value = (Boolean) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.util.Date")) {
				Method m = model.getClass().getMethod("get" + name);
				Date value = (Date) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}

			if (type.equals("java.util.ArrayList<bean.Major>")) {

				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Major> value = ((ArrayList<Major>) m.invoke(model));
				ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
				if (value != null && value.size() != 0) {
					for (int i = 0; i < value.size(); i++) {
						Major major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("_id", major.get_id());
						bis.put("Name", major.getName());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;
				}

			}

			if (type.equals("java.util.ArrayList<bean.InActivityCategoty>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<InActivityCategoty> value = ((ArrayList<InActivityCategoty>) m
						.invoke(model));
				ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
				if (value != null && value.size() != 0) {
					for (int i = 0; i < value.size(); i++) {
						InActivityCategoty major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("_id", major.get_id());
						bis.put("Name", major.getName());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;
				}
			}
			if (type.equals("java.util.ArrayList<bean.Manager>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Manager> value = ((ArrayList<Manager>) m.invoke(model));
				ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
				if (value != null && value.size() != 0) {
					for (int i = 0; i < value.size(); i++) {
						Manager major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("Pwd", major.getPwd());
						bis.put("Name", major.getName());
						bis.put("UserId", major.getUserId());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;
				}
			}
			
			if (type.equals("java.util.ArrayList<bean.TableInfoColumn>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<TableInfoColumn> value = ((ArrayList<TableInfoColumn>) m.invoke(model));
				ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
				if (value != null && value.size() != 0) {
					for (int i = 0; i < value.size(); i++) {
						TableInfoColumn major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("Choose", major.getChoose());
						bis.put("Name", major.getName());
						bis.put("Length", major.getLength());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;
				}
			}
			
			if (type.equals("java.util.ArrayList<bean.TableContentColumn>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<TableContentColumn> value = ((ArrayList<TableContentColumn>) m.invoke(model));
				ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
				if (value != null && value.size() != 0) {
					for (int i = 0; i < value.size(); i++) {
						TableContentColumn major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("Content", major.getContent());
						bis.put("Name", major.getName());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;
				}
			}
			
			if (type.equals("java.util.ArrayList<bean.Member>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Member> value = ((ArrayList<Member>) m.invoke(model));
				ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
				if (value != null && value.size() != 0) {
					for (int i = 0; i < value.size(); i++) {
						Member major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						
						bis.put("Abstract", major.getAbstract());
						bis.put("Degree", major.getDegree());
						bis.put("Grade", major.getGrade());
						bis.put("IdCard", major.getIdCard());
						bis.put("MajorName", major.getMajorName());
						bis.put("Name", major.getName());
						bis.put("Phone", major.getPhone());
						bis.put("SchoolId", major.getSchoolId());
						bis.put("State", major.getState());
						bis.put("StuId", major.getStuId());
						bis.put("NowTime", major.getNowTime());
						
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;
				}
			}
			
			if (type.equals("java.util.ArrayList<bean.City>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<City> value = ((ArrayList<City>) m.invoke(model));
				ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
				if (value != null && value.size() != 0) {
					for (int i = 0; i < value.size(); i++) {
						City major=value.get(i);
						BasicDBObject bis=new BasicDBObject();

						bis.put("Name", major.getName());
						
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;
				}
			}
		}
		return map;
	}

	public static BasicDBObject getQueryFromBean(Object model) throws Exception {
		BasicDBObject map = new BasicDBObject();
		Field[] field = model.getClass().getDeclaredFields(); // 获取实体类的所有属性，返回Field数组
		for (int j = 0; j < field.length; j++) { // 遍历所有属性
			String name = field[j].getName(); // 获取属性的名字
			name = name.substring(0, 1).toUpperCase() + name.substring(1); // 将属性的首字符大写，方便构造get，set方法
			String type = field[j].getGenericType().toString(); // 获取属性的类型
			if (type.equals("class java.lang.Integer")) { // 如果type是类类型，则前面包含"class "，后面跟类名
				Method m = model.getClass().getMethod("get" + name);
				Integer value = (Integer) m.invoke(model); // 调用getter方法获取属性值
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.String")) { // 如果type是类类型，则前面包含"class "，后面跟类名
				Method m = model.getClass().getMethod("get" + name);
				String value = (String) m.invoke(model); // 调用getter方法获取属性值
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class org.bson.types.ObjectId")) {
				Method m = model.getClass().getMethod("get" + name);
				ObjectId value = (ObjectId) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Short")) {
				Method m = model.getClass().getMethod("get" + name);
				Short value = (Short) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Double")) {
				Method m = model.getClass().getMethod("get" + name);
				Double value = (Double) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Boolean")) {
				Method m = model.getClass().getMethod("get" + name);
				Boolean value = (Boolean) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.util.Date")) {
				Method m = model.getClass().getMethod("get" + name);
				Date value = (Date) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}

			if (type.equals("java.util.ArrayList<bean.Major>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Major> value = ((ArrayList<Major>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					BasicDBObject sic=new BasicDBObject();
					if(value.get(0).get_id()!=null){
						sic.put("_id", value.get(0).get_id());
					}
					if(value.get(0).getName()!=null){
						sic.put("Name", value.get(0).getName());
					}
					BasicDBObject ob1=new BasicDBObject("$elemMatch",sic);
					map.put(name, ob1);
				}

			}

			if (type.equals("java.util.ArrayList<bean.InActivityCategoty>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<InActivityCategoty> value = ((ArrayList<InActivityCategoty>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					BasicDBObject sic=new BasicDBObject();
					if(value.get(0).get_id()!=null){
						sic.put("_id", value.get(0).get_id());
					}
					if(value.get(0).getName()!=null){
						sic.put("Name", value.get(0).getName());
					}	
					BasicDBObject ob1=new BasicDBObject("$elemMatch",sic);
					map.put(name, ob1);
				}

			}
			
			if (type.equals("java.util.ArrayList<bean.Manager>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Manager> value = ((ArrayList<Manager>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					BasicDBObject sic=new BasicDBObject();
					if(value.get(0).getPwd()!=null){
						sic.put("Pwd", value.get(0).getPwd());
					}
					if(value.get(0).getName()!=null){
						sic.put( "Name", value.get(0).getName());
					}	
					if(value.get(0).getUserId()!=null){
						sic.put("UserId", value.get(0).getUserId());
					}	
					BasicDBObject ob1=new BasicDBObject("$elemMatch",sic);
					map.put(name, ob1);
				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.TableInfoColumn>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<TableInfoColumn> value = ((ArrayList<TableInfoColumn>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					BasicDBObject sic=new BasicDBObject();
					if(value.get(0).getChoose()!=null){
						sic.put("Choose", value.get(0).getChoose());
					}
					if(value.get(0).getName()!=null){
						sic.put("Name", value.get(0).getName());
					}	
					if(value.get(0).getLength()!=null){
						sic.put("Length", value.get(0).getLength());
					}	
					BasicDBObject ob1=new BasicDBObject("$elemMatch",sic);
					map.put(name, ob1);
				}
			}
			
			if (type.equals("java.util.ArrayList<bean.TableContentColumn>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<TableContentColumn> value = ((ArrayList<TableContentColumn>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					BasicDBObject sic=new BasicDBObject();
					if(value.get(0).getContent()!=null){
						sic.put("Content", value.get(0).getContent());
					}
					if(value.get(0).getName()!=null){
						sic.put("Name", value.get(0).getName());
					}
					BasicDBObject ob1=new BasicDBObject("$elemMatch",sic);
					map.put(name, ob1);
				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.Member>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Member> value = ((ArrayList<Member>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					BasicDBObject sic=new BasicDBObject();
					
					if(value.get(0).getAbstract()!=null){
						sic.put("Abstract", value.get(0).getAbstract());
					}
					if(value.get(0).getDegree()!=null){
						sic.put("Degree", value.get(0).getDegree());
					}
					if(value.get(0).getGrade()!=null){
						sic.put("Grade", value.get(0).getGrade());
					}
					if(value.get(0).getIdCard()!=null){
						sic.put("IdCard", value.get(0).getIdCard());
					}
					if(value.get(0).getMajorName()!=null){
						sic.put("MajorName", value.get(0).getMajorName());
					}
					if(value.get(0).getName()!=null){
						sic.put("Name", value.get(0).getName());
					}
					if(value.get(0).getPhone()!=null){
						sic.put("Phone", value.get(0).getPhone());
					}
					if(value.get(0).getSchoolId()!=null){
						sic.put("SchoolId", value.get(0).getSchoolId());
					}					
					
					if(value.get(0).getState()!=null){
						sic.put("State", value.get(0).getState());
					}	
					if(value.get(0).getStuId()!=null){
						sic.put("StuId", value.get(0).getStuId());
					}
					if(value.get(0).getNowTime()!=null){
						sic.put("NowTime", value.get(0).getNowTime());
					}
					BasicDBObject ob1=new BasicDBObject("$elemMatch",sic);
					map.put(name, ob1);
				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.City>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<City> value = ((ArrayList<City>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					BasicDBObject sic=new BasicDBObject();

					if(value.get(0).getName()!=null){
						sic.put("Name", value.get(0).getName());
					}

					
					BasicDBObject ob1=new BasicDBObject("$elemMatch",sic);
					map.put(name, ob1);
				}
				
			}
		}
		return map;
	}
	
	
	public static BasicDBObject getUpateFromBean(Object model) throws Exception {
		BasicDBObject map = new BasicDBObject();
		Field[] field = model.getClass().getDeclaredFields(); // 获取实体类的所有属性，返回Field数组
		for (int j = 0; j < field.length; j++) { // 遍历所有属性
			String name = field[j].getName(); // 获取属性的名字
			name = name.substring(0, 1).toUpperCase() + name.substring(1); // 将属性的首字符大写，方便构造get，set方法
			String type = field[j].getGenericType().toString(); // 获取属性的类型
			if (type.equals("class java.lang.Integer")) { // 如果type是类类型，则前面包含"class "，后面跟类名
				Method m = model.getClass().getMethod("get" + name);
				Integer value = (Integer) m.invoke(model); // 调用getter方法获取属性值
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.String")) { // 如果type是类类型，则前面包含"class "，后面跟类名
				Method m = model.getClass().getMethod("get" + name);
				String value = (String) m.invoke(model); // 调用getter方法获取属性值
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class org.bson.types.ObjectId")) {
				Method m = model.getClass().getMethod("get" + name);
				ObjectId value = (ObjectId) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Short")) {
				Method m = model.getClass().getMethod("get" + name);
				Short value = (Short) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Double")) {
				Method m = model.getClass().getMethod("get" + name);
				Double value = (Double) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Boolean")) {
				Method m = model.getClass().getMethod("get" + name);
				Boolean value = (Boolean) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.util.Date")) {
				Method m = model.getClass().getMethod("get" + name);
				Date value = (Date) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}

			if (type.equals("java.util.ArrayList<bean.Major>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Major> value = ((ArrayList<Major>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					if(value.get(0).get_id()!=null){
						map.put("Major.$._id", value.get(0).get_id());
					}
					if(value.get(0).getName()!=null){
						map.put("Major.$.Name", value.get(0).getName());
					}
				}
			}

			if (type.equals("java.util.ArrayList<bean.InActivityCategoty>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<InActivityCategoty> value = ((ArrayList<InActivityCategoty>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					if(value.get(0).get_id()!=null){
						map.put("InActivityCategoty.$._id", value.get(0).get_id());
					}
					if(value.get(0).getName()!=null){
						map.put("InActivityCategoty.$.Name", value.get(0).getName());
					}	
				}

			}
			
			if (type.equals("java.util.ArrayList<bean.Manager>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Manager> value = ((ArrayList<Manager>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					if(value.get(0).getPwd()!=null){
						map.put("Manager.$.Pwd", value.get(0).getPwd());
					}
					if(value.get(0).getName()!=null){
						map.put( "Manager.$.Name", value.get(0).getName());
					}	
					if(value.get(0).getUserId()!=null){
						map.put("Manager.$.UserId", value.get(0).getUserId());
					}	
				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.TableInfoColumn>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<TableInfoColumn> value = ((ArrayList<TableInfoColumn>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					if(value.get(0).getChoose()!=null){
						map.put("TableInfoColumn.$.Choose", value.get(0).getChoose());
					}
					if(value.get(0).getName()!=null){
						map.put("TableInfoColumn.$.Name", value.get(0).getName());
					}	
					if(value.get(0).getLength()!=null){
						map.put("TableInfoColumn.$.Length", value.get(0).getLength());
					}	
				}
			}
			
			if (type.equals("java.util.ArrayList<bean.TableContentColumn>")) {
				
				
				System.out.println("dsfdsfs");
				
				
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<TableContentColumn> value = ((ArrayList<TableContentColumn>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}

					if(value.get(0).getContent()!=null){
						map.put("TableContentColumn.$.Content", value.get(0).getContent());
					}
					if(value.get(0).getName()!=null){
						map.put("TableContentColumn.$.Name", value.get(0).getName());
					}
				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.Member>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Member> value = ((ArrayList<Member>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}				
					
					if(value.get(0).getAbstract()!=null){
						map.put("Member.$.Abstract", value.get(0).getAbstract());
					}
					if(value.get(0).getDegree()!=null){
						map.put("Member.$.Degree", value.get(0).getDegree());
					}
					if(value.get(0).getGrade()!=null){
						map.put("Member.$.Grade", value.get(0).getGrade());
					}
					if(value.get(0).getIdCard()!=null){
						map.put("Member.$.IdCard", value.get(0).getIdCard());
					}
					if(value.get(0).getMajorName()!=null){
						map.put("Member.$.MajorName", value.get(0).getMajorName());
					}
					if(value.get(0).getName()!=null){
						map.put("Member.$.Name", value.get(0).getName());
					}
					if(value.get(0).getPhone()!=null){
						map.put("Member.$.Phone", value.get(0).getPhone());
					}
					if(value.get(0).getSchoolId()!=null){
						map.put("Member.$.SchoolId", value.get(0).getSchoolId());
					}
					if(value.get(0).getState()!=null){
						map.put("Member.$.State", value.get(0).getState());
					}
					if(value.get(0).getStuId()!=null){
						map.put("Member.$.StuId", value.get(0).getStuId());
					}
					if(value.get(0).getNowTime()!=null){
						map.put("Member.$.NowTime", value.get(0).getNowTime());
					}
				
				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.City>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<City> value = ((ArrayList<City>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}				

					if(value.get(0).getName()!=null){
						map.put("City.$.Name", value.get(0).getName());
					}					
				
				}
			}
		}
		return map;
	}
	
	public static BasicDBObject getUpateAllSonFromBean(Object model) throws Exception {
		BasicDBObject map = new BasicDBObject();
		Field[] field = model.getClass().getDeclaredFields(); // 获取实体类的所有属性，返回Field数组
		for (int j = 0; j < field.length; j++) { // 遍历所有属性
			String name = field[j].getName(); // 获取属性的名字
			name = name.substring(0, 1).toUpperCase() + name.substring(1); // 将属性的首字符大写，方便构造get，set方法
			String type = field[j].getGenericType().toString(); // 获取属性的类型
			if (type.equals("class java.lang.Integer")) { // 如果type是类类型，则前面包含"class "，后面跟类名
				Method m = model.getClass().getMethod("get" + name);
				Integer value = (Integer) m.invoke(model); // 调用getter方法获取属性值
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.String")) { // 如果type是类类型，则前面包含"class "，后面跟类名
				Method m = model.getClass().getMethod("get" + name);
				String value = (String) m.invoke(model); // 调用getter方法获取属性值
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class org.bson.types.ObjectId")) {
				Method m = model.getClass().getMethod("get" + name);
				ObjectId value = (ObjectId) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Short")) {
				Method m = model.getClass().getMethod("get" + name);
				Short value = (Short) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Double")) {
				Method m = model.getClass().getMethod("get" + name);
				Double value = (Double) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Boolean")) {
				Method m = model.getClass().getMethod("get" + name);
				Boolean value = (Boolean) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.util.Date")) {
				Method m = model.getClass().getMethod("get" + name);
				Date value = (Date) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}

			if (type.equals("java.util.ArrayList<bean.Major>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Major> value = ((ArrayList<Major>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					if(value.get(0).get_id()!=null){
						map.put("Major.$._id", value.get(0).get_id());
					}
					if(value.get(0).getName()!=null){
						map.put("Major.$.Name", value.get(0).getName());
					}
				}
			}

			if (type.equals("java.util.ArrayList<bean.InActivityCategoty>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<InActivityCategoty> value = ((ArrayList<InActivityCategoty>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					if(value.get(0).get_id()!=null){
						map.put("InActivityCategoty.$._id", value.get(0).get_id());
					}
					if(value.get(0).getName()!=null){
						map.put("InActivityCategoty.$.Name", value.get(0).getName());
					}	
				}

			}
			
			if (type.equals("java.util.ArrayList<bean.Manager>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Manager> value = ((ArrayList<Manager>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					if(value.get(0).getPwd()!=null){
						map.put("Manager.$.Pwd", value.get(0).getPwd());
					}
					if(value.get(0).getName()!=null){
						map.put( "Manager.$.Name", value.get(0).getName());
					}	
					if(value.get(0).getUserId()!=null){
						map.put("Manager.$.UserId", value.get(0).getUserId());
					}	
				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.TableInfoColumn>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<TableInfoColumn> value = ((ArrayList<TableInfoColumn>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}
					if(value.get(0).getChoose()!=null){
						map.put("TableInfoColumn.$.Choose", value.get(0).getChoose());
					}
					if(value.get(0).getName()!=null){
						map.put("TableInfoColumn.$.Name", value.get(0).getName());
					}	
					if(value.get(0).getLength()!=null){
						map.put("TableInfoColumn.$.Length", value.get(0).getLength());
					}	
				}
			}
			
			if (type.equals("java.util.ArrayList<bean.TableContentColumn>")) {
				
				
				System.out.println("dsfdsfs");
				
				
				
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<TableContentColumn> value = ((ArrayList<TableContentColumn>) m.invoke(model));
				if (value != null && value.size() != 0) {
					
					System.out.println(value.get(0).getContent());
					
					map.put("TableContentColumn", value);
				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.Member>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Member> value = ((ArrayList<Member>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}				
					
					if(value.get(0).getAbstract()!=null){
						map.put("Member.$.Abstract", value.get(0).getAbstract());
					}
					if(value.get(0).getDegree()!=null){
						map.put("Member.$.Degree", value.get(0).getDegree());
					}
					if(value.get(0).getGrade()!=null){
						map.put("Member.$.Grade", value.get(0).getGrade());
					}
					if(value.get(0).getIdCard()!=null){
						map.put("Member.$.IdCard", value.get(0).getIdCard());
					}
					if(value.get(0).getMajorName()!=null){
						map.put("Member.$.MajorName", value.get(0).getMajorName());
					}
					if(value.get(0).getName()!=null){
						map.put("Member.$.Name", value.get(0).getName());
					}
					if(value.get(0).getPhone()!=null){
						map.put("Member.$.Phone", value.get(0).getPhone());
					}
					if(value.get(0).getSchoolId()!=null){
						map.put("Member.$.SchoolId", value.get(0).getSchoolId());
					}
					if(value.get(0).getState()!=null){
						map.put("Member.$.State", value.get(0).getState());
					}
					if(value.get(0).getStuId()!=null){
						map.put("Member.$.StuId", value.get(0).getStuId());
					}
					if(value.get(0).getNowTime()!=null){
						map.put("Member.$.NowTime", value.get(0).getNowTime());
					}
				
				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.City>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<City> value = ((ArrayList<City>) m.invoke(model));
				if (value != null && value.size() != 0) {
					if (value.size() != 1) {
						return null;
					}				

					if(value.get(0).getName()!=null){
						map.put("City.$.Name", value.get(0).getName());
					}					
				
				}
			}
		}
		return map;
	}
	
	public static BasicDBObject getUpateWholeFromBean(Object model) throws Exception {
		BasicDBObject map = new BasicDBObject();
		Field[] field = model.getClass().getDeclaredFields(); // 获取实体类的所有属性，返回Field数组
		for (int j = 0; j < field.length; j++) { // 遍历所有属性
			String name = field[j].getName(); // 获取属性的名字
			name = name.substring(0, 1).toUpperCase() + name.substring(1); // 将属性的首字符大写，方便构造get，set方法
			String type = field[j].getGenericType().toString(); // 获取属性的类型
			if (type.equals("class java.lang.Integer")) { // 如果type是类类型，则前面包含"class "，后面跟类名
				Method m = model.getClass().getMethod("get" + name);
				Integer value = (Integer) m.invoke(model); // 调用getter方法获取属性值
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.String")) { // 如果type是类类型，则前面包含"class "，后面跟类名
				Method m = model.getClass().getMethod("get" + name);
				String value = (String) m.invoke(model); // 调用getter方法获取属性值
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class org.bson.types.ObjectId")) {
				Method m = model.getClass().getMethod("get" + name);
				ObjectId value = (ObjectId) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Short")) {
				Method m = model.getClass().getMethod("get" + name);
				Short value = (Short) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Double")) {
				Method m = model.getClass().getMethod("get" + name);
				Double value = (Double) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.lang.Boolean")) {
				Method m = model.getClass().getMethod("get" + name);
				Boolean value = (Boolean) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}
			if (type.equals("class java.util.Date")) {
				Method m = model.getClass().getMethod("get" + name);
				Date value = (Date) m.invoke(model);
				if (value != null) {
					map.put(name, value);
				}
			}

			if (type.equals("java.util.ArrayList<bean.Major>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Major> value = ((ArrayList<Major>) m.invoke(model));
				if (value != null && value.size() != 0) {					
					ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
					for (int i = 0; i < value.size(); i++) {
						Major major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("_id", major.get_id());
						bis.put("Name", major.getName());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;
				}
			}

			if (type.equals("java.util.ArrayList<bean.InActivityCategoty>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<InActivityCategoty> value = ((ArrayList<InActivityCategoty>) m.invoke(model));
				if (value != null && value.size() != 0) {
					
					ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
					for (int i = 0; i < value.size(); i++) {
						InActivityCategoty major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("_id", major.get_id());
						bis.put("Name", major.getName());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;
				}

			}
			
			if (type.equals("java.util.ArrayList<bean.Manager>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Manager> value = ((ArrayList<Manager>) m.invoke(model));
				if (value != null && value.size() != 0) {
					
					ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
					for (int i = 0; i < value.size(); i++) {
						Manager major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("Pwd", major.getPwd());
						bis.put("Name", major.getName());
						bis.put("UserId", major.getUserId());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;

					
				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.TableInfoColumn>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<TableInfoColumn> value = ((ArrayList<TableInfoColumn>) m.invoke(model));
				if (value != null && value.size() != 0) {
					
					ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
					for (int i = 0; i < value.size(); i++) {
						TableInfoColumn major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("Choose", major.getChoose());
						bis.put("Name", major.getName());
						bis.put("Length", major.getLength());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;

				}
			}
			
			if (type.equals("java.util.ArrayList<bean.TableContentColumn>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<TableContentColumn> value = ((ArrayList<TableContentColumn>) m.invoke(model));
				if (value != null && value.size() != 0) {
					
					ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
					for (int i = 0; i < value.size(); i++) {
						TableContentColumn major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("Content", major.getContent());
						bis.put("Name", major.getName());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;

				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.Member>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<Member> value = ((ArrayList<Member>) m.invoke(model));
				if (value != null && value.size() != 0) {
					
					
					ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
					for (int i = 0; i < value.size(); i++) {
						Member major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("Abstract", major.getAbstract());
						bis.put("Degree", major.getDegree());
						bis.put("Grade", major.getGrade());
						bis.put("Name", major.getName());
						bis.put("IdCard", major.getIdCard());
						bis.put("MajorName", major.getMajorName());
						bis.put("Phone", major.getPhone());
						bis.put("SchoolId", major.getSchoolId());
						bis.put("State", major.getState());
						bis.put("StuId", major.getStuId());
						bis.put("NowTime", major.getNowTime());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;

				}
				
			}
			
			if (type.equals("java.util.ArrayList<bean.City>")) {
				Method m = model.getClass().getMethod("get" + name);
				@SuppressWarnings("unchecked")
				ArrayList<City> value = ((ArrayList<City>) m.invoke(model));
				if (value != null && value.size() != 0) {

					ArrayList<BasicDBObject> list = new ArrayList<BasicDBObject>();
					for (int i = 0; i < value.size(); i++) {
						City major=value.get(i);
						BasicDBObject bis=new BasicDBObject();
						bis.put("Name", major.getName());
						list.add(bis);
					}
					map.put(name, list);
					value.clear();
					value = null;				
				
				}
			}
		}
		return map;
	}
}
