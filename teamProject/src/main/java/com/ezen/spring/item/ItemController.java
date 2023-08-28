package com.ezen.spring.item;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.spring.item.ItemAttach;
import com.ezen.spring.member.Member;
import com.ezen.spring.member.MemberDAO;
import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/item")
@Slf4j
@SessionAttributes("memberID")
public class ItemController {

	@Autowired
	@Qualifier("itemDAO")
	private ItemDAO itemDAO;
	
	@Autowired
	@Qualifier("memberDAO")
	private MemberDAO memberDAO;
	
	@Autowired
	private ItemSvc itemSvc;
	
	@GetMapping("/") //test
	@ResponseBody
	public String test()
	{
		return "서버 정상 실행 test";
	}
	
	//판매 상품 추가 폼 띄우기 및 DB 저장 
	@GetMapping("/add")
	public String add() {
		return "item/itemAddForm";
	}
	
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> add(
							@RequestParam("items")MultipartFile[] mfiles,
							HttpServletRequest request,
							Item item)
	{
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/items");
		
		List<ItemAttach> attList = new ArrayList<>();
		try {
			for(int i=0;i<mfiles.length;i++) {
				if(mfiles[0].getSize()==0) continue;
				String originName = mfiles[i].getOriginalFilename();
				mfiles[i].transferTo(
				  new File(savePath+"/"+originName));
				/* MultipartFile 주요 메소드 */
				String cType = mfiles[i].getContentType();
				String pName = mfiles[i].getName();
				Resource res = mfiles[i].getResource();
				long fSize = mfiles[i].getSize();
				boolean empty = mfiles[i].isEmpty();
				
				ItemAttach att = new ItemAttach();
				att.setItemAttachName(originName);
				att.setItemAttachFileSize(fSize/1024);
				att.setItemAttachFileContentType(cType);
				
				attList.add(att);
			}
			
			item.setAttList(attList);
			boolean added = itemDAO.addItem(item);
			Map<String, Object> map = new HashMap<>();
			map.put("added", added);
			map.put("itemNum", item.getItemNum());
			return map;
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}
		Map<String, Object> map = new HashMap<>();
		map.put("added", false);
		return map;
	}
	
	@GetMapping("/detail/{itemNum}") //아이템 상세보기 
	public String getBoard(@PathVariable int itemNum, @SessionAttribute(name="memberID",required = false) String memberID, Model model)
	{
		Item item = itemSvc.getItem(itemNum);
		model.addAttribute("item", item); 
		Member member = memberDAO.getMember(memberID);
		model.addAttribute("member",member);
		return "item/itemDetail";
	}
	
	@GetMapping("/list/page/{pageNum}")
	public String getList(@PathVariable int pageNum, 
						  @RequestParam(value="keyword", required=false) String keyword,
						  Model model) 
	{
		PageInfo<Map> pageInfo = null;
		//if(keyword!=null) { //검색결과 목록
		//	pageInfo = itemDAO.search(keyword, pageNum);
		//	model.addAttribute("keyword", keyword);
		//}else {
			pageInfo = itemDAO.getList(pageNum);
		//}
		model.addAttribute("pageInfo", pageInfo);
		return "item/itemList";
	}
	//카테고리별 리스트 
	@GetMapping("/list/page/{pageNum}/{category}")
	public String getCategoryList(@PathVariable int pageNum,
								  @PathVariable String category, 
								  @RequestParam(value="keyword", required=false) String keyword,
								  Model model) 
	{
		PageInfo<Map> pageInfo = null;
		//if(keyword!=null) { //검색결과 목록
		//	pageInfo = itemDAO.search(keyword, pageNum);
		//	model.addAttribute("keyword", keyword);
		//}else {
			pageInfo = itemDAO.getCategoryList(pageNum,category);
		//}
		model.addAttribute("pageInfo", pageInfo);
		return "item/itemList";
	}
	//아이템 디테일 수정
	@GetMapping("/editForm/{itemNum}")
	public String editForm(@PathVariable int itemNum, Model model)
	{
		Item item = itemSvc.getItem(itemNum);
		model.addAttribute("item", item);
		return "item/itemEditForm";
	}
	@PostMapping("/update")
	@ResponseBody
	public Map<String, Object> update(Item item)
	{
		boolean updated = itemDAO.update(item);
		Map<String, Object> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}
	//아이템 삭제 
	@GetMapping("/delete/{itemNum}")
	@ResponseBody
	public Map<String, Boolean> delItem(@PathVariable int itemNum)
	{
		boolean deleteItem = itemDAO.delete(itemNum);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleteItem", deleteItem);
		return map;
	}
	//이미지 추가 
	@PostMapping("/addAttach")
	@ResponseBody
	public Map<String, Boolean> addAttach(@RequestParam("files")MultipartFile[] mfiles,
							HttpServletRequest request,
							@RequestParam("itemAttachParentsNum") int itemAttachParentsNum)
	{
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/items");
		
		List<ItemAttach> attList = new ArrayList<>();
		try {
			for(int i=0;i<mfiles.length;i++) {
				if(mfiles[0].getSize()==0) continue;
				String originName = mfiles[i].getOriginalFilename();
				mfiles[i].transferTo(
				  new File(savePath+"/"+originName));
				/* MultipartFile 주요 메소드 */
				String cType = mfiles[i].getContentType();
				String pName = mfiles[i].getName();
				Resource res = mfiles[i].getResource();
				long fSize = mfiles[i].getSize();
				boolean empty = mfiles[i].isEmpty();
				
				ItemAttach itemAttach = new ItemAttach();
				itemAttach.setItemAttachParentsNum(itemAttachParentsNum);
				itemAttach.setItemAttachName(originName);
				itemAttach.setItemAttachFileSize(fSize);
				itemAttach.setItemAttachFileContentType(cType);
				
				attList.add(itemAttach);
			}

			boolean addAttach = itemDAO.addAttach(attList);
			Map<String, Boolean> map = new HashMap<>();
			map.put("addAttach", addAttach);
			return map;
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		Map<String, Boolean> map = new HashMap<>();
		map.put("added", false);
		return map;
	}
	//이미지 삭제 
	@PostMapping("/deleteAttach")
	@ResponseBody
	public Map<String, Boolean> deleteAttach(@RequestParam("itemAttachNum") int itemAttachNum, 
											@RequestParam("itemAttachName") String itemAttachName,
											HttpServletRequest request)
	{
		boolean deleteAttach = itemSvc.deleteAttach(itemAttachNum,itemAttachName, request);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleteAttach", deleteAttach);
		return map;
	}
}
