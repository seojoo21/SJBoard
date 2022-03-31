package com.seojoo21.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seojoo21.domain.BoardVO;
import com.seojoo21.domain.Criteria;

// 게시판의 SQL 처리를 위한 BoardMapper Interface
public interface BoardMapper {
	
	// 1. 게시물 전체를 읽어온다. 
	public List<BoardVO> getList();
	
	// 2. 게시물을 생성한다(Create)
	public void create(BoardVO board);
	
	// 3. 특정 게시물을 조회한다.(Read)
	public BoardVO read(Long bno);
	
	// 4. 특정 게시물을 수정한다. (Update)
	public int update(BoardVO board);
	
	// 5. 특정 게시물을 삭제한다. (Delete) 
	public int delete(Long bno);
	
	// 6. 특정 게시물의 조회수를 올린다. 
	public int viewHit(Long bno);
	
	// 7. 특정 게시물의 추천수를 가져온다.
	public int updateLikeHit(Long bno, int amount);

	// 8. 페이징 및 검색 처리를 하여 게시물 전체를 읽어온다. 
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	// 9. 전체 게시물의 개수를 구한다.
	public int getTotalCount(Criteria cri);
	
	// 10. 댓글 수를 업데이트 한다. (게시물 제목 옆에 댓글 수가 자동으로 뜨도록 하기 위함) 
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	// 11. 최신 게시물을 가져온다.
	public List<BoardVO> getRecentList(Criteria cri);
	
	// 12. 인기 게시물을 가져온다. 
	public List<BoardVO> getLikeHitList(Criteria cri);
}
