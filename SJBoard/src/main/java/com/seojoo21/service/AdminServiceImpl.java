package com.seojoo21.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seojoo21.domain.AuthVO;
import com.seojoo21.domain.Criteria;
import com.seojoo21.domain.MemberVO;
import com.seojoo21.domain.DateDTO;
import com.seojoo21.mapper.AdminMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AdminServiceImpl implements AdminService {
	
	@Setter(onMethod_= {@Autowired})
	private AdminMapper mapper;
	
	// 가입된 회원 전체 정보 확인 
	@Override
	public List<MemberVO> getMemberList() {
		log.info("Get Member List......");
		return mapper.getMemberList();
	}
	
	// 가입된 회원 전체 정보 확인 (페이징처리)
	@Override
	public List<MemberVO> getMemberListWithPaging(Criteria cri) {
		log.info("Get Member List......");
		return mapper.getMemberListWithPaging(cri);
	}

	
	// 전체 회원수 확인
	@Override
	public Long getTotalMemberNo() {
		log.info("Get Total Member No......");
		return mapper.getTotalMemberNo();
	}
	
	// 전체 게시글 수 확인 
	@Override
	public Long getTotalBnoNo() {
		log.info("Get Total Bno No......");
		return mapper.getTotalBnoNo();
	}

	// 전체 댓글 수 확인 
	@Override
	public Long getTotalRnoNo() {
		log.info("Get Total Rno No......");
		return mapper.getTotalRnoNo();
	}
	
	// 회원 등급 변경 
	@Override
	public int updateAuth(AuthVO vo) {
		log.info("Update Auth..........");
		int result = mapper.updateAuth(vo);
		return result;
	}
	
	// 회원 강제 탈퇴 처리 
	@Override
	public int deleteMemberByAdmin(String userid) {
		log.info("Delete Member By Admin.........");
		int result = mapper.deleteMemberByAdmin(userid);
		return result;
	}
	
	// 주간 게시글 수 확인
	@Override
	public List<DateDTO> getWeeklyBnoNo(int num) {
		log.info("Get Weekly Bno No..........");
		return mapper.getWeeklyBnoNo(num);
	}
	
	// 주간 댓글 수 확인 
	@Override
	public List<DateDTO> getWeeklyRnoNo(int num) {
		log.info("Get Weekly Rno No.......");
		return mapper.getWeeklyRnoNo(num);
	}
	
	// 주간 신규 회원 수 확인 
	@Override
	public List<DateDTO> getWeeklyNewMemberNo(int num) {
		log.info("Get Weekly New Member No.......");
		return mapper.getWeeklyNewMemberNo(num);
	}

	// 기간별 게시글 수 확인 
	@Override
	public Long getBoardNoByPeriod() {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 기간별 댓글 수 확인
	@Override
	public Long getReplyNoByPeriod() {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 기간별 가입 회원 수 확인 
	@Override
	public Long getJoinMemberByPeriod() {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 기간별 탈퇴 회원 수 확인 
	@Override
	public Long getDeleteMemberByPeriod() {
		// TODO Auto-generated method stub
		return null;
	}



}
