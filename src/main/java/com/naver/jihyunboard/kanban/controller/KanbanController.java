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
	@RequestMapping(value = "/insert", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String insertKanbanData(Kanban kanban, Authentication auth) throws Exception {
		int userId = Integer.parseInt(boardService.authUserId(auth));
		int todoNum = kanbanService.getTodoStateNum(userId);
		if (todoNum >= 10) {
			return "해야할 일이 10개 등록되어있는 상태라 더 이상 등록할 수 없습니다.";
		} else {
			kanbanService.insertKanban(kanban, userId);
			return "등록되었습니다";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void updateKanbanData(Kanban kanban) throws Exception {
		kanbanService.updateKanban(kanban);
	}

	@RequestMapping(value = "/viewDetailDialog", method = RequestMethod.POST)
	public String viewDetailDialog(Board board, Model model) throws Exception {
		model.addAttribute("board", kanbanService.viewDetailDialog(board));
		return "kanban/viewDetailDialog";
	}
}
