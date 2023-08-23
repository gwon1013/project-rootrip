package com.rootrip.rootripteam.category;

import java.math.BigDecimal;

public interface CategoryMapper {
	public abstract BigDecimal getCategoryCode(String categoryName);

	public abstract int insertCategory(Category c);
}
