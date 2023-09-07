package com.rootrip.rootripteam.recommendLoc;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface RecommendLocMapper {
	
	public abstract List<BigDecimal> getLocByCate(BigDecimal l);
	public abstract List<BigDecimal> getCateByLoc(BigDecimal c);
	public abstract String getLocName(BigDecimal k);
	public abstract String getCatName(BigDecimal q);
	public abstract List<BigDecimal> getAllLoc();
	public abstract BigDecimal getLocNum(String nm);
	public abstract BigDecimal getRandomSpot(@Param("l_no")BigDecimal l_no, @Param("c_no")BigDecimal c_no);
	public abstract List<BigDecimal> getCateByLoca(BigDecimal l);
}
