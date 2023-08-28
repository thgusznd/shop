package com.ezen.spring.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component("noticeMapper")
@Mapper
public interface NoticeMapper {

	public int addNotice(Notice notice);

	public List<Notice> getList();

	public Notice getNotice(int noticeNum);

	public int updated(Notice notice);

	public int deleted(int noticeNum);

}
