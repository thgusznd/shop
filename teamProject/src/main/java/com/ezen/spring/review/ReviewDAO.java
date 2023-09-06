package com.ezen.spring.review;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("reviewDAO")
public class ReviewDAO 
{
	@Autowired
	private ReviewMapper reviewMapper;
	
	public boolean addReview(Review review)
	{
		boolean reviewSaved = reviewMapper.addReview(review)>0;
		
		int pnum = review.getReviewNum();
		List<ReviewAttach> list = review.getReviewAttList();
		for(int i=0;i<list.size();i++) {
			list.get(i).setReviewAttachParentsNum(pnum);
		}
		
		boolean attachSaved = false;
		if(review.getReviewAttList().size()>0) {
			attachSaved = reviewMapper.addAttachReview(review.getReviewAttList())>0;
		}else {
			attachSaved = true;
		}
		
		return reviewSaved && attachSaved;
	}
	
	//전체 리뷰 리스트 가져오기 
	public List<Map<String, String>> getReviewList()
	{
		return reviewMapper.getReviewList();
	}
	
	//아이템 관련 리뷰 리스트 가져오기 
	public List<Map<String, String>> getReviewListByItemNum(int itemNum) 
	{
		return reviewMapper.getReviewListByItemNum(itemNum);
	}
	
	public List<Map<String, String>> detailReview(int reviewNum)
	{
		return reviewMapper.getReview(reviewNum);
	}
	
	public boolean removeAttach(int reviewAttachNum)
	{
		return reviewMapper.removeAttach(reviewAttachNum)>0;
	}
	
	public ReviewAttach getAttach(int reviewAttachNum)
	{
		return reviewMapper.getAttach(reviewAttachNum);
	}
	
	public boolean addAttachReview(List<ReviewAttach> list)
	{
		return reviewMapper.addAttachReview(list)>0;
	}
	
	public boolean updateReview(Review review)
	{
		return reviewMapper.updateReview(review)>0;
	}
	
	public boolean deleteReview(int reviewNum)
	{
		return reviewMapper.deleteReview(reviewNum)>0;
	}
	
	public boolean likeCnt(int reviewNum)
	{
		return reviewMapper.likeCnt(reviewNum)>0;
	}
	
	//best Review Top 3 가져오기 
	public List<Map<String, String>> getTopReviews() { 
        return reviewMapper.getTopReviews();
    }
	
}