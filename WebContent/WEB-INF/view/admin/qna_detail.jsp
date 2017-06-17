<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
});

function updateqna() {
	var frm_update = $('#frm_update')[0];

	var qna_content = $('#qna_content').val();
	if(qna_content == '') {
		alert('답변내용을 입력해 주세요.');
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
<form id="frm_update" name="frm_update" method="post" action="<c:url value="/admin/qna_updateafter.do" />">
<input type="hidden" name="qna_cd" value="${result.qna_cd}" />
<input type="hidden" name="pageIndex" value="${QnaInfoVo.pageIndex}" />
	<input type="hidden" name="searchKeyword" value="${QnaInfoVo.searchKeyword}" />
	<input type="hidden" name="searchKeyword1" value="${QnaInfoVo.searchKeyword1}" />
	<input type="hidden" name="hakwon_cd" value="${QnaInfoVo.hakwon_cd}" />
	<input type="hidden" name="search_qna_answer_state" value="${QnaInfoVo.search_qna_answer_state}" />
<input type="hidden" name="qna_answer_state" value="Y" />
<div class="content_wrap">
	<div class="content content_style3">
		<hr>
		<h4 class="c_bullet bold">Q&A상세</h4>
		<div class="form_table">
			<table>
				<colgroup><col width="15%" /><col width="85%" /></colgroup>
				<tbody>
					<tr>
						<th scope="row">질문제목</th>
						<td>
							${result.qna_title}
						</td>
					</tr>
					<tr>
						<th scope="row">질문내용</th>
						<td>
							<pre>${result.qna_content}</pre>
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
							<textarea name="qna_answer" id="qna_answer" cols="100" rows="10">${result.qna_answer}</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="right_btn_wrap2">	
			<span class="sb_type_s"><a href="javascript:updateqna();">수정</a></span>
			<span class="sb_type_s"><a href="javascript:qnalist();">목록</a></span>
		</div>
	</div>
</div>
</form>

<form id="frm_list" name="frm_list" method="post" action="<c:url value="/admin/qna_list.do" />" >
	<input type="hidden" name="pageIndex" value="${QnaInfoVo.pageIndex}" />
	<input type="hidden" name="searchKeyword" value="${QnaInfoVo.searchKeyword}" />
	<input type="hidden" name="searchKeyword1" value="${QnaInfoVo.searchKeyword1}" />
	<input type="hidden" name="hakwon_cd" value="${QnaInfoVo.hakwon_cd}" />
	<input type="hidden" name="search_qna_answer_state" value="${QnaInfoVo.search_qna_answer_state}" />
</form>
