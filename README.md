Jihyun Yun
=====

# Development environment
* Language - JSP, JAVA, Javascript, HTML, CSS
* Web framework - Spring MVC
* Java persistence framework - MyBatis
* IDE - Spring Tool Suite

# Server 
* OS : CentOS 7.6
* WEB Server - apache 2.2.31
* WAS - tomcat 7.0.78 
* Server name - dev-inhyun.ncl
* IP - 10.105.171.231

# DB
> MySQL 5.6.30

# DB Tables
* board table 

      CREATE TABLE board(
  
        boardNum int PRIMARY KEY AUTO_INCREMENT,

        boardUserId int NOT NULL,

        boardTitle VARCHAR(150) NOT NULL,

        boardContent VARCHAR(300) NOT NULL,

        boardCategory VARCHAR(45) NOT NULL,

        boardDate DATETIME NOT NULL,

        boardReadCount int DEFAULT 0,

        FOREIGN KEY (`boardUserId`) REFERENCES `user` (`userId`)

      );


* user table 

      CREATE TABLE user(

        userId int  PRIMARY KEY,

        userPw   VARCHAR(15) NOT NULL,

        userName  VARCHAR(30) NOT NULL,

        userMajor VARCHAR(45) NOT NULL,

        userPhoneNum VARCHAR(45) NOT NULL

       );


# Service url
>[10.105.171.231:9001/jihyunboard/login](http://10.105.171.231:9001/jihyunboard/login)

> test ID : 1212220  PW : 1111
