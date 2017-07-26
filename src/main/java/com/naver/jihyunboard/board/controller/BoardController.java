package com.naver.jihyunboard.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    @RequestMapping(value = "/list")
    public String list(@ModelAttribute BoardDTO dto, @RequestParam(defaultValue = "1") int currentPage,
        @RequestParam(defaultValue = "all") String searchOption, @RequestParam(defaultValue = "") String keyword,
        Model model) throws Exception {
        Map<String, Object> map = boardService.listAll(searchOption, keyword, currentPage);
        model.addAttribute("map", map);

        return "/board/list";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/write")
    public String write() {
        return "/board/write";
    }

    //새 글 등록하기
    @RequestMapping(method = RequestMethod.POST, value = "/insert")
    public String insert(@ModelAttribute BoardDTO dto, Authentication auth) throws Exception {
        auth = SecurityContextHolder.getContext().getAuthentication();
        String userId = auth.getName();
        dto.setBoardUserId(Integer.parseInt(userId));
        boardService.insertBoard(dto);
        return "redirect:list";
    }

    //게시물 상세보기
    @RequestMapping("/view")
    public String view(@RequestParam("boardNum") int boardNum, @RequestParam("currentPage") int currentPage,
        @RequestParam("searchOption") String searchOption, @RequestParam("keyword") String keyword,
        Model model, Authentication auth) throws Exception {
        boardService.increaseReadCount(boardNum);
        auth = SecurityContextHolder.getContext().getAuthentication();
        String userId = auth.getName();
        model.addAttribute("BoardDTO", boardService.viewBoard(boardNum));
        model.addAttribute("userId", userId);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchOption", searchOption);
        return "/board/board_view";
    }

    @RequestMapping("/modify")
    public String modify(@RequestParam("boardNum") int boardNum, Model model) throws Exception {
        model.addAttribute("BoardDTO", boardService.viewBoard(boardNum));
        return "/board/modify";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/update")
    public String update(@ModelAttribute BoardDTO dto, Authentication auth) throws Exception {
        boardService.updateBoard(dto);
        //권한체크
        auth = SecurityContextHolder.getContext().getAuthentication();
        String userId = auth.getName();
        if (Integer.parseInt(userId) != dto.getBoardUserId()) {
            return "/user/authCheck";
        }
        return "redirect:view?boardNum=" + dto.getBoardNum();
    }

    @RequestMapping("/delete")
    public String delete(@RequestParam("boardNum") int boardNum) throws Exception {
        boardService.deleteBoard(boardNum);
        return "redirect:list";
    }

    @RequestMapping("/getFileList/{boardNum}")
    @ResponseBody
    public List<String> getFileList(@PathVariable("boardNum") int boardNum) {
        return boardService.getFileList(boardNum);
    }

}
