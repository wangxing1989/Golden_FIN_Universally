package com.finuniversally.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import com.finuniversally.dao.VarietyDao;
import com.finuniversally.model.Variety;
import com.finuniversally.service.VarietyService;

@Component
@Transactional
public class VarietyServiceImpl implements VarietyService{
	@Autowired
	private VarietyDao varietyDao;
	
	@Override
	public List<Variety> getVarietys() {
		return varietyDao.getVarietys();
	}
}