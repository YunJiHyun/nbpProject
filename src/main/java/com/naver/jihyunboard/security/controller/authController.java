package com.naver.jihyunboard.security.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class authController {

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(
        @RequestParam(value = "error", required = false) String error,
        @RequestParam(value = "logout", required = false) String logout) {

        ModelAndView mv = new ModelAndView();
        if (error != null) {
            mv.addObject("error", "아이디와 비밀번호를 확인해주세요");
        }

        if (logout != null) {
            mv.addObject("msg", "로그아웃 하셨습니다. 로그인 페이지로 돌아갑니다.");
        }
        mv.setViewName("/user/login");
        return mv;

    }

}
