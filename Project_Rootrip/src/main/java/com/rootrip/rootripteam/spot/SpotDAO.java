package com.rootrip.rootripteam.spot;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rootrip.rootripteam.category.CategoryDAO;

@Service
public class SpotDAO {
	@Autowired
	private SqlSession ss;
	@Autowired
	private CategoryDAO cDAO;
	
	public List<Spot> getSpotList(int p){
		return ss.getMapper(SpotMapper.class).getSpotList(p);
	}
	
	public int getAllSpotCount() {
		return ss.getMapper(SpotMapper.class).getAllSpotCount();
	}
	
	public List<Spot> getSpotByCate(List<Integer> categories) {
		return ss.getMapper(SpotMapper.class).getSpotWithCate(categories);
	}
	
	public List<Spot> getSpotByloc(List<Integer> locations) {
		return ss.getMapper(SpotMapper.class).getSpotWithLoc(locations);
	}
	
	public List<Spot> getSpotByCateloc(List<Integer> categories, List<Integer> locations) {
		return ss.getMapper(SpotMapper.class).getSpotWithCateLoc(categories, locations);
	}
	
	public List<Spot> getSpotByName(String name) {
		return ss.getMapper(SpotMapper.class).getSpotWithName(name);
	}
	
	public List<Spot> getSpotByNum(int number) {
		return ss.getMapper(SpotMapper.class).getSpotWithNumber(number);
	}
	
	public List<Spot> getSpotByCateName(List<Integer> categories, @Param("name")String name) {
		return ss.getMapper(SpotMapper.class).getSpotWithCateName(categories, name);
	}
	
	public List<Spot> getSpotBylocName(List<Integer> locations, @Param("name")String name) {
		return ss.getMapper(SpotMapper.class).getSpotWithLocName(locations, name);
	}
	
	public List<Spot> getSpotByCatelocName(List<Integer> categories, List<Integer> locations, @Param("name")String name) {
		return ss.getMapper(SpotMapper.class).getSpotWithCateLocName(categories, locations, name);
	}

	public int insertDataToDB(String category, List<String[]> data) {
		int categoryCode = cDAO.getCategoryCode(category);
		int result = 0;
		
		for (int i = 1; i < data.size(); i++) {
			switch (categoryCode) {
			case 102:
				result += insertMarket(data.get(i));
				break;
			case 101:
			case 103:
			case 104:
				result += insertRestaurant(categoryCode, data.get(i));
				break;
			case 201:
				result += insertFestival(data.get(i));
				break;
			case 202:
			case 203:
			case 204:
			case 205:
				result += insertTour(categoryCode, data.get(i));
				break;
			case 301:
			case 302:
			case 303:
				result += insertWellness(categoryCode, data.get(i));
				break;
			case 401:
			case 402:
			case 403:
			case 404:
			case 405:
			case 406:
			case 407:
			case 408:
			case 409:
			case 410:
			case 411:
			case 412:
			case 413:
				result += insertActivity(categoryCode, data.get(i));
			default:
				break;
			}
		}
		return result;
	}

	private int insertMarket(String[] data) {
		int result = 0;
		String s_photo = data[0];
		String s_name = data[1];
		String s_addr_jibun = data[2];
		String s_addr_road = data[3];
		String s_tel = data[4];
		double s_lat = Double.parseDouble(data[5]);
		double s_lon = Double.parseDouble(data[6]);
		String s_comment = data[7];
		BigDecimal c_no = new BigDecimal(Integer.parseInt(data[8]));
		BigDecimal l_no = new BigDecimal(Integer.parseInt(data[9]));
		BigDecimal m_sort = new BigDecimal(Integer.parseInt(data[10]));
		BigDecimal m_day = null;

		if (data[11] != null) {
			m_day = new BigDecimal(Integer.parseInt(data[11]));
		}

		Market m = new Market();

		m.setS_photo(s_photo);
		m.setS_name(s_name);
		m.setS_addr_jibun(s_addr_jibun);
		m.setS_addr_road(s_addr_road);
		m.setS_tel(s_tel);
		m.setS_lat(s_lat);
		m.setS_lon(s_lon);
		m.setS_comment(s_comment);
		m.setC_no(c_no);
		m.setL_no(l_no);
		m.setM_sort(m_sort);
		m.setM_day(m_day);

		if (ss.getMapper(SpotMapper.class).insertMarket(m) == 1) {
			result = ss.getMapper(SpotMapper.class).insertMarket2(m);
		}

		return result;
	}

	private int insertRestaurant(int categoryCode, String[] data) {
		int result = 0;

		// TODO : CSV 파일 완성되면 조금 더 채울 것!!
		Restaurant r = new Restaurant();

		return result;
	}

