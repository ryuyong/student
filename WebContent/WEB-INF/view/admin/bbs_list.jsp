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

function bbsinsert() {
	var frm_insert = $('#frm_insert')[0];
	frm_insert.submit();
}

function bbsupdate() {
	var frm = $('#frm_update')[0];
	var cnt = 0;
	var bbs_id = '';
	$("input[name=bbs_id]").each(function() {
		if(this.checked) {
			cnt++;
			bbs_id = this.value;
		}
	});
	if(cnt == 0) {
		alert('수정할 공지사항을 선택해주세요');
		return;
	}
	frm.bbs_id.value = bbs_id;
	frm.submit();
}

function bbsdelete() {
	var frm = $('#frm_delete')[0];
	var cnt = 0;
	var bbs_ids = '';
	$("input[name=bbs_id]").each(function() {
		if(this.checked) {
			cnt++;
			bbs_ids = this.value+":::::";
		}
	});
	if(cnt == 0) {
		alert('삭제할 공지사항을 선택해주세요');
		return;
	}
	if(confirm("공지사항을 삭제하겠습니까?")) {
		frm.bbs_ids.value = bbs_ids;
		frm.submit();
	}
}

function fn_downFile(file_id, file_sn){
	var LeftPosition = (screen.width) ? (screen.width-200)/2 : 0; 
    var TopPosition = (screen.height) ? (screen.height-200)/2 : 0; 
    //window.open('','downloadpop');
   
    var frm_down = $('#frm_down')[0];
    //alert(frm_down);
	//frm_down.target="downloadpop";
	frm_down.file_id.value = file_id;
	frm_down.file_sn.value = file_sn;
	
	frm_down.submit();
}

</script>
<!-- state : end -->
<form id="frm_search" name="frm_search" method="post" action="<c:url value="/admin/bbs_list.do" />">
<input type="hidden" name="pageIndex" value="1" />
<div class="content_wrap">
	<div class="content content_style1">
		<hr>
		<h4 class="c_bullet bold">공지사항 리스트</h4>
		
		<div class="search" style="height:50px;">
			<fieldset>
				<p class="mgt_10 mgl_10 left">
					<label for="stud_nm">공지사항제목</label>
					<input type="text" name="bbs_subject" id="bbs_subject" value="${BbsInfoVo.bbs_subject}" />
					
					<label for="stud_nm">공지사항종류</label>
					<select name='bbs_gubun' id='bbs_gubun' style="width:150px;">
      						<option value="">전체</option>
      						<option value="1" <c:if test="${ BbsInfoVo.bbs_gubun eq '1'}">selected</c:if>>NOTICE</option>
      						<option value="2" <c:if test="${ BbsInfoVo.bbs_gubun eq '2'}">selected</c:if>>Listening</option>
      						<option value="3" <c:if test="${ BbsInfoVo.bbs_gubun eq '3'}">selected</c:if>>Data</option>
     				</select>
					<label for="hakneon">학년</label>
					<select name='hakneon' id='hakneon' style="width:195px;">
      					<option value="">전체</option>
	         			<option value="1" <c:if test="${BbsInfoVo.hakneon eq '1'}">selected</c:if>>1학년</option>
	         			<option value="2" <c:if test="${BbsInfoVo.hakneon eq '2'}">selected</c:if>>2학년</option>
	         			<option value="3" <c:if test="${BbsInfoVo.hakneon eq '3'}">selected</c:if>>3학년</option>
					</select>
					<input type="button" value="검색" class="admin_search"  onclick="javascript:Search(1)"/>
				</p>
			</fieldset>
		</div>
		<br/>
		<div class="table_list table_list_style5">
			<table>
				<colgroup><col width="10%" /><col width="10%" /><col width="15%" /><col width="10%" /><col width="30%" /><col width="15%" /><col width="10%" /></colgroup>
				<thead>
					<tr>
						<th>ㅁ</th>
						<th>번호</th>
						<th>공지사항종류</th>
						<th>학년</th>
						<th>공지사항제목</th>
						<th>등록일자</th>
						<th>첨부파일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty bbsList}">
						<tr>
							<td colspan="7">검색결과가 없습니다.</td>
						</tr>
					</c:if>
					
					<c:if test="${!empty bbsList}">
						<c:forEach var="bbsList" items="${bbsList}" varStatus="status">
							<tr>
								<td><input type="checkbox" name="bbs_id" id="bbs_id" value="${bbsList.bbs_id}"/></td>
								<td>${bbsList.rnum}</td>
								<td>
									<c:if test="${bbsList.bbs_gubun eq '1'}">NOTICE</c:if>
									<c:if test="${bbsList.bbs_gubun eq '2'}">Listening</c:if>
									<c:if test="${bbsList.bbs_gubun eq '3'}">Data</c:if>
								</td>
								<td>
									<c:if test="${!empty bbsList.hakneon}">
										${bbsList.hakneon}
									</c:if>
									<c:if test="${empty bbsList.hakneon}">
										전체
									</c:if>
									
								</td>
								<td>${bbsList.bbs_subject}</td>
								<td>${bbsList.reg_date}</td>
								<td>
								<c:if test="${!empty bbsList.file_id}">
			           				<a href="javascript:fn_downFile('${bbsList.file_id}','1')"><img src="<c:url value="/images/common/blt_file.gif" />" alt="파일다운" id="file_down" /></a>
								</c:if>
								<c:if test="${empty bbsList.file_id}">
									&nbsp;
								</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="right_btn_wrap2">	
			<span class="sb_type_s"><a href="javascript:bbsinsert()">등록</a></span>
			<span class="sb_type_s"><a href="javascript:bbsupdate()">수정</a></span>
			<span class="sb_type_s"><a href="javascript:bbsdelete()">삭제</a></span>
		</div>
		<div class="pagenum mgt_10">
			<!-- 이전/다음페이지 없을 경우, 숨김처리-->
			${pageUtil}
		</div>
	</div>
</div>
</form>

<form id="frm_insert" name="frm_insert" method="post" action="<c:url value="/admin/bbs_insert.do" />">
</form>

<form id="frm_update" name="frm_update" method="post" action="<c:url value="/admin/bbs_update.do" />">
	<input type="hidden" name="bbs_id" value="" />
</form>

<form id="frm_delete" name="frm_delete" method="post" action="<c:url value="/admin/bbs_deleteafter.do" />">
	<input type="hidden" name="bbs_ids" value="" />
</form>

<form id="frm_down" name="frm_down" method="post" action="<c:url value="/common/fildDownloadup.do" />" >
	<input type="hidden" name="file_id" value="" />
	<input type="hidden" name="file_sn" value="" />
</form>