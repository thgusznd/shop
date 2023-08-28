package com.ezen.spring.answer;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component("answerMapper")
@Mapper
public interface AnswerMapper {

	int addAnswer(Answer answer);

	Answer getAnswer(int questionNum);

	int editAnswer(Answer answer);

	int delete(int answerNum);


}
