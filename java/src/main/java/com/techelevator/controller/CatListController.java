package com.techelevator.controller;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.techelevator.dao.CatListDAO;
import com.techelevator.dao.UserDAO;
import com.techelevator.model.CatList;

@RestController
@CrossOrigin

public class CatListController
{
	@Autowired
	CatListDAO catListDao;
	@Autowired
	UserDAO userDao;
	
	
	//get list of all cats
	@PreAuthorize("permitAll")
	@RequestMapping(path="/cats", method =RequestMethod.GET)
	public List<CatList> getCatList() {
		return catListDao.retrieveCatList();
	}
	
//	Need authorization to be able to see details
	@RequestMapping(path="/cats/{catId}", method =RequestMethod.GET)
	public List<CatList> getCatDetails(@PathVariable int catId)
	{
		return catListDao.retrieveCatDetails(catId);
	}
	
	@ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(path="/cats", method =RequestMethod.POST)
	public void addCatProfile(@RequestBody CatList catList) //Might need to add in Principal
	{
		catListDao.addCat(catList);
		
	}
	
	
	@ResponseStatus(HttpStatus.NO_CONTENT)
	@RequestMapping(value="/cats/{catId}", method = RequestMethod.DELETE)
	public void deleteCatProfile(@Valid @PathVariable("catId") int catId) //Might need to add in Principal  ADD EXCEPTIONS
	{	
		catListDao.deleteCat(catId);
		
	}
	
	//Messaging System
	
	@RequestMapping(path="/msg/{catId}", method =RequestMethod.GET)
	public List<CatList> getCatMsg(@PathVariable int catId)
	{
		return catListDao.retrieveCatMessage(catId);
	}
	
	@ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(path="/msg", method =RequestMethod.POST)
	public void msgCat(@RequestBody CatList catList) //Might need to add in Principal
	{
		catListDao.addMessage(catList);
		
	}

}
