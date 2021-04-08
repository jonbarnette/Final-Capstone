package com.techelevator.dao;


import java.util.List;

import com.techelevator.model.CatList;

public interface CatListDAO {
	
	List<CatList> retrieveCatList();
	
	List<CatList> retrieveCatDetails(int cat_id); //will give details for the cat selected
	
	void addCat(CatList catList);
	
	boolean deleteCat(int cat_id);

}
