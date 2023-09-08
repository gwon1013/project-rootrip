package com.rootrip.rootripteam.category;

import java.math.BigDecimal;
import java.util.List;

public interface CategoryMapper {
	public abstract BigDecimal getCategoryCode(String categoryName);

	public abstract int insertCategory(Category c);
	
	public abstract List<Category> getAllCategory();
	
	public abstract List<Category> getMainCategory();
	
	public abstract List<Category> getSubCategory(String c_no);
}
