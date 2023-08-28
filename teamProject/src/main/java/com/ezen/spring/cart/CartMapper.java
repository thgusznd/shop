package com.ezen.spring.cart;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component("cartMapper")
@Mapper
public interface CartMapper {

	public int addCart(Cart cart);

	public int cartClear(String memberID);

	public List<Cart> getList(String memberID);

	public int updateCart(Cart cart);

	public int cartDelete(int cartNum);

	public Cart getCart(Cart cart);

	public Cart getCartByCartNum(int cartNum);

}
 