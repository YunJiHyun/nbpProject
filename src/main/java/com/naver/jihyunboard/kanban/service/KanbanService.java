package com.naver.jihyunboard.kanban.service;

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
		System.out.println("dkjlwjkdljkl" + kanban.getKanbanUserId());
		System.out.println("ffffffffffff" + kanban.getKanbanBoardNum());
		System.out.println("ffffffffffff" + kanban.getKanbanContent());
		System.out.println("ffffffffffff" + kanban.getKanbanImportance());
		System.out.println("ffffffffffff" + kanban.getKanbanDeadline());
		kanbanRepository.insertKanban(kanban);

	}
}
