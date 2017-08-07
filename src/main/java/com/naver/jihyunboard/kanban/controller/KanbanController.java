package com.naver.jihyunboard.kanban.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.naver.jihyunboard.board.model.Board;
import com.naver.jihyunboard.board.service.BoardService;
import com.naver.jihyunboard.kanban.model.Kanban;
import com.naver.jihyunboard.kanban.service.KanbanService;

@Controller
@RequestMapping("/kanban/")
public class KanbanController {

	@Autowired
	KanbanService kanbanService;

	@Autowired
	BoardService boardService;

	/**
	 * 현재 로그인한 사용자의 칸반보드 메인 페이지
	 * @param board
	 * @param auth
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mainList")
	public String goKanbanMainPage(Authentication auth, Model model) throws Exception {
		int userId = Integer.parseInt(boardService.authUserId(auth));
		model.addAttribute("kanbanList", kanbanService.kanbanListAll(userId));
		return "kanban/kanbanMain";
	}

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String goKanbanWritePage(Board board, Model model) throws Exception {
		model.addAttribute("board", kanbanService.writeKanban(board.getBoardNum()));
		return "kanban/kanbanWriteForm";
	}

	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public void insertKanbanData(Kanban kanban, Authentication auth) throws Exception {
		int userId = Integer.parseInt(boardService.authUserId(auth));
		kanbanService.insertKanban(kanban, userId);
	}
}
