<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
});

function updatestudent() {
	var frm_update = $('#frm_update')[0];
	var hakwon_cd = $('#hakwon_cd').val();
	if(hakwon_cd == '') {
		alert('학원을 선택해 주세요.');
		return;
	}
	
	
	var stud_id = $('#stud_id').val();
	if(stud_id == '') {
		alert('학생ID를 입력해 주세요.');
		return;
	}
	
	var stud_nm = $('#stud_nm').val();
	if(stud_nm == '') {
		alert('학생명를 입력해 주세요.');
		return;
	}
	/*
	var clinictype = $('#clinictype').val();
	if(clinictype != '') {
		if(/[^A-Z]/g.test(clinictype)) {
			alert('클리닉 유형은 영문대문자로 입력해 주세요.');
			return;
		}
	}*/
	
	if(confirm("학생을 수정하겠습니까?")) {
		frm_update.target = "summitframe";
		frm_update.submit();
	}
}
</script>
<!-- state : end -->
<form id="frm_update" name="frm_update" method="post" action="<c:url value="/admin/student_updateafter.do" />">
<input type="hidden" name="stud_cd" value="${result.stud_cd}" />
<input type="hidden" name="old_stud_id" value="${result.stud_id}" />
<div class="content_wrap">
	<div class="content content_style3">
		<hr>
		<h4 class="c_bullet bold">학생수정</h4>
		<div class="form_table">
			<table>
				<colgroup><col width="15%" /><col width="85%" /></colgroup>
				<tbody>
					<tr>
						<th scope="row">학원선택</th>
						<td>
							<select name='hakwon_cd' id='hakwon_cd' style="width:150px;">
		      						<option value="">선택</option>
			         			<c:forEach var="hakwonList" items="${hakwonList}" varStatus="status">
									<option value="${hakwonList.hakwon_cd}" <c:if test="${hakwonList.hakwon_cd eq result.hakwon_cd}">selected</c:if>>${hakwonList.hakwon_nm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">학생ID</th>
						<td>
							<input type="text" name="stud_id" id="stud_id" maxlength="16" style="width: 250px;" onkeyup="checkHan(this)" class="inform4" value="${result.stud_id}" />
						</td>
					</tr>
					<tr>
						<th scope="row">학생명</th>
						<td>
							<input type="text" name="stud_nm" id="stud_nm" maxlength="16" style="width: 250px;" class="inform4" value="${result.stud_nm}" />
						</td>
					</tr>
					<tr>
						<th scope="row">클리닉 유형</th>
						<td>
							<input type="text" name="clinictype" style="width:250px;" id="clinictype" value="${result.clinictype}" maxlength="20" />
						</td>
					</tr>
					<tr>
						<th scope="row">학교</th>
						<td>
							<input type="text" name="school" style="width:250px;" id="school" value="${result.school}" maxlength="50" />
						</td>
					</tr>
					<tr>
						<th scope="row">전화번호</th>
						<td>
							<input type="text" name="tel_no" style="width:250px;" id="tel_no" value="${result.tel_no}" maxlength="20" />
						</td>
					</tr>
					<tr>
						<th scope="row">부모님전화번호</th>
						<td>
							<input type="text" name="ptel_no" style="width:250px;" id="ptel_no" value="${result.ptel_no}" maxlength="20" />
						</td>
					</tr>
					<tr>
						<th scope="row">학년</th>
						<td>
							<select name='hakneon' id='hakneon' style="width:195px;">
	       						<option value="">선택</option>
			         			<option value="1" <c:if test="${result.hakneon eq '1'}">selected</c:if>>1학년</option>
			         			<option value="2" <c:if test="${result.hakneon eq '2'}">selected</c:if>>2학년</option>
			         			<option value="3" <c:if test="${result.hakneon eq '3'}">selected</c:if>>3학년</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">비고</th>
						<td>
							<textarea name="bigo" id="bigo" cols="70" rows="10">${result.bigo}</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="right_btn_wrap2">	
			<span class="sb_type_s"><a href="javascript:updatestudent()">수정</a></span>
		</div>
	</div>
</div>
</form>
