package com.rootrip.rootripteam.maptest;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rootrip.rootripteam.member.MemberDAO;

@Controller
public class MaptestController {
	
	@Autowired
	private MemberDAO mDAO;
	
	@RequestMapping(value = "/maptest.map.go", method = RequestMethod.GET)
	public String goMaptest(HttpServletRequest req) {
		mDAO.loginCheck(req);
		req.setAttribute("contentPage", "maptest/maptest.jsp");
		return "index";
	}
}
