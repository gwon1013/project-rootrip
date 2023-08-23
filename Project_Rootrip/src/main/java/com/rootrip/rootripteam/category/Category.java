package com.rootrip.rootripteam.category;

import java.math.BigDecimal;

public class Category {
	private BigDecimal c_no;
	private String c_name;

	public Category() {
		// TODO Auto-generated constructor stub
	}

	public Category(BigDecimal c_no, String c_name) {
		super();
		this.c_no = c_no;
		this.c_name = c_name;
	}

	public BigDecimal getC_no() {
		return c_no;
	}

	public void setC_no(BigDecimal c_no) {
		this.c_no = c_no;
	}

	public String getC_name() {
		return c_name;
	}

	public void setC_name(String c_name) {
		this.c_name = c_name;
	}

}