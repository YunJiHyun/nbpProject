package com.naver.jihyunboard.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.naver.jihyunboard.user.dto.UserDTO;
import com.naver.jihyunboard.user.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping("/login")
	 public String login() {
		return "/user/login";
	}
	
	@RequestMapping("/register")
	 public String register() {
		return "/user/register";
	}
	
	@RequestMapping(method=RequestMethod.POST,value="/addUser")
	public String addUser(@ModelAttribute UserDTO dto) {
		userService.registerUser(dto);
		return "redirect:login";
	}

}
