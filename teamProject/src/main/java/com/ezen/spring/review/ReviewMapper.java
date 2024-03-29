package com.ezen.spring.review;

import java.util.*;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component("reviewMapper")
@Mapper
public interface ReviewMapper 
{
	public int addReview(Review review);
	
	public int addAttachReview(List<ReviewAttach> reviewAttachList);
	
	//전체 리뷰 리스트 
	public List<Map<String, String>> getReviewList();
	
	//아이템별 리뷰 리스트 
	public List<Map<String, String>> getReviewListByItemNum(int itemNum);
	
	public List<Map<String, String>> getReview(int reviewNum);
	
	public int removeAttach(int reviewAttachNum);
	
	public ReviewAttach getAttach(int reviewAttachNum);
	
	public int updateReview(Review review);
	
	public int deleteReview(int reviewNum);
	
	public int likeCnt(int reviewNum);
	
	public List<Map<String, String>> getTopReviews();

	public int numberOfReviews(int itemNum);

	
}