<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
});

function updatehakwon() {
	var frm_update = $('#frm_update')[0];
	var hakwon_nm = $('#hakwon_nm').val();
	if(hakwon_nm == '') {
		alert('학원명을 입력해 주세요.');
		return;
	}
	if(confirm("학원을 수정하겠습니까?")) {
		frm_update.target = "summitframe";
		frm_update.submit();
	}
}
</script>
<!-- state : end -->
<form id="frm_update" name="frm_update" method="post" action="<c:url value="/admin/hakwon_updateafter.do" />">
<input type="hidden" name="hakwon_cd" value="${result.hakwon_cd}" />
<div class="content_wrap">
	<div class="content content_style3">
		<hr>
		<h4 class="c_bullet bold">학원수정</h4>
		<div class="form_table">
			<table>
				<colgroup><col width="15%" /><col width="85%" /></colgroup>
				<tbody>
					<tr>
						<th scope="row">학원명</th>
						<td>
							<input type="text" name="hakwon_nm" id="hakwon_nm" maxlength="16" style="width: 250px;" class="inform4" value="${result.hakwon_nm}">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="right_btn_wrap2">	
			<span class="sb_type_s">
				<a href="javascript:updatehakwon()">수정</a>
			</span>
		</div>
	</div>
</div>
</form>
