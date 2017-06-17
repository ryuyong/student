<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
});

function updatebbs() {
	var frm_update = $('#frm_update')[0];

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
	
	if(confirm("공지사항을 수정하겠습니까?")) {
		frm_update.target = "summitframe";
		frm_update.submit();
	}
}
</script>
<!-- state : end -->
<form id="frm_update" name="frm_update" method="post" action="<c:url value="/admin/bbs_updateafter.do" />" enctype="multipart/form-data" >
<input type="hidden" name="bbs_id" value="${result.bbs_id}" />
<div class="content_wrap">
	<div class="content content_style3">
		<hr>
		<h4 class="c_bullet bold">공지사항수정</h4>
		<div class="form_table">
			<table>
				<colgroup><col width="15%" /><col width="85%" /></colgroup>
				<tbody>
					<tr>
						<th scope="row">공지사항종류</th>
						<td>
							<select name='bbs_gubun' id='bbs_gubun' style="width:150px;">
	       						<option value="">선택</option>
	       						<option value="1" <c:if test="${ result.bbs_gubun eq '1'}">selected</c:if>>NOTICE</option>
	       						<option value="2" <c:if test="${ result.bbs_gubun eq '2'}">selected</c:if>>Listening</option>
	       						<option value="3" <c:if test="${ result.bbs_gubun eq '3'}">selected</c:if>>Data</option>
       						</select>
						</td>
					</tr>
					<tr>
						<th scope="row">공지사항제목</th>
						<td>
							<input type="text" name="bbs_subject" id="bbs_subject" maxlength="80" style="width: 250px;" class="inform4" value="${result.bbs_subject}">
						</td>
					</tr>
					<tr>
						<th scope="row">공지사항내용</th>
						<td>
							<textarea name="bbs_content" id="bbs_content" cols="100" rows="10">${result.bbs_content}</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">학년</th>
						<td>
							<select name='hakneon' id='hakneon' style="width:195px;">
	       						<option value="">전체</option>
			         			<option value="1" <c:if test="${result.hakneon eq '1'}">selected</c:if>>1학년</option>
			         			<option value="2" <c:if test="${result.hakneon eq '2'}">selected</c:if>>2학년</option>
			         			<option value="3" <c:if test="${result.hakneon eq '3'}">selected</c:if>>3학년</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">기존첨부파일</th>
						<td>
							<c:import charEncoding="utf-8" url="/common/selectFileInfs.do" >
		               			 <c:param name="file_id" value="${result.file_id}" />
		               			 <c:param name="file_sn" value="1" />
		        			</c:import>
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
			<span class="sb_type_s"><a href="javascript:updatebbs()">수정</a></span>
		</div>
	</div>
</div>
</form>
