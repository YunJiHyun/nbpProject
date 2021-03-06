package com.naver.jihyunboard.reply.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.naver.jihyunboard.board.model.BoardPageHelper;
import com.naver.jihyunboard.board.service.BoardService;
import com.naver.jihyunboard.reply.model.Reply;
import com.naver.jihyunboard.reply.service.ReplyService;

@Controller
@RequestMapping("/reply/")
public class ReplyController {

	@Autowired
	ReplyService replyService;

	@Autowired
	BoardService boardService;

	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public void insertReplyData(@ModelAttribute Reply reply, Authentication auth) {
		reply.setReplyer(boardService.authUserId(auth));
		replyService.insertReply(reply);
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String getReplyList(@RequestParam int boardNum, @RequestParam(defaultValue = "1") int currentPage,
		Authentication auth, Model model) {

		int count = replyService.listCount(boardNum);

		BoardPageHelper replyPageHelper = new BoardPageHelper(count, currentPage, 5);
		replyPageHelper.setBoardNum(boardNum);

		model.addAttribute("userId", boardService.authUserId(auth));
		model.addAttribute("replyList", replyService.replyList(replyPageHelper));
		model.addAttribute("replyPageHelper", replyPageHelper);

		return "reply/replyList";
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String viewReplyDetail(@RequestParam int replyNum, Model model) {
		Reply reply = replyService.detailReply(replyNum);
		model.addAttribute("reply", reply);

		return "reply/replyDetail";
	}

	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateReplyData(Reply reply, Authentication auth, Model model) {
		if (boardService.authUserId(auth).equals(replyService.replyerId(reply.getReplyNum()))) {
			replyService.updateReply(reply);
			return "ok";
		} else {
			return "permission denied";
		}

	}

	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET, produces = "text/plain")
	public String deleteReplyData(Reply reply, Authentication auth, Model model) {
		if (boardService.authUserId(auth).equals(replyService.replyerId(reply.getReplyNum()))) {
			replyService.deleteReply(reply);
			return "ok";
		} else {
			return "permission denied";
		}
	}

}
