package com.seojoo21.controller;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.seojoo21.service.ChartService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@AllArgsConstructor
@RequestMapping("/chart/*")
@Slf4j
public class ChartController {
	
	private ChartService service;
	
	// 기간별 게시물 수 JSON 타입으로 파싱
	@GetMapping("/bno")
	@ResponseBody
	public JSONObject chartBno(String fromDate, String toDate) throws Exception{
		log.info("Bno Chart Loading........");
		log.info("fromDate : " + fromDate );
		log.info("toDate : " + toDate );
		return service.getBnoNoByPeriod(fromDate, toDate);
	}
	
	
	// 기간별 댓글 수 JSON 타입으로 파싱
	@GetMapping("/rno")
	@ResponseBody
	public JSONObject chartRno(String fromDate, String toDate) throws Exception{
		log.info("Rno Chart Loading........");
		log.info("fromDate : " + fromDate );
		log.info("toDate : " + toDate );
		return service.getRnoNoByPeriod(fromDate, toDate);
	}
	
	// 기간별 회원 수 JSON 타입으로 파싱
	@GetMapping("/member")
	@ResponseBody
	public JSONObject chartMember(String fromDate, String toDate) throws Exception{
		log.info("Rno Chart Loading........");
		log.info("fromDate : " + fromDate );
		log.info("toDate : " + toDate );
		return service.getMemberNoByPeriod(fromDate, toDate);
	}
	
}
