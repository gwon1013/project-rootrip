package com.rootrip.rootripteam.spot;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rootrip.rootripteam.category.CategoryDAO;
import com.rootrip.rootripteam.location.LocationDAO;

@Controller
public class SpotController {
	@Autowired
	SpotDAO sDAO;
	@Autowired
	CategoryDAO cDAO;
	@Autowired
	LocationDAO lDAO;

	public SpotController() {
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping(value = "/getSpots.num", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Spots getSpotNumber(HttpServletRequest req) {
		int number = Integer.parseInt(req.getParameter("s_no"));
		
		return new Spots(sDAO.getSpotByNum(number));
	}

	@RequestMapping(value = "/getSpots.category", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Spots getSpotCategory(HttpServletRequest req) {
		String[] temp = req.getParameter("categories").split(",");
		ArrayList<Integer> categories = new ArrayList<Integer>();
		for (String categoryName : temp) {
			categories.add(new Integer(cDAO.getCategoryCode(categoryName)));
		}
		return new Spots(sDAO.getSpotByCate(categories));
	}

	@RequestMapping(value = "/getSpots.location", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Spots getSpotLocation(HttpServletRequest req) {
		String[] temp = req.getParameter("locations").split(",");
		ArrayList<Integer> locations = new ArrayList<Integer>();
		for (String t : temp) {
			if (t.endsWith("00")) {
				List<BigDecimal> subLocations = lDAO.getSubLocationCode(t);
				for (BigDecimal s : subLocations) {
					locations.add(s.intValue());
				}
			}
			locations.add(Integer.parseInt(t));
		}
		return new Spots(sDAO.getSpotByloc(locations));
	}

	@RequestMapping(value = "/getSpots.cateloca", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Spots getSpotCateLocation(HttpServletRequest req) {
		String[] temp = req.getParameter("categories").split(",");
		ArrayList<Integer> categories = new ArrayList<Integer>();
		for (String categoryName : temp) {
			categories.add(new Integer(cDAO.getCategoryCode(categoryName)));
		}

		String[] temp2 = req.getParameter("locations").split(",");
		ArrayList<Integer> locations = new ArrayList<Integer>();
		for (String t : temp2) {
			if (t.endsWith("00")) {
				List<BigDecimal> subLocations = lDAO.getSubLocationCode(t);
				for (BigDecimal s : subLocations) {
					locations.add(s.intValue());
				}
			}
			locations.add(Integer.parseInt(t));
		}
		return new Spots(sDAO.getSpotByCateloc(categories, locations));
	}

	@RequestMapping(value = "/getSpots.name", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Spots getSpotName(HttpServletRequest req) {
		String name = req.getParameter("name");
		return new Spots(sDAO.getSpotByName(name));
	}

	@RequestMapping(value = "/getSpots.catename", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Spots getSpotCateName(HttpServletRequest req) {
		String[] temp = req.getParameter("categories").split(",");
		String name = req.getParameter("name");
		ArrayList<Integer> categories = new ArrayList<Integer>();

		for (String categoryName : temp) {
			categories.add(new Integer(cDAO.getCategoryCode(categoryName)));
		}
		return new Spots(sDAO.getSpotByCateName(categories, name));
	}

	@RequestMapping(value = "/getSpots.locaname", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Spots getSpotLocaName(HttpServletRequest req) {
		String[] temp = req.getParameter("locations").split(",");
		String name = req.getParameter("name");
		ArrayList<Integer> locations = new ArrayList<Integer>();

		for (String t : temp) {
			if (t.endsWith("00")) {
				List<BigDecimal> subLocations = lDAO.getSubLocationCode(t);
				for (BigDecimal s : subLocations) {
					locations.add(s.intValue());
				}
			}
			locations.add(Integer.parseInt(t));

		}
		return new Spots(sDAO.getSpotBylocName(locations, name));
	}

	@RequestMapping(value = "/getSpots.catelocaname", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody Spots getSpotCateLocaName(HttpServletRequest req) {
		String[] temp = req.getParameter("categories").split(",");
		ArrayList<Integer> categories = new ArrayList<Integer>();
		String name = req.getParameter("name");
		for (String categoryName : temp) {
			categories.add(new Integer(cDAO.getCategoryCode(categoryName)));
		}

		String[] temp2 = req.getParameter("locations").split(",");
		ArrayList<Integer> locations = new ArrayList<Integer>();
		for (String t : temp2) {
			if (t.endsWith("00")) {
				List<BigDecimal> subLocations = lDAO.getSubLocationCode(t);
				for (BigDecimal s : subLocations) {
					locations.add(s.intValue());
				}
			}
			locations.add(Integer.parseInt(t));

		}
		return new Spots(sDAO.getSpotByCatelocName(categories, locations, name));
	}

}