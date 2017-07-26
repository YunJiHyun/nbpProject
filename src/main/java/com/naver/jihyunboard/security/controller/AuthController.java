package com.naver.jihyunboard.security.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

	/**
	 * spring security login-page
	 *
	 * @param error
	 * @param logout
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(
		@RequestParam(value = "error", required = false) String error,
		@RequestParam(value = "logout", required = false) String logout, Model model) {

		if (error != null) {
			model.addAttribute("error", "아이디와 비밀번호를 확인해주세요");
		}

		if (logout != null) {
			model.addAttribute("msg", "로그아웃 하셨습니다.");
		}
		return "/user/login";

	}

}
