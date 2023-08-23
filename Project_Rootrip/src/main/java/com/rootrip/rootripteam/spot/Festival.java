package com.rootrip.rootripteam.spot;

import java.math.BigDecimal;
import java.util.Date;

public class Festival extends Spot {
	private Date f_s_date;
	private Date f_e_date;

	public Festival() {
		super();
	}

	public Festival(BigDecimal s_no, String s_photo, String s_name, String s_addr_jibun, String s_addr_road,
			String s_tel, double s_lat, double s_lon, String s_comment, BigDecimal c_no, BigDecimal l_no, Date f_s_date,
			Date f_e_date) {
		super(s_no, s_photo, s_name, s_addr_jibun, s_addr_road, s_tel, s_lat, s_lon, s_comment, c_no, l_no);
		this.f_s_date = f_s_date;
		this.f_e_date = f_e_date;
	}

	public Date getF_s_date() {
		return f_s_date;
	}

	public void setF_s_date(Date f_s_date) {
		this.f_s_date = f_s_date;
	}

	public Date getF_e_date() {
		return f_e_date;
	}

	public void setF_e_date(Date f_e_date) {
		this.f_e_date = f_e_date;
	}
}
