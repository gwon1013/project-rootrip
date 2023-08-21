package com.rootrip.rootripteam.member;

import java.math.BigDecimal;

// javabean
public class Member {
	private String u_mail;
	private String u_pw;
	private String u_nickname;
	private String u_profile;
	private BigDecimal u_type;

	public Member() {
		// TODO Auto-generated constructor stub
	}

	public Member(String u_mail, String u_pw, String u_nickname, String u_profile, BigDecimal u_type) {
		super();
		this.u_mail = u_mail;
		this.u_pw = u_pw;
		this.u_nickname = u_nickname;
		this.u_profile = u_profile;
		this.u_type = u_type;
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

	public String getU_profile() {
		return u_profile;
	}

	public void setU_profile(String u_profile) {
		this.u_profile = u_profile;
	}

	public BigDecimal getU_type() {
		return u_type;
	}

	public void setU_type(BigDecimal u_type) {
		this.u_type = u_type;
	}

}
