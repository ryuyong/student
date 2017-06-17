<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
});

function insertqna() {
	var frm_insert = $('#frm_insert')[0];

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
	
	if(confirm("Q&A을 등록하겠습니까?")) {
		frm_insert.target = "summitframe";
		frm_insert.submit();
	}
}
</script>
<!-- state : end -->
<form id="frm_insert" name="frm_insert" method="post" action="<c:url value="/stud/qna_insertafter.do" />">
<input type="hidden" name="use_yn" value="Y" />
<div class="content">
	<div class="state">
	<h2><span>Q&A등록</span></h2>
	</div>
	<div class="table_view">
		<table>
			<colgroup><col width="15%" /><col width="85%" /></colgroup>
			<tbody>
				<tr>
					<th scope="row">질문제목</th>
					<td>
						<input type="text" name="qna_title" id="qna_title" maxlength="100" style="width: 400px;" class="inform4">
					</td>
				</tr>
				<tr>
					<th scope="row">질문내용</th>
					<td>
						<textarea name="qna_content" id="qna_content" cols="100" rows="10"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="default_btn_wrap">	
		<a href="javascript:insertqna();" class="btype_m"><span>등록</span></a>
	</div>
</div>
</form>
