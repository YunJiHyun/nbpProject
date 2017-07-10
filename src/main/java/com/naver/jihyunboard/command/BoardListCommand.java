package com.naver.jihyunboard.command;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.naver.jihyunboard.dao.BoardDAO;
import com.naver.jihyunboard.dto.BoardDTO;

public class BoardListCommand implements BoardCommand{

	@Override
	public void execute(Model model) {
	
		BoardDAO bordDAO = new BoardDAO();
		ArrayList<BoardDTO> boardDTOs = bordDAO.list();
		
		model.addAttribute("list",boardDTOs);
	} 

}
