package com.rootrip.rootripteam.spot;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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

	public abstract List<Spot> getSpotWithCate(List<Integer> categories);

	public abstract List<Spot> getSpotWithLoc(List<Integer> categories);

	public abstract List<Spot> getSpotWithCateLoc(List<Integer> categories, List<Integer> locations);

	public abstract List<Spot> getSpotWithName(String name);
	
	public abstract List<Spot> getSpotWithNumber(int number);

	public abstract List<Spot> getSpotWithCateName(List<Integer> categories, @Param("name") String name);

	public abstract List<Spot> getSpotWithLocName(List<Integer> categories, @Param("name") String name);

	public abstract List<Spot> getSpotWithCateLocName(List<Integer> categories, List<Integer> locations,
			@Param("name") String name);
}
