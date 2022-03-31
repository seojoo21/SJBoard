package com.seojoo21.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.seojoo21.domain.Criteria;
import com.seojoo21.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@AllArgsConstructor
@Slf4j
public class HomeController {
	
	private BoardService boardService;
	
	@GetMapping("/")
	public String home(Criteria cri, Model model) {
		
		// 1페이지에 10개씩 출력  
		cri.setPageNum(1);
		cri.setAmount(10);
		log.info("Welcome SJBoard!");
		
		// 최신 게시글 목록을 조회한다. 
		model.addAttribute("recentList", boardService.getRecentList(cri));
		
		// 인기 게시글 목록을 조회한다. 
		model.addAttribute("likeHitList", boardService.getLikeHitList(cri));
		
		return "home";
				
	}
	
}
