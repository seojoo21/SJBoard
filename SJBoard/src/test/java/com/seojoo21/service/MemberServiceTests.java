package com.seojoo21.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.seojoo21.domain.MemberVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class MemberServiceTests {
	
	@Setter(onMethod_= {@Autowired})
	private MemberService service;
	
	
	//0. MemberService 객체를 주입하는데 이상없지 확인 
//	@Test
//	public void testExist() {
//		log.info("service:" + service);
//		assertNotNull(service);
//	}
//	
//	//1. 회원 가입을 한다. 
//	@Test
//	public void testMemberRegister() {
//		MemberVO vo  = new MemberVO();
//		vo.setUserid("tester0");
//		vo.setUserpw("tester0");
//		vo.setUserName("tester0");
//		vo.setEmail("tester0@test.com");
//		
//		service.registerMember(vo);
//		log.info("New Member Info: " + vo);
//	}
//	
//	//2. 회원 정보를 가져온다.
//	@Test
//	public void testMemberRead() {
//		MemberVO vo = service.readMember("admin1");
//		log.info("userinfo:" + vo);
//		
//	}
//	
//	//3. 회원 정보를 수정한다.
//	@Test
//	public void testMemberUpdate() {
//		MemberVO vo = new MemberVO();
//		vo.setUserid("tester100");
//		
//		vo.setUserName("수정");
//		vo.setUserpw("12341234");
//		vo.setEmail("sss@sss.ss");
//		
//		service.updateMember(vo);
//		log.info("Member Update Info: " + vo);
//	
//	}
	
	//4. 회원 탈퇴를 한다. 
//	@Test
//	public void testMemberDelete() {
//		MemberVO vo = new MemberVO();
//		
//		vo.setUserid("tester104");
//		vo.setUserpw("tester104");
//		
//		log.info("Member Delete Info: " + service.deleteMember(vo.getUserid(),vo.getUserpw()));
//	}
	
	// 5. 회원 아이디 중복 여부를 확인한다.
//	@Test
//	public void testCheckUserId() {
//		MemberVO vo = new MemberVO();
//		
//		vo.setUserid("admin1");
//		
//		log.info("Id Check: " + service.checkUserId("admin1"));
//		
//	}
	
	// 6. 회원 사용자 이름 중복 여부를 확인한다.
//	@Test
//	public void testCheckUserName() {
//		MemberVO vo = new MemberVO();
//		
//		vo.setUserName("관리자");
//		
//		log.info("Id Check: " + service.checkUserName("관리자"));
//	}
	
	// 7. 회원 아이디를 찾는다.
//	@Test
//	public void testFindUserId() {
//		MemberVO vo = new MemberVO();
//		vo.setEmail("test");
//		log.info("Find UserId:" + service.findUserId(vo.getEmail()));
//	}
	
	// 8. 회원 비밀번호를 재설정한다. 
	@Test
	public void testUpdatePwd() {
		MemberVO vo = new MemberVO();
		vo.setUserid("tester105");
		vo.setUserpw("11111111");
		
		service.updatePwd(vo.getUserid(), vo.getUserpw());
		log.info("Member Update Info : " + vo);
	}
}
