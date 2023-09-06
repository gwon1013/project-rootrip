package com.rootrip.rootripteam.location;

import java.io.File;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oreilly.servlet.MultipartRequest;
import com.rootrip.rootripteam.ftp.FTPConnect;

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

	public int editLocation(Location l, HttpServletRequest req) {
		int result = 0;
		String path = req.getSession().getServletContext().getRealPath("resources/img");
		MultipartRequest mr;
		try {
			mr = new MultipartRequest(req, path, 10485760, "utf-8");
			l.setL_name(mr.getParameter("l_name"));
			l.setL_no(new BigDecimal(mr.getParameter("l_no")));
			l.setL_lat(Double.parseDouble(mr.getParameter("l_lat")));
			l.setL_lon(Double.parseDouble(mr.getParameter("l_lon")));

			File file = mr.getFile("l_photo");

			FTPConnect.connect();
			FTPConnect.upload(file);

			String photo = mr.getFilesystemName("l_photo");
			if (photo != null) {
				String photo_kor = URLEncoder.encode(photo, "utf-8").replace('+', ' ');
				l.setL_photo(photo_kor);
				result = ss.getMapper(LocationMapper.class).editWithPhoto(l);
			} else {
				result = ss.getMapper(LocationMapper.class).editWithoutPhoto(l);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public int addLocation(Location l, HttpServletRequest req) {
		int result = 0;
		String path = req.getSession().getServletContext().getRealPath("resources/img");
		MultipartRequest mr;
		try {
			mr = new MultipartRequest(req, path, 10485760, "utf-8");
			l.setL_name(mr.getParameter("l_name"));
			l.setL_no(new BigDecimal(mr.getParameter("l_no")));
			l.setL_lat(Double.parseDouble(mr.getParameter("l_lat")));
			l.setL_lon(Double.parseDouble(mr.getParameter("l_lon")));

			File file = mr.getFile("l_photo");

			FTPConnect.connect();
			FTPConnect.upload(file);

			String photo = mr.getFilesystemName("l_photo");
			if (photo != null) {
				String photo_kor = URLEncoder.encode(photo, "utf-8").replace('+', ' ');
				l.setL_photo(photo_kor);

			}
			result = ss.getMapper(LocationMapper.class).addLocation(l);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public void getLocationImage(String l_no) {
		String imageName = ss.getMapper(LocationMapper.class).getLocationImage(l_no);
		try {
			FTPConnect.connect();
			String imageName_kor = URLDecoder.decode(imageName, "UTF-8");
			FTPConnect.download(imageName_kor);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void removeLocation(String l_no) {
		ss.getMapper(LocationMapper.class).removeLocation(l_no);
	}

	public List<Location> getLocationList(int p) {
		return ss.getMapper(LocationMapper.class).getLocationList(p);
	}

	public int getAllLocationCount() {
		return ss.getMapper(LocationMapper.class).getAllLocationCount();
	}

	public int getLocationCount(String name) {
		return ss.getMapper(LocationMapper.class).getLocationCount(name);
	}

	public List<Location> getLocationWithName(String name, int p) {
		return ss.getMapper(LocationMapper.class).getLocationListWithName(name, p);
	}

	public List<Location> getLocation(String l_no) {
		return ss.getMapper(LocationMapper.class).getLocation(l_no);
	}

	public List<Location> getAllLocation() {
		return ss.getMapper(LocationMapper.class).getAllLocation();
	}
}
