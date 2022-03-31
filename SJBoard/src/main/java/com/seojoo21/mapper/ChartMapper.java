package com.seojoo21.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface ChartMapper {
	
	// 기간별 게시글 수 확인 
	public List<Map<String, Object>> getBoardNoByPeriod(String fromDate, String toDate);
	
	// 기간별 댓글 수 확인
	public List<Map<String, Object>> getReplyNoByPeriod(String fromDate, String toDate);
	
	// 기간별 가입 회원 수 확인 
	public List<Map<String, Object>> getMemberNoByPeriod(String fromDate, String toDate);
	
}
