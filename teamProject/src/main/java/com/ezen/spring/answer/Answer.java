package com.ezen.spring.answer;

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
@EqualsAndHashCode(exclude= {"answerAuthor", "answerDate", "answerContents"})
public class Answer {
	
	private int answerNum; //답변 번호 
	private String answerAuthor; //답변 작성자 
	private java.sql.Date answerDate; //답변 작성일 
	private String answerContents; //답변 내용 
	private int pQuestionNum; //질문 번호 
	
}
