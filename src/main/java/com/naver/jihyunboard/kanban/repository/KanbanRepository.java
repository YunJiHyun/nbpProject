package com.naver.jihyunboard.kanban.repository;

import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.kanban.model.Kanban;

@Repository
public interface KanbanRepository {

	public void insertKanban(Kanban kanban);

	//public Board writeKanban(Board board);

}
