package com.seojoo21.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.seojoo21.domain.Criteria;
import com.seojoo21.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AdminMapperTests {
	
	@Setter(onMethod_=@Autowired)
	public AdminMapper mapper;
	
	
	// 가입된 회원 전체 정보를 읽어온다. 
//	@Test
//	public void testGetMemberList() {
//		mapper.getMemberList().forEach(board -> log.info(board));
//		
//	}
	
//	// 가입된 회원 전체 정보를 읽어온다. (페이징)
//	@Test
//	public void testGetMemberListWithPaging() {
//		Criteria cri = new Criteria();
//		cri.setPageNum(1);
//		cri.setAmount(10);
//		List<MemberVO> list = mapper.getMemberListWithPaging(cri);
//		list.forEach(member -> log.info(member));
//	}
	
	// 전체 게시글 수  
//	@Test
//	public void testGetMemberList() {
//		log.info("전체 게시글 수: " + mapper.getTotalBnoNo());
//	}

	// 회원 등급 변경 
//	@Test
//	public void testUpdateAuth() {
//		AuthVO vo = new AuthVO();
//		vo.setUserid("admin0");
//		vo.setAuth("ROLE_ADMIN");
//		int result = mapper.updateAuth(vo);
//		log.info("result : " + result);
//	}
//	
	// 회원 강제 탈퇴 
//	@Test
//	public void testDeleteMemberByAdin() {
//		MemberVO vo = new MemberVO();
//		vo.setUserid("deleteTest");
//		int result = mapper.deleteMemberByAdmin(vo.getUserid());
//		log.info("resut : " + result);
//	}
	
	// 주간 게시글 수 확인 
	@Test
	public void testGetBnoNoByWeek() {
		int num = 0;
		mapper.getWeeklyBnoNo(num).forEach(day -> log.info(day));
	}
}
