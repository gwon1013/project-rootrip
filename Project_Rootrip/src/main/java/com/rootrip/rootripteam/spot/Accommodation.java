package com.rootrip.rootripteam.spot;

import java.math.BigDecimal;

public class Accommodation extends Spot {
	private BigDecimal a_price;

	public Accommodation() {
	}

	public Accommodation(BigDecimal s_no, String s_photo, String s_name, String s_addr_jibun, String s_addr_road,
			String s_tel, double s_lat, double s_lon, String s_comment, BigDecimal c_no, BigDecimal l_no,
			BigDecimal a_price) {
		super(s_no, s_photo, s_name, s_addr_jibun, s_addr_road, s_tel, s_lat, s_lon, s_comment, c_no, l_no);
		this.a_price = a_price;
	}

	public BigDecimal getA_price() {
		return a_price;
	}

	public void setA_price(BigDecimal a_price) {
		this.a_price = a_price;
	}

}
