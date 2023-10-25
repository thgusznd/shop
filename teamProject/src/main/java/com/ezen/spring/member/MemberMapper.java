package com.ezen.spring.member;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component("memberMapper")
@Mapper
public interface MemberMapper {

	public int addMember(Member member); //회원가입 
	
	public Member login(String memberID, String memberPwd); //로그인 

	public Member findIDByEmail(Member member); //이메일로 ID 찾기 
	public Member findIDByPhone(String memberName, String memberPhone); //휴대폰번호로 ID 찾기 
	
	public Member findPwdByEmail(Member member); //이메일로 ID 찾기 
	public Member findPwdByPhone(String memberName, String memberID, String memberPhone); //휴대폰번호로 ID 찾기 

	public Member getMemmber(String memberID);

	public int editMember(Member editMember);

	public int deleteMember(String memberID);

	public int updateSaveMoney(Member buyer); //적립금 업데이트 

	public String checkID(String memberID); //아이디 중복체크 

	public Member existMember(Member member); //이미 존재하는 멤버인지 확인 

}
