package com.seojoo21.controller;

import java.security.SecureRandom;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.seojoo21.domain.MemberVO;
import com.seojoo21.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor //@AllArgsConstructor를 이용해서 생성자를 만들고 자동으로 의존성 주입을 해준다.
@Slf4j
public class MemberController {
	
	
	private MemberService service;
	
	private BCryptPasswordEncoder pwdEncoder;

	private JavaMailSender mailSender;
	
	
	// 1. 회원 가입 GET (회원 가입 페이지로 이동) 
	@GetMapping("/register")
	public void getRegister() {
		log.info("Get Member Register............");
	}
	
	// 2. 회원 가입 POST (회원 가입 페이지에서 실제 회원 가입 버튼을 눌렀을 때 회원 가입 처리) 
	@PostMapping("/register")
	public String postRegister(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		
		// 비밀번호 암호화 처리 
		String userpw = pwdEncoder.encode(vo.getUserpw());
		vo.setUserpw(userpw);
		
		// 아이디, 사용자 이름 중복 체크
		int idResult = service.checkUserId(vo.getUserid());
		int userNameResult = service.checkUserName(vo.getUserName());
		
		// 인증번호 체크 
		String isValid = (String) session.getAttribute("isRegNumKey");
		
		try {
			// 아이디, 사용자 이름 중복, 인증 번호 일치 여부 이상 없음 
			if(idResult == 0 && userNameResult == 0 && isValid.equals("Y")) {
				service.registerMember(vo);
				log.info("Sign Up Success....." + vo);
				rttr.addFlashAttribute("result", "success");
				return "redirect:/member/login";
			}
			// 아이디, 사용자 이름 중복, 인증 번호 불일치 
			if(idResult == 1 || userNameResult == 1 || isValid.equals("N")) {
				log.info("Sign Up Fail......" + vo);
				rttr.addFlashAttribute("result", "fail");
				return "redirect:/member/register";
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}

		return "redirect:/member/login"; // 회원 가입 완료 후 로그인 페이지를 호출한다. 
	}
	
	// 2-1. 회원 아이디 중복 여부를 확인한다. 
	@PostMapping("/idCheck")
	@ResponseBody
	public String checkUserId(String userid) throws Exception {
		int result = service.checkUserId(userid);
		if(result != 0) {
			return "fail";
		} else {
			return "success";
		}
	}
	
	// 2-2. 회원 사용자이름 중복 여부를 확인한다. 
	@PostMapping("/userNameCheck")
	@ResponseBody
	public String checkUserName(String userName) throws Exception {
		int result = service.checkUserName(userName);
		if(result != 0) {
			return "fail";
		} else {
			return "success";
		}
	}
	
	
	// 2-3. 회원 가입 시 이메일 인증을 위해 메일로 인증 번호를 보낸다.
	// 7-1. 비밀번호 찾기 시 이메일 인증을 위해 메일로 인증 번호를 보낸다. 
	@GetMapping("/mailCheck")
	@ResponseBody
	public String getMailCheck(String email, HttpSession session) throws Exception{
		
		// 인증번호 난수 생성 
		SecureRandom random = new SecureRandom();
		int checkNum = random.nextInt(888888)+111111; // 111111 ~ 999999 범위의 난수를 얻는다. 
		
		log.info("이메일 데이터 전송 확인");
		log.info("이메일 주소:" + email);
		log.info("인증번호: " + checkNum);
		
		// 인증 이메일 보내기 
		String from = "seojoo21@naver.com";
		String to = email;
		String subject = "SJBoard 인증 번호 안내 메일 입니다.";
		String content = "안녕하세요. SJBoard를 방문해주셔서 감사합니다.<br><br>"
				+ "인증 번호는 " + checkNum + "입니다. <br>"
				+ "해당 인증 번호를 인증 번호 입력란에 입력해주세요.";
		
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");

			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content, true ); 
			
			mailSender.send(mail);
			
		}catch(Exception e){
			
			e.printStackTrace();}
		
		String checkNumToString = Integer.toString(checkNum);
		session.setAttribute("RegNumKey", checkNumToString);
		
