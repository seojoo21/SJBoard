package com.seojoo21.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member/*")
@Slf4j
public class LoginController {
	
	// 1. 로그인 시 
	@GetMapping("/login")
	public void memberLogin(String error, String logout, Model model, HttpSession session) {
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "로그인 오류입니다. ID와 비밀번호를 다시 확인해주세요. ");
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃 되었습니다.");
		}
	}
	
	// 2. 로그아웃 시(GET)
	@GetMapping("/logout")
	public void memberLogoutGet() {
		log.info("GET member logout");
		
	}
	
	// 3. 접근 오류 시
	@GetMapping("/accessError")
	public String accessDenied(Authentication auth) {
		log.info("access Denied: " + auth);
		return "/accessError";
	}
	
}
