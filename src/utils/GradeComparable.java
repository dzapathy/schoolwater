package utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import bean.Grade;

public class GradeComparable implements Comparator<Grade>{

	public static void main(String[] args) {
		ArrayList<Grade> grades = new ArrayList<Grade>();
		for(int i = 0 ;i<10;i++){
			Grade grade = new Grade();
			grade.setName(i+"");
			grade.setScore(i);
			grades.add(grade);
		}
//		for (int i = 0; i < grades.size(); i++) {
//			System.out.println(grades.get(i).getName()+"---"+grades.get(i).getScore());
//		}
		GradeComparable comparable = new GradeComparable();
		Collections.sort(grades, comparable);
		for (int i = 0; i < grades.size(); i++) {
			System.out.println(grades.get(i).getName()+"---"+grades.get(i).getScore());
		}
	}
	
	public int compare(Grade o1, Grade o2) {
		Double double1 = (Double)o1.getScore();
		Double double2 = (Double)o2.getScore();
		return double2.compareTo(double1);
	}
}
