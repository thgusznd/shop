package com.ezen.spring.member;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component("memberMapper")
@Mapper
public interface MemberMapper {

	int addMember(Member member); //회원가입 
	
	Member login(String memberID, String memberPwd); //로그인 

	Member findIDByEmail(Member member); //이메일로 ID 찾기 
	Member findIDByPhone(String memberName, String memberPhone); //휴대폰번호로 ID 찾기 
	
	Member findPwdByEmail(Member member); //이메일로 ID 찾기 
	Member findPwdByPhone(String memberName, String memberID, String memberPhone); //휴대폰번호로 ID 찾기 

	Member getMemmber(String memberID);

	int editMember(Member editMember);

	int deleteMember(String memberID);

	int updateSaveMoney(Member buyer); 

}
