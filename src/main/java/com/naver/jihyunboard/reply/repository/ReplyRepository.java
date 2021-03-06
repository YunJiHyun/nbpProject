package com.naver.jihyunboard.reply.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.board.model.BoardPageHelper;
import com.naver.jihyunboard.reply.model.Reply;

@Repository
public interface ReplyRepository {

	public void insertReply(Reply reply);

	public List<Reply> replyList(BoardPageHelper replyPageHelper);

	public int listCount(int boardNum);

	public Reply detailReply(int replyNum);

	public void updateReply(Reply reply);

	public void deleteReply(Reply reply);

	public int replyerId(int replyNum);

}
