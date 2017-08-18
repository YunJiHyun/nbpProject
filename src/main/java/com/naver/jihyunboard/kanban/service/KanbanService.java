package com.naver.jihyunboard.kanban.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.board.model.Board;
import com.naver.jihyunboard.board.repository.BoardRepository;
import com.naver.jihyunboard.kanban.model.Kanban;
import com.naver.jihyunboard.kanban.repository.KanbanRepository;

@Service
public class KanbanService {

	@Autowired
	KanbanRepository kanbanRepository;

	@Autowired
	BoardRepository boardRepository;

	public Board writeKanban(int boardNum) throws Exception {
		return boardRepository.viewBoard(boardNum);
	}

	public void insertKanban(Kanban kanban, int userId) {
		kanban.setKanbanUserId(userId);
		kanbanRepository.insertKanban(kanban);

	}

	public List<Kanban> kanbanListAll(int userId) {
		return kanbanRepository.kanbanListAll(userId);
	}

	public void updateKanban(Kanban kanban, int stateNum) {

		String kanbanState = kanban.getKanbanState();
		if ((kanbanState.equals("TODO") && stateNum < 10) || (kanbanState.equals("DOING") && stateNum < 6)
			|| (kanbanState.equals("DONE") && stateNum < 8)) {
			kanbanRepository.updateKanban(kanban);
		}
		if (kanbanState.equals("DELETE")) {
			kanbanRepository.deleteKanban(kanban);
		}

	}

	public Board viewDetailDialog(Board board) throws Exception {
		return boardRepository.viewBoard(board.getBoardNum());

	}

	public int getStateNum(Kanban kanban, int userId) {
		kanban.setKanbanUserId(userId);
		return kanbanRepository.getStateNum(kanban);
	}

	public int checkAddedKanban(int userId, int boardNum) {
		Kanban kanban = new Kanban();
		kanban.setKanbanBoardNum(boardNum);
		kanban.setKanbanUserId(userId);
		return kanbanRepository.checkAddedKanban(kanban);
	}

}
