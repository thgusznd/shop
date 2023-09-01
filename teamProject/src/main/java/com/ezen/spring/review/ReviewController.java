package com.ezen.spring.review;

import java.io.File;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
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
import org.springframework.web.multipart.MultipartFile;

import com.ezen.spring.item.ItemController;
import com.ezen.spring.item.ItemDAO;
import com.github.pagehelper.PageInfo;
import com.mysql.cj.log.Log;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/review")
@SessionAttributes("memberID")
@Slf4j
public class ReviewController 
{
	@Autowired
	private ReviewDAO reviewDAO;
	
	@Autowired
	private ItemDAO itemDAO;
	
	@Autowired
	private ReviewSvc reviewSvc;
	
	@GetMapping("/")
	public String index()
	{
		return "review test";
	}
	
	@GetMapping("/add/{itemNum}")
	public String addReview(@PathVariable int itemNum, Model model,
							@SessionAttribute(name="memberID",required = false) String memberID)
	{
		String goods = null;
		List<Map<String, String>> list = itemDAO.getItem(itemNum);
		for(int i=0 ; i<list.size();i++) {
			goods = list.get(i).get("goods");
		}
		model.addAttribute("goods", goods);
		model.addAttribute("itemNum", itemNum);
		return "review/reviewAddForm";
	}
	
	@PostMapping("/add")  //리뷰 추가
	@ResponseBody
	public Map<String, Object> addResult(Review review, HttpServletRequest request, 
							 			 @RequestParam("files")MultipartFile[] mfiles,
										 @SessionAttribute(name="memberID",required = false) String memberID)
	{
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/reviewPhoto");
		
		List<ReviewAttach> reviewAttachList = new ArrayList<>();
		
		try {
			for(int i=0;i<mfiles.length;i++) {
				if(mfiles[0].getSize()==0) continue;
				String originName = mfiles[i].getOriginalFilename();
				mfiles[i].transferTo(new File(savePath+"/"+originName));
				
				String cType = mfiles[i].getContentType();
				String pName = mfiles[i].getName();
				Resource res = mfiles[i].getResource();
				long fSize = mfiles[i].getSize();
				boolean empty = mfiles[i].isEmpty();
				
				ReviewAttach reviewAttach = new ReviewAttach();
				reviewAttach.setReviewAttachName(originName);
				reviewAttach.setReviewAttachFileSize(fSize/1024);
				reviewAttach.setReviewAttachFileContentType(cType);
				
				reviewAttachList.add(reviewAttach);
			}
			
			review.setReviewAttList(reviewAttachList);
			review.setReviewAuthor(memberID);
			log.info("reviewStar={}",review.getReviewStar());
			boolean added = reviewDAO.addReview(review);
			Map<String, Object> map = new HashMap<>();
			map.put("added", added);
			map.put("reviewNum", review.getReviewNum());
			
			return map;
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		Map<String, Object> map = new HashMap<>();
		map.put("added", false);
		return map;
	}
	
	@GetMapping("/list")  //전체 리뷰 리스트
	public String reviewList(Model model)
	{
		List<Map<String, String>> reviewList = reviewDAO.getReviewList();
		model.addAttribute("reviewList", reviewList);
		log.info("reviewList={}", reviewList);
		return "review/reviewList";
	}
	
	@GetMapping("/get/{reviewNum}")  //리뷰 상세보기
	public String detailReview(@PathVariable int reviewNum, Model model, 
							   @SessionAttribute(name="memberID",required = false) String memberID)
	{
		Review review = reviewSvc.getReview(reviewNum);
		log.info("Controller : reviewStar={}", review.getReviewStar());
		model.addAttribute("review", review);
		model.addAttribute("memberID", memberID);
		return "review/reviewDetail";
	}
	
	@GetMapping("/remove/{reviewAttachNum}") //리뷰 첨부파일 삭제
	@ResponseBody
	public Map<String,Object> attachRemove(@PathVariable int reviewAttachNum, HttpServletRequest request)
	{
		boolean removed = reviewSvc.removeAttach(reviewAttachNum, request);
		Map<String, Object> map = new HashMap<>();
		map.put("removed", removed);
		return map;
	}
	
	@PostMapping("/addAttach") //첨부파일 추가시
	@ResponseBody
	public Map<String,Object> addAttachReview(@RequestParam("files")MultipartFile[] mfiles, 
										      HttpServletRequest request, 
										      @RequestParam("reviewParentsNum") int reviewParentsNum)
	{
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/reviewPhoto");
		
		List<ReviewAttach> reviewAttachList = new ArrayList<>();
		
		try {
			for(int i=0;i<mfiles.length;i++) {
				if(mfiles[0].getSize()==0) continue;
				String originName = mfiles[i].getOriginalFilename();
				mfiles[i].transferTo(new File(savePath+"/"+originName));
				
				/* MultipartFile 주요 메소드 */
				String cType = mfiles[i].getContentType();
				String pName = mfiles[i].getName();
				Resource res = mfiles[i].getResource();
				long fSize = mfiles[i].getSize();
				boolean empty = mfiles[i].isEmpty();
				
				ReviewAttach reviewAttach = new ReviewAttach();
				reviewAttach.setReviewAttachName(originName);
				reviewAttach.setReviewAttachFileSize(fSize/1024);
				reviewAttach.setReviewAttachFileContentType(cType);
				reviewAttach.setReviewAttachParentsNum(reviewParentsNum);
				
				reviewAttachList.add(reviewAttach);
			}
			boolean added = reviewDAO.addAttachReview(reviewAttachList);
			Map<String, Object> map = new HashMap<>();
			map.put("added", added);
			return map;
		}catch(Exception ex) {
				ex.printStackTrace();
		}
		Map<String, Object> map = new HashMap<>();
		map.put("added", false);
		return map;
	}
	
	@GetMapping("/update/{reviewNum}") //수정폼
	public String updateReview(@PathVariable int reviewNum, Model model)
	{
		Review review = reviewSvc.getReview(reviewNum);
		model.addAttribute("review", review);
		return "review/reviewUpdateForm";
	}
	
	@PostMapping("/update")  //수정
	@ResponseBody
	public Map<String,Object> updateResult(Review review)
	{
		boolean updated = reviewDAO.updateReview(review);
		Map<String,Object> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}
	
	@GetMapping("/delete/{reviewNum}")  //삭제
	@ResponseBody
	public Map<String,Object> deleteResult(@PathVariable int reviewNum)
	{
		boolean deleted = reviewDAO.deleteReview(reviewNum);
		Map<String,Object> map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
	
	@GetMapping("/like/{reviewNum}")  //좋아요 버튼
	@ResponseBody
	public Map<String,Object> likeCnt(@PathVariable int reviewNum, 
									  @SessionAttribute(name="memberID",required = false) String memberID)
	{
		boolean likeUpdated = reviewDAO.likeCnt(reviewNum);
		Map<String,Object> map = new HashMap<>();
		map.put("likeUpdated", likeUpdated);
		map.put("memberID", memberID);
		return map;
	}
}