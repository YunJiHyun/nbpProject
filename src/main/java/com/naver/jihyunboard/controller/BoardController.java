package com.naver.jihyunboard.controller;



import java.util.ArrayList;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.naver.jihyunboard.dto.BoardDTO;
import com.naver.jihyunboard.service.BoardService;

@Controller
public class BoardController {
	
	@Inject
    BoardService boardService;
	
	 //게시글 목록
    @RequestMapping("/list")
    public ModelAndView list() throws Exception{
        ArrayList<BoardDTO> list = boardService.listAll();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("list"); // 뷰를 list.jsp로 설정
        mv.addObject("list", list); // 데이터를 저장
        return mv;
    }
}
