package com.naver.jihyunboard.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.naver.jihyunboard.board.model.Board;
import com.naver.jihyunboard.board.service.BoardService;
import com.naver.jihyunboard.user.service.UserService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	UserService userService;

	//게시글 리스트
	@RequestMapping(value = "/list")
	public String list(@ModelAttribute Board dto, @RequestParam(defaultValue = "1") int currentPage,
		@RequestParam(defaultValue = "all") String searchOption, @RequestParam(defaultValue = "") String keyword,
		Model model) throws Exception {
		Map<String, Object> map = boardService.listAll(searchOption, keyword, currentPage);
		model.addAttribute("map", map);

		return "/board/list";
	}

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write() {
		return "/board/write";
	}

	//새 글 등록하기
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(@ModelAttribute Board dto, Authentication auth) throws Exception {
		boardService.insertBoard(dto, auth);
		System.out.println(dto.getBoardContent());
		return "redirect:list";
	}

	//게시물 상세보기
	@RequestMapping("/view")
	public String view(@RequestParam("boardNum") int boardNum, @RequestParam("currentPage") int currentPage,
		@RequestParam("searchOption") String searchOption, @RequestParam("keyword") String keyword,
		Model model, Authentication auth, HttpServletRequest request, HttpServletResponse response, Board board)
		throws Exception {
		auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		model.addAttribute("BoardDTO", boardService.viewBoard(boardNum, request, response));
		model.addAttribute("userId", userId);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("keyword", keyword);
		model.addAttribute("searchOption", searchOption);
		return "/board/board_view";

	}

	@RequestMapping("/modify")
	public String modify(@RequestParam("boardNum") int boardNum, Model model, HttpServletRequest request,
		HttpServletResponse response,
		@RequestParam("currentPage") int currentPage,
		@RequestParam("searchOption") String searchOption, @RequestParam("keyword") String keyword) throws Exception {
		List<String> list = boardService.getFileList(boardNum);
		model.addAttribute("list", list);
		model.addAttribute("BoardDTO", boardService.viewBoard(boardNum, request, response));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("keyword", keyword);
		model.addAttribute("searchOption", searchOption);
		return "/board/modify";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute Board dto,
		@RequestParam("currentPage") int currentPage,
		@RequestParam("searchOption") String searchOption, @RequestParam("keyword") String keyword) throws Exception {
		boardService.updateBoard(dto);

		return "redirect:view?boardNum=" + dto.getBoardNum()
			+ "&currentPage=" + currentPage
			+ "&searchOption=" + searchOption
			+ "&keyword=" + keyword;
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
