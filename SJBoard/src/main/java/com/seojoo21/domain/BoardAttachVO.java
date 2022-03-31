package com.seojoo21.domain;

import lombok.Data;

// 게시판 파일 첨부 VO 클래스
@Data
public class BoardAttachVO {
	
	private String uuid; // 첨부파일 uuid 값 
	private String uploadPath; // 파일 업로드 경로 
	private String fileName; // 파일 이름 
	private boolean fileType; // 파일 종류 (이미지 파일 여부를 판단하므로 boolean 처리) 
	private Long bno; // 게시물 번호 
}
