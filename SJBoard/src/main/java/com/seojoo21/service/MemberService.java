package com.seojoo21.service;

import java.util.List;

import com.seojoo21.domain.MemberVO;

public interface MemberService {
	
	// 1. 회원가입을 한다.
	public void registerMember(MemberVO vo);
	
	// 2. 회원 정보를 가져온다.
	public MemberVO readMember(String userid);
	
	// 3. 회원 정보를 수정한다.
	// 엄격하게 처리하기 위해서 Boolean 타입으로 처리한다. 
	public boolean updateMember(MemberVO vo);
	
	// 4. 회원 탈퇴를 한다. 
	// 엄격하게 처리하기 위해서 Boolean 타입으로 처리한다. 
	public boolean deleteMember(String userid, String userpw);
	
	// 5. 회원 아이디 중복 여부를 확인한다.
	public int checkUserId(String userid);
	
	// 6. 회원 사용자 이름 중복 여부를 확인한다.
	public int checkUserName(String userName);
	
	// 7. 회원 아이디를 찾는다.
	public List<MemberVO> findUserId(String email);
	
	// 8. 회원 비밀번호를 재설정한다.
	public boolean updatePwd(String userid, String userpw);


}
