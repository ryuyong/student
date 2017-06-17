<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
});

function updateqna() {
	var frm_update = $('#frm_update')[0];
	
	var qna_title = $('#qna_title').val();
	if(qna_title == '') {
		alert('질문제목을 입력해 주세요.');
		return;
	}
	
	var qna_content = $('#qna_content').val();
	if(qna_content == '') {
		alert('질문내용을 입력해 주세요.');
		return;
	}
	
	if(confirm("Q&A을 수정하겠습니까?")) {
		frm_update.target = "summitframe";
		frm_update.submit();
	}
}

function qnalist() {
	var frm_list = $('#frm_list')[0];
	frm_list.submit();
}

</script>
<!-- state : end -->
<form id="frm_update" name="frm_update" method="post" action="<c:url value="/stud/qna_updateafter.do" />">
<input type="hidden" name="qna_cd" value="${result.qna_cd}" />
<input type="hidden" name="pageIndex" value="${QnaInfoVo.pageIndex}" />
<input type="hidden" name="searchKeyword" value="${QnaInfoVo.searchKeyword}" />
<input type="hidden" name="searchKeyword1" value="${QnaInfoVo.searchKeyword1}" />
<div class="content">
	<div class="state">
	<h2><span>Q&A상세</span></h2>
	</div>
	<div class="table_view">
		<table>
			<colgroup><col width="15%" /><col width="85%" /></colgroup>
			<tbody>
				<tr>
					<th scope="row">질문제목</th>
					<td>
						<input type="text" name="qna_title" id="qna_title" maxlength="100" style="width: 400px;" value="${result.qna_title}" class="inform4">
					</td>
				</tr>
				<tr>
					<th scope="row">질문내용</th>
					<td>
						<textarea name="qna_content" id="qna_content" cols="100" rows="10">${result.qna_content}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">등록일자</th>
					<td>
						${result.reg_date}
					</td>
				</tr>
				<tr>
					<th scope="row">답변여부</th>
					<td>
						<c:if test="${result.qna_answer_state eq 'Y'}">
							답변
						</c:if>
						<c:if test="${result.qna_answer_state eq 'N'}">
							미답변
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row">답변일자</th>
					<td>
						${result.answer_date}
					</td>
				</tr>
				<tr>
					<th scope="row">답변내용</th>
					<td>
						<pre>${result.qna_answer}</pre>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="default_btn_wrap">	
		<a href="javascript:updateqna();" class="btype_m"><span>수정</span></a>
		<a href="javascript:qnalist();" class="btype_m"><span>목록</span></a>
	</div>
</div>
</form>

<form id="frm_list" name="frm_list" method="post" action="<c:url value="/stud/qna_list.do" />" >
	<input type="hidden" name="pageIndex" value="${QnaInfoVo.pageIndex}" />
	<input type="hidden" name="searchKeyword" value="${QnaInfoVo.searchKeyword}" />
	<input type="hidden" name="searchKeyword1" value="${QnaInfoVo.searchKeyword1}" />
</form>
