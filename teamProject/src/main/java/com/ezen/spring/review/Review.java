package com.ezen.spring.review;

import java.util.List;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
@EqualsAndHashCode(exclude= {"reviewAuthor", "reviewContents", "reviewDate", "reviewParentsNum", "reviewLikeCnt", "reviewStar"})
public class Review 
{
	private int reviewNum; //리뷰 번호(PK,AI)
	private String reviewAuthor; //리뷰 작성자(memberID) 
	private String reviewContents; //리뷰 내용 
	private java.sql.Date reviewDate; //리뷰 작성일 
	private int reviewParentsNum; //관련 아이템 번호 
	private int reviewLikeCnt; //리뷰 좋아요 갯수 
	private int reviewStar; //별점 갯수 
	
	List<ReviewAttach> reviewAttList; //리뷰 사진 
}