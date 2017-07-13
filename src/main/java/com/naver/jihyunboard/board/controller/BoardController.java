package com.naver.jihyunboard.board.controller;



import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.naver.jihyunboard.board.dto.BoardDTO;
import com.naver.jihyunboard.board.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
    BoardService boardService;
	   
	   //게시글 리스트
	   @RequestMapping("/list")
	    public String list(Model model) throws Exception{
		   model.addAttribute("boardList", boardService.listAll());
		   return "/board/list";		
	    }
	   
	   //새 글 작성하기
	   @RequestMapping(method=RequestMethod.GET, value="/write")
	    public String write(){
	        return "/board/write"; 
	    }
	   
	   @RequestMapping(method=RequestMethod.POST, value="/insert")
	   public String insert(@ModelAttribute BoardDTO dto) throws Exception{
		   boardService.insertBoard(dto);
		   return "redirect:list";
	   }
	   
	   @RequestMapping("/view")
	   public String boardView(HttpServletRequest request, Model model) throws Exception{
		   String title = request.getParameter("boardTitle");
		   String content = request.getParameter("boardContent");
		   String category = request.getParameter("boardCategory");
		   System.out.println("제목" + title);
		   System.out.println("내용" + content);
		   System.out.println("분류" + category);
		   model.addAttribute("BoardDTO",boardService.viewBoard(title));
		   return "/board/board_view";
	   }
	   
	   
	   
	   
}
