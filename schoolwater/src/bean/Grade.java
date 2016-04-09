package bean;

import java.util.ArrayList;

public class Grade{
	private String name;
	private String idCard;
	private double score;
	private ArrayList<Detail> detail;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdCard(){
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public ArrayList<Detail> getDetail() {
		return detail;
	}
	public void setDetail(ArrayList<Detail> detail) {
		this.detail = detail;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
}
