package com.seojoo21.mapper;

import java.util.List;
import java.util.Map;

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
public class ChartMapperTests {
	
	@Setter(onMethod_=@Autowired)
	public ChartMapper mapper;
	
	// 기간별 게시글 수 확인 
//	@Test
//	public void testGetBoardNoByPeriod() {
//		
//		log.info("==========================");
//		List<Map<String, Object>> list = mapper.getBoardNoByPeriod("2022-03-20", "2022-03-27");
//		log.info("List : " + list);
//		log.info("List Size : " + list.size());
//		log.info("list.get(0).get(\"REGDATE\"): " + list.get(0).get("REGDATE"));
//		log.info("list.get(0).get(\"CNT\"): " + list.get(0).get("CNT"));
//		
//	}
	
	// 기간별 댓글 수 확인 
	@Test
	public void testGetReplyNoByPeriod() {
		
		log.info("==========================");
		List<Map<String, Object>> list = mapper.getReplyNoByPeriod("2022-03-22", "2022-03-30");
		log.info("List : " + list);
		log.info("List Size : " + list.size());
		log.info("list.get(0).get(\"REGDATE\"): " + list.get(0).get("REGDATE"));
		log.info("list.get(0).get(\"CNT\"): " + list.get(0).get("CNT"));
		
	}
}
