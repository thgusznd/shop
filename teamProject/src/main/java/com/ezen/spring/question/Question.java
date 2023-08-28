package com.ezen.spring.question;

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
@EqualsAndHashCode(exclude= {"questionTitle","questionAuthor","questionDate","questionContents"})
public class Question {

	private int questionNum; //질문번호 
	private String questionTitle; //질문제목 
	private String questionAuthor; //질문작성자 
	private java.sql.Date questionDate; //질문작성일 
	private String questionContents; //질문내용 
	private String questionPassword; //질문 비밀번호 
	
}