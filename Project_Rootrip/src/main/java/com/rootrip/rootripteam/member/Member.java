package com.rootrip.rootripteam.member;

import java.math.BigDecimal;

// javabean
public class Member {
	private BigDecimal u_no;
	private String u_mail;
	private String u_pw;
	private String u_nickname;
	
	public Member() {
		// TODO Auto-generated constructor stub
	}

	public Member(BigDecimal u_no, String u_mail, String u_pw, String u_nickname) {
		super();
		this.u_no = u_no;
		this.u_mail = u_mail;
		this.u_pw = u_pw;
		this.u_nickname = u_nickname;
	}

	public BigDecimal getU_no() {
		return u_no;
	}

	public void setU_no(BigDecimal u_no) {
		this.u_no = u_no;
	}

	public String getU_mail() {
		return u_mail;
	}

	public void setU_mail(String u_mail) {
		this.u_mail = u_mail;
	}

	public String getU_pw() {
		return u_pw;
	}

	public void setU_pw(String u_pw) {
		this.u_pw = u_pw;
	}

	public String getU_nickname() {
		return u_nickname;
	}

	public void setU_nickname(String u_nickname) {
		this.u_nickname = u_nickname;
	}
	
	
}
