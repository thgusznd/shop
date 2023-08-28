package com.ezen.spring.answer;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.ezen.spring.member.Member;
import com.ezen.spring.member.MemberDAO;
import com.ezen.spring.question.Question;
import com.ezen.spring.question.QuestionDAO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/answer")
@Slf4j
@SessionAttributes("memberID")
public class AnswerController {

	@Autowired
	@Qualifier("answerDAO")
	private AnswerDAO answerDAO;
	
	@Autowired
	@Qualifier("memberDAO")
	private MemberDAO memberDAO;
	
	@Autowired
	@Qualifier("questionDAO")
	private QuestionDAO questionDAO;
	
	@GetMapping("/") //test
	@ResponseBody
	public String test()
	{
		return "서버 정상 실행 test";
	}
	@GetMapping("/addForm/{questionNum}") //답변 작성 폼 띄우기
	public String add(@PathVariable int questionNum, Model model) {
		Question question = questionDAO.getQuestion(questionNum);
		model.addAttribute("question",question);
		return "question/answer";
	}
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> add(Answer answer, Model model){
		Map<String, Object> map = new HashMap<>();
		boolean added = answerDAO.addAnswer(answer);
		map.put("added", added);
		if(added) {
			int answerNum = answer.getAnswerNum();
			map.put("answerNum", answerNum);
		}
		return map;
	}
	@GetMapping("/editForm/{questionNum}")
	public String edit(@PathVariable int questionNum, Model model,
					   @SessionAttribute(name="memberID",required = false) String memberID) {
		Question question = questionDAO.getQuestion(questionNum);
		model.addAttribute("question",question);
		Answer answer = answerDAO.getAnswer(questionNum);
		model.addAttribute("answer", answer);
		Member member = memberDAO.getMember(memberID);
		model.addAttribute("member",member);
		return "question/answerEdit";
	}
	@PostMapping("/edit")
	@ResponseBody
	public Map<String, Object> edit(Answer answer){
		Map<String, Object> map = new HashMap<>();
		boolean editAnswer = answerDAO.editAnswer(answer);
		map.put("editAnswer", editAnswer);
		return map;
	}
	@GetMapping("/delete/{answerNum}")
	@ResponseBody
	public Map<String, Boolean> delete(@PathVariable int answerNum){
		boolean deleted = answerDAO.delete(answerNum);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
	
}
