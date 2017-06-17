<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
});

function bbslist() {
	var frm_list = $('#frm_list')[0];
	frm_list.submit();
}

</script>
<!-- state : end -->
<div class="content">
	<div class="state">
	<h2><span>공지사항상세</span></h2>
	</div>
	<div class="table_view">
		<table>
			<colgroup><col width="15%" /><col width="85%" /></colgroup>
			<tbody>
				<tr>
					<th scope="row">공지사항제목</th>
					<td>
						${result.bbs_subject}
					</td>
				</tr>
				<tr>
					<th scope="row">공지사항내용</th>
					<td>
						<pre>${result.bbs_content}</pre>
					</td>
				</tr>
				<tr>
					<th scope="row">등록일자</th>
					<td>
						${result.reg_date}
					</td>
				</tr>
				
				<tr>
					<th scope="row">첨부파일</th>
					<td>
						<c:import charEncoding="utf-8" url="/common/selectFileInfs.do" >
	               			 <c:param name="file_id" value="${result.file_id}" />
	               			 <c:param name="file_sn" value="1" />
	        			</c:import>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="default_btn_wrap">	
		<a href="javascript:bbslist();" class="btype_m"><span>목록</span></a>
	</div>
</div>

<form id="frm_list" name="frm_list" method="post" action="<c:url value="/stud/bbs_list.do" />" >
	<input type="hidden" name="pageIndex" value="${BbsInfoVo.pageIndex}" />
	<input type="hidden" name="searchKeyword" value="${BbsInfoVo.searchKeyword}" />
	<input type="hidden" name="bbs_gubun" value="${BbsInfoVo.bbs_gubun}" />
</form>
