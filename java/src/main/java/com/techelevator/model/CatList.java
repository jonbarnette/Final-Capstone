package com.techelevator.model;

public class CatList {
	
	private String imageName;
	private String name;
	private int lives;  //based on cat years starting at 15
	private String breed; //can be guessed if not sure TABBY WILL BE DEFAULT
	private String color; //what if you are color blind?
	private String occupation;
	private String tagline; //this is the quick summary shown on the list  this is ONLY ON THE LIST
	private String address; //this is the last seen location
	private String summary; //this is the full summary in the details page
	private int cat_id; //will be the foreign key for the database
	
	
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}	
	public int getCat_Id() {
		return cat_id;
	}
	public void setCat_Id(int cat_id) {
		this.cat_id = cat_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getLives() {
		return lives;
	}
	public void setLives(int lives) {
		this.lives = lives;
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
