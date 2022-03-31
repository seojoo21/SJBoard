package com.seojoo21.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.seojoo21.domain.Criteria;
import com.seojoo21.domain.ReplyVO;

public interface ReplyMapper {
	
	//1. 댓글을 등록한다. (Create)
	public int create(ReplyVO reply);
	//2. 댓글을 가져온다. (Read)
	public ReplyVO read(Long bno);
	//3. 댓글을 수정한다. (Update)
	public int update(ReplyVO reply);
	//4. 댓글을 삭제한다. (Delete) 
	public int delete(Long bno);
	//5. 페이징 처리가 된 특정 게시물의 댓글 목록을 가져온다.
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
	//6. 게시물별 전체 댓글의 개수를 구한다.
	public int getReplyCountByBno(Long bno);
}
