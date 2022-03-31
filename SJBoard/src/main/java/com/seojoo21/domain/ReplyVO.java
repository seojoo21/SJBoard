package com.seojoo21.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	private Long rno; // 댓글 번호 
	private Long bno; // 게시물 번호 (테이블 tbl_reply와 tbl_board의 FK) 
	private String reply; // 댓글 
	private String replyer; // 댓글 작성자 
	private Date replyDate; // 댓글 작성일 
	private Date updateDate; // 댓글 수정일 
	private String userid; // 댓글 작성자의 아이디 

}
