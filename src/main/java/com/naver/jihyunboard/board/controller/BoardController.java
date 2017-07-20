package com.naver.jihyunboard.board.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.naver.jihyunboard.board.dto.BoardDTO;
import com.naver.jihyunboard.board.service.BoardServiceImpl;
import com.naver.jihyunboard.user.service.UserServiceImpl;

@Controller
@RequestMapping("/board/*")
public class BoardController {

    @Autowired
    BoardServiceImpl boardService;

    @Autowired
    UserServiceImpl userService;

    //게시글 리스트
    @RequestMapping("/list")

    public String list(@ModelAttribute BoardDTO dto, @RequestParam(defaultValue = "1") int currentPage,
        Model model) throws Exception {

        Map<String, Object> map = boardService.listAll(currentPage);
        model.addAttribute("map", map);
        //model.addAttribute("auth", auth);
        return "/board/list";

    }

    @RequestMapping(method = RequestMethod.GET, value = "/write")
    public String write() {
        return "/board/write";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/insert")
    public String insert(@ModelAttribute BoardDTO dto, Authentication auth) throws Exception {
        auth = SecurityContextHolder.getContext().getAuthentication();
        String user_id = auth.getName();
        dto.setBoardUserId(Integer.parseInt(user_id)); //ID확인 Mapper에서 insert해보기
        // dto.setBoardUserId(Integer.parseInt(user_id));
        boardService.insertBoard(dto);
        return "redirect:list";
    }

    @RequestMapping("/view")
    public String view(@RequestParam("boardNum") int boardNum, Model model) throws Exception {
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
