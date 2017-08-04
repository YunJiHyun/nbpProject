package com.naver.jihyunboard.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

	/**
	 * 회원가입 페이지로 이동
	 * @return
	 */
	@RequestMapping("/register")
	public String goRegisterPage() {
		return "/user/register";
	}

	@ResponseBody
	@RequestMapping(value = "/checkId", method = RequestMethod.POST, produces = "application/json")
	public BoardUser checkId(@RequestParam("userId") int userId) {
		BoardUser userdto = userService.checkId(userId);
		return userdto;

	}

	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	public String insertUserData(@ModelAttribute BoardUser dto) {
		dto.setUserPw(shaEncoder.saltEncoding(dto.getUserPw(), dto.getUserId()));
		userService.insertUser(dto);
		return "redirect:/login";
	}

	@RequestMapping(value = "/userInfo", method = RequestMethod.POST)
	public String userInfo(int userId, Model model) {
		model.addAttribute("boardUser", userService.userInformation(userId));
		return "user/userInfo";
	}

}
