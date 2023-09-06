package com.rootrip.rootripteam.location;

import java.util.List;

public interface LocationMapper {
	public abstract int insertLocation(Location l);

	public abstract List<Location> getAllLocation();

	public abstract List<Location> getLocation(String l_co);
	
	public abstract int editWithPhoto(Location l);

	public abstract int editWithoutPhoto(Location l);
	
	public abstract String getLocationImage(String l_no);
}
