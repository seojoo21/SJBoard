package com.seojoo21.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.seojoo21.domain.AuthVO;
import com.seojoo21.domain.Criteria;
import com.seojoo21.domain.DateDTO;
import com.seojoo21.domain.MemberVO;
import com.seojoo21.domain.PageDTO;
import com.seojoo21.service.AdminService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@AllArgsConstructor
@RequestMapping("/admin/*")
@Slf4j
@PreAuthorize("hasRole('ROLE_ADMIN')")
public class AdminController {
	
	private AdminService service;
	
	// 관리자 페이지 GET
	@GetMapping("/main")
	public void getAdmin(Locale locale, Model model) {
		log.info("Get Admin Page....");
		
		Date date = new Date();
		
		//현재 시스템 시간 
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);
		
		//오늘 날짜 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd E요일");
		String today = sdf.format(date);
		log.info("오늘 날짜 : " + today);
		model.addAttribute("today", today);
		
		// 전체 회원, 게시물, 댓글 수
		model.addAttribute("TotalUserNo", service.getTotalMemberNo());
		model.addAttribute("TotalBnoNo", service.getTotalBnoNo());
		model.addAttribute("TotalRnoNo", service.getTotalRnoNo());
		
		// 지난주 주간 게시물 수 확인 
		List<DateDTO> lastWeekBnoList = service.getWeeklyBnoNo(-7);
		model.addAttribute("lastWeekBnoList", lastWeekBnoList);
		
		// 이번주 주간 게시물 수 확인
		List<DateDTO> thisWeekBnoList = service.getWeeklyBnoNo(0);
		model.addAttribute("thisWeekBnoList", thisWeekBnoList);
		
		// 저번주 주간 댓글 수 확인
		List<DateDTO> lastWeekRnoList = service.getWeeklyRnoNo(-7);
		model.addAttribute("lastWeekRnoList", lastWeekRnoList);
		
		// 이번주 주간 댓글 수 확인
		List<DateDTO> thisWeekRnoList = service.getWeeklyRnoNo(0);
		model.addAttribute("thisWeekRnoList", thisWeekRnoList);
		
		// 저번주 주간 신규 회원 수 확인
		List<DateDTO> lastWeekNewMemberList = service.getWeeklyNewMemberNo(-7);
		model.addAttribute("lastWeekNewMemberList", lastWeekNewMemberList );
		
		// 이번주 주간 신규 회원 수 확인
		List<DateDTO> thisWeekNewMemberList = service.getWeeklyNewMemberNo(0);
		model.addAttribute("thisWeekNewMemberList", thisWeekNewMemberList);
		
	}
	
	
	// 전체 회원 정보 확인 (페이징 처리)
	@GetMapping("/memberList")
	public void getMemberListWithPaging(Criteria cri, Model model) {
		
		log.info("Get Member List from Admin.....");
		
		// 페이징 처리를 위해 전체 회원수 값 가져오기 
		int memberNo = service.getTotalMemberNo().intValue();
		
		// 전체 회원 정보 출력 
		List<MemberVO> list = service.getMemberListWithPaging(cri);
		model.addAttribute("list", list);
		model.addAttribute("TotalUserNo", memberNo);
		model.addAttribute("pageMaker", new PageDTO(cri, memberNo));
	
	} 
	
	// 회원 등급 변경 
	@PostMapping("/updateAuth")
	@ResponseBody
	public String updateAuth(AuthVO vo) throws Exception {
	    log.info("Update Auth..........");
	    log.info("Update Auth to....: " + vo.getUserid() + "/" + vo.getAuth());
	    int result = service.updateAuth(vo);
	    
		if(result != 0) {
			log.info("Update Auth Success.....");
		    return "success";
		} else {
			log.info("Update Auth Fail.....");
		    return "fail";
		}
	}
	
	//회원 강제 탈퇴 
	@PostMapping("/deleteMember")
	@ResponseBody
	public String deleteMemberByAdmin(String userid) {
		log.info("Delete Member By Admin...........");
		log.info("Delete UserId : " + userid);
		int result = service.deleteMemberByAdmin(userid);
		
		if(result != 0 ) {
			log.info("Delete User Success.........");
			return "success";
		} else {
			log.info("Delete User Fail............");
			return "fail";
		}
	}
	
	//기간별 게시물 현황 페이지 
	@GetMapping("/bnoStats")
	public void bnoStats() {
		log.info("Admin Bno Stats.............");
		
	}
	
	//기간별 댓글 현황 페이지 
	@GetMapping("/rnoStats")
	public void rnoStats() {
		log.info("Admin Rno Stats.............");
	}
	
	//기간별 회원 현황 페이지 
	@GetMapping("/memberStats")
	public void stats() {
		log.info("Admin Member Stats.............");
	}
	
}

