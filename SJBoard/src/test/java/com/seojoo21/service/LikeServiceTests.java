package com.seojoo21.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.seojoo21.domain.LikeVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class LikeServiceTests {
	
	@Setter(onMethod_= {@Autowired })
	private LikeService service;
	
	// LikeService 객체 주입 가능한지 확인 작업
//	@Test
//	public void testExist() {
//		log.info("Service: " + service);
//		assertNotNull(service);
//	}
	
	// 게시글을 추천한다. 
//	@Test
//	public void testUpdateLike() {
//		LikeVO vo = new LikeVO();
//		vo.setBno(348L);
//		vo.setUserid("admin1");
//		int count = service.updateLike(vo.getBno(), vo.getUserid());
//		log.info("Update Like Count" + count);
//	}
	
	// 게시글 추천 여부를 확인한다.
	@Test
	public void testCheckLike() {
		LikeVO vo = new LikeVO();
		vo.setBno(348L);
		vo.setUserid("admin1");
		LikeVO list = service.checkLike(vo.getBno(), vo.getUserid());
		log.info("list : " + list.toString());
	}
}

