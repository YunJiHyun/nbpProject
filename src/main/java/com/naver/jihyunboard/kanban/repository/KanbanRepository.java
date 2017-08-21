package com.naver.jihyunboard.kanban.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.kanban.model.Kanban;

@Repository
public interface KanbanRepository {

	public List<Kanban> kanbanListAll(int userId);

	public void insertKanban(Kanban kanban);

	public void updateKanbanState(Kanban kanban);

	public void deleteKanban(Kanban kanban);

	public int getStateNum(Kanban kanban);

	public int checkAddedKanban(Kanban kanban);

	public void updateKanbanForDeleteBoard(int boardNum);

	public void sortKanbanList(Kanban kanban);

	public void updateKanbanContent(Kanban kanban);

}
