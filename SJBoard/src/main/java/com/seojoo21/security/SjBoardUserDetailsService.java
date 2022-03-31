package com.seojoo21.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.seojoo21.domain.MemberVO;
import com.seojoo21.mapper.MemberMapper;
import com.seojoo21.security.domain.SjBoardUser;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SjBoardUserDetailsService implements UserDetailsService{

	@Setter(onMethod_= {@Autowired})
	private MemberMapper memberMapper;
	
	@Override
	// username = userid (회원 아이디임. 사용자이름 아님)
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.warn("Load User By Username(userid) : " + username );
		
		MemberVO vo = memberMapper.read(username);
		
		log.warn("User Info : " + vo);
	
		return vo == null? null : new SjBoardUser(vo);
	}
}
