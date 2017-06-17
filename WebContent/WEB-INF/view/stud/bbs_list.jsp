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

function bbsdetail(bbs_id) {
	var frm_detail = $('#frm_detail')[0];
	frm_detail.bbs_id.value = bbs_id;
	frm_detail.submit();
}

/*function fn_downFile(file_id, file_sn){
	window.open("<c:url value='/common/fildDownloadup.do?file_id="+file_id+"&file_sn="+file_sn+"'/>");
}*/	

</script>

<c:set value="NOTICE" var="setstr"/>
<c:if test="${BbsInfoVo.bbs_gubun eq '2'}">
<c:set value="Listening" var="setstr"/>
</c:if>
<c:if test="${BbsInfoVo.bbs_gubun eq '3'}">
<c:set value="Data" var="setstr"/>
</c:if>

<form id="frm_search" name="frm_search" method="post" action="<c:url value="/stud/bbs_list.do" />">
<input type="hidden" name="pageIndex" value="1" />
<input type="hidden" name="bbs_gubun" value="${BbsInfoVo.bbs_gubun}" />

<div class="content">
	<div class="state">
		<h2><span>${setstr} 리스트</span></h2>
	</div>
	
	<div class="search" style="height:40px;">
		<fieldset>
			<div class="selbox" style="width:100%;vertical-align:middle;">
				<label for="stud_nm"><b>공지사항제목:</b></label>
					<input type="text" name="searchKeyword" id="searchKeyword" value="${BbsInfoVo.searchKeyword}" />
		    		<input type="button" value="검색" class="btn_search" onclick="javascript:Search(1);" />
			</div>
		</fieldset>
	</div>
	<br/>	
	<div class="table_list board_style">
		<table>
			<colgroup><col width="10%" /><col width="60%" /><col width="20%" /><col width="10%" /></colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>공지사항제목</th>
					<th>등록일자</th>
					<th>첨부파일</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty bbsList}">
					<tr>
						<td colspan="4">검색결과가 없습니다.</td>
					</tr>
				</c:if>
				
				<c:if test="${!empty bbsList}">
					<c:forEach var="bbsList" items="${bbsList}" varStatus="status">
						<tr>
							<td>${bbsList.rnum}</td>
							<td><a href="javascript:bbsdetail('${bbsList.bbs_id}')">${bbsList.bbs_subject}</a></td>
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
	<div class="pagenum mgt_10">
		<!-- 이전/다음페이지 없을 경우, 숨김처리-->
		${pageUtil}
	</div>
</div>
</form>

<form id="frm_down" name="frm_down" method="post" action="<c:url value="/common/fildDownloadup.do" />" >
	<input type="hidden" name="file_id" value="" />
	<input type="hidden" name="file_sn" value="" />
	<input type="hidden" name="bbs_gubun" value="${BbsInfoVo.bbs_gubun}" />
</form>

<form id="frm_detail" name="frm_detail" method="post" action="<c:url value="/stud/bbs_detail.do" />" >
	<input type="hidden" name="pageIndex" value="${BbsInfoVo.pageIndex}" />
	<input type="hidden" name="searchKeyword" value="${BbsInfoVo.searchKeyword}" />
	<input type="hidden" name="bbs_id" value="" />
	<input type="hidden" name="bbs_gubun" value="${BbsInfoVo.bbs_gubun}" />
</form>
