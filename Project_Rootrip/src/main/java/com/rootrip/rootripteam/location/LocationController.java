package com.rootrip.rootripteam.location;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rootrip.rootripteam.member.MemberDAO;

@Controller
public class LocationController {
	@Autowired
	LocationDAO lDAO;
	@Autowired
	MemberDAO mDAO;

	@RequestMapping(value = "/location.all", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Locations getAllLocation() {
		return new Locations(lDAO.getAllLocation());
	}
	
	@RequestMapping(value = "/location", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Locations getLocation(String l_no) {
		return new Locations(lDAO.getLocation(l_no));
	}
	
	@RequestMapping(value = "/admin.location", method = RequestMethod.POST)
	public String editLocation(Location l, HttpServletRequest req) {
		if(mDAO.loginCheck(req)) {
			lDAO.editLocation(l, req);
			req.setAttribute("contentPage", "admin/location.jsp");
		}
		else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}
}
