<%@ page language="java"%><%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="header_wrap">
<span><b>${sessionScope.stud.stud_nm}</b></span> 님 환영합니다.
<a href="<c:url value="/slogout.do" />" class="btype_c"><span style="font-size:12px;">로그아웃</span></a>
<span style="text-align:right;">
<a href="<c:url value="/stud/question_list.do" />" class="btype_m"><span style="font-size:12px;">문제풀이</span></a>
<a href="<c:url value="/stud/qna_list.do" />" class="btype_m"><span style="font-size:12px;">Q&A게시판</span></a>
<a onclick="javascript:gobbslist('1');" class="btype_m"><span style="font-size:12px;">NOTICE</span></a>
<a onclick="javascript:gobbslist('2');" class="btype_m"><span style="font-size:12px;">Listening</span></a>
<a onclick="javascript:gobbslist('3');" class="btype_m"><span style="font-size:12px;">Data</span></a>
</span>
</div>

