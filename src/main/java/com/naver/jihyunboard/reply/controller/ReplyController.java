package com.naver.jihyunboard.reply.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
	public void insert(@ModelAttribute Reply reply, Authentication auth) {
		auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		System.out.println(userId);
		reply.setReplyer(userId);
		replyService.insert(reply);
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam int boardNum, @RequestParam(defaultValue = "1") int currentPage, Model model) {
		int count = replyService.listCount(boardNum);

		BoardPageHelper replyPageHelper = new BoardPageHelper(count, currentPage, 5);
		replyPageHelper.setBoardNum(boardNum);
		model.addAttribute("replyList", replyService.list(replyPageHelper));
		model.addAttribute("replyPageHelper", replyPageHelper);

		return "reply/replyList";
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(@RequestParam int replyNum, Model model) {
		Reply reply = replyService.detail(replyNum);
		model.addAttribute("reply", reply);

		return "reply/replyDetail";
	}

	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void update(Reply reply, Model model) {
		replyService.updateReply(reply);
	}

	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public void delete(Reply reply, Model model) {
		replyService.deleteReply(reply);
	}

}
