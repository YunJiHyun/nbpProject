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
	@RequestMapping(value = "/mainList", method = RequestMethod.GET)
	public String goKanbanMainPage(Authentication auth, Model model) throws Exception {
		return "kanban/kanbanMain";
	}

	@RequestMapping(value = "/mainList", method = RequestMethod.POST)
	public String goKanbanPage(Authentication auth, Model model) throws Exception {
		return "redirect:mainList";
	}

	@RequestMapping(value = "/kanbanList", method = RequestMethod.GET)
	public String getKanbanlist(Authentication auth, Model model) throws Exception {
		int userId = Integer.parseInt(boardService.authUserId(auth));
		model.addAttribute("kanbanList", kanbanService.kanbanListAll(userId));
		return "kanban/kanbanList";
	}

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String goKanbanWritePage(Board board, Model model) throws Exception {
		model.addAttribute("board", kanbanService.writeKanban(board.getBoardNum()));
		return "kanban/kanbanWriteForm";
	}

	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	public int insertKanbanData(Kanban kanban, Authentication auth) throws Exception {
		int userId = Integer.parseInt(boardService.authUserId(auth));
		int todoNum = kanbanService.getStateNum(kanban, userId);

		if (todoNum < 10) {
			kanbanService.insertKanban(kanban, userId);
		}
		return todoNum;
	}

	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public int updateKanbanData(Kanban kanban, Authentication auth) throws Exception {
		int userId = Integer.parseInt(boardService.authUserId(auth));
		int stateNum = kanbanService.getStateNum(kanban, userId);
		kanbanService.updateKanban(kanban, stateNum);
		return stateNum;
	}

	@RequestMapping(value = "/viewDetailDialog", method = RequestMethod.POST)
	public String viewDetailDialog(Board board, Model model) throws Exception {
		model.addAttribute("board", kanbanService.viewDetailDialog(board));
		return "kanban/viewDetailDialog";
	}
}
