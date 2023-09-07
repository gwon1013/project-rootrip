package com.rootrip.rootripteam.category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CategoryController {
	@Autowired
	CategoryDAO cDAO;

	public CategoryController() {
		// TODO Auto-generated constructor stub
	}

	@RequestMapping(value = "/categories", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Categories getAllCategories() {
		return new Categories(cDAO.getAllCategory());
	}
}
