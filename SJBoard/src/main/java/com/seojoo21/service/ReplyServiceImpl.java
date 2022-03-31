package com.seojoo21.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.seojoo21.domain.Criteria;
import com.seojoo21.domain.ReplyPageDTO;
import com.seojoo21.domain.ReplyVO;
import com.seojoo21.mapper.BoardMapper;
import com.seojoo21.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_= {@Autowired})
	private ReplyMapper mapper;
	
	// 게시물 제목 옆 댓글 수 표시 업데이트를 위한 트랜잭션 작업에 필요한 BoardMapper 주입 
	@Setter(onMethod_= {@Autowired})
	private BoardMapper boardMapper; 

	// 1. 댓글 등록 
	@Transactional // 게시물 제목 옆 댓글 수 표시 업데이트를 위해 트랜잭션 처리 
	@Override
	public int register(ReplyVO reply) {
		log.info("register........" + reply);
		boardMapper.updateReplyCnt(reply.getBno(), 1); // 댓글 수 업데이트 메서드 추가 (댓글 등록 시 1 증가)
		return mapper.create(reply);
	}
	
	// 2. 댓글 조회
	@Override
	public ReplyVO get(Long rno) {
		log.info("get..........");
		return mapper.read(rno);
	}
	
	// 3. 댓글 수정 
	@Override
	public int modify(ReplyVO reply) {
		log.info("modify........" + reply);
		return mapper.update(reply);
	}
	
	// 4. 댓글 삭제 
	@Transactional // 게시물 제목 옆 댓글 수 표시 업데이트를 위해 트랜잭션 처리 
	@Override
	public int remove(Long rno) {
		log.info("delete......");
		ReplyVO reply = mapper.read(rno);  // 댓글의 삭제는 전달되는 파라미터가 rno 뿐이므로 해당 댓글의 게시물을 알아내는 과정이 필요.
		boardMapper.updateReplyCnt(reply.getBno(), -1); // 댓글 수 업데이트 메서드 추가 (댓글 등록 시 1 감소)
		return mapper.delete(rno);
	}
	
	// 5. 댓글 목록 조회 
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("getList..........");
		return mapper.getListWithPaging(cri, bno);
	}
	
	// 6. 댓글 목록 조회 (페이징 처리) 
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(
				mapper.getReplyCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}
	

}
