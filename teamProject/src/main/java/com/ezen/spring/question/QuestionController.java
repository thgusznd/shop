package com.ezen.spring.question;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.ezen.spring.answer.Answer;
import com.ezen.spring.answer.AnswerDAO;
import com.ezen.spring.member.Member;
import com.ezen.spring.member.MemberDAO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/question")
@Slf4j
@SessionAttributes("memberID")
public class QuestionController {

	@Autowired
	@Qualifier("questionDAO")
	private QuestionDAO questionDAO;
	
	@Autowired
	@Qualifier("memberDAO")
	private MemberDAO memberDAO;
	
	@Autowired
	@Qualifier("answerDAO")
	private AnswerDAO answerDAO;
	
	@GetMapping("/") //test
	@ResponseBody
	public String test()
	{
		return "서버 정상 실행 test";
	}
	
	//질문 작성 폼 보여주기
	@GetMapping("/add") 
	public String join(@SessionAttribute(name="memberID",required = false) String memberID, Model model) {
		model.addAttribute("memberID", memberID);
		return "question/addForm";
	}
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> add(Question question){
		Map<String, Object> map = new HashMap<>();
		boolean addQuestion = questionDAO.addQuestion(question);
		map.put("added", addQuestion);
		map.put("questionNum", question.getQuestionNum());
		return map;
	}
	//질문 리스트 보여주기 
	@GetMapping("/list") 
	public String list(@SessionAttribute(name="memberID",required = false) String memberID, Model model) {
		Member member = memberDAO.getMember(memberID);
		List<Question> questionList = questionDAO.getList();
		model.addAttribute("questionList", questionList);
		model.addAttribute("member",member);
		return "question/questionList";
	}
	//질문 상세보기 
	@GetMapping("/detail/{questionNum}") 
	public String getNotice(@PathVariable int questionNum,
							@SessionAttribute(name="memberID",required = false) String memberID,
							Model model)
	{
		Question question = questionDAO.getQuestion(questionNum);
		Member member = memberDAO.getMember(memberID);
		
		model.addAttribute("question", question);
		model.addAttribute("member",member);
		
		//답변이 존재하는 경우 답변도 같이 보여주기 
		Answer answer = answerDAO.getAnswer(questionNum);
		if(answer != null) {
			model.addAttribute("answer", answer);
		}
		
		return "question/questionDetail";
	}
	//질문 수정 폼 보여주기 
	@GetMapping("/editForm/{questionNum}") 
	public String edit(@PathVariable int questionNum, Model model) {
		Question question = questionDAO.getQuestion(questionNum);
		model.addAttribute("question",question);
		return "question/questionEdit";
	}
	//질문 내용 수정하기
	@PostMapping("/edit") 
	@ResponseBody
	public Map<String, Object> edit(Question question) {
		boolean updated = questionDAO.update(question);
		Map<String, Object> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}
	//질문 삭제하기 
	@GetMapping("/delete/{questionNum}") 
	@ResponseBody
	public Map<String, Boolean> delete(@PathVariable int questionNum)
	{
		boolean deleted = questionDAO.delete(questionNum);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
	
}
