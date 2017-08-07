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

	public void updateKanban(Kanban kanban) {
		String kanbanState = kanban.getKanbanState();

		if (kanbanState.equals("TODO") || kanbanState.equals("DOING")) {
			kanbanRepository.updateKanban(kanban);
		} else {
			kanbanRepository.deleteKanban(kanban);
		}
	}
}
