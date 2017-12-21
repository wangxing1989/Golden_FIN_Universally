package com.finuniversally.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.finuniversally.dao.OrderDao;
import com.finuniversally.service.OrderService;
import com.finuniversally.untils.MultipleDataSource;
import com.finuniversally.vo.StatisticsVo;

@Component
public class OrderServiceImpl implements OrderService{
	@Autowired
	private OrderDao orderDao;

	/**
	 * 获取统计数据
	 */
	@Override
	public StatisticsVo getStaticsVo(String variety) {
		//视图模型
		StatisticsVo statisticsVo = new StatisticsVo();
		
		//多总持仓
		Double multipleTotalHolding = getMultipleTotalHolding(variety);
		statisticsVo.setMultipleTotalHolding(multipleTotalHolding);

		//空总持仓
		Double emptyTotalHolding = getEmptyTotalHolding(variety);
		statisticsVo.setEmptyTotalHolding(emptyTotalHolding);
		
		//多总价
		Double multipleTotalPrice = getMultipleTotalPrice(variety);
		//空总价
		Double emptyTotalPrice = getEmptyTotalPrice(variety);
		//多总均价
		statisticsVo.setMultipleTotalAveragePrice(multipleTotalPrice/multipleTotalHolding);
		//空总均价
		statisticsVo.setEmptyTotalAveragePrice(emptyTotalPrice/emptyTotalHolding);
		//中间价
		statisticsVo.setMiddlePrice((multipleTotalPrice+emptyTotalPrice)/(multipleTotalHolding+emptyTotalHolding));
		
		return statisticsVo;
	}
	/**
	 * 获取多总持仓(cmd=0)
	 * @return
	 * @author riseSun
	
	 * 2017年12月21日下午8:18:06
	 */
	@Transactional
	private Double getMultipleTotalHolding(String variety) {
		MultipleDataSource.setDataSourceKey("dataSourceHongKong");
		Double qtys75 = orderDao.getHoldQtys("orders75",variety, 0L);
		Double qtys76 = orderDao.getHoldQtys("orders76",variety, 0L);
		return (qtys75==null ? 0 : qtys75)+(qtys76 == null ? 0:qtys76);
	}
	/**
	 * 获取空总持仓
	 * @param variety
	 * @return
	 * @author riseSun
	
	 * 2017年12月21日下午8:29:24
	 */
	@Transactional
	private Double getEmptyTotalHolding(String variety) {
		//切换香港数据库
		MultipleDataSource.setDataSourceKey("dataSourceHongKong");
		Double qtys75 = orderDao.getHoldQtys("orders75",variety, 1L);
		Double qtys76 = orderDao.getHoldQtys("orders76",variety, 1L);
		return (qtys75==null ? 0 : qtys75)+(qtys76 == null ? 0:qtys76);
	}
	
	/**
	 * 获取多总价
	 */
	@Transactional
	private Double getMultipleTotalPrice(String variety) {
		//切换香港的数据库
		MultipleDataSource.setDataSourceKey("dataSourceHongKong");
		Double totalPrice75 = orderDao.getTotalPrice("orders75", variety, 0L);
		Double totalPrice76 = orderDao.getTotalPrice("orders76", variety, 0L);
		return (totalPrice75==null ? 0 : totalPrice75)+(totalPrice76 == null ? 0:totalPrice76);
	}
	
	/**
	 * 获得空总价
	 */
	@Transactional
	private Double getEmptyTotalPrice(String variety) {
		//切换香港的数据库
		MultipleDataSource.setDataSourceKey("dataSourceHongKong");
		Double totalPrice75 = orderDao.getTotalPrice("orders75", variety, 1L);
		Double totalPrice76 = orderDao.getTotalPrice("orders76", variety, 1L);
		return (totalPrice75==null ? 0 : totalPrice75)+(totalPrice76 == null ? 0:totalPrice76);
	}
	
}
