package com.naver.jihyunboard.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.naver.jihyunboard.board.service.BoardService;
import com.naver.jihyunboard.user.dto.UserDTO;
import com.naver.jihyunboard.user.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    BoardService boardService;

    @RequestMapping("/login")
    public String login() {
        return "/user/login";
    }

    @RequestMapping("/loginCheck")
    public ModelAndView loginCheck(@ModelAttribute UserDTO dto, HttpSession session) throws Exception {

        boolean result = userService.loginCheck(dto, session);

        ModelAndView mv = new ModelAndView();

        if (result == true) {
            //로그인 성공
            mv.addObject("boardList", boardService.listAll());
            mv.setViewName("/board/list");
        } else {
            //mv.addObject("msg", "아이디나 비밀번호가 맞지 않습니다.");
            mv.setViewName("redirect:login");
        }

        return mv;

    }

    @RequestMapping("/register")
    public String register() {
        return "/user/register";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/checkId", produces = "application/json")
    public @ResponseBody UserDTO checkId(@RequestParam("userId") int userId) {
        UserDTO userdto = userService.checkId(userId);
        return userdto;

    }

    @RequestMapping(method = RequestMethod.POST, value = "/addUser")
    public String addUser(@ModelAttribute UserDTO dto) {
        userService.registerUser(dto);
        return "redirect:login";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("userId");
        return "redirect:login";
    }

}
