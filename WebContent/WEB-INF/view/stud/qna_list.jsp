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

function qnainsert() {
	var frm_insert = $('#frm_insert')[0];
	frm_insert.submit();
}

function qnadetail(qna_cd) {
	var frm_detail = $('#frm_detail')[0];
	frm_detail.qna_cd.value = qna_cd;
	frm_detail.submit();
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
		alert('삭제할 Q&A 를선택해주세요');
		return;
	}
	if(confirm("Q&A를 삭제하겠습니까?")) {
		frm.qna_cds.value = qna_cds;
		frm.submit();
	}
}
</script>
<form id="frm_search" name="frm_search" method="post" action="<c:url value="/stud/qna_list.do" />">
<input type="hidden" name="pageIndex" value="1" />
<div class="content">
	<div class="state">
		<h2><span>Q&A 리스트</span></h2>
	</div>
	
	<div class="search" style="height:40px;">
		<fieldset>
			<div class="selbox" style="width:100%;vertical-align:middle;">
				<label for="searchKeyword"><b>질문제목:</b></label>
				<input type="text" name="searchKeyword" id="searchKeyword" value="${QnaInfoVo.searchKeyword}" />
		    	
		    	<label for="searchKeyword1"><b>답변여부:</b></label>
	    		<select name='searchKeyword1' id='searchKeyword1' style="width:150px;">
					<option value="">전체</option>
					<option value="Y" <c:if test="${QnaInfoVo.searchKeyword1 eq 'Y'}">selected</c:if>>답변</option>
					<option value="N" <c:if test="${QnaInfoVo.searchKeyword1 eq 'N'}">selected</c:if>>미답변</option>
				</select>
				
		    	<input type="button" value="검색" class="btn_search" onclick="javascript:Search(1);" />
			
			</div>
		</fieldset>
	</div>
	<br/>	
	<div class="table_list board_style">
		<table>
			<colgroup><col width="5%" /><col width="5%" /><col width="40%" /><col width="20%" /><col width="10%" /><col width="20%" /></colgroup>
			<thead>
				<tr>
					<th>선택</th>
					<th>번호</th>
					<th>질문제목</th>
					<th>등록일자</th>
					<th>답변일자</th>
					<th>답변여부</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty qnaList}">
					<tr>
						<td colspan="6">검색결과가 없습니다.</td>
					</tr>
				</c:if>
				
				<c:if test="${!empty qnaList}">
					<c:forEach var="qnaList" items="${qnaList}" varStatus="status">
						<tr>
							<td><input type="checkbox" name="chk_qna_cd" id="chk_qna_cd" value="${qnaList.qna_cd}"/></td>
							<td>${qnaList.rnum}</td>
							<td><a href="javascript:qnadetail('${qnaList.qna_cd}')">${qnaList.qna_title}</a></td>
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
	<div class="pagenum mgt_10">
		<!-- 이전/다음페이지 없을 경우, 숨김처리-->
		${pageUtil}
	</div>
	
	<div class="default_btn_wrap">	
		<a href="javascript:qnainsert();" class="btype_m"><span>등록</span></a>
		<a href="javascript:qnadelete();" class="btype_m"><span>삭제</span></a>
	</div>
</div>
</form>

<form id="frm_detail" name="frm_detail" method="post" action="<c:url value="/stud/qna_detail.do" />" >
	<input type="hidden" name="pageIndex" value="${QnaInfoVo.pageIndex}" />
	<input type="hidden" name="searchKeyword" value="${QnaInfoVo.searchKeyword}" />
	<input type="hidden" name="searchKeyword1" value="${QnaInfoVo.searchKeyword1}" />
	<input type="hidden" name="qna_cd" value="" />
</form>

<form id="frm_insert" name="frm_insert" method="post" action="<c:url value="/stud/qna_insert.do" />" >
</form>


<form id="frm_delete" name="frm_delete" method="post" action="<c:url value="/stud/qna_deleteafter.do" />">
	<input type="hidden" name="qna_cds" value="" />
</form>