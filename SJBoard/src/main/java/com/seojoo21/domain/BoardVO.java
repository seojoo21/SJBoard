package com.seojoo21.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	
	private Long bno; // 게시물 번호 
	private String title; // 게시물 제목 
	private String content; // 게시물 내용 
	private String writer; // 게시물 작성자 
	private Date regdate;  // 게시물 등록일 
	private Date updateDate; // 게시물 수정일 
	private Long viewHit;  // 게시물 조회수 
	private String userid; // 사용자 아이디 
	
	private int replyCnt; // 댓글 수
	private Long likeHit; // 게시물 추천수 
	
	private List<BoardAttachVO> attachList; // 첨부파일 정보  
}
