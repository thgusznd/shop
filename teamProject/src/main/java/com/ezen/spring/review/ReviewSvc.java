package com.ezen.spring.review;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReviewSvc 
{
	@Autowired
	private ReviewDAO reviewDAO;
	
	public Review getReview(int reviewNum)
	{
		List<Map<String, String>> list = reviewDAO.detailReview(reviewNum);
		Review r = getReviewIn(list.get(0));
		r.setReviewAttList(new ArrayList<ReviewAttach>());
		
		for(int i=0;i<list.size();i++) { //list.size() 첨부파일의 갯수와 일치
			Map<String, String> m = list.get(i);
			
			List<ReviewAttach> attList = getReviewAttachIn(m);
			r.setReviewAttList(attList);
		}
		return r;
	}
	
	private List<ReviewAttach> getReviewAttachIn(Map m)
	{
		if(m.get("reviewAttachNames")==null) return null;
		
		String reviewAttachNums = m.get("reviewAttachNums").toString();
		String reviewAttachNames = m.get("reviewAttachNames").toString();
		
		String[] nums = reviewAttachNums.split(",");
		String[] names = reviewAttachNames.split(",");
		
		List<ReviewAttach> rattlist = new ArrayList<>();
		for(int i=0; i<nums.length; i++) {
			int reviewattNum = Integer.parseInt(nums[i]);
			String reviewattName = names[i];
			
			ReviewAttach ratt = new ReviewAttach();
			ratt.setReviewAttachNum(reviewattNum);
			ratt.setReviewAttachName(reviewattName);
			
			rattlist.add(ratt);
		}
		
		return rattlist;
	}
	
	private Review getReviewIn(Map m)
	{
		int reviewNum = Integer.parseInt(m.get("reviewNum").toString());
		String reviewContents = m.get("reviewContents").toString();
		String reviewAuthor = m.get("reviewAuthor").toString();
		java.sql.Date reviewDate = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		int reviewStar = Integer.parseInt(m.get("reviewStar").toString());
		try {
			reviewDate = new java.sql.Date(sdf.parse(m.get("reviewDate").toString()).getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		int reviewLikeCnt = Integer.parseInt(m.get("reviewLikeCnt").toString());
		
		Review review = new Review();
		review.setReviewNum(reviewNum);
		review.setReviewContents(reviewContents);
		review.setReviewAuthor(reviewAuthor);
		review.setReviewDate(reviewDate);
		review.setReviewLikeCnt(reviewLikeCnt);
		review.setReviewStar(reviewStar);
		
		return review;
	}
	
	@Transactional
	public boolean removeAttach(int reviewAttachNum, HttpServletRequest request)
	{
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/reviewPhoto");
		ReviewAttach reviewAttach = reviewDAO.getAttach(reviewAttachNum);
		String fname = reviewAttach.getReviewAttachName();
		File delFile = new File(savePath, fname);
		
		boolean deleted = reviewDAO.removeAttach(reviewAttachNum);
		boolean fdeleted = delFile.delete();

		return deleted && fdeleted;
	}
	
	public List<Map<String, String>> getTopReviews() {
	    return reviewDAO.getTopReviews();
	}
}