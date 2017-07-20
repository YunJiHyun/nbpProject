package com.naver.jihyunboard.security.service;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.user.dto.UserDTO;
import com.naver.jihyunboard.user.service.UserServiceImpl;

@Service
public class authService implements UserDetailsService {

    @Autowired
    UserServiceImpl userService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserDTO userdto = userService.checkId(Integer.parseInt(username));
        if (userdto == null) {
            throw new UsernameNotFoundException("해당 사용자가 없습니다.");
        }

        Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
        roles.add(new SimpleGrantedAuthority("ROLE_USER"));
        UserDetails user = new User(username, userdto.getUserPw(), roles); //사용자를 추가
        return user;
    }

}