	private int insertFestival(String[] data) {
		int result = 0;
		String s_photo = data[0];
		String s_name = data[1];
		String s_addr_jibun = data[2];
		String s_addr_road = data[3];
		String s_tel = data[4];
		double s_lat = Double.parseDouble(data[5]);
		double s_lon = Double.parseDouble(data[6]);
		String s_comment = data[7];
		BigDecimal c_no = new BigDecimal(Integer.parseInt(data[8]));
		BigDecimal l_no = new BigDecimal(Integer.parseInt(data[9]));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		
		try {
			Date f_s_date = sdf.parse(data[10]);
			Date f_e_date = sdf.parse(data[11]);

			Festival f = new Festival();
			f.setS_photo(s_photo);
			f.setS_name(s_name);
			f.setS_addr_jibun(s_addr_jibun);
			f.setS_addr_road(s_addr_road);
			f.setS_tel(s_tel);
			f.setS_lat(s_lat);
			f.setS_lon(s_lon);
			f.setS_comment(s_comment);
			f.setC_no(c_no);
			f.setL_no(l_no);
			f.setF_s_date(f_s_date);
			f.setF_e_date(f_e_date);

			if (ss.getMapper(SpotMapper.class).insertFestival(f) == 1) {
				result = ss.getMapper(SpotMapper.class).insertFestival2(f);
			}
		} catch (ParseException e) {
			e.printStackTrace();

			return result;
		}

		return result;
	}

	private int insertTour(int categoryCode, String[] data) {
		int result = 0;
		String s_photo = data[0];
		String s_name = data[1];
		String s_addr_jibun = data[2];
		String s_addr_road = data[3];
		String s_tel = data[4];
		double s_lat = Double.parseDouble(data[5]);
		double s_lon = Double.parseDouble(data[6]);
		String s_comment = data[7];
		BigDecimal c_no = new BigDecimal(Integer.parseInt(data[8]));
		BigDecimal l_no = new BigDecimal(Integer.parseInt(data[9]));

		Tour t = new Tour();

		t.setS_photo(s_photo);
		t.setS_name(s_name);
		t.setS_addr_jibun(s_addr_jibun);
		t.setS_addr_road(s_addr_road);
		t.setS_tel(s_tel);
		t.setS_lat(s_lat);
		t.setS_lon(s_lon);
		t.setS_comment(s_comment);
		t.setC_no(c_no);
		t.setL_no(l_no);

		if (ss.getMapper(SpotMapper.class).insertTour(t) == 1) {
			result = ss.getMapper(SpotMapper.class).insertTour2(t);
		}

		return result;
	}

	private int insertWellness(int categoryCode, String[] data) {
		int result = 0;
		String s_photo = data[0];
		String s_name = data[1];
		String s_addr_jibun = data[2];
		String s_addr_road = data[3];
		String s_tel = data[4];
		double s_lat = Double.parseDouble(data[5]);
		double s_lon = Double.parseDouble(data[6]);
		String s_comment = data[7];
		BigDecimal c_no = new BigDecimal(Integer.parseInt(data[8]));
		BigDecimal l_no = new BigDecimal(Integer.parseInt(data[9]));

		Wellness w = new Wellness();

		w.setS_photo(s_photo);
		w.setS_name(s_name);
		w.setS_addr_jibun(s_addr_jibun);
		w.setS_addr_road(s_addr_road);
		w.setS_tel(s_tel);
		w.setS_lat(s_lat);
		w.setS_lon(s_lon);
		w.setS_comment(s_comment);
		w.setC_no(c_no);
		w.setL_no(l_no);

		if (ss.getMapper(SpotMapper.class).insertWellness(w) == 1) {
			result = ss.getMapper(SpotMapper.class).insertWellness2(w);
		}

		return result;
	}

	private int insertActivity(int categoryCode, String[] data) {
		int result = 0;
		String s_photo = data[0];
		String s_name = data[1];
		String s_addr_jibun = data[2];
		String s_addr_road = data[3];
		String s_tel = data[4];
		double s_lat = Double.parseDouble(data[5]);
		double s_lon = Double.parseDouble(data[6]);
		String s_comment = data[7];
		BigDecimal c_no = new BigDecimal(Integer.parseInt(data[8]));
		BigDecimal l_no = new BigDecimal(Integer.parseInt(data[9]));

		Activity a = new Activity();

		a.setS_photo(s_photo);
		a.setS_name(s_name);
		a.setS_addr_jibun(s_addr_jibun);
		a.setS_addr_road(s_addr_road);
		a.setS_tel(s_tel);
		a.setS_lat(s_lat);
		a.setS_lon(s_lon);
		a.setS_comment(s_comment);
		a.setC_no(c_no);
		a.setL_no(l_no);

		if (ss.getMapper(SpotMapper.class).insertActivity(a) == 1) {
			result = ss.getMapper(SpotMapper.class).insertActivity2(a);
		}

		return result;
	}

}
