package com.naver.jihyunboard.kanban.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.kanban.model.Kanban;

@Repository
public interface KanbanRepository {

	public List<Kanban> kanbanListAll(int userId);

	public void insertKanban(Kanban kanban);

}
