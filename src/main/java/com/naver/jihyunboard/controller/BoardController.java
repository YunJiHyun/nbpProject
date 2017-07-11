package com.naver.jihyunboard.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.naver.jihyunboard.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
    BoardService boardService;
	   
	   //게시글 리스트
	   @RequestMapping("/board/list")
	    public String list(Model model) throws Exception{
		   model.addAttribute("boardList", boardService.listAll());
		   return "/board/list";		
	    }
	   
	   //새 글 작성하기
	   @RequestMapping(method=RequestMethod.GET, value="/write")
	    public String write(){
	        return "/board/write"; 
	    }

	   
}
