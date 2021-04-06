import java.security.Principal;
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
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.dao.CatListDAO;
import com.techelevator.dao.UserDAO;

@RestController
@CrossOrigin
@PreAuthorize(“isAuthenticated()“)
//Mapping starts here
@RequestMapping(path = “/transfers”)
public class CatListController
{
	@Autowired
	CatListDAO catListDao;
	@Autowired
	UserDAO userDao;
	
//	Mapped as a GET Method using base url of /transfers
	@GetMapping()
	public List<CatList> retrieveCatList()
	{
		int catId = catListDao.retrieveCatList()
		List<CatList> transfers = userDao.getTransfersByUser(id);
		
		return transfers;
	}
	
//	Mapped as a GET Method using /transfers/{id}
	@GetMapping(“/cats“)
	public Transfer getById
	{
		return transferDao.get(id);
	}
	
//	Mapped as a PUT Method to update transfers using /transfers/update/{id}
	@PutMapping(“/update/{id}“)
	public Transfer updateTransfer(@RequestBody Transfer transfer, Principal principal, @PathVariable int id)
	{
		Transfer updatedTransfer = new Transfer();
		
		if(isValidUser(transfer, principal))
		{
			updatedTransfer = transferDao.update(transfer);
		}
		return updatedTransfer;
	}
	
//	Mapped as a POST Method using base url of /transfers
	@PostMapping()
	public Transfer createTransfer(@RequestBody Transfer transfer, Principal principal)
	{
		Transfer newTransfer = new Transfer();
		
		if(isValidUser(transfer, principal))
		{
			newTransfer = transferDao.create(transfer);	
		}
		
		return newTransfer;
	}
	
	private boolean isValidUser(Transfer transfer, Principal principal)
	{
		if(principal.getName().equalsIgnoreCase(transfer.getUserFrom()) ||
				principal.getName().equalsIgnoreCase(transfer.getUserTo()))
		{
			return true;
		}
		return false;
	}
}
