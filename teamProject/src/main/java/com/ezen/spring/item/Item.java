package com.ezen.spring.item;

import java.util.List;

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
@EqualsAndHashCode(exclude= {"goods","price","purchaseCnt","CartCnt","category","explains","hashtag"})
public class Item {

	private int itemNum; //아이템번호 
	private String goods; //품명 
	private String option1; //옵션1
	private String option2; //옵션2
	private int price; //가격 
	private int purchaseCnt; //구매횟수 
	private int CartCnt; //장바구니에 담긴 횟수 
	private String category; //카테고리 
	private String explains; //상품설명 
	private String hashtag; //해시태그 
	private int inventory; //재고 수량 
	
	private List<ItemAttach> attList;
}
