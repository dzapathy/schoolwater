package com.dao;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

public class DBClientFactory {
	private static MongoClient mongoClient = null;

	public static MongoDatabase getDB() {

		MongoDatabase conn = null;

		if (mongoClient == null) {
			intializeMongoClient();

		}

		conn = mongoClient.getDatabase("schooltime");

		return conn;

	}

	private static void intializeMongoClient() {

//		mongoClient = new MongoClient("localhost", 27017);
		mongoClient = new MongoClient("114.215.135.115", 27017);
	}

	public static synchronized void closeConnection() {

		if (mongoClient != null) {

			mongoClient.close();

		}
	}
}
