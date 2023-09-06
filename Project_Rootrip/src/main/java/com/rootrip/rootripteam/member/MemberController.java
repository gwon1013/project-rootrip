package com.rootrip.rootripteam.member;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {
	@Autowired
	private MemberDAO mDAO;

	public MemberController() {
		// TODO Auto-generated constructor stub
	}

	@RequestMapping(value = "/join.go", method = RequestMethod.GET)
	public String goJoin(HttpServletRequest req) {
		mDAO.loginCheck(req);
		req.setAttribute("contentPage", "member/join.jsp");
		return "index";
	}

	@RequestMapping(value = "/member.check", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Members check(Member m) {
		return mDAO.idCheck(m);
	}

	@RequestMapping(value = "/member.join", method = RequestMethod.POST)
	public String join(Member m, HttpServletRequest req) {
		mDAO.loginCheck(req);
		mDAO.join(m, req);
		req.setAttribute("contentPage", "start.jsp");
		return "index";
	}

	@RequestMapping(value = "/member.drop", method = RequestMethod.GET)
	public String drop(HttpServletRequest req) {
		mDAO.drop(req);
		mDAO.logout(req);
		mDAO.loginCheck(req);
		req.setAttribute("contentPage", "start.jsp");
		return "index";
	}

	@RequestMapping(value = "/member.update", method = RequestMethod.POST)
	public String update(Member m, HttpServletRequest req) {
		mDAO.update(m, req);
		mDAO.loginCheck(req);
		req.setAttribute("contentPage", "start.jsp");
		return "index";
	}

	@RequestMapping(value = "/login.go", method = RequestMethod.GET)
	public String goLogin(HttpServletRequest req) {
		mDAO.loginCheck(req);
		req.setAttribute("contentPage", "member/login.jsp");
		return "index";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Member m, HttpServletRequest req) {
		mDAO.login(m, req);
		if(mDAO.loginCheck(req)) {
			req.setAttribute("contentPage", "admin.jsp");
		}
		else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest req) {
		mDAO.logout(req);
		mDAO.loginCheck(req);
		req.setAttribute("contentPage", "start.jsp");
		return "index";
	}

	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public String goInfo(HttpServletRequest req) {
		mDAO.loginCheck(req);
		req.setAttribute("contentPage", "member/info.jsp");
		return "index";
	}
}
