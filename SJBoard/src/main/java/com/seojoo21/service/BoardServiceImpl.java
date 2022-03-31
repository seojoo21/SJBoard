package com.seojoo21.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.seojoo21.domain.BoardAttachVO;
import com.seojoo21.domain.BoardVO;
import com.seojoo21.domain.Criteria;
import com.seojoo21.mapper.BoardAttachMapper;
import com.seojoo21.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
// 이 클래스는 비즈니스 영역을 구현하는 클래스이다.  
public class BoardServiceImpl implements BoardService {
	
	// 비즈니스 영역 구현을 위해 BoardMapper 객체를 가져온다. 
	@Setter(onMethod_= {@Autowired})
	private BoardMapper mapper;
	
	// 게시물 내 파일 첨부를 위해 BoardAttachMapper 객체를 가져온다. 
	@Setter(onMethod_= {@Autowired})
	private BoardAttachMapper attachMapper;
	
	// 1. 게시물 전체를 읽어온다. 
	@Override
	public List<BoardVO> getList() {
		log.info("getList...............");
		return mapper.getList();
	}
	
	// 2. 게시물을 생성한다.
	@Transactional // 파일 첨부 기능을 위한 트랜잭션 처리 
	@Override
	public void register(BoardVO board) {
		log.info("register..............." + board);
		mapper.create(board);
		
		if(board.getAttachList()==null || board.getAttachList().size() <= 0 ) { return; }
		
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
			});
	}
	
	// 3. 특정 게시물을 조회한다.
	@Override
	public BoardVO get(Long bno) {
		log.info("get................" + bno);
		return mapper.read(bno);
	}
	
	// 4. 특정 게시물을 수정한다.	정상적으로 수정이 이루어지면 1이라는 값 반환 
	// 4-1. 게시물 수정 시 첨부파일도 함께 수정되도록 트랜잭션 처리
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify................" + board);
		
		attachMapper.deleteAll(board.getBno());
		
		boolean modifyResult = mapper.update(board) == 1;
		
		if (modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
				});
		}
		
		return modifyResult;
	}
	
	// 5. 특정 게시물을 삭제한다. 정상적으로 수정이 이루어지면 1이라는 값 반환 	
	// 5-1. 게시물 삭제 시 첨부파일도 함께 삭제 되도록 트랜잭션 처리  
	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove................" + bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}
	
	// 6. 특정 게시물의 조회수를 올린다. 
	@Override
	public void viewCount(Long bno) {
		log.info("getViewHit................" + bno);
		mapper.viewHit(bno);
	}
	
	// 8. 페이징 처리를 하여 전체 게시물 목록을 조회한다. 
	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		log.info("getListWithPaging........");
		return mapper.getListWithPaging(cri);
	}
	
	// 9. 전체 게시물의 개수를 구한다.
	@Override
	public int getTotal(Criteria cri) {
		log.info("getTotalAmount......");
		return mapper.getTotalCount(cri);
	}
	
	// 10. 해당 게시물의 첨부파일 목록을 가져온다. 
	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get AttachList by Bno" + bno);
		return attachMapper.findByBno(bno);
	}
	
	// 11. 최신 게시물을 가져온다.
	@Override
	public List<BoardVO> getRecentList(Criteria cri) {
		log.info("get Recent List.......");
		return mapper.getRecentList(cri);
	}
	
	// 12. 인기 게시물을 가져온다. 
	@Override
	public List<BoardVO> getLikeHitList(Criteria cri) {
		log.info("get Like List........");
		return mapper.getLikeHitList(cri);
	}


}
