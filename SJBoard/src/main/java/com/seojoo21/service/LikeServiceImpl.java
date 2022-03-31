package com.seojoo21.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.seojoo21.domain.LikeVO;
import com.seojoo21.mapper.BoardMapper;
import com.seojoo21.mapper.LikeMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LikeServiceImpl implements LikeService {
	
	@Setter(onMethod_=@Autowired)
	private LikeMapper likeMapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardMapper boardMapper;
	
	// 게시글을 추천한다. 
	@Transactional
	@Override
	public int updateLike(Long bno, String userid) {
		log.info("Update Like.............");
		int result = likeMapper.updateLike(bno, userid); // 성공하면 1 반환  
		
		// 트랜잭션을 위해 boardMapper에서 추천수를 가져오는 메서드 updateLikeHit을 추가하고 성공 시 반환되는 1을 파라미터로 전달 (따라서 실제 1씩 증가) 
		boardMapper.updateLikeHit(bno, result); 
		
		return result;
	}
	
	// 게시글 추천을 취소한다.
	@Transactional
	@Override
	public int deleteLike(Long bno, String userid) {
		log.info("Delete Like.............");
		int result = likeMapper.deleteLike(bno, userid); // 성공하면 1 반환 
		
		// 트랜잭션을 위해 boardMapper에서 추천수를 가져오는 메서드 updateLikeHit을 추가하고 성공 시 반환되는 -1을 파라미터로 전달 (따라서 실제 -1씩 증가)
		boardMapper.updateLikeHit(bno, -result);
		
		return result;
	}
	
	// 게시글 추천 여부를 확인한다. 
	@Override
	public LikeVO checkLike(Long bno, String userid) {
		log.info("Check Like......" + userid);
		return likeMapper.checkLike(bno, userid);
	}
	
	// 게시글 추천수를 가져온다.
	@Override
	public Long getLikeNo(Long bno) {
		log.info("Get Like Num.........");
		Long result = likeMapper.getLikeNo(bno);
		return result;
	}
}
