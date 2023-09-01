package com.ezen.spring.item;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ItemSvc {
	
	@Autowired
	private ItemDAO itemDAO;
	
	public Item getItem(int itemNum) 
	{
		List<Map<String, String>> list = itemDAO.getItem(itemNum);
		
		Item item = getItemIn(list.get(0));
		item.setAttList(new ArrayList<ItemAttach>());
		
		for(int i=0;i<list.size();i++) { 
			Map<String, String> m = list.get(i);
			List<ItemAttach> attList = getAttachIn(m);
	        item.setAttList(attList);
		}
		return item;
	}
	
	private Item getItemIn(Map m) 
	{
		int itemNum = Integer.parseInt( m.get("itemNum").toString());
		String goods = m.get("goods").toString();
		int price = Integer.parseInt(m.get("price").toString());
		int purchaseCnt = Integer.parseInt(m.get("purchaseCnt").toString());
		int CartCnt = Integer.parseInt(m.get("CartCnt").toString());
		String category = m.get("category").toString();
		String explains = m.get("explains").toString();
		String hashtag = m.get("hashtag").toString();
		int inventory = Integer.parseInt(m.get("inventory").toString());

		Item item = new Item();
		item.setItemNum(itemNum);
		item.setGoods(goods);
		item.setPrice(price);
		item.setPurchaseCnt(purchaseCnt);
		item.setCartCnt(CartCnt);
		item.setCategory(category);
		item.setExplains(explains);
		item.setHashtag(hashtag);
		item.setInventory(inventory);
		
		return item;
	}
	
	private List<ItemAttach> getAttachIn(Map m) 
	{
		if(m.get("fnames")==null) return null;
		
		//콤마로 구분된 데이터를 쪼개서 각각의 Attach 오브젝트를 생성한다
	    String anums = m.get("fnums").toString();
        String fnames = m.get("fnames").toString();
        String fsizes = m.get("fsizes").toString();
        String contenttypes = m.get("contenttypes").toString();
        
        String[] afnum = anums.split(",");
        String[] afname = fnames.split(",");
        String[] afsize = fsizes.split(",");
        String[] contenttype = contenttypes.split(",");
        

        List<ItemAttach> attlist = new ArrayList<>();
        for(int i=0; i<afnum.length; i++) 
        {
           int fnum = Integer.parseInt(afnum[i]);
           float fsize = Float.parseFloat(afsize[i]);
           String fname = afname[i];
           String ftype = contenttype[i];
           
           ItemAttach att = new ItemAttach();
           att.setItemAttachNum(fnum);
           att.setItemAttachName(fname);
           att.setItemAttachFileSize(fsize);
           att.setItemAttachFileContentType(contenttypes);
           
           attlist.add(att);
        }
        return attlist;

	}

	@Transactional
	public boolean deleteAttach(int itemAttachNum, String itemAttachName, HttpServletRequest request) 
	{	
		//DB에서 삭제 
		boolean deleteAttachByDB = itemDAO.deleteAttach(itemAttachNum);  

		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/WEB-INF/items");
		File deleteFile = new File(savePath, itemAttachName);

		//서버 저장소에서 삭제
		boolean deleteAttachByServer = deleteFile.delete(); 
		
		return deleteAttachByDB && deleteAttachByServer;
	}

	//Best item Top 10 가져오기 
	public List<Map<String, String>> getTopItems(int limit) {
	    return itemDAO.getTopItems(limit);
	}
}
