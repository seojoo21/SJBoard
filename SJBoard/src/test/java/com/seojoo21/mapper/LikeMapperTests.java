package com.seojoo21.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.seojoo21.domain.LikeVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Slf4j
public class LikeMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private LikeMapper likeMapper;

	// 게시글을 추천한다. 
//	@Test
//	public void testUpdateLike() {
//		LikeVO vo = new LikeVO();
//		vo.setBno(348L);
//		vo.setUserid("admin1");
//		int count = likeMapper.updateLike(vo.getBno(), vo.getUserid());
//		log.info("count : " + count);
//	}
	
	// 게시글 추천 여부를 확인한다.
//	@Test
//	public void testCheckLike() {
//		LikeVO vo = new LikeVO();
//		vo.setBno(348L);
//		vo.setUserid("admin1");
//		LikeVO list = likeMapper.checkLike(vo.getBno(), vo.getUserid());
//		log.info("list : " + list.toString());
//	}
	
	// 게시글 추천 수를 가져온다.
	@Test
	public void testGetLikeNo() {
		LikeVO vo = new LikeVO();
		vo.setBno(345L);
		Long result = likeMapper.getLikeNo(vo.getBno());
		log.info("LikeNo : " + result);
	}
}
