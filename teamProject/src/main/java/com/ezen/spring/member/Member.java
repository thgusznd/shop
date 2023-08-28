package com.ezen.spring.member;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Component
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@EqualsAndHashCode(exclude= {"memberSex","memberBirth","national","saveMoney","point","couponNum","interest"})
public class Member {

	private int memberNum; //번호
	private String memberName; //이름 
	private String memberPhone; //연락처 
	//private String memberAddress; //주소 
	private String post; //우편번호 
	private String address; //주소 
	private String detailAddress; //상세주소 
	private String memberID; //아이디 
	private String memberPwd; //비밀번호 
	private String memberEmail; //이메일 
	private String memberSex; //성별 
	private java.sql.Date memberBirth; //생년월일 
	private String national; //내국인,외국인 
	private int saveMoney; //적립금 
	private int point; //포인
	private int couponNum; //쿠폰 
	private String interest; //관심
	private String memberClass; //회원등급 
	
}
