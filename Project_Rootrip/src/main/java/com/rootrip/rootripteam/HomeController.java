package com.rootrip.rootripteam;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rootrip.rootripteam.member.MemberDAO;

@Controller
public class HomeController {
	
	@Autowired
	private MemberDAO mDAO;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest req) {
		mDAO.loginCheck(req);
		req.setAttribute("contentPage", "start.jsp");
		return "index";
	}
	@RequestMapping(value = "/home.go", method = RequestMethod.GET)
	public String home2(HttpServletRequest req) {
		return home(req);
	}
	
	
}
