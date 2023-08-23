package com.rootrip.rootripteam.spot;

import java.math.BigDecimal;

public class Spot {
	private BigDecimal s_no;
	private String s_photo;
	private String s_name;
	private String s_addr_jibun;
	private String s_addr_road;
	private String s_tel;
	private double s_lat;
	private double s_lon;
	private String s_comment;
	private BigDecimal c_no;
	private BigDecimal l_no;

	public Spot() {
		// TODO Auto-generated constructor stub
	}

	public Spot(BigDecimal s_no, String s_photo, String s_name, String s_addr_jibun, String s_addr_road, String s_tel,
			double s_lat, double s_lon, String s_comment, BigDecimal c_no, BigDecimal l_no) {
		super();
		this.s_no = s_no;
		this.s_photo = s_photo;
		this.s_name = s_name;
		this.s_addr_jibun = s_addr_jibun;
		this.s_addr_road = s_addr_road;
		this.s_tel = s_tel;
		this.s_lat = s_lat;
		this.s_lon = s_lon;
		this.s_comment = s_comment;
		this.c_no = c_no;
		this.l_no = l_no;
	}

	public BigDecimal getS_no() {
		return s_no;
	}

	public void setS_no(BigDecimal s_no) {
		this.s_no = s_no;
	}

	public String getS_photo() {
		return s_photo;
	}

	public void setS_photo(String s_photo) {
		this.s_photo = s_photo;
	}

	public String getS_name() {
		return s_name;
	}

	public void setS_name(String s_name) {
		this.s_name = s_name;
	}

	public String getS_addr_jibun() {
		return s_addr_jibun;
	}

	public void setS_addr_jibun(String s_addr_jibun) {
		this.s_addr_jibun = s_addr_jibun;
	}

	public String getS_addr_road() {
		return s_addr_road;
	}

	public void setS_addr_road(String s_addr_road) {
		this.s_addr_road = s_addr_road;
	}

	public String getS_tel() {
		return s_tel;
	}

	public void setS_tel(String s_tel) {
		this.s_tel = s_tel;
	}

	public double getS_lat() {
		return s_lat;
	}

	public void setS_lat(double s_lat) {
		this.s_lat = s_lat;
	}

	public double getS_lon() {
		return s_lon;
	}

	public void setS_lon(double s_lon) {
		this.s_lon = s_lon;
	}

	public String getS_comment() {
		return s_comment;
	}

	public void setS_comment(String s_comment) {
		this.s_comment = s_comment;
	}

	public BigDecimal getC_no() {
		return c_no;
	}

	public void setC_no(BigDecimal c_no) {
		this.c_no = c_no;
	}

	public BigDecimal getL_no() {
		return l_no;
	}

	public void setL_no(BigDecimal l_no) {
		this.l_no = l_no;
	}

}
