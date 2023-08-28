package com.ezen.spring.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Repository("memberDAO")
@Slf4j
public class MemberDAO {

	@Autowired
	@Qualifier("memberMapper")
	private MemberMapper memberMapper;

	@Transactional
	public boolean addMember(Member member) { //회원가입 
		boolean addMember = memberMapper.addMember(member)>0;
		return addMember;
	}

	public boolean login(String memberID, String memberPwd) { //로그인 
		Member m = memberMapper.login(memberID,memberPwd);
		boolean login=false;
		if(m!=null) login = true;
		return login;
	}

	//이메일로 아이디 찾기
	public Member findIDByEmail(String memberName, String memberEmail) {
		Member member = new Member();
		member.setMemberName(memberName);
		member.setMemberEmail(memberEmail);
		Member foundMember = memberMapper.findIDByEmail(member);
		return foundMember;
	}
	//휴대폰번호로 아이디 찾기 
	public Member findIDByPhone(String memberName, String memberPhone) { 
		Member foundMember = memberMapper.findIDByPhone(memberName, memberPhone);
		return foundMember;
	}
	//이메일로 비밀번호 찾기
	public Member findPwdByEmail(String memberName, String memberID, String memberEmail) {
		Member member = new Member();
		member.setMemberName(memberName);
		member.setMemberID(memberID);
		member.setMemberEmail(memberEmail);
		Member foundMember = memberMapper.findPwdByEmail(member);
		return foundMember;
	}
	//휴대폰번호로 비밀번호 찾기 
	public Member findPwdByPhone(String memberName, String memberID, String memberPhone) { 
		Member foundMember = memberMapper.findPwdByPhone(memberName, memberID, memberPhone);
		return foundMember;
	}

	public Member getMember(String memberID) {
		Member member = memberMapper.getMemmber(memberID);
		return member;
	}

	public boolean editMember(Member editMember) { //회원정보 수정 
		return memberMapper.editMember(editMember)>0;
	}

	public boolean deleteMember(String memberID) {
		return memberMapper.deleteMember(memberID)>0;
	}

	public boolean updateSaveMoney(Member buyer) {
		return memberMapper.updateSaveMoney(buyer)>0;
	}

}
