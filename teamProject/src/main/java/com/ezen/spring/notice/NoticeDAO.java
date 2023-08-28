package com.ezen.spring.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Repository("noticeDAO")
@Slf4j
public class NoticeDAO {

	@Autowired
	@Qualifier("noticeMapper")
	private NoticeMapper noticeMapper;

	@Transactional
	public boolean addNotice(Notice notice) {
		return noticeMapper.addNotice(notice)>0;
	}

	public List<Notice> getList() {
		List<Notice> noticeList = noticeMapper.getList();
		return noticeList;
	}

	public Notice getNotice(int noticeNum) {
		Notice notice = noticeMapper.getNotice(noticeNum);
		return notice;
	}

	public boolean update(Notice notice) {
		return noticeMapper.updated(notice)>0;
	}

	public boolean delete(int noticeNum) {
		return noticeMapper.deleted(noticeNum)>0;
	}
}
