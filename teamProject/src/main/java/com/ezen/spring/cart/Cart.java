package com.ezen.spring.cart;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Component
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class Cart {

	private int cartNum; //카트 번호  
	private int itemNum; //아이템 번호 
	private String optionInformation; //옵션정보 
	private int price; //가격 
	private int quantity; //수량 
	private String memberID; //회원 아이디 
	
}
