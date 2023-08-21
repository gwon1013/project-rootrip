package com.rootrip.rootripteam.question;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rootrip.rootripteam.member.MemberDAO;

@Controller
public class QuestionController {
	
	@Autowired
	private MemberDAO mDAO;
	
	@RequestMapping(value = "/question.question.go", method = RequestMethod.GET)
	public String goQuestion(HttpServletRequest req) {
		mDAO.loginCheck(req);
		req.setAttribute("contentPage", "question/question4.jsp");
		return "index";
	}
}
