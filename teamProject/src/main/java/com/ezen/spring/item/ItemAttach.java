package com.ezen.spring.item;

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
@EqualsAndHashCode(exclude= {"itemAttachName","itemAttachParentsNum","itemAttachFileSize","itemAttachFileContentType"})
public class ItemAttach {

	private int itemAttachNum; //상품 이미지 번호 
	private String itemAttachName; //상품 이미지
	private int itemAttachParentsNum; //이미지 관련 상품 번호 
	private float itemAttachFileSize; //상품 이미지 파일 사이즈 
	private String itemAttachFileContentType; //상품 이미지 파일 타입 
	
}
