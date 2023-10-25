package com.ezen.spring.cart;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Repository("cartDAO")
@Slf4j
public class CartDAO {

	@Autowired
	@Qualifier("cartMapper")
	private CartMapper cartMapper;

	@Transactional
	public boolean addCart(Cart cart) {
		return cartMapper.addCart(cart) > 0;
	}

	public List<Map<String, String>> getList(String memberID) {
		return cartMapper.getList(memberID);
	}

	public boolean cartClear(String memberID) {
		return cartMapper.cartClear(memberID)>0;
	}
	
	public boolean updateCart(Cart cart) 
	{
		return cartMapper.updateCart(cart)>0;
	}
	
	public int delete(int cartNum) 
	{
		return cartMapper.cartDelete(cartNum);
	}

	public Cart getCart(Cart cart) 
	{
		return cartMapper.getCart(cart);
	}
	
	public Map<String, Object> getCartByCartNum(int cartNum) 
	{
		return cartMapper.getCartByCartNum(cartNum);
	}

}
