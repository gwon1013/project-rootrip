package com.rootrip.rootripteam.spot;

import java.util.List;

public interface SpotMapper {
	public abstract int insertMarket(Market m);

	public abstract int insertMarket2(Market m);

	public abstract int insertRestaurant(Restaurant r);

	public abstract int insertRestaurant2(Restaurant r);

	public abstract int insertFestival(Festival f);

	public abstract int insertFestival2(Festival f);

	public abstract int insertTour(Tour t);

	public abstract int insertTour2(Tour t);

	public abstract int insertWellness(Wellness w);

	public abstract int insertWellness2(Wellness w);

	public abstract int insertActivity(Activity a);

	public abstract int insertActivity2(Activity a);
	
	public abstract List<Spot> getSpotList(int p);
	
	public abstract int getAllSpotCount();
}
