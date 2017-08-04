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

	public void insertReply(Reply reply) {
		replyRepository.insertReply(reply);
	}

	public List<Reply> replyList(BoardPageHelper replyPageHelper) {
		return replyRepository.replyList(replyPageHelper);
	}

	public int listCount(int boardNum) {
		return replyRepository.listCount(boardNum);
	}

	public Reply detailReply(int replyNum) {
		return replyRepository.detailReply(replyNum);
	}

	public void updateReply(Reply reply) {
		replyRepository.updateReply(reply);
	}

	public void deleteReply(Reply reply) {
		replyRepository.deleteReply(reply);
	}

	public String replyerId(int replyNum) {
		return Integer.toString(replyRepository.replyerId(replyNum));
	}

}
