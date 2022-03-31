package com.seojoo21.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.seojoo21.domain.Criteria;
import com.seojoo21.domain.ReplyPageDTO;
import com.seojoo21.domain.ReplyVO;
import com.seojoo21.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/replies")
@AllArgsConstructor
@Slf4j
public class ReplyController {
	
	private ReplyService service;
	
	// 1. 댓글 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/new", consumes= "application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO reply) throws Exception{
		log.info("ReplyVO : " + reply);
		int count = service.register(reply);
		log.info("Reply Register Count : " + count);
		return count == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
			
	// 2. 댓글 조회
	@GetMapping(value= "/{rno}", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		log.info("get:" + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
			
	// 3. 댓글 수정 
	@PreAuthorize("principal.username == #reply.userid")
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, 
					value = "/{rno}", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@PathVariable("rno") Long rno, @RequestBody ReplyVO reply){
		reply.setRno(rno);
		log.info("rno: " + rno);
		log.info("modify: " + reply);
		return service.modify(reply) == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
		
	// 4. 댓글 삭제 
	@PreAuthorize("principal.username == #reply.userid")
	@DeleteMapping(value="/{rno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno, @RequestBody ReplyVO reply){
		log.info("remove: " + rno);
		log.info("replyer:" + reply.getReplyer());
		return service.remove(rno) == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 5. 댓글 목록 조회 
//	@GetMapping(value="/pages/{bno}/{page}", 
//				produces= {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
//	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") Long bno, @PathVariable("page") int page){
//		log.info("getList..........");
//		Criteria cri = new Criteria(page,10);
//		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
//	}
	
	// 6. 댓글 목록 조회 (페이징 처리) 
	@GetMapping(value="/pages/{bno}/{page}", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("bno") Long bno, @PathVariable("page") int page) {
		Criteria cri = new Criteria(page,10);
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
}
