package com.rootrip.rootripteam.recommendLoc;

import java.math.BigDecimal;
import java.util.List;

public interface RecommendLocMapper {
	public abstract List<BigDecimal> getLocByCate(BigDecimal a);
}
