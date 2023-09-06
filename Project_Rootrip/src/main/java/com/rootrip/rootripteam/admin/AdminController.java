package com.rootrip.rootripteam.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rootrip.rootripteam.location.LocationDAO;
import com.rootrip.rootripteam.member.MemberDAO;

@Controller
public class AdminController {
	@Autowired
	private MemberDAO mDAO;
	@Autowired
	private LocationDAO lDAO;

	@RequestMapping(value = "admin.location", method = RequestMethod.GET)
	public String manageLocation(HttpServletRequest req) {
		if(mDAO.loginCheck(req)) {
			req.setAttribute("contentPage", "admin/location.jsp");
		}
		else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}
	
	@RequestMapping(value = "admin.location.edit", method = RequestMethod.GET)
	public String editLocation(HttpServletRequest req) {
		if(mDAO.loginCheck(req)) {
			String l_no = req.getParameter("l_no");
			lDAO.getLocationImage(l_no);
			req.setAttribute("contentPage", "admin/editLocation.jsp");
		}
		else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}

}