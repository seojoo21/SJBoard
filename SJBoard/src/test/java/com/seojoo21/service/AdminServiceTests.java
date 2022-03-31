package com.seojoo21.service;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.seojoo21.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AdminServiceTests {
	
	@Setter(onMethod_= {@Autowired})
	private AdminService service;
	
	@Setter(onMethod_= {@Autowired})
	private ChartService chartService;
	
	// MemberService 객체를 주입하는데 이상없지 확인 
//	@Test
//	public void testExist() {
//		log.info("service:" + service);
//		assertNotNull(service);
//	}
	
	// 회원 정보를 가져온다.
//	@Test
//	public void testGetMemberList() {
////		service.getMemberList().forEach(member -> log.info(member)); // 페이징 처리 전 
//		service.getMemberListWithPaging(new Criteria(1,10));
//	}
	
//	// 전체 게시글 수를 가져온다. 
//	@Test
//	public void testGetTotalBnoNo() {
//		log.info("전체 게시글 수" + service.getTotalBnoNo());
//	}
	
	// 전체 댓글 수를 가져온다. 
//	@Test
//	public void testGetTotalRnoNo() {
//		log.info("전체 댓글 수" + service.getTotalRnoNo());
//	}
	
	// 회원 등급 변경 
//	@Test
//	public void testUpdateAuth() {
//		AuthVO vo = new AuthVO();
//		vo.setUserid("admin0");
//		vo.setAuth("ROLE_MEMBER");
//		int result = service.updateAuth(vo);
//		log.info("Update Auth Result" + result);
//	}
//	
	// 회원 강제 탈퇴 처리 
//	@Test
//	public void testDeleteMemberByAdmin() {
//		MemberVO vo = new MemberVO();
//		vo.setUserid("deleteTest1");
//		int result = service.deleteMemberByAdmin(vo.getUserid());
//		log.info("Delete User Result" + result);
//	}
	
	// 주간 게시글 수 확인
//	@Test 
//	public void testGetWeeklyBnoNo() {
//		log.info("Get Weekly Bno No...........");
//		int num1 = -7; // 지난주
//		int num2 = 0; // 이번주 
//		service.getWeeklyBnoNo(num2).forEach(day -> log.info(day));
//	}
	

}
