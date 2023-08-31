package com.ezen.spring.review;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

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
	
	public PageInfo<Map> reviewList(int itemNum, int pageNum)
	{
		PageHelper.startPage(pageNum, 2);
		PageInfo<Map> pageInfo = new PageInfo<>(reviewMapper.reviewList(itemNum));
		return pageInfo;
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
}