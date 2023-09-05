package com.rootrip.rootripteam.location;

import java.util.List;

public class Locations {

	public Locations() {
		// TODO Auto-generated constructor stub
	}
	
	private List<Location> Location;

	public List<Location> getLocation() {
		return Location;
	}

	public void setLocation(List<Location> location) {
		Location = location;
	}

	public Locations(List<Location> location) {
		super();
		Location = location;
	}

}
