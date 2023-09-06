package com.rootrip.rootripteam.location;

import java.util.List;

public interface LocationMapper {
	public int insertLocation(Location l);

	public List<Location> getAllLocation();

	public List<Location> getLocation(String l_co);
	
	public abstract int editWithPhoto(Location l);

	public abstract int editWithoutPhoto(Location l);
}
