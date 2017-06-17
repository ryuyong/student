<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
});

function inserthakwon() {
	var frm_insert = $('#frm_insert')[0];
	var hakwon_nm = $('#hakwon_nm').val();
	if(hakwon_nm == '') {
		alert('학원명을 입력해 주세요.');
		return;
	}
	if(confirm("학원을 등록하겠습니까?")) {
		frm_insert.target = "summitframe";
		frm_insert.submit();
	}
}
</script>
<!-- state : end -->
<form id="frm_insert" name="frm_insert" method="post" action="<c:url value="/admin/hakwon_insertafter.do" />">
<input type="hidden" name="use_yn" value="Y" />
<div class="content_wrap">
	<div class="content content_style3">
		<hr>
		<h4 class="c_bullet bold">학원등록</h4>
		<div class="form_table">
			<table>
				<colgroup><col width="15%" /><col width="85%" /></colgroup>
				<tbody>
					<tr>
						<th scope="row">학원명</th>
						<td>
							<input type="text" name="hakwon_nm" id="hakwon_nm" maxlength="16" style="width: 250px;" class="inform4">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="default_btn_wrap">	
			<span class="sb_type_s"><a href="javascript:inserthakwon()">등록</a></span>
		</div>
	</div>
</div>
</form>
