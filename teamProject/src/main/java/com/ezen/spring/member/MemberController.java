package com.ezen.spring.member;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.ezen.spring.item.ItemSvc;
import com.ezen.spring.review.ReviewSvc;

import jakarta.servlet.ServletContext;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
@SessionAttributes("memberID")
public class MemberController {

	@Autowired
	@Qualifier("memberDAO")
	private MemberDAO memberDAO;
	
	@Autowired
	@Qualifier("itemSvc")
	private ItemSvc itemSvc;
	
	@Autowired
	@Qualifier("reviewSvc")
	private ReviewSvc reviewSvc;
	
	@Autowired
	private ServletContext ctx;
	
	@Autowired
	private MemberSvc svc;
	
	@GetMapping("/") //쇼핑몰 main 화면 
	public String main(Model model)
	{
		// best Item top10 메인 화면에 띄우기 
		List<Map<String, String>> topItems = itemSvc.getTopItems(10);
	    model.addAttribute("topItems", topItems);
	    
	 // best Review top3 메인 화면에 띄우기 
	    List<Map<String, String>> topReviews = reviewSvc.getTopReviews();
	    model.addAttribute("topReviews", topReviews);
		return "main";
	}
	
	//회원가입 폼 보여주기 및 회원가입 실행 
		@GetMapping("/admin") 
		public String admin() {
			return "admin/main_admin";
		}
		
	//회원가입 폼 보여주기 및 회원가입 실행 
	@GetMapping("/join") 
	public String join() {
		return "member/membershipForm";
	}
	
	@PostMapping("/add") //회원가입 
	public String add(Member member, Model model){
	    
	    //이미 존재하는 멤버인지 확인
	    boolean existMember = memberDAO.existMember(member);
	    if(existMember) {
	        
	    	model.addAttribute("existMsg", "회원정보가 이미 존재합니다.");
	        return "member/membershipForm";
	    }
	    else {
	        boolean added = memberDAO.addMember(member);
	        if (added) {
	        	model.addAttribute("success",true);
	        	model.addAttribute("successMsg", "회원가입이 완료되었습니다.");
	        	return "member/loginForm";
	        } else {
	        	
	        	model.addAttribute("errorMsg", "회원가입에 실패했습니다. 형식에 맞게 양식을 작성해주세요.");
	        	return "member/membershipForm";
	        }
	    }
	}

	
	//아이디 중복 체크
	@PostMapping("/checkId")
	@ResponseBody
	public boolean checkId(@RequestParam("memberID") String memberID) {
	boolean checkID = memberDAO.checkId(memberID); //기존에 존재하는 id인지 확인 
	return checkID;
	}

	
	//로그인 폼 보여주기 및 로그인 실행 
	@GetMapping("/login") 
	public String login() {
		return "member/loginForm";
	}
	
	@PostMapping("/login") //로그인
	@ResponseBody
	public Map<String, Object> login(String memberID, String memberPwd, Model model){
		boolean login = memberDAO.login(memberID,memberPwd);
		Map<String, Object> map = new HashMap<>();
		map.put("login", login);
		if(login) {
			model.addAttribute("memberID",memberID);//session에 memberID 저장하는 코드 
			map.put("memberID", memberID);
		}
		return map;
	}
	
	//로그아웃 
	@GetMapping("/logout")
	@ResponseBody
	public Map<String, Boolean> logout(SessionStatus status){
		status.setComplete();
		Map<String, Boolean> map = new HashMap<>();
		map.put("logout", true);
		return map;
	}
	//마이페이지 
	@GetMapping("/mypage/{memberID}")
	public String mypage(@PathVariable String memberID, Model model){
		Member member = memberDAO.getMember(memberID);
		model.addAttribute("member", member);
		return "member/myPage";
		
	}
	
	//마이페이지 수정 
	@GetMapping("/mypage/edit/{memberID}")
	public String mypageEditForm(@PathVariable String memberID, Model model) {
		Member member = memberDAO.getMember(memberID);
		model.addAttribute("member", member);
		return "member/myPageEdit";
	}
	
	@PostMapping("/mypage/edit")
	@ResponseBody
	public Map<String, Object> mypageEdit(Member editMember, Model model){
		Map<String, Object> map = new HashMap<>();
		boolean updated = memberDAO.editMember(editMember);
		Member member = memberDAO.getMember(editMember.getMemberID());
		model.addAttribute("member", member);
		map.put("updated", updated);
		map.put("member", member);
		return map;
	}
	
	//아이디 찾기 
	@GetMapping("/findIDForm")
	public String findId() {
		return "member/FindIDForm";
	}
	
