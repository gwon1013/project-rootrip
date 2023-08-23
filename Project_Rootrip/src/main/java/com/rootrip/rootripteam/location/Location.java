package com.rootrip.rootripteam.location;

import java.math.BigDecimal;

public class Location {
	private BigDecimal l_no;
	private String l_name;
	private double l_lat;
	private double l_lon;

	public Location() {
		// TODO Auto-generated constructor stub
	}

	public Location(BigDecimal l_no, String l_name, double l_lat, double l_lon) {
		super();
		this.l_no = l_no;
		this.l_name = l_name;
		this.l_lat = l_lat;
		this.l_lon = l_lon;
	}

	public BigDecimal getL_no() {
		return l_no;
	}

	public void setL_no(BigDecimal l_no) {
		this.l_no = l_no;
	}

	public String getL_name() {
		return l_name;
	}

	public void setL_name(String l_name) {
		this.l_name = l_name;
	}

	public double getL_lat() {
		return l_lat;
	}

	public void setL_lat(double l_lat) {
		this.l_lat = l_lat;
	}

	public double getL_lon() {
		return l_lon;
	}

	public void setL_lon(double l_lon) {
		this.l_lon = l_lon;
	}
}
