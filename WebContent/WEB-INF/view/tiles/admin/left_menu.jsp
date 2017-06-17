<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div class="part_area">
	<h2 class="part_style3"><span class="kill_bl">관리자용</span></h2>
	<div class="user user_style1">
		<div class="user_info">
			<em>${sessionScope.admin.admin_nm}<span>님</span></em>
		</div>
		<div class="logout">
			<a href="<c:url value="/alogout.do" />"><span class="kill_bl">로그아웃</span></a>
		</div>
	</div>
</div>
<!-- quick_area : end -->

<div>
	<dl>
		<dd>
			<ul>
				<li><a href="<c:url value="/admin/hakwon_list.do" />">학원관리</a></li>
				<li><a href="<c:url value="/admin/student_list.do" />">학생관리</a></li>
				<li><a href="<c:url value="/admin/answer_list.do" />">문제별정답리스트</a></li>
				<li><a href="<c:url value="/admin/answersubmit_list.do" />">학생별제출리스트</a></li>
				<li><a href="<c:url value="/admin/wrongnote_make.do" />">오답노트생성</a></li>
				<li><a href="<c:url value="/admin/clinic_make.do" />">클리닉생성</a></li>
				<li><a href="<c:url value="/admin/bbs_list.do" />">공지사항</a></li>
				<li><a href="<c:url value="/admin/qna_list.do" />">Q&A</a></li>
			</ul>
		</dd>
	</dl>
</div>
