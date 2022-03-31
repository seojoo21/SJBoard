package com.seojoo21.domain;

import lombok.Data;

@Data
public class LikeVO {
	
	private Long lno; // PK 설정용 단순 순번
	private Long likeNo; // 게시물 추천 수 
	private Long bno; // 게시물 번호 
	private String userid; // 사용자 아이디 

}
