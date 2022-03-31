package com.seojoo21.service;

import com.seojoo21.domain.LikeVO;

public interface LikeService {
	
	// 게시글을 추천한다.
	public int updateLike(Long bno, String userid);
	
	// 게시글 추천을 취소한다.
	public int deleteLike(Long bno, String userid);
	
	// 게시글 추천 여부를 확인한다. 
	public LikeVO checkLike(Long bno, String userid);
	
	// 게시글 추천수를 가져온다.
	public Long getLikeNo(Long bno);

}
