package com.naver.jihyunboard.security.service;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.user.model.BoardUser;
import com.naver.jihyunboard.user.model.UserDetailsImpl;
import com.naver.jihyunboard.user.service.UserService;

@Service
public class AuthService implements UserDetailsService {

	@Autowired
	private UserService userService;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		BoardUser userdto = userService.checkId(Integer.parseInt(username));
		if (userdto == null) {
			throw new UsernameNotFoundException("해당 사용자가 없습니다.");
		}
		System.out.println(userdto.getUserId());
		Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
		roles.add(new SimpleGrantedAuthority("ROLE_USER")); //권한 부여
		return new UserDetailsImpl(userdto, roles); //UserDetails를 상속받가 따로 구현 할 수도
	}

}
