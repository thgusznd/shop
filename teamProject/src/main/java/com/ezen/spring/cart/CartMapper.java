package com.ezen.spring.cart;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component("cartMapper")
@Mapper
public interface CartMapper {

	public int addCart(Cart cart);

	public int cartClear(String memberID);

	public List<Map<String, String>> getList(String memberID);

	public int updateCart(Cart cart);

	public int cartDelete(int cartNum);

	public Cart getCart(Cart cart);

	public Map<String, Object> getCartByCartNum(int cartNum);

}
 