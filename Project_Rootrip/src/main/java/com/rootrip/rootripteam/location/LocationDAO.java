package com.rootrip.rootripteam.location;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LocationDAO {
	@Autowired
	SqlSession ss;

	public LocationDAO() {
		// TODO Auto-generated constructor stub
	}

	public int insertDataToDB(List<String[]> data) {
		Location l = new Location();
		int result = 0;
		for (int i = 1; i < data.size(); i++) {
			BigDecimal l_no = new BigDecimal(Integer.parseInt(data.get(i)[0]));
			String l_name = data.get(i)[1];
			double l_lat = Double.parseDouble(data.get(i)[2]);
			double l_lon = Double.parseDouble(data.get(i)[3]);

			l.setL_no(l_no);
			l.setL_name(l_name);
			l.setL_lat(l_lat);
			l.setL_lon(l_lon);

			result += ss.getMapper(LocationMapper.class).insertLocation(l);
		}

		return result;
	}
}
