<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
});

function Search(pageIndex) {
	var frm_search = $('#frm_search')[0];
	frm_search.pageIndex.value = pageIndex;
	frm_search.submit();
}

function qnadetail(qna_cd) {
	var frm = $('#frm_detail')[0];
	frm.qna_cd.value = qna_cd;
	frm.submit();
}

function qnadelete() {
	var frm = $('#frm_delete')[0];
	var cnt = 0;
	var qna_cds = '';
	$("input[name=chk_qna_cd]").each(function() {
		if(this.checked) {
			cnt++;
			qna_cds = this.value+":::::";
		}
	});
	if(cnt == 0) {
		alert('삭제할 Q&A를 선택해주세요');
		return;
	}
	if(confirm("Q&A를 삭제하겠습니까?")) {
		frm.qna_cds.value = qna_cds;
		frm.submit();
	}
}

</script>
<!-- state : end -->
<form id="frm_search" name="frm_search" method="post" action="<c:url value="/admin/qna_list.do" />">
<input type="hidden" name="pageIndex" value="1" />
<div class="content_wrap">
	<div class="content content_style1">
		<hr>
		<h4 class="c_bullet bold">Q&A 리스트</h4>
		
		<div class="search" style="height:100px;">
			<fieldset>
				<p class="mgt_10 mgl_10 left">
					<label for="hakwon_cd">학원</label>
					<select name='hakwon_cd' id='hakwon_cd' style="width:150px;">
      						<option value="">선택</option>
	         			<c:forEach var="hakwonList" items="${hakwonList}" varStatus="status">
							<option value="${hakwonList.hakwon_cd}" <c:if test="${hakwonList.hakwon_cd eq QnaInfoVo.hakwon_cd}">selected</c:if>>${hakwonList.hakwon_nm}</option>
						</c:forEach>
					</select>
					<label for="searchKeyword">질문제목</label>
					<input type="text" name="searchKeyword" id="searchKeyword" value="${QnaInfoVo.searchKeyword}" />
					
				</p>
				<p class="mgt_10 mgl_10 left">

					
					<label for="stud_nm">질문자명</label>
					<input type="text" name="searchKeyword1" id="searchKeyword1" value="${QnaInfoVo.searchKeyword1}" />
					
					<label for="stud_nm">답변여부</label>
					<select name='search_qna_answer_state' id='search_qna_answer_state' style="width:150px;">
						<option value="">전체</option>
						<option value="Y" <c:if test="${QnaInfoVo.search_qna_answer_state eq 'Y'}">selected</c:if>>답변</option>
						<option value="N" <c:if test="${QnaInfoVo.search_qna_answer_state eq 'N'}">selected</c:if>>미답변</option>
					</select>
					
					<input type="button" value="검색" class="admin_search"  onclick="javascript:Search(1)"/>
					
				</p>
			</fieldset>
		</div>
		<br/>
		<div class="table_list table_list_style5">
			<table>
				<colgroup><col width="5%" /><col width="5%" /><col width="30%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /></colgroup>
				<thead>
					<tr>
						<th>ㅁ</th>
						<th>번호</th>
						<th>질문제목</th>
						<th>학원명</th>
						<th>질문자ID</th>
						<th>질문자명</th>
						<th>등록일자</th>
						<th>답변일자</th>
						<th>답변여부</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty qnaList}">
						<tr>
							<td colspan="9">검색결과가 없습니다.</td>
						</tr>
					</c:if>
					
					<c:if test="${!empty qnaList}">
						<c:forEach var="qnaList" items="${qnaList}" varStatus="status">
							<tr>
								<td><input type="checkbox" name="chk_qna_cd" id="chk_qna_cd" value="${qnaList.qna_cd}"/></td>
								<td>${qnaList.rnum}</td>
								<td><a href="javascript:qnadetail('${qnaList.qna_cd}')">${qnaList.qna_title}</a></td>
								<td>${qnaList.hakwon_nm}</td>
								<td>${qnaList.stud_id}</td>
								<td>${qnaList.stud_nm}</td>
								<td>${qnaList.reg_date}</td>
								<td>
								<c:if test="${empty qnaList.answer_date}">
									&nbsp;
								</c:if>
								<c:if test="${!empty qnaList.answer_date}">
									${qnaList.answer_date}
								</c:if>
								</td>
								<td>
									<c:if test="${qnaList.qna_answer_state eq 'Y'}">
										답변
									</c:if>
									<c:if test="${qnaList.qna_answer_state eq 'N'}">
										미답변
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="right_btn_wrap2">	
			<span class="sb_type_s"><a href="javascript:qnadelete()">삭제</a></span>
		</div>
		<div class="pagenum mgt_10">
			<!-- 이전/다음페이지 없을 경우, 숨김처리-->
			${pageUtil}
		</div>
	</div>
</div>
</form>

<form id="frm_detail" name="frm_detail" method="post" action="<c:url value="/admin/qna_detail.do" />">
	<input type="hidden" name="qna_cd" value="" />
	<input type="hidden" name="pageIndex" value="${QnaInfoVo.pageIndex}" />
	<input type="hidden" name="searchKeyword" value="${QnaInfoVo.searchKeyword}" />
	<input type="hidden" name="searchKeyword1" value="${QnaInfoVo.searchKeyword1}" />
	<input type="hidden" name="hakwon_cd" value="${QnaInfoVo.hakwon_cd}" />
	<input type="hidden" name="search_qna_answer_state" value="${QnaInfoVo.search_qna_answer_state}" />
</form>

<form id="frm_delete" name="frm_delete" method="post" action="<c:url value="/admin/qna_deleteafter.do" />">
	<input type="hidden" name="qna_cds" value="" />
</form>