package com.rootrip.rootripteam.category;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

@Service
public class CategoryDAO {
	@Autowired
	private SqlSession ss;

	public CategoryDAO() {
		// TODO Auto-generated constructor stub
	}

	public int getCategoryCode(@RequestParam("categoryName") String category) {
		return ss.getMapper(CategoryMapper.class).getCategoryCode(category).intValue();
	}

	public int insertDataToDB(List<String[]> data) {
		Category c = new Category();
		int result = 0;

		for (int i = 1; i < data.size(); i++) {
			BigDecimal c_no = new BigDecimal(Integer.parseInt(data.get(i)[0]));
			String c_name = data.get(i)[1];

			c.setC_no(c_no);
			c.setC_name(c_name);

			result += ss.getMapper(CategoryMapper.class).insertCategory(c);
		}

		return result;
	}

	public List<Category> getAllCategory() {
		return ss.getMapper(CategoryMapper.class).getAllCategory();
	}
	
	public List<Category> getMainLocation(){
		return ss.getMapper(CategoryMapper.class).getMainCategory();
	}
	
	public List<Category> getSubLocation(String c_no){
		return ss.getMapper(CategoryMapper.class).getSubCategory(c_no);
	}

}
