package com.ezen.spring.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository("orderDAO")
@Slf4j
public class OrderDAO {

	@Autowired
	@Qualifier("orderMapper")
	private OrderMapper orderMapper;

	public int getMaxOrderNum() {
		return orderMapper.getMaxOrderNum();
	}

	public boolean addOrder(Order order) {
		return orderMapper.addOrder(order)>0;
	}
}
