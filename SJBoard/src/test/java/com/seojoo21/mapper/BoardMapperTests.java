package com.seojoo21.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.seojoo21.domain.BoardVO;
import com.seojoo21.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_=@Autowired)
	public BoardMapper mapper;
	
	
	// 1. 게시물 전체를 읽어온다. 
//	@Test
//	public void testGetList() {
//		mapper.getList().forEach(board -> log.info(board));
//		
//	}
	
	// 2. 게시물을 생성한다(Create)
//	@Test
//	public void testCreate() {
//		BoardVO board = new BoardVO();
//		
//		board.setTitle("STS 생성 테스트");
//		board.setContent("STS 생성 테스트");
//		board.setWriter("STS 테스터");
//		board.setUserid("member1");
//		
//		mapper.create(board);
//		
//		log.info(board);
//		
//	}
	
	// 3. 특정 게시물을 조회한다.(Read)
//	@Test
//	public void testRead() {
//		BoardVO board = mapper.read(101L);
//		
//		log.info(board);
//		
//	}
	
	// 4. 특정 게시물을 수정한다. (Update)
//	@Test
//	public void testUpdate() {
//		
//		BoardVO board = new BoardVO();
//	
//		board.setBno(341L);
//		board.setTitle("수정된 제목");
//		board.setContent("수정된 내용");
//		board.setWriter("user00");
//		board.setUserid("member1");
//		
//		int count = mapper.update(board);
//		log.info("UPDATE COUNT: " + count);
//		
//	}
	// 5. 특정 게시물을 삭제한다. (Delete) 
//	@Test
//	public void testDelete() {
//		log.info("DELETE COUNT" + mapper.delete(101L));
//		
//	}
	
	// 6. 특정 게시물의 조회수를 올린다. 조회수 올라갈 시 값 1 반환 
//	@Test
//	public void testViewHit() {
//		
//		int count = mapper.viewHit(99L);
//		log.info("VIEWHIT COUNT:" + count);
//	
//	}
	
	// 7. 특정 게시물의 추천수를 올린다. 추천수 올라갈 시 값 1 반환 
//	@Test
//	public void testUpdateRec() {
//		
//		int count = mapper.updateRec(182L);
//		log.info("UpdateRec COUNT:" + count);
//	}
	
	// 7.1 특정 게시물의 추천수를 내린다. 추천수 내려갈 시 값 1 반환 
//	@Test
//	public void testUpdateRecCancel() {
//		int count = mapper.updateRecCancel(182L);
//		log.info("UpdateRecCancel count: " + count);
//	}
	
	
	// 8. 페이징 처리를 하여 게시물 전체를 읽어온다.
//	@Test
//	public void testGetListWithPaging() {
//		
//		Criteria cri = new Criteria();
//		cri.setPageNum(2);
//		cri.setAmount(10);
//		
//		List<BoardVO> list = mapper.getListWithPaging(cri);
//		list.forEach(board -> log.info(board.getBno()));
//	}
	
	// 9. 검색 처리 테스트 
//	@Test
//	public void testSearch() {
//		Criteria cri = new Criteria();
//		cri.setType("TWC");
//		cri.setKeyword("테스트");
//		
//		List<BoardVO> list = mapper.getListWithPaging(cri);
//		list.forEach(board -> log.info(list));
//	}
	
	// 10. 최신 게시물을 가져온다.
//	@Test
//	public void testGetRecentList() {
//		Criteria cri = new Criteria();
//		cri.setPageNum(1);
//		cri.setAmount(5);
//		
//		List<BoardVO> list = mapper.getRecentList(cri);
//		list.forEach(board -> log.info(board.getBno()));
//		
//	}
	
	// 11. 인기 게시물을 가져온다. 
//	@Test
//	public void testGetLikeHitList() {
//		Criteria cri = new Criteria();
//		
//		cri.setPageNum(1);
//		cri.setAmount(2);
//		
//		List<BoardVO> list = mapper.getLikeHitList(cri);
//		list.forEach(board -> log.info(board.getBno()));
//	}
}
