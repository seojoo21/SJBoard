package com.seojoo21.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.seojoo21.domain.Criteria;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class BoardServiceTests {
	
	@Setter(onMethod_= {@Autowired })
	private BoardService service;
	
	// 0. BoardService 객체 주입 가능한지 확인 작업
//	@Test
//	public void testExist() {
//		log.info(service);
//		assertNotNull(service);
//	}
	
	// 1. 게시물 전체를 읽어온다.
//	@Test
//	public void testGetList() {
//		service.getList().forEach(board -> log.info(board));
//		
//	}
	
	// 2. 게시물을 생성한다.
//	@Test
//	public void testRegister() {
//		BoardVO board = new BoardVO();
//		board.setTitle("reigster test");
//		board.setContent("test");
//		board.setWriter("admin00");
//		
//		service.register(board);
//		log.info("생성된 게시물 번호:" + board.getBno());
//	}
	
	// 3. 특정 게시물을 조회한다.		
//	@Test
//	public void testGet() {
//		BoardVO board = service.get(102L);
//		System.out.println(board);
//	}
	
	// 4. 특정 게시물을 수정한다. 
//	@Test
//	public void testModify() {
//		BoardVO board = service.get(102L);
//		
//		if(board==null) {
//			return;
//		} else {
//			board.setTitle("제목 수정합니다.");
//			board.setContent("내용도 수정합니다.");
//			board.setWriter("새로운 작성자");
//			
//			log.info("Modify Result : " + service.modify(board));
//			
//		}
//		
//	}
	// 5. 특정 게시물을 삭제한다.
//	@Test
//	public void testRemove() {
//		log.info("Remove Result: " +service.remove(99L));
//	}
	
	// 6. 특정 게시물의 조회수를 올린다.
//	@Test
//	public void testGetViewHit() {
//		service.viewCount(102L);
//	}
	
	// 8. 페이징 처리를 하여 전체 게시물 목록을 조회한다. 
//	@Test
//	public void testGetListWithPaging() {
//		service.getListWithPaging(new Criteria(1,10)).forEach(board -> System.out.println(board));
//	}
	
	// 11. 최신 게시물을 가져온다.
//	@Test
//	public void testGetRecentList() {
//		service.getRecentList(new Criteria(1,5)).forEach(board -> System.out.println(board));
//	}
	
	// 12. 인기 게시물을 가져온다.
//	@Test
//	public void testGetLikeList() {
//		service.getLikeHitList(new Criteria(1,5)).forEach(board -> System.out.println(board));
//	}
}

