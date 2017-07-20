package com.naver.jihyunboard.user.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("userDto")
@Data
public class UserDTO {

    private int userId;
    private String userPw;
    private String userName;
    private String userMajor;
    private String userPhoneNum;

}
