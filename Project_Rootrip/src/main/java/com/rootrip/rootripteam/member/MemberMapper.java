package com.rootrip.rootripteam.member;

import java.util.List;

public interface MemberMapper {
	public abstract int join(Member m);

	public abstract List<Member> getMemberByMail(Member m);

	public abstract int drop(Member m);

	public abstract int updateWithProfile(Member m);

	public abstract int updateWithoutProfile(Member m);
}
