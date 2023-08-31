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
@EqualsAndHashCode
public class Review 
{
	private int reviewNum;
	private String reviewTitle;
	private String reviewAuthor;
	private String reviewContents;
	private java.sql.Date reviewDate;
	private int reviewParentsNum;
	private int reviewLikeCnt;
	
	List<ReviewAttach> reviewAttList;
}