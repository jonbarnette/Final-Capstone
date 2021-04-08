package com.techelevator.controller;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
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
	@RequestMapping(path="/cats/{cat_id}", method =RequestMethod.GET)
	public List<CatList> getCatDetails(@PathVariable int cat_id)
	{
		return catListDao.retrieveCatDetails(cat_id);
	}
	
	@ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(path="/cats", method =RequestMethod.POST)
	public void addCatProfile(@RequestBody CatList catList) //Might need to add in Principal
	{
		catListDao.addCat(catList);
		
	}
	
	
	@ResponseStatus(HttpStatus.NO_CONTENT)
	@RequestMapping(path="/cats", method =RequestMethod.DELETE)
	public void deleteCatProfile(@RequestBody CatList catList) //Might need to add in Principal  ADD EXCEPTIONS
	{
		catListDao.addCat(catList);
		
	}
	
	
	
	
////	Mapped as a PUT Method to update transfers using /transfers/update/{id}
//	@PutMapping(“/update/{id}“)
//	public Transfer updateTransfer(@RequestBody Transfer transfer, Principal principal, @PathVariable int id)
//	{
//		Transfer updatedTransfer = new Transfer();
//		
//		if(isValidUser(transfer, principal))
//		{
//			updatedTransfer = transferDao.update(transfer);
//		}
//		return updatedTransfer;
//	}
//	
////	Mapped as a POST Method using base url of /transfers
//	@PostMapping()
//	public Transfer createTransfer(@RequestBody Transfer transfer, Principal principal)
//	{
//		Transfer newTransfer = new Transfer();
//		
//		if(isValidUser(transfer, principal))
//		{
//			newTransfer = transferDao.create(transfer);	
//		}
//		
//		return newTransfer;
//	}
//	
//	private boolean isValidUser(Transfer transfer, Principal principal)
//	{
//		if(principal.getName().equalsIgnoreCase(transfer.getUserFrom()) ||
//				principal.getName().equalsIgnoreCase(transfer.getUserTo()))
//		{
//			return true;
//		}
//		return false;
//	}
}
