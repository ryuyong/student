<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
});

function insertbbs() {
	var frm_insert = $('#frm_insert')[0];

	var bbs_gubun = $('#bbs_gubun').val();
	if(bbs_gubun == '') {
		alert('공지사항종류를 선택해 주세요.');
		return;
	}
	var bbs_subject = $('#bbs_subject').val();
	if(bbs_subject == '') {
		alert('공지사항제목을 입력해 주세요.');
		return;
	}
	
	var bbs_content = $('#bbs_content').val();
	if(bbs_subject == '') {
		alert('공지사항내용을 입력해 주세요.');
		return;
	}
	
	if(confirm("공지사항을 등록하겠습니까?")) {
		frm_insert.target = "summitframe";
		frm_insert.submit();
	}
}
</script>
<!-- state : end -->
<form id="frm_insert" name="frm_insert" method="post" action="<c:url value="/admin/bbs_insertafter.do" />" enctype="multipart/form-data">
<input type="hidden" name="use_yn" value="Y" />
<div class="content_wrap">
	<div class="content content_style3">
		<hr>
		<h4 class="c_bullet bold">공지사항등록</h4>
		<div class="form_table">
			<table>
				<colgroup><col width="15%" /><col width="85%" /></colgroup>
				<tbody>
					<tr>
						<th scope="row">공지사항종류</th>
						<td>
							<select name='bbs_gubun' id='bbs_gubun' style="width:150px;">
	       						<option value="">선택</option>
	       						<option value="1">NOTICE</option>
	       						<option value="2">Listening</option>
	       						<option value="3">Data</option>
       						</select>
						</td>
					</tr>
					<tr>
						<th scope="row">공지사항제목</th>
						<td>
							<input type="text" name="bbs_subject" id="bbs_subject" maxlength="80" style="width: 250px;" class="inform4">
						</td>
					</tr>
					<tr>
						<th scope="row">공지사항내용</th>
						<td>
							<textarea name="bbs_content" id="bbs_content" cols="100" rows="10"></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">학년</th>
						<td>
							<select name='hakneon' id='hakneon' style="width:195px;">
	       						<option value="">전체</option>
			         			<option value="1">1학년</option>
			         			<option value="2">2학년</option>
			         			<option value="3">3학년</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일</th>
						<td>
							<input name="file" type="file" style="width:250px;" class="inform4" title="파일첨부"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="right_btn_wrap2">	
			<span class="sb_type_s"><a href="javascript:insertbbs()">등록</a></span>
		</div>
	</div>
</div>
</form>
