package com.rootrip.rootripteam.recommendLoc;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rootrip.rootripteam.member.MemberDAO;
import com.rootrip.rootripteam.spot.Spot;

@Controller
public class RecommendLocController {
	
	@Autowired
	private MemberDAO mDAO;
	
	@Autowired
	private RecommendLocDAO lDAO;
	
	// 질문페이지 이동
	@RequestMapping(value = "/recommendLoc.question.go", method = RequestMethod.GET)
	public String goQuestion(HttpServletRequest req) {
		mDAO.loginCheck(req);
		req.setAttribute("contentPage", "recommendLoc/question.jsp");
		return "index";
	}
	
	// 결과페이지 이동
	@RequestMapping(value = "/recommendLoc.result.go", method = RequestMethod.GET)
	public String goResult(HttpServletRequest req) {
		mDAO.loginCheck(req);
		lDAO.getResult(req);
		req.setAttribute("contentPage", "recommendLoc/result.jsp");
		return "index";
	}
	
	// 지도 페이지로 보내기
	@RequestMapping(value = "/recommendLoc.map.go", method = RequestMethod.GET)
	public String goMap(HttpServletRequest req) {
		mDAO.loginCheck(req);
		lDAO.recommendCourse(req);
		req.setAttribute("contentPage", "#");
		return "index";
	}
}
