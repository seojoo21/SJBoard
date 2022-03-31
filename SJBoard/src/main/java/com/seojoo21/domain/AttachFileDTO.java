package com.seojoo21.domain;

import lombok.Data;

@Data
// AttachFileDTO: 첨부파일 관리에 필요한 값들을 저장한다. 
public class AttachFileDTO {
	
	private String fileName; // 원본 파일의 이름 
	private String uploadPath; // 업로드 경로 
	private String uuid; // 파일 이름 중복 방지를 위한 UUID값 
	private boolean image; // 이미지 여부(image) 정보 
	
	// 업로드 폴더 경로 
	final public String uploadFolder = "/Users/juyoungkang/Desktop/Back-End Project/Project1_SJBoard/board_upload/";
	

}
