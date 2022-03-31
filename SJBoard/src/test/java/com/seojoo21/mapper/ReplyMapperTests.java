package com.seojoo21.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.seojoo21.domain.Criteria;
import com.seojoo21.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_= {@Autowired })
	private ReplyMapper mapper;
	
	// 0. 객체 사용 가능 여부 확인 
//	@Test
//	public void testMapper() {
//		log.info(mapper);
//	}
	
	//1. 댓글을 등록한다. (Create)
//	@Test
//	public void testCreate() {
//		ReplyVO reply = new ReplyVO();
//		
//		reply.setBno(345L);
//		reply.setReply("댓글테스트1");
//		reply.setReplyer("댓글테스터");
//		reply.setUserid("member1");
//		
//		mapper.create(reply);
//		
//	}

	//2. 댓글을 가져온다. (Read)
//	@Test
//	public void testRead() {
//		Long rno = 1L;
//		ReplyVO reply = mapper.read(rno);
//		log.info(reply);
//	}
//	
	//3. 댓글을 수정한다. (Update)
//	@Test
//	public void testUpdate() {
//		Long rno = 301L;
//		
//		ReplyVO reply = mapper.read(rno);
//		
//		reply.setReply("update test");
//		reply.setUserid("member1");
//		
//		mapper.update(reply);
//	}
	
	//4. 댓글을 삭제한다. (Delete) 
//	@Test
//	public void testDelete() {
//		Long rno = 5L;
//		mapper.delete(rno);
//	}
	
	//5. 페이징 처리가 된 특정 게시물의 댓글 목록을 가져온다.
//	@Test
//	public void testGetListWithPaging() {
//		Criteria cri = new Criteria(2,10);
//		List<ReplyVO> replies = mapper.getListWithPaging(cri, 161L);
//		replies.forEach(reply -> log.info(reply));
//	}
//	
}
