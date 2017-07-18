package com.naver.jihyunboard.board.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.naver.jihyunboard.board.dto.BoardDTO;
import com.naver.jihyunboard.board.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

    @Autowired
    BoardService boardService;

    //게시글 리스트
    @RequestMapping("/list")

    public ModelAndView list(@RequestParam(defaultValue = "1") int currentPage) throws Exception {
        /*int count = boardService.boardListCount();
        BoardPageHelper boardPageHelper = new BoardPageHelper(count, currentPage);
        int start = boardPageHelper.getPageBegin();
        int end = boardPageHelper.getPageEnd();
        
        List<BoardDTO> boardList = boardService.listAll(start, end);
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("boardList", boardList);
        map.put("count", count);
        map.put("boardPageHelper", boardPageHelper);*/

        Map<String, Object> map = boardService.listAll(currentPage);

        ModelAndView mv = new ModelAndView();
        mv.addObject("map", map);
        mv.setViewName("/board/list");

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
    public String view(@RequestParam("boardNum") int boardNum, Model model) throws Exception {
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
