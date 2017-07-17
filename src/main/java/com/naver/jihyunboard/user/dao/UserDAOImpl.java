package com.naver.jihyunboard.user.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.user.dto.UserDTO;

@Repository
public class UserDAOImpl implements UserDAO {

    @Autowired
    SqlSession SqlSession;

    private static String namespace = "com.naver.jihyunboard.user.dao.UserDAO";

    @Override
    public void registerUser(UserDTO dto) {
        SqlSession.insert(namespace + ".insert", dto);
    }

    @Override
    public boolean loginCheck(UserDTO dto) {
        String name = SqlSession.selectOne("loginCheck", dto);

        if (name == null) {
            return false;
        }
        return true;
    }

    @Override
    public UserDTO userInfo(UserDTO dto) {
        return SqlSession.selectOne("userInfo", dto);
    }

    @Override
    public UserDTO ckeckId(int userId) {
        return SqlSession.selectOne("checkId", userId);

    }

}
