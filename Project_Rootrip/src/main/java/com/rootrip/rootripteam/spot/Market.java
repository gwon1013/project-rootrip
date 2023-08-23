package com.rootrip.rootripteam.spot;

import java.math.BigDecimal;

public class Market extends Spot {
	private BigDecimal m_sort;
	private BigDecimal m_day;

	public Market() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Market(BigDecimal s_no, String s_photo, String s_name, String s_addr_jibun, String s_addr_road, String s_tel,
			double s_lat, double s_lon, String s_comment, BigDecimal c_no, BigDecimal l_no, BigDecimal m_sort,
			BigDecimal m_day) {
		super(s_no, s_photo, s_name, s_addr_jibun, s_addr_road, s_tel, s_lat, s_lon, s_comment, c_no, l_no);
		this.m_sort = m_sort;
		this.m_day = m_day;
	}

	public BigDecimal getM_sort() {
		return m_sort;
	}

	public void setM_sort(BigDecimal m_sort) {
		this.m_sort = m_sort;
	}

	public BigDecimal getM_day() {
		return m_day;
	}

	public void setM_day(BigDecimal m_day) {
		this.m_day = m_day;
	}

}
