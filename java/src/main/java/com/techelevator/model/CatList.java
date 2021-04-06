package com.techelevator.model;

public class CatList {
	
	private String name;
	private int age;  //based on cat years starting at 15
	private String breed; //can be guessed if not sure TABBY WILL BE DEFAULT
	private String color; //what if you are color blind?
	private String occupation;
	private String tagline; //this is the quick summary shown on the list  this is ONLY ON THE LIST
	private String address; //this is the last seen location
	private String summary; //this is the full summary in the details page
	private int catId; //will be the foreign key for the database
	
	
	
	
	public int getCatId() {
		return catId;
	}
	public void setCatId(int catId) {
		this.catId = catId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getBreed() {
		return breed;
	}
	public void setBreed(String breed) {
		this.breed = breed;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getOccupation() {
		return occupation;
	}
	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}
	public String getTagline() {
		return tagline;
	}
	public void setTagline(String tagline) {
		this.tagline = tagline;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}


}
