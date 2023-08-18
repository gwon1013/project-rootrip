package com.rootrip.rootripteam.question;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class QuestionController {
	
	@RequestMapping(value = "/question.question.go", method = RequestMethod.GET)
	public String goQuestion(HttpServletRequest req) {
		req.setAttribute("contentPage", "question/question4.jsp");
		return "index";
	}
}
