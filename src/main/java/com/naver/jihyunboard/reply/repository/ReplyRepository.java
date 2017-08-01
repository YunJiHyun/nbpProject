package com.naver.jihyunboard.reply.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.board.model.BoardPageHelper;
import com.naver.jihyunboard.reply.model.Reply;

@Repository
public interface ReplyRepository {

	public void insert(Reply reply);

	public List<Reply> list(BoardPageHelper replyPageHelper);

	public int listCount(int boardNum);

	public Reply detail(int replyNum);

	public void updateReply(Reply reply);

}