	@PostMapping("/findID")
	@ResponseBody
	public Map<String, Object> findID(@RequestParam("findType") String findType,
									  @RequestParam String memberName, 
									  @RequestParam(value = "memberEmail", required = false) String memberEmail,
									  @RequestParam(value = "memberPhone", required = false) String memberPhone){
		Map<String, Object> map = new HashMap<>();
		if(findType.equals("memberEmail")) { //이메일로 검색한 경우 
			Member foundMember = memberDAO.findIDByEmail(memberName,memberEmail);
			
			if(foundMember!=null) { 
				map.put("found", true);
				map.put("foundMember", foundMember); 
			} else {
				map.put("msg", "입력하신 정보로 가입 된 회원 아이디는 존재하지 않습니다.");
			}
		} else if(findType.equals("memberPhone")){ //휴대폰으로 검색한 경우 
			Member foundMember = memberDAO.findIDByPhone(memberName,memberPhone);
			if(foundMember!=null) {
				map.put("found", true);
				map.put("foundMember", foundMember); 
			} else {
				map.put("msg", "입력하신 정보로 가입 된 회원 아이디는 존재하지 않습니다.");
			}
		}
		
		return map;
	}
	
	//아이디 찾기 결과 
	@GetMapping("/showID/{memberID}")
	public String showFindID(@PathVariable String memberID, Model model) {
		Member member = memberDAO.getMember(memberID);
		model.addAttribute("member", member);
		return "member/showFindID";
	}
	
	//비밀번호 찾기 
	@GetMapping("/findPwdForm")
	public String findPwd() {
		return "member/FindPwdForm";
	}
	
	@PostMapping("/findPwd")
	@ResponseBody
	public Map<String, Object> findPwd(@RequestParam("findType") String findType,
									   @RequestParam String memberName, 
									   @RequestParam String memberID,
									   @RequestParam(value = "memberEmail", required = false) String memberEmail,
									   @RequestParam(value = "memberPhone", required = false) String memberPhone){
		Map<String, Object> map = new HashMap<>();
		if(findType.equals("memberEmail")) { //이메일로 검색한 경우 
			Member foundMember = memberDAO.findPwdByEmail(memberName, memberID, memberEmail);
			
			if(foundMember!=null) { 
				map.put("found", true);
				map.put("foundMember", foundMember); 
			} else {
				map.put("msg", "입력하신 정보로 가입 된 회원 비밀번호는 존재하지 않습니다.");
			}
		} else if(findType.equals("memberPhone")){ //휴대폰으로 검색한 경우 
			Member foundMember = memberDAO.findPwdByPhone(memberName, memberID, memberPhone);
			if(foundMember!=null) {
				map.put("found", true);
				map.put("foundMember", foundMember); 
			} else {
				map.put("msg", "입력하신 정보로 가입 된 회원 비밀번호는 존재하지 않습니다.");
			}
		}
		
		return map;
	}
	
	//비밀번호 찾기 결과 
		@GetMapping("/showPwd/{memberID}")
		public String showFindPwd(@PathVariable String memberID, Model model) {
			Member member = memberDAO.getMember(memberID);
			model.addAttribute("member", member);
			return "member/showFindPwd";
		}
		
	//회원탈퇴 
	@PostMapping("/unregister")
	@ResponseBody
	public Map<String, Object> unregister(@RequestParam String memberID){
		boolean deleteMember = memberDAO.deleteMember(memberID);
		Map<String, Object> map = new HashMap<>();
		map.put("unregister", deleteMember);
		return map;
	}
	
	@GetMapping("/auth/{memberEmail}")  //이메일 인증 버튼 눌렀을 시 인증메일 보내는 메소드
	@ResponseBody
	public Map<String,Boolean> sendTestMail(@PathVariable String memberEmail)
	{
		boolean isSent = svc.sendHTMLMessage(ctx, memberEmail);
		Map<String,Boolean> resMap = new HashMap<>();
		resMap.put("sent", isSent);
		return resMap;
	}
	
	@GetMapping("/auth/{memberEmail}/{code}")  // 보낸 메일에서 이용자가 인증 링크를 클릭했을 때
	@ResponseBody
	public String setEmailAuth(@PathVariable("memberEmail")String memberEmail, @PathVariable("code")String returnCode)
	{
		Map<String, String> authMap = (Map)ctx.getAttribute("authMap");
		if(authMap.get(memberEmail).equals(returnCode)) {
			authMap.put(memberEmail, "1");
			return "이메일 인증 성공";
		}
		log.info("인증코드 확인={}", returnCode);
		return "이메일 인증 실패";
	}
	
	@GetMapping("/auth_check")  //인증 성공 유무 알려줄 메소드
	@ResponseBody
	public Map<String, Boolean> email_auth(@RequestParam("memberEmail") String memberEmail)
	{
		Map<String, String> authMap = (Map) ctx.getAttribute("authMap");
		String result = authMap.get(memberEmail);
	      
		Map<String, Boolean> resMap = new HashMap<>();
	      
		if(result.equals("1")) {
			resMap.put("auth", true);
			authMap.remove(memberEmail);
		}else {
			resMap.put("auth", false);
		}
		return resMap;
	}
}

