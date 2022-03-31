package com.seojoo21.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userid; // 사용자 아이디
	private String userpw; 	// 사용자 비밀번호 
	private String userName; // 사용자 이름
	private Date regdate; // 사용자 가입일
	private Date updateDate; // 사용자 정보 수정일
	private List<AuthVO> authList; // 사용자 권한 정보 리스트 
	private String email; // 사용자 이메일 주소 

}
