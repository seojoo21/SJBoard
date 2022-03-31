package com.seojoo21.service;

import java.util.List;

import com.seojoo21.domain.Criteria;
import com.seojoo21.domain.ReplyPageDTO;
import com.seojoo21.domain.ReplyVO;

public interface ReplyService {
	
	// 1. 댓글 등록
	public int register(ReplyVO reply);
	// 2. 댓글 조회
	public ReplyVO get(Long rno);
	// 3. 댓글 수정 
	public int modify(ReplyVO reply);
	// 4. 댓글 삭제 
	public int remove(Long rno);
	// 5. 댓글 목록 조회 
	public List<ReplyVO> getList(Criteria cri, Long bno);
	// 6. 댓글 목록 조회 (페이징 처리) 
	public ReplyPageDTO getListPage(Criteria cri, Long bno);

}
