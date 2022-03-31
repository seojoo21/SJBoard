package com.seojoo21.mapper;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.seojoo21.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MemberMapperTests {
	
	@Setter(onMethod_= {@Autowired})
	private MemberMapper memberMapper;

	// 1. 가입된 회원의 정보를 가져온다. 
//	@Test
//	public void testRead() {
//		MemberVO vo = memberMapper.read("tester103");
//		log.info(vo);
//		vo.getAuthList().forEach(authVO -> log.info(authVO));
//		
//	}
//	
//	// 2. 회원 가입을 한다.  
//	@Test
//	public void testMemberJoin() {
//		MemberVO vo = new MemberVO();
//		vo.setUserid("tester2");
//		vo.setUserpw("tester2");
//		vo.setUserName("테스터2");
//		vo.setEmail("tester2@test.com");
//		
//		memberMapper.memberJoin(vo);
//		log.info(vo);
//	}
//	
//	// 3. 회원 정보 수정을 한다.
//	@Test
//	public void testMemberUpdate() {
//		MemberVO vo = new MemberVO();
//		
//		vo.setUserid("tester2");
//		
//		vo.setUserName("테스터222");
//		vo.setUserpw("12341234");
//		vo.setEmail("ts@ts.com");
//		
//		int count = memberMapper.memberUpdate(vo);
//		log.info("Member Info Update: " + vo );
//		log.info("Member Update Success: " + count);
//		
//	}
	
	// 4. 회원 탈퇴를 한다.
//	@Test
//	public void testMemberDelete() {
//		MemberVO vo = new MemberVO();
//		
//		vo.setUserid("tester102");
//		vo.setUserpw("tester102");
//		
//		log.info("Member Delete Sucess Count" + memberMapper.memberDelete(vo.getUserid(), vo.getUserpw()));
//	}
	
	// 5. 회원 아이디 중복 여부를 확인한다.
//	@Test
//	public void testIdChk() {
//		MemberVO vo = new MemberVO();
//		
//		vo.setUserid("admin00"); // DB에 실제 존재 하는 아이디, 존재 하지 않는 아이디 모두 체크해보기 
//		int count = memberMapper.idChk("admin00"); // 일치하는 id가 있으면 1 반환, 없으면 0 반환  
//		log.info("Member Id Check: " + count);
//	}
//		
//	// 6. 회원 사용자 이름 중복 여부를 확인한다.
//	@Test
//	public void testuserNameChk() {
//		MemberVO vo = new MemberVO();
//		
//		vo.setUserName("호랑");
//		int count = memberMapper.userNameChk("호랑");
//		log.info("Member UserName Check: " + count);
//	}
	
	// 7. 회원 아이디를 찾는다.
//	@Test
//	public void testFindId() {
//		MemberVO vo = new MemberVO();
//		
//		vo.setEmail("test");
//		log.info("Find memberId: " + memberMapper.findId(vo.getEmail()));
//	}
	
	// 8. 회원 비밀번호를 재설정한다. 
	@Test
	public void testUpdatePwd() {
		log.info("==========test============");
		MemberVO vo = new MemberVO();
		
		vo.setUserid("tester105");
		vo.setUserpw("12341234");
	
		int count = memberMapper.updatePwd(vo.getUserid(), vo.getUserpw());
		log.info("count : " + count);
		log.info("info : " + vo);
	}
}
