package com.rootrip.rootripteam.member;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

@Service
public class MemberDAO {
	public boolean loginCheck(HttpServletRequest req) {
		Member m = (Member)req.getSession().getAttribute("loginMember");
		if (m != null) {
			req.setAttribute("loginPage", "member/afterlogin.jsp");
			return true;
		} else {
			req.setAttribute("loginPage", "member/beforlogin.jsp");
			return false;
		}
	}
}
