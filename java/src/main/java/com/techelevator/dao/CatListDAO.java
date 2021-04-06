package com.techelevator.dao;


import java.util.List;

import com.techelevator.model.CatList;

public interface CatListDAO {
	
	List<CatList> retrieveCatList();
	
	List<CatList> retrieveCatDetails(Long catId);

}
