package com.rootrip.rootripteam.member;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Service
public class MemberDAO {
	@Autowired
	private SqlSession ss;

	public boolean loginCheck(HttpServletRequest req) {
		Member m = (Member) req.getSession().getAttribute("loginMember");
		if (m != null && m.getU_type().intValue() == 1) {
			req.setAttribute("loginPage", "member/afterlogin.jsp");
			return true;
		}
		else if (m != null) {
			req.setAttribute("loginPage", "member/afterlogin.jsp");
			return false;
		} else {
			req.setAttribute("loginPage", "member/beforlogin.jsp");
			return false;
		}
	}

	public Members idCheck(Member m) {
		Members idList = new Members(ss.getMapper(MemberMapper.class).getMemberByMail(m));
		if (idList.getMember().size() != 0) {
			idList.getMember().get(0).setU_pw("forbidden");
		}

		return idList;
	}

	public void join(Member m, HttpServletRequest req) {
		try {
			String path = req.getSession().getServletContext().getRealPath("resources/img");

			MultipartRequest mr = new MultipartRequest(req, path, 10485760, "utf-8", new DefaultFileRenamePolicy());

			String domain;
			if (mr.getParameter("u_domain").equals("직접입력")) {
				domain = mr.getParameter("u_domain_manual");
			} else {
				domain = mr.getParameter("u_domain");
			}

			String mail = mr.getParameter("u_id") + "@" + domain;

			m.setU_mail(mail);
			m.setU_pw(encryptPW(mr.getParameter("u_pw")));
			m.setU_nickname(mr.getParameter("u_nickname"));

			String photo = mr.getFilesystemName("u_profile");
			if (photo != null) {
				String photo_kor = URLEncoder.encode(photo, "utf-8").replace('+', ' ');
				m.setU_profile(photo_kor);
			}
			m.setU_type(new BigDecimal(0));

			ss.getMapper(MemberMapper.class).join(m);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void login(Member m, HttpServletRequest req) {
		try {
			List<Member> mList = ss.getMapper(MemberMapper.class).getMemberByMail(m);
			if (mList.size() == 1) {
				if (mList.get(0).getU_pw().equals(encryptPW(m.getU_pw()))) {
					req.getSession().setAttribute("loginMember", mList.get(0));
					req.getSession().setMaxInactiveInterval(10 * 60);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void logout(HttpServletRequest req) {
		req.getSession().setAttribute("loginMember", null);
	}

	public void drop(HttpServletRequest req) {
		try {
			Member m = (Member) req.getSession().getAttribute("loginMember");
			ss.getMapper(MemberMapper.class).drop(m);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void update(Member m, HttpServletRequest req) {
		String path = req.getSession().getServletContext().getRealPath("resources/img");

		MultipartRequest mr;
		try {
			mr = new MultipartRequest(req, path, 10485760, "utf-8", new DefaultFileRenamePolicy());
			m.setU_mail(mr.getParameter("u_mail"));
			m.setU_pw(encryptPW(mr.getParameter("u_pw")));
			m.setU_nickname(mr.getParameter("u_nickname"));

			String photo = mr.getFilesystemName("u_profile");
			if (photo != null) {
				String photo_kor = URLEncoder.encode(photo, "utf-8").replace('+', ' ');
				m.setU_profile(photo_kor);
				ss.getMapper(MemberMapper.class).updateWithProfile(m);
			} else {
				ss.getMapper(MemberMapper.class).updateWithoutProfile(m);
			}
			req.getSession().setAttribute("loginMember", m);
			req.getSession().setMaxInactiveInterval(10 * 60);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String encryptPW(String password) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(password.getBytes());

		StringBuilder sb = new StringBuilder();
		for (byte b : md.digest()) {
			sb.append(String.format("%02x", b));
		}
		return sb.toString();
	}
}
