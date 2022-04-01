package com.seojoo21.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.seojoo21.domain.AttachFileDTO;
import com.seojoo21.domain.BoardAttachVO;
import com.seojoo21.domain.BoardVO;
import com.seojoo21.domain.Criteria;
import com.seojoo21.domain.LikeVO;
import com.seojoo21.domain.PageDTO;
import com.seojoo21.service.BoardService;
import com.seojoo21.service.LikeService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/sjboard/*")
@AllArgsConstructor
//BoardController는 BoardService에 의존적이므로 @AllArgsConstructor를 이용해서 생성자를 만들고 자동으로 주입해준다. 
@Slf4j
public class BoardController {
	
	private BoardService service; 
	
	// 게시글 추천 기능 서비스 
	private LikeService likeService;
	
	@GetMapping("/test")
	public void test() {
		
	}
	
	//1. 페이징 처리하여 게시물 목록을 조회한다. 
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("list" + cri);
		int total = service.getTotal(cri);
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	//2-1. 게시물 입력 페이지로 이동 
	//게시물 등록 작업은 POST 방식으로 처리하지만,화면에서 입력을 받아야 하므로 먼저 GET방식으로 입력 페이지를 볼 수 있도록 함. 
	//GET방식으로 연결한 register()는 입력 페이지를 보여주는 역할만을 하기 때문에 별도의 처리는 필요 없음
	//@PreAuthorize: 로그인 한 사용자만 게시물 작성 가능 
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
	
		}
		
	//2. 신규 게시물을 등록한다. 
	//RedirectAttributes를 파라미터로 지정한 이유: 등록 작업이 끝난 후 다시 목록 화면으로 이동하기 위함. 
	//리다이렉트시 추가적으로 새롭게 등록된 게시물의 번호를 같이 전달하는데 일회성으로만 전달하면되므로 addFlashAttribute를 이용함.
	//@PreAuthorize: 로그인 한 사용자만 게시물 작성 가능 
	@PostMapping("/register")	
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("====================");
		log.info("register: " + board);
		
		// 첨부 파일 목록 
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> System.out.println(attach));
		}
		
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/sjboard/list";
	}
	
	//3. 특정 게시물을 조회한다. 
	@GetMapping("/get")
	public void read(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, HttpSession session, Model model) {
		
		// 기존 게시물 조회 부분  
		log.info("/get");
		service.viewCount(bno);
		model.addAttribute("board", service.get(bno));
		
		// 게시물 추천 기능 추가 부분 
		// 현재 접속자의 로그인 여부에 따라 로그인하지 않았으면 anonoymousUser, 로그인했으면 로그인한 아이디 값을 가져와 세션에 저장 
		Authentication user = SecurityContextHolder.getContext().getAuthentication();
		String userId = user.getName();
		log.info("annoymousUser or loginUser? " + userId);
		session.setAttribute("userid", userId);
		
		// 세션에 저장한 아이디 값을 불러옴  
		String userid = (String) session.getAttribute("userid");
		log.info("userid : " + userid);
		
		// 로그인한 사용자에 한해 게시물 추천 여부 확인 
		try {
			
			LikeVO like = likeService.checkLike(bno, userid);
			
			if(like == null) {
				return;
			} else {
				log.info("Like History : " + like.toString());
				model.addAttribute("like", like);
			}
		
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//4-1. 게시물 수정 페이지로 이동
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/modify");
		model.addAttribute("board", service.get(bno));
	}
	
	//4-2. 특정 게시물을 수정한다. 
	//@PreAuthorize: 작성자만이 게시물 수정 가능 
	@PostMapping("/modify")
	@PreAuthorize("principal.username == #board.userid")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + board);
		
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		// 2. UriComponentsBuilder로 생성된 URL을 이용하여 리다이렉트를 처리. 
		return "redirect:/sjboard/list" + cri.getListLink();
	}
	
	//5. 특정 게시물을 삭제한다. 
	//5-1. 특정 게시물을 삭제하면서 첨부파일도 함께 삭제한다. 
	//@PreAuthroze: 작성자만이 게시물 삭제 가능
	@PostMapping("/remove")
	@PreAuthorize("principal.username == #board.userid")
	public String remove(@RequestParam("bno")Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
			, BoardVO board) {
		log.info("remove:" + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result","success");
		}
		
		// 2. UriComponentsBuilder로 생성된 URL을 이용하여 리다이렉트를 처리. 
		return "redirect:/sjboard/list" + cri.getListLink();
	}
	
	//6. 해당 게시물의 첨부파일 목록을 가져온다. 
	@GetMapping(value = "/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		
		log.info("getAttachList" + bno); 
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	//7. 게시물을 삭제하면서 첨부파일도 삭제한다. 
	public void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList== null || attachList.size() == 0) {
			return; 
		}
		
		log.info("delete attach files............." );
		log.info("attachList :" + attachList);
		
		// 파일 업로드 경로 
		String uploadFolder = new AttachFileDTO().uploadFolder;
		
		attachList.forEach(attach -> {
			
			try {
				Path file = Paths.get(uploadFolder + attach.getUploadPath()+"/"
									+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get(uploadFolder+attach.getUploadPath()+"/s_"
												+attach.getUuid()+"_"+attach.getFileName());
					
					Files.delete(thumbNail);
				}
				
			}catch(Exception e) {
				log.error("delete files error" + e.getMessage());
			}
		});
	}
}
