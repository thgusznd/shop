package com.ezen.spring.item;

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
@EqualsAndHashCode(exclude= {"itemAttachName","itemAttachParentsNum","itemAttachFileSize","itemAttachFileContentType"})
public class ItemAttach {

	private int itemAttachNum;
	private String itemAttachName;
	private int itemAttachParentsNum;
	private float itemAttachFileSize;
	private String itemAttachFileContentType;
	
}
