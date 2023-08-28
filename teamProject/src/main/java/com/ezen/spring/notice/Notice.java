package com.ezen.spring.notice;


import org.springframework.stereotype.Component;


import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Component
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@EqualsAndHashCode(exclude= {"noticeTitle","noticeAuthor","noticeDate","noticeContents"})
public class Notice {

	private int noticeNum;
	private String noticeTitle;
	private String noticeAuthor;
	private java.sql.Date noticeDate;
	private String noticeContents;
	
}
