package com.ezen.spring.item;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component("itemMapper")
@Mapper
public interface ItemMapper {

	public int addAndGetKey(Item item);

	public int addAttach(List<ItemAttach> attList);

	public List<Map<String,String>> getItem(int itemNum); //아이템 가져오기 

	public List<Map<String, String>> getList(); //아이템 리스트 가져오기 
	
	public List<Map<String, String>> getCategoryList(String category); //카테고리별 리스트 가져오기 

	public int delItem(int itemNum); //아이템 삭제 

	public int update(Item item); //아이템 수정 

	public int deleteAttach(int itemAttachNum); //첨부파일 삭제 

	public List<Map<String, String>> getTopItems(int limit); //아이템 best top 10 가져오기 
	
}
