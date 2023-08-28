package com.ezen.spring.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/cart")
@Slf4j
@SessionAttributes("memberID")
public class CartController {

	@Autowired
	@Qualifier("cartDAO")
	private CartDAO cartDAO;
	
	@GetMapping("/") //test
	@ResponseBody
	public String test()
	{
		return "서버 정상 실행 test";
	}
	
	@PostMapping("/addCart") //장바구니에 담기 
	@ResponseBody
	public Map<String, Object> add(@SessionAttribute(name = "memberID", required = false) String memberID,
	                               @RequestParam int itemNum,
	                               @RequestParam int price,
	                               @RequestParam int quantity) {
		Map<String, Object> map = new HashMap<>();
		if(memberID==null) {
			map.put("added", false);
			map.put("msg", "로그인을 해주세요.");
		}
		//방금 장바구니에 담긴 cart 객체 
		Cart cart = new Cart();
		cart.setItemNum(itemNum);
		cart.setPrice(price);
		cart.setQuantity(quantity);
		cart.setMemberID(memberID);
		
		Cart existingCart = cartDAO.getCart(cart);
		if(existingCart != null) {
			//이미 장바구니에 같은 아이템이 있는 경우 수량만 증가 
			int existingQty = existingCart.getQuantity();
			existingCart.setQuantity(existingQty + quantity);
			
			boolean updated = cartDAO.updateCart(existingCart);
			map.put("added", updated);
		}
		else {
			boolean addCart = cartDAO.addCart(cart);
			map.put("added", addCart);
		}
	    map.put("itemNum", itemNum);
	    return map;  
	}
	
	@GetMapping("/list")  
	public String cartList(Model model, @SessionAttribute(name="memberID",required = false) String memberID)
	{
		List<Cart> list = cartDAO.getList(memberID);
		model.addAttribute("list", list);
		model.addAttribute("memberID", memberID);
		return "cart/cartList";
	}
	
	@PostMapping("/update")  
	@ResponseBody
	public Map<String, Object> updateResult(@RequestParam int cartNum, @RequestParam int quantity)
	{
		Cart cart = new Cart();
		cart.setCartNum(cartNum);
		cart.setQuantity(quantity);
		
		boolean updated = cartDAO.updateCart(cart);
		Map<String, Object> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}
	
	@PostMapping("/delete")  //삭제
	@ResponseBody
	public Map<String, Object> delete(@SessionAttribute(name="memberID",required = false) String memberID, 
									  @RequestBody List<Integer> cartNums)
	{
		Map<String, Object> map = new HashMap<>();
		List<Cart> cart = cartDAO.getList(memberID);

		if(cart==null) {
			map.put("deleted", false);
		}else {
			for(int i=0;i<cartNums.size();i++) {
				cartDAO.delete(cartNums.get(i));            
			} 
			map.put("deleted", true);
		}
		return map;
	}
	
	@PostMapping("/clear") //장바구니 비우기
	@ResponseBody
	public Map<String,Object> cartClear(@SessionAttribute(name="memberID",required = false) String memberID){
		Map<String, Object> map = new HashMap<>();
		
		List<Cart> cartList = cartDAO.getList(memberID);
		if(cartList==null) {
			map.put("msg", "장바구니가 비어있습니다.");
		} else {
			boolean cleared = cartDAO.cartClear(memberID);
			map.put("cleared", cleared);
		}
		return map;
	}

}
