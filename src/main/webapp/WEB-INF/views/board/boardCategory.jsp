<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<div id="categoryDiv">
			<ul class="nav nav-pills">
				<li role="presentation" class="active">	
					<a href="${path}/board/list?currentPage=1&searchOption=${boardPageHelper.searchOption}
							&keyword=${boardPageHelper.keyword}">전체</a>
				</li>
				<li role="presentation">
					<a href="${path}/board/list?currentPage=1&searchOption=${boardPageHelper.searchOption}
							&keyword=${boardPageHelper.keyword}&category=공지">
						<c:if test="${boardPageHelper.category ne '공지'}">
							<span style="color:gray">공지</span>
						</c:if>
						<c:if test="${boardPageHelper.category eq '공지'}">
							<b>공지</b>
						</c:if>
					</a>
				</li>
				<li role="presentation">
					<a href="${path}/board/list?currentPage=1&searchOption=${boardPageHelper.searchOption}
							&keyword=${boardPageHelper.keyword}&category=학사">
						<c:if test="${boardPageHelper.category ne '학사'}">
							<span style="color:gray">학사</span>
						</c:if>
						<c:if test="${boardPageHelper.category eq '학사'}">
							<b>학사</b>
						</c:if>	
					</a>
				</li>
				<li role="presentation">
					<a href="${path}/board/list?currentPage=1&searchOption=${boardPageHelper.searchOption}
							&keyword=${boardPageHelper.keyword}&category=장학">
						<c:if test="${boardPageHelper.category ne '장학'}">
							<span style="color:gray">장학</span>
						</c:if>
						<c:if test="${boardPageHelper.category eq '장학'}">
							<b>장학</b>
						</c:if>
					</a>
				</li>
				<li role="presentation">
					<a href="${path}/board/list?currentPage=1&searchOption=${boardPageHelper.searchOption}
							&keyword=${boardPageHelper.keyword}&category=졸업">
						<c:if test="${boardPageHelper.category ne '졸업'}">
							<span style="color:gray">졸업</span>
						</c:if>
						<c:if test="${boardPageHelper.category eq '졸업'}">
							<b>졸업</b>
						</c:if>	
					</a>
				</li>
				<li role="presentation">
					<a href="${path}/board/list?currentPage=1&searchOption=${boardPageHelper.searchOption}
							&keyword=${boardPageHelper.keyword}&category=모집">
						<c:if test="${boardPageHelper.category ne '모집'}">
							<span style="color:gray">모집</span>
						</c:if>
						<c:if test="${boardPageHelper.category eq '모집'}">
							<b>모집</b>
						</c:if>		
					</a>
				</li>
			</ul>
		</div>
