package com.ezen.spring.question;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import com.ezen.spring.notice.Notice;

@Component("questionMapper")
@Mapper
public interface QuestionMapper {

	int addQuestion(Question question); //질문 작성

	public List<Question> getList(); 

	Question getQuestion(int questionNum);

	int update(Question question);

	int delete(int questionNum);
}
