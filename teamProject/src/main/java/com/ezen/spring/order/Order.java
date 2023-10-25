package com.ezen.spring.order;

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
public class Order {

	//기본 정보 
	private int orderNum; //주문번호 
	private int itemOrderNum; //상품 주문번호 
	private java.sql.Date paymentDate; //결제일 
	private int itemNum; //상품번호 
	private int quantity; //수량 
	private String buyer; //구매자 아이디 
	private String paymentMethod; //결제방법 
	private String orderStatus; //주문상태 
	
	//할인 관련 
	private int itemSellingPrice; //판매가 
	private int reserveDiscount; //적립금 할인 금액 
	private int itemPaymentAmount; //최종 상품 결제 금액 
	
	//배송지 관련 
	private String payeeName; //수취인명 
	private String Contact; //연락처 
	private String shippingAddress; //배송지 주소 
	private String shippingNote; //배송메모 
	
}
