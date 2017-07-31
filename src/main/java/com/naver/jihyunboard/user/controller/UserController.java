package com.naver.jihyunboard.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.naver.jihyunboard.user.model.BoardUser;
import com.naver.jihyunboard.user.service.ShaEncoder;
import com.naver.jihyunboard.user.service.UserService;

@Controller
@RequestMapping("/user/")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private ShaEncoder shaEncoder;

	@RequestMapping("/register")
	public String register() {
		return "/user/register";
	}

	@ResponseBody
	@RequestMapping(value = "/checkId", method = RequestMethod.POST, produces = "application/json")
	public BoardUser checkId(@RequestParam("userId") int userId) {
		BoardUser userdto = userService.checkId(userId);
		return userdto;

	}

	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	public String addUser(@ModelAttribute BoardUser dto) {
		dto.setUserPw(shaEncoder.saltEncoding(dto.getUserPw(), dto.getUserId()));
		userService.registerUser(dto);
		return "redirect:/login";
	}

}
