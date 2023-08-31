package com.ezen.spring.review;

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
@EqualsAndHashCode(exclude= {"reviewAttachFileSize","reviewAttachFileContentType"})
public class ReviewAttach
{
	private int reviewAttachNum;
	private String reviewAttachName;
	private int reviewAttachParentsNum;
	private float reviewAttachFileSize;
	private String reviewAttachFileContentType;
	
}