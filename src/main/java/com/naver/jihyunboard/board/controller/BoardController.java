package com.naver.jihyunboard.board.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.naver.jihyunboard.board.dto.BoardDTO;
import com.naver.jihyunboard.board.service.BoardService;
import com.naver.jihyunboard.user.dto.UserDTO;
import com.naver.jihyunboard.user.service.UserService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

    @Autowired
    BoardService boardService;

    @Autowired
    UserService userService;

    //게시글 리스트
    @RequestMapping("/list")

    public ModelAndView list(@ModelAttribute UserDTO userdto, HttpSession session,
        @RequestParam(defaultValue = "1") int currentPage, Authentication auth) throws Exception {

        //userService.loginCheck(userdto, session);

        ModelAndView mv = new ModelAndView();

        // if (result == true) {
        Map<String, Object> map = boardService.listAll(currentPage);
        mv.addObject("map", map);
        mv.addObject("auth", auth);
        mv.setViewName("/board/list");
        //} else {
        //mv.addObject("msg", "아이디나 비밀번호가 맞지 않습니다.");
        // mv.setViewName("/user/login");
        //}
        return mv;

    }

    //새 글 작성하기
    @RequestMapping(method = RequestMethod.GET, value = "/write")
    public String write() {
        return "/board/write";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/insert")
    public String insert(@ModelAttribute BoardDTO dto) throws Exception {
        boardService.insertBoard(dto);
        return "redirect:list";
    }

    @RequestMapping("/view")
    public String view(@RequestParam("boardNum") int boardNum, HttpSession session, Model model) throws Exception {
        boardService.increaseReadCount(boardNum);
        model.addAttribute("BoardDTO", boardService.viewBoard(boardNum));
        return "/board/board_view";
    }

    @RequestMapping("/modify")
    public String modify(@RequestParam("boardNum") int boardNum, Model model) throws Exception {
        model.addAttribute("BoardDTO", boardService.viewBoard(boardNum));
        return "/board/modify";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/update")
    public String update(@ModelAttribute BoardDTO dto) throws Exception {
        boardService.updateBoard(dto);
        return "redirect:view?boardNum=" + dto.getBoardNum();

    }

    @RequestMapping("/delete")
    public String delete(@RequestParam("boardNum") int boardNum) throws Exception {
        boardService.deleteBoard(boardNum);
        return "redirect:list";
    }

}
