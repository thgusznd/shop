package com.ezen.spring.answer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository("answerDAO")
@Slf4j
public class AnswerDAO {

	@Autowired
	private AnswerMapper answerMapper;

	public boolean addAnswer(Answer answer) {
		return answerMapper.addAnswer(answer)>0;
	}

	public Answer getAnswer(int questionNum) {
		Answer answer = answerMapper.getAnswer(questionNum);
		return answer;
	}

	public boolean editAnswer(Answer answer) {
		return answerMapper.editAnswer(answer)>0;
	}

	public boolean delete(int answerNum) {
		return answerMapper.delete(answerNum)>0;
	}
}
