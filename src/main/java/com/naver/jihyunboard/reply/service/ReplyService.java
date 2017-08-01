package com.naver.jihyunboard.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.board.model.BoardPageHelper;
import com.naver.jihyunboard.reply.model.Reply;
import com.naver.jihyunboard.reply.repository.ReplyRepository;

@Service
public class ReplyService {

	@Autowired
	ReplyRepository replyRepository;

	public void insert(Reply reply) {
		replyRepository.insert(reply);
	}

	public List<Reply> list(BoardPageHelper replyPageHelper) {
		return replyRepository.list(replyPageHelper);
	}

	public int listCount(int boardNum) {
		return replyRepository.listCount(boardNum);
	}

}
