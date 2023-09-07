package com.rootrip.rootripteam.location;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface LocationMapper {
	public abstract int insertLocation(Location l);

	public abstract List<Location> getAllLocation();
	
	public List<Location> getMainLocation();
	
	public List<Location> getSubLocation(String l_co);
	
	public List<BigDecimal> getSubLocationCode (String l_no);

	public abstract List<Location> getLocation(String l_co);

	public abstract int addLocation(Location l);

	public abstract int editWithPhoto(Location l);

	public abstract int editWithoutPhoto(Location l);

	public abstract String getLocationImage(String l_no);

	public abstract List<Location> getLocationList(int p);

	public abstract int getAllLocationCount();

	public abstract List<Location> getLocationListWithName(@Param("name") String name, @Param("p") int p);

	public abstract int getLocationCount(String name);

	public abstract int removeLocation(String l_no);
}
