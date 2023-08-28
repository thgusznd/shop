package com.ezen.spring.notice;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.ezen.spring.member.MemberDAO;
import com.ezen.spring.member.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/notice")
@Slf4j
@SessionAttributes("memberID")
public class NoticeController {

	@Autowired
	@Qualifier("noticeDAO")
	private NoticeDAO noticeDAO;
	
	@Autowired
	@Qualifier("memberDAO")
	private MemberDAO memberDAO;
	
	@GetMapping("/") //test
	@ResponseBody
	public String test()
	{
		return "서버정상실행 test";
	}
	
	@GetMapping("/addForm") //공지사항 작성 폼 띄우기
	public String add() {
		return "notice/noticeAddForm";
	}
	@PostMapping("/addResult") //공지사항 작성 후 DB 저장
	@ResponseBody
	public Map<String, Object> add(Notice notice, Model model){
		Map<String, Object> map = new HashMap<>();
		boolean added = noticeDAO.addNotice(notice);
		map.put("added", added);
		if(added) {
			int noticeNum = notice.getNoticeNum();
			log.info("noticeNum={}",noticeNum);
			map.put("noticeNum", noticeNum);
		}
		return map;
	}
	
	@GetMapping("/list") //공지사항 리스트 보여주기 
	public String list(@SessionAttribute(name="memberID",required = false) String memberID, Model model) {
		List<Notice> noticeList = noticeDAO.getList();
		Member member = memberDAO.getMember(memberID);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("member",member);
		return "notice/noticeList";
	}
	
	@GetMapping("/detail/{noticeNum}") //공지사항 상세보기 
	public String getNotice(@PathVariable int noticeNum, 
							@SessionAttribute(name="memberID",required = false) String memberID,
							Model model)
	{
		Notice notice = noticeDAO.getNotice(noticeNum);
		Member member = memberDAO.getMember(memberID);
		model.addAttribute("notice", notice);
		model.addAttribute("member",member);
		return "notice/noticeDetail";
	}
	
	@GetMapping("/editForm/{noticeNum}") //수정 폼 보여주기 
	public String edit(@PathVariable int noticeNum, Model model) {
		Notice notice = noticeDAO.getNotice(noticeNum);
		model.addAttribute("notice",notice);
		return "notice/noticeEdit";
	}
	@PostMapping("/edit") //공지사항 수정하기
	@ResponseBody
	public Map<String, Object> edit(Notice notice) {
		boolean updated = noticeDAO.update(notice);
		Map<String, Object> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}
	
	@GetMapping("/delete/{noticeNum}") //공지사항 삭제하기 
	@ResponseBody
	public Map<String, Boolean> delete(@PathVariable int noticeNum)
	{
		boolean deleted = noticeDAO.delete(noticeNum);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
}
