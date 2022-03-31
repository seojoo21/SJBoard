package com.seojoo21.mapper;

import java.util.List;

import com.seojoo21.domain.AuthVO;
import com.seojoo21.domain.Criteria;
import com.seojoo21.domain.MemberVO;
import com.seojoo21.domain.DateDTO;

public interface AdminMapper {
	
	// 가입된 회원 전체 정보 확인 
	public List<MemberVO> getMemberList();
	
	// 가입된 회원 전체 정보 확인 (페이징처리)
	public List<MemberVO> getMemberListWithPaging(Criteria cri);
	
	// 전체 회원수 확인
	public Long getTotalMemberNo();
	
	// 전체 게시글 수 확인 
	public Long getTotalBnoNo(); 
	
	// 전체 댓글 수 확인 
	public Long getTotalRnoNo();
	
	// 회원 등급 변경 
	public int updateAuth(AuthVO vo);
	
	// 회원 강제 탈퇴 처리 
	public int deleteMemberByAdmin(String userid);
	
	// 주간 게시글 수 확인
	// 지난주: -7, 이번주: 0 
	public List<DateDTO> getWeeklyBnoNo(int num);
	
	// 주간 댓글 수 확인 
	// 지난주: -7, 이번주: 0 
	public List<DateDTO> getWeeklyRnoNo(int num);
	
	// 주간 신규 회원 수 확인 
	// 지난주: -7, 이번주: 0 
	public List<DateDTO> getWeeklyNewMemberNo(int num);
	
	// 기간별 게시글 수 확인 
	public Long getBoardNoByPeriod();
	
	// 기간별 댓글 수 확인
	public Long getReplyNoByPeriod();
	
	// 기간별 가입 회원 수 확인 
	public Long getJoinMemberByPeriod();
	
	// 기간별 탈퇴 회원 수 확인 
	public Long getDeleteMemberByPeriod();
	
}
