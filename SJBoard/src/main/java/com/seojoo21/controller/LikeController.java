package com.seojoo21.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.seojoo21.service.LikeService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@AllArgsConstructor
@Slf4j
public class LikeController {

	private LikeService service;
	
	// 게시글을 추천한다.
	@PostMapping ("/updateLike")
	@ResponseBody
	public String updateLike(Long bno, String userid) throws Exception {
		log.info("updateLike..............");
		log.info("BNO : " + bno + " / USER ID : " + userid);
		
		int result = service.updateLike(bno, userid); 
		log.info("Update Like Result : " + result); // 성공 시 1 반환 
			
		if (result == 1 ) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 게시글 추천을 취소한다.
	@PostMapping("/deleteLike")
	@ResponseBody
	public String deleteLike(Long bno, String userid) {
		log.info("Delete Like................");
		log.info("BNO : " + bno + " / USER ID : " + userid);
		
		int result = service.deleteLike(bno, userid); 
		log.info("Delete Like Result : " + result); // 성공 시 1 반환 
			
		if (result == 1 ) {
			return "success";
		} else {
			return "fail";
		}
	};

}
