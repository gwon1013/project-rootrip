package com.rootrip.rootripteam.category;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CategoryController {
	@Autowired
	CategoryDAO cDAO;

	@RequestMapping(value = "/category.main", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Categories getMainCategory() {
		return new Categories(cDAO.getMainLocation());
	}
	
	@RequestMapping(value = "/category.sub", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Categories getSubCategory(HttpServletRequest req) {
		String c_no = req.getParameter("c_no");
		return new Categories(cDAO.getSubLocation(c_no));
	}

}
