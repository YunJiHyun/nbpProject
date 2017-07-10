package com.naver.jihyunboard.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.naver.jihyunboard.command.BoardCommand;
import com.naver.jihyunboard.command.BoardContentCommand;
import com.naver.jihyunboard.command.BoardDeleteCommand;
import com.naver.jihyunboard.command.BoardListCommand;
import com.naver.jihyunboard.command.BoardModifyCommand;
import com.naver.jihyunboard.command.BoardWriteCommand;

@Controller
public class BoardController {
	
	BoardCommand command; 
	
	@RequestMapping("/list")  // 기본기능 : 리스트
	public String list(Model model){
				
		command = new BoardListCommand();
		command.execute(model);
		
		return "list"; 
	}
	
	@RequestMapping("/write_view") // 기본기능 : 글 쓰기
	public String write_view(Model model){
		
		return "write_view";
	}
	
	@RequestMapping("/write")
	public String write(HttpServletRequest request, Model model){
		model.addAttribute("request",request);
		command = new BoardWriteCommand();
		command.execute(model);
		
		return "redirect:list";
	}
	
	@RequestMapping("content_view") // 기본기능 : 글 읽기
	public String content_view(HttpServletRequest request, Model model){
		
		model.addAttribute("request",request);
		command = new BoardContentCommand();
		command.execute(model);
		
		return "content_view";
	}
	
	@RequestMapping(method=RequestMethod.POST, value="/modify") // 기본기능 : 글 수정하기
	public String modify(HttpServletRequest request, Model model){
		
		model.addAttribute("request", request);
		command = new BoardModifyCommand();
		command.execute(model);
		
		return "redirect:list";
	}
	
	@RequestMapping("/delete") // 기본기능 : 글 삭제하기
	public String delete(HttpServletRequest request, Model model){
		
		model.addAttribute("request",request);
		command = new BoardDeleteCommand();
		command.execute(model);
		return "redirect:list";
	}
	
	
	
}
