package com.seojoo21.service;

import java.util.List;

import com.seojoo21.domain.BoardAttachVO;
import com.seojoo21.domain.BoardVO;
import com.seojoo21.domain.Criteria;

public interface BoardService {
	
	// 1. 전체 게시물 목록을 조회한다.    
	public List<BoardVO> getList();
	
	// 2. 신규 게시물을 등록한다. 
	public void register(BoardVO board);
	
	// 3. 특정 게시물을 조회한다.
	public BoardVO get(Long bno);
	
	// 4. 특정 게시물을 수정한다. 
	// 엄격하게 처리하기 위해서 Boolean 타입으로 처리한다. 
	public boolean modify(BoardVO board);
	
	// 5. 특정 게시물을 삭제한다.
	// 엄격하게 처리하기 위해서 Boolean 타입으로 처리한다. 
	public boolean remove(Long bno);
	
	// 6. 특정 게시물의 조회수를 올린다.
	public void viewCount(Long bno);
	
	// 8. 페이징 처리를 하여 전체 게시물 목록을 조회한다. 
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	// 9. 전체 게시물의 개수를 구한다.
	public int getTotal(Criteria cri);
	
	// 10. 해당 게시물의 첨부파일 목록을 가져온다. 
	public List<BoardAttachVO> getAttachList(Long bno);
	
	// 11. 최신 게시물을 가져온다.
	public List<BoardVO> getRecentList(Criteria cri);
	
	// 12. 인기 게시물을 가져온다. 
	public List<BoardVO> getLikeHitList(Criteria cri);


}
