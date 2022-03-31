package com.seojoo21.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seojoo21.domain.MemberVO;
import com.seojoo21.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_= {@Autowired})
	private MemberMapper memberMapper;
	
	// 1. 회원가입을 한다.
	@Override
	public void registerMember(MemberVO vo) {
		log.info("New Member Register: " + vo);
		memberMapper.memberJoin(vo);
	}

	// 2. 회원 정보를 가져온다. 
	@Override
	public MemberVO readMember(String userid) {
		log.info("Member Info Read:" + userid);
		return memberMapper.read(userid);
	}
	
	// 3. 회원 정보를 수정한다. 
	@Override
	public boolean updateMember(MemberVO vo) {
		log.info("Member Info Update: " + vo);
		boolean result = memberMapper.memberUpdate(vo) == 1 ;
		return result;
	}

	// 4. 회원 탈퇴를 한다. 
	@Override
	public boolean deleteMember(String userid, String userpw) {
		log.info("Member Delete: " + "userid:" + userid + "/userpw:" + userpw);
		return memberMapper.memberDelete(userid, userpw) == 1;
	}
	
	// 5. 회원 아이디 중복 여부를 확인한다.
	@Override
	public int checkUserId(String userid) {
		int result = memberMapper.idChk(userid);
		log.info("Id Check:" + userid);
		return result;
	}
	
	// 6. 회원 사용자 이름 중복 여부를 확인한다.
	@Override
	public int checkUserName(String userName) {
		int result = memberMapper.userNameChk(userName);
		log.info("userName Check:" + userName);
		return result;
	}
	
	// 7. 회원 아이디를 찾는다.
	@Override
	public List<MemberVO> findUserId(String email) {
		log.info("Find Member Id : " + email);
		return memberMapper.findId(email);
	}
	
	// 8. 회원 비밀번호를 재설정한다.
	@Override
	public boolean updatePwd(String userid, String userpw) {
		log.info("Update Password : userid: " +userid + "userpw: "+ userpw);
		return memberMapper.updatePwd(userid, userpw) == 1;
	}

}