		return checkNumToString;
	}
	
	// 2-4. 회원 가입 시 인증 번호 일치 여부를 확인한다. 
	// 7-2. 비밀번호 찾기 시 인증 번호 일치 여부를 확인한다.
	@PostMapping("/regCheckNum")
	@ResponseBody
	public String postRegCheckNum(String regCheckNum, HttpSession session) throws Exception {
		
		String regNumKey = (String) session.getAttribute("RegNumKey"); // 세션에 저장된 인증 번호 값을 입력값과 비교하기 위해 불러온다.
		
		if(!regNumKey.equals(regCheckNum)) {
			session.setAttribute("isRegNumKey", "N"); //인증번호 불일치 시 세션에 "N"을 저장 
			return "fail";
			
		} else {
			session.setAttribute("isRegNumKey", "Y"); //인증번호 일치 시 세션에 "Y"을 저장 
			return "success";
		}
	}
	
	// 3. 회원 정보 조회 GET 
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/profile")
	public void getProfile(Authentication authentication, Model model) throws Exception {
		log.info("Profile...........");
		
		//시큐리티에서 UserDetails 이용하여 로그인 정보를 불러온다. 
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		
		//현재 로그인한 사용자의 아이디를 불러온다. 
		String loginUser = userDetails.getUsername();
		log.info("Login User: " + loginUser);
		
		//현재 로그인한 사용자의 아이디로 회원 정보를 읽어온다.  
		MemberVO vo = service.readMember(loginUser);
		log.info("Login User Info: " + vo);
		
		//view로 읽어온 회원 정보를 넘겨준다. 
		model.addAttribute("profile", vo);
		
	}
	
	// 4. 회원 정보 수정 GET (회원 정보 수정 페이지로 이동) 
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/update")
	public void getUpdate(Authentication authentication, Model model) {
		log.info("Get Member Info Update............");
		
		//시큐리티에서 UserDetails 이용하여 로그인 정보를 불러온다. 
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
				
		//현재 로그인한 사용자의 아이디를 불러온다. 
		String loginUser = userDetails.getUsername();
		log.info("Login User: " + loginUser);
				
		//현재 로그인한 사용자의 아이디로 회원 정보를 읽어온다.  
		MemberVO vo = service.readMember(loginUser);
		log.info("Login User Info: " + vo);
				
		//view로 읽어온 회원 정보를 넘겨준다. 
		model.addAttribute("profile", vo);
		
	}
	
	// 4. 회원 정보 수정 POST(실제 회원 정보 수정)  
	@PreAuthorize("principal.username == #vo.userid")
	@PostMapping("/update")
	public String postUpdate(MemberVO vo, HttpSession session, RedirectAttributes rttr){
		log.info("Post Member Info Update............");
		
		// 비밀번호 암호화 처리 
		String userpw = pwdEncoder.encode(vo.getUserpw());
		vo.setUserpw(userpw);
		
		// 사용자 이름 중복 체크
		int userNameResult = service.checkUserName(vo.getUserName());
		
		try {
			// 사용자 이름 중복 이상 없음
			if(userNameResult == 0) {
				service.updateMember(vo);
				log.info("userNameResult: " + userNameResult);
				log.info("Update User Info Success.....:" + vo);
				rttr.addFlashAttribute("result", "UpdateUserInfoSuccess");
				// 회원 정보 수정 후 기존 세션 종료 
				session.invalidate();
				return "redirect:/member/login";
			} 
			
			// 사용자 이름 중복 
			if (userNameResult == 1) {
				log.info("userNameResult: " + userNameResult);
				log.info("Update User Info Fail.......:" + vo);
				rttr.addFlashAttribute("result", "UpdateUserInfoFail");
				return "redirect:/member/update";
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/member/login"; // 회원 정보 수정 후 다시 로그인 
	}
	
	// 5. 회원 탈퇴 GET (회원 탈퇴 페이지로 이동) 
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/delete")
	public void getDelete(Authentication authentication, Model model) {
		log.info("Get Member Delete...........");
		
		//시큐리티에서 UserDetails 이용하여 로그인 정보를 불러온다. 
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
				
		//현재 로그인한 사용자의 아이디를 불러온다. 
		String loginUser = userDetails.getUsername();
		log.info("Login User: " + loginUser);
				
		//현재 로그인한 사용자의 아이디로 회원 정보를 읽어온다.  
		MemberVO vo = service.readMember(loginUser);
		log.info("Login User Info: " + vo);
				
		//view로 읽어온 회원 정보를 넘겨준다. 
		model.addAttribute("profile", vo);
		
	}
	
	// 5. 회원 탈퇴 POST (실제 회원 탈퇴 처리) 
	@PreAuthorize("principal.username == #vo.userid")
	@PostMapping("/delete")
	public String postDelete(MemberVO vo, Authentication authentication, HttpSession session, RedirectAttributes rttr) {
		log.info("Post Member Delete...........");
		
		//시큐리티에서 UserDetails 이용하여 로그인 정보를 불러온다. 
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
						
		//현재 로그인한 사용자의 아이디와 비밀번호를 불러온다. 
		String loginUser = userDetails.getUsername();
		String loginUserPw = userDetails.getPassword();
		log.info("Login User: " + loginUser + " / " + "Login User Password: " + loginUserPw);
		
		//현재 로그인한 사용자의 비밀번호와 입력된 비밀번호가 같아야만 회원 탈퇴가 된다.
		if(!(pwdEncoder.matches(vo.getUserpw(), loginUserPw))) {
			
			log.info("Delete User Fail.......");
			log.info("Input User Password: " + vo.getUserpw());
			rttr.addFlashAttribute("result", "deleteUserFail");
			return "redirect:/member/delete";
			
		} else {
			
			service.deleteMember(loginUser, loginUserPw);
			SecurityContextHolder.clearContext(); // 이 코드가 있어야만 회원 탈퇴 시 로그아웃 처리가 된다. 필수.
			session.invalidate();
			
			log.info("Delete User Success......");
			rttr.addFlashAttribute("result", "deleteUserSuccess");
			
			return "redirect:/";
		}
		
	}
	
	// 6. 회원 아이디 찾기 GET (회원 아이디 찾기 페이지로 이동)
	@GetMapping("/findId")
	public void getFindId() {
		log.info("Get Find Id.............");
	}
	
	// 6. 회원 아이디 찾기 POST (실제 회원 아이디 찾기 처리) 
	@PostMapping("/findId")
	public void postFindId(String email, Model model) {
		log.info("Post Find Id........");
		log.info("Email Input : " + email);
		
		List<MemberVO> userIdList = service.findUserId(email);
		
		// 해당 이메일로 가입된 아이디가 없다.
		if(userIdList.size() == 0 || userIdList == null) { 
			log.info("userIdList" + userIdList);
			model.addAttribute("fail", 0);
		
		// 해당 이메일로 가입된 아이디가 있다.
		} else {
			log.info("userIdList : " + userIdList);
			
			Set<String> regIdSet = new HashSet<String>();
			
			for (MemberVO memberList : userIdList) {
				log.info("memberList: " + memberList);
				log.info("userId : " + memberList.getUserid());
				
				for(int i=0; i<userIdList.size(); i++) {
					regIdSet.add(memberList.getUserid());
				} 
			}
	
			log.info("regIdSetset: " + regIdSet);
			
			model.addAttribute("success", 1);
			model.addAttribute("userid", regIdSet);

		}
	}
	
	// 7. 회원 비밀번호 찾기 GET (비밀번호 찾기 페이지로 이동)
	@GetMapping("/findPwd")
	public void getFindPwd() {
		log.info("Get Find Pwd.........");
	}
	
	// 7. 회원 비밀번호 찾기 POST (실제 비밀번호 찾기 처리) 
	@PostMapping("/findPwd")
	public String postFindPwd(String userid, String email, HttpSession session, RedirectAttributes rttr) {
		log.info("Post Find Pwd.........");
		log.info("userid: " + userid);
		log.info("email: " + email);
		
		// 인증번호 체크 
		String isValid = (String) session.getAttribute("isRegNumKey");
		
		// 아이디 세션 저장
		session.setAttribute("userid", userid);
		
		try {
			// 인증 번호 일치 시 
			if(isValid.equals("Y")) {
				log.info("인증 번호 일치 ");
				rttr.addFlashAttribute("result", "success");
				return "redirect:/member/updatePwd";
			}
			// 인증 번호 불일치 시 
			if(isValid.equals("N")) {
				log.info("인증 번호 불일치");
				rttr.addFlashAttribute("result", "fail");
				return "redirect:/member/findPwd";
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:/member/updatePwd";
		
	}
	
	// 8. 비밀번호 재설정 Get (비밀번호 재설정 페이지로 이동) 
	@GetMapping("/updatePwd")
	public void getUpdatePwd() {
		log.info("Get Update Pwd...........");
	}
	
	// 8. 비밀번호 재설정 POST (실제 비밀번호 재설정 처리)
	@PostMapping("/updatePwd")
	public String postUpdatePwd(String userid, String userpw, HttpSession session, RedirectAttributes rttr) {
		log.info("Post Update Pwd...........");
		
		// 비밀번호 암호화 
		String encodedUserpw = pwdEncoder.encode(userpw);
		service.updatePwd(userid, encodedUserpw);
		rttr.addFlashAttribute("result", "UpdatePwSuccess");
		
		// 비밀번호 수정 후 기존 세션 종료 
		session.invalidate();
		
		return "redirect:/member/login"; // 비밀 번호 수정 후 로그인 페이지로  
	}
}
