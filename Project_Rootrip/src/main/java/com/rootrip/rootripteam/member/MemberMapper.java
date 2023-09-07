package com.rootrip.rootripteam.member;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface MemberMapper {
	public abstract int join(Member m);

	public abstract List<Member> getMemberByMail(Member m);

	public abstract int drop(Member m);

	public abstract int kick(String mail);

	public abstract int updateWithProfile(Member m);

	public abstract int updateWithoutProfile(Member m);

	public abstract List<Member> getUserList(int p);

	public abstract List<Member> getUserListWithNickname(@Param("nickname") String nickname, @Param("p") int p);

	public abstract List<Member> getUserListWithMail(@Param("mail") String mail, @Param("p") int p);

	public abstract int getAllUserCount();

	public abstract int getUserCountWithNickname(String nickname);

	public abstract int getUserCountWithMail(String mail);
}
