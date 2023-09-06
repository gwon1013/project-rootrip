package com.rootrip.rootripteam.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rootrip.rootripteam.location.Location;
import com.rootrip.rootripteam.location.LocationDAO;
import com.rootrip.rootripteam.member.Member;
import com.rootrip.rootripteam.member.MemberDAO;

@Controller
public class AdminController {
	@Autowired
	private MemberDAO mDAO;
	@Autowired
	private LocationDAO lDAO;

	@RequestMapping(value = "admin.location", method = RequestMethod.GET)
	public String manageLocation(HttpServletRequest req) {
		if (mDAO.loginCheck(req)) {
			int p = Integer.parseInt(req.getParameter("p"));
			String query = req.getParameter("query");
			int all;
			List<Location> locations;
			if (query == null) {
				all = lDAO.getAllLocationCount();

				locations = lDAO.getLocationList(p);
			} else {
				all = lDAO.getLocationCount(query);

				locations = lDAO.getLocationWithName(query, p);
			}
			all = calcPageCount(all);
			req.setAttribute("locations", locations);
			req.setAttribute("p", p);
			req.setAttribute("all", all);

			req.setAttribute("contentPage", "admin/location.jsp");
		} else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}

	@RequestMapping(value = "admin.location.edit", method = RequestMethod.GET)
	public String editLocation(HttpServletRequest req) {
		if (mDAO.loginCheck(req)) {
			String l_no = req.getParameter("l_no");
			lDAO.getLocationImage(l_no);
			req.setAttribute("contentPage", "admin/editLocation.jsp");
		} else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}

	@RequestMapping(value = "admin.location.remove", method = RequestMethod.GET)
	public String removeLocation(HttpServletRequest req) {
		if (mDAO.loginCheck(req)) {
			String l_no = req.getParameter("l_no");
			lDAO.removeLocation(l_no);
			req.setAttribute("contentPage", "admin.jsp");
		} else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}

	@RequestMapping(value = "admin.users", method = RequestMethod.GET)
	public String manageUsers(HttpServletRequest req) {
		if (mDAO.loginCheck(req)) {
			int p = Integer.parseInt(req.getParameter("p"));
			String mail = req.getParameter("mail");
			String nickname = req.getParameter("nickname");
			int all;
			List<Member> users;
			if (mail != null) {
				all = mDAO.getUserCountWithMail(mail);

				users = mDAO.getUserListWithMail(mail, p);
			} else if (nickname != null) {
				all = mDAO.getUserCountWithNickname(nickname);

				users = mDAO.getUserListWithNickname(nickname, p);
			} else {
				all = mDAO.getAllUserCount();

				users = mDAO.getUserList(p);
			}
			all = calcPageCount(all);
			req.setAttribute("users", users);
			req.setAttribute("p", p);
			req.setAttribute("all", all);

			req.setAttribute("contentPage", "admin/users.jsp");
		} else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}

	@RequestMapping(value = "admin.users.kick", method = RequestMethod.GET)
	public String kickUser(HttpServletRequest req) {
		if (mDAO.loginCheck(req)) {
			String mail = req.getParameter("mail");
			mDAO.kick(mail);

			req.setAttribute("contentPage", "admin.jsp");
		} else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}

	@RequestMapping(value = "admin.location.add.go", method = RequestMethod.GET)
	public String goAddLocation(HttpServletRequest req) {
		if (mDAO.loginCheck(req)) {
			req.setAttribute("contentPage", "admin/addLocation.jsp");
		} else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}

	@RequestMapping(value = "admin.location.add", method = RequestMethod.POST)
	public String addLocation(Location l, HttpServletRequest req) {
		if (mDAO.loginCheck(req)) {
			lDAO.addLocation(l, req);
			req.setAttribute("contentPage", "admin.jsp");
		} else {
			req.setAttribute("contentPage", "start.jsp");
		}
		return "index";
	}

	private int calcPageCount(int all) {
		return (all % 10 == 0) ? all / 10 : (all / 10) + 1;
	}
}