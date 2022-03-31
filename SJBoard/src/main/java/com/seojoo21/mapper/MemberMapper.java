package com.seojoo21.mapper;

import java.util.List;

import com.seojoo21.domain.MemberVO;

public interface MemberMapper {
	
	// 1. 가입된 회원의 정보를 가져온다. 
	public MemberVO read(String userid);
	
	// 2. 회원 가입을 한다.
	public void memberJoin(MemberVO vo);
	
	// 3. 회원 정보를 수정한다.
	public int memberUpdate(MemberVO vo);
	
	// 4. 회원 탈퇴를 한다.
	public int memberDelete(String userid, String userpw);
	
	// 5. 회원 아이디 중복 여부를 확인한다.
	public int idChk(String userid);
	
	// 6. 회원 사용자 이름 중복 여부를 확인한다.
	public int userNameChk(String userName);
	
	// 7. 회원 아이디를 찾는다.
	public List<MemberVO> findId(String email);
	
	// 8. 회원 비밀번호를 재설정한다. 
	public int updatePwd(String userid, String userpw);
	
}
