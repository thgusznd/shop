package com.ezen.spring.question;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Repository("questionDAO")
@Slf4j
public class QuestionDAO {
	
	@Autowired
	private QuestionMapper questionMapper;

	@Transactional
	public boolean addQuestion(Question question) { //질문작성
		boolean addQuestion = questionMapper.addQuestion(question)>0;
		return addQuestion;
	}
	public List<Question> getList() {
		List<Question> questionList = questionMapper.getList();
		return questionList;
	}
	public Question getQuestion(int questionNum) {
		Question question = questionMapper.getQuestion(questionNum);
		return question;
	}

	public boolean update(Question question) {
		return questionMapper.update(question)>0;
	}

	public boolean delete(int questionNum) {
		return questionMapper.delete(questionNum)>0;
	}

}
