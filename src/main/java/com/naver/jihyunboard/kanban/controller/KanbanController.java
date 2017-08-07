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

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String goKanbanWritePage(Board board, Model model) throws Exception {
		model.addAttribute("board", kanbanService.writeKanban(board.getBoardNum()));
		return "kanban/kanbanWriteForm";
	}

	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public void insertKanbanData(Kanban kanban, Authentication auth, Model model) throws Exception {
		int userId = Integer.parseInt(boardService.authUserId(auth));
		kanbanService.insertKanban(kanban, userId);
	}
}
