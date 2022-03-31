package com.seojoo21.service;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ChartServiceTests {
	
	@Setter(onMethod_= {@Autowired})
	private ChartService service;
	
//	@Test
//	public void testGetBnoNoByPeriod() {
//		log.info("=======================");
//		log.info("TEST RESULT...............");
//		log.info(service.getBnoNoByPeriod("2022-03-20", "2022-03-27"));
//	}
	
//	@Test
//	public void testGetRnoNoByPeriod() {
//		log.info("=======================");
//		log.info("TEST RESULT...............");
//		log.info(service.getRnoNoByPeriod("2022-03-22", "2022-03-30"));
//	
//	}
	
	@Test 
	public void testGetMemberNoByPeriod() {
		log.info("=======================");
		log.info("TEST RESULT...............");
		log.info(service.getMemberNoByPeriod("2022-03-30", "2022-03-30"));
	
	}
}
