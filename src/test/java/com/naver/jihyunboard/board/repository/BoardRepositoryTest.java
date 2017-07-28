package com.naver.jihyunboard.board.repository;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:application-context.xml")
public class BoardRepositoryTest {

	@Autowired
	BoardRepository boardDao;

	@Test
	public void test() throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("searchOption", "all");
		map.put("keyword", "복학");

		int count = boardDao.listCount(map);
		assertNotSame(0, count);

		//		Map<String, Object> map = new HashMap<>();
		//		boardDao.listAll(map);

	}

}
