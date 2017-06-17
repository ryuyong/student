<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="org.apache.pdfbox.pdmodel.PDDocument;" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String print = (String)request.getParameter("print");
	if(print != null && print.equals("1")) {
		String file_nm = (String)request.getParameter("file_nm");
		PDDocument document = PDDocument.load(file_nm);
		document.print();
	}
%>

<script type="text/javascript">
$(document).ready(function(){
	var weekvalue = '${AnswerVo.weekvalue}';
	//alert(weekvalue+"ss"+dayvalue);
	if(weekvalue != '') {
		//changedayfirst();	
	}
});
function changedayfirst() {
	var weekvalue = '${AnswerVo.weekvalue}';
	var dayvalue = '${AnswerVo.dayvalue}';
	//var depart_no = $('#depart_no').val();
	
	if(weekvalue == '') {
		return;
	}
	$.ajax({
        url:"<%=request.getContextPath()%>/stud/day_list.do",
        type:"POST",
        timeout:3000,
        async:true,
        datatype:"String",
        data:{
        	"weekvalue":weekvalue,
        	"dayvalue":dayvalue
        },
        success:function(data){
        	if(data == '') {
        		var setData = "<option value=''>선택</option>";
        		$("#dayvalue").html(setData);
        	} else {
        		$("#dayvalue").html(data);
        		//$('#school_cd').val(school_cd);
        		//$('#gaeyeul_nm').val(gaeyeul_nm);
        	}
        },
        error: function(error){
            alert("에러발생");
        }
    });
}

function changeday() {
	var weekvalue = $('#weekvalue').val();

	if(weekvalue == '') {
		return;
	}
	$.ajax({
        url:"<%=request.getContextPath()%>/stud/day_list.do",
        type:"POST",
        timeout:3000,
        async:true,
        datatype:"String",
        data:{
        	"weekvalue":weekvalue
        },
        success:function(data){
        	if(data == '') {
        		var setData = "<option value=''>선택</option>";
        		$("#dayvalue").html(setData);
        	} else {
        		$("#dayvalue").html(data);
        		//$('#school_cd').val(school_cd);
        		//$('#gaeyeul_nm').val(gaeyeul_nm);
        	}
        },
        error: function(error){
            alert("에러발생");
        }
    });
}

function Search(pageIndex) {
	var frm_search = $('#frm_search')[0];
	
	var hakwon_cd = $('#hakwon_cd').val();
	if(hakwon_cd == '') {
		alert('학원을 선택해 주세요.');
		return;
	}
	
	var weekvalue = $('#weekvalue').val();
	if(weekvalue == '') {
		alert('주차From을 선택해 주세요.');
		return;
	}
	var weekvalueto = $('#weekvalueto').val();
	if(weekvalueto == '') {
		alert('주차To를 선택해 주세요.');
		return;
	}
	
	if(weekvalue > weekvalueto) {
		alert('주차From 보다 주차To가 작습니다.');
		return;
	}
	
	frm_search.submit();
}

function wrongnotemakeone(stud_cd) {
	var frm_insert = $('#frm_insert')[0];
	var hakwon_cd = $('#hakwon_cd').val();
	var weekvalue = $('#weekvalue').val();
	var weekvalueto = $('#weekvalueto').val();
	var hakneon = $('#hakneon').val();
	if(weekvalue > weekvalueto) {
		alert('주차From 보다 주차To가 작습니다.');
		return;
	}
	
	if(confirm("오답노트를 생성하시겠습니까?")) {
		frm_insert.stud_cd.value = stud_cd;
		frm_insert.hakwon_cd.value = hakwon_cd;
		frm_insert.weekvalue.value = weekvalue;
		frm_insert.weekvalueto.value = weekvalueto;
		frm_insert.hakneon.value = hakneon;
		frm_insert.target = 'summitframe';
		frm_insert.submit();
	}
}

function wrongnotemakeoneprint(stud_cd) {
	var frm_insert = $('#frm_insert')[0];
	var hakwon_cd = $('#hakwon_cd').val();
	var weekvalue = $('#weekvalue').val();
	var dayvalue = $('#dayvalue').val();
	if(confirm("오답노트를 출력하시겠습니까?")) {
		frm_insert.stud_cd.value = stud_cd;
		frm_insert.hakwon_cd.value = hakwon_cd;
		frm_insert.weekvalue.value = weekvalue;
		frm_insert.weekvalueto.value = weekvalueto;
		frm_insert.print.value = '1';
		frm_insert.target = 'summitframe';
		frm_insert.submit();
	}
}


function deleteanswernodayvalue() {
	var frm_update = $('#frm_update')[0];
	frm_update.target = 'summitframe';
	frm_update.submit();
}

</script>

<div class="content_wrap">
	<div class="content content_style1">
		<hr>
		<h4 class="c_bullet bold">오답노트생성</h4>
		<form id="frm_search" name="frm_search" method="post" action="<c:url value="/admin/wrongnote_make.do" />">
			<input type="hidden" id="stud_cd" name="stud_cd" />
			<div class="search" style="height:50px;">
				<fieldset>
					<p class="mgt_10 mgl_10 left">
						<label for="hakwon_cd">학원</label>
						<select name='hakwon_cd' id='hakwon_cd' style="width:150px;">
       						<option value="">선택</option>
		         			<c:forEach var="hakwonList" items="${hakwonList}" varStatus="status">
								<option value="${hakwonList.hakwon_cd}" <c:if test="${hakwonList.hakwon_cd eq AnswerVo.hakwon_cd}">selected</c:if>>${hakwonList.hakwon_nm}</option>
							</c:forEach>
						</select>
						
						<label for="hakneon">학년</label>
						<select name='hakneon' id='hakneon' style="width:195px;">
	      						<option value="">전체</option>
		         			<option value="1" <c:if test="${AnswerVo.hakneon eq '1'}">selected</c:if>>1학년</option>
		         			<option value="2" <c:if test="${AnswerVo.hakneon eq '2'}">selected</c:if>>2학년</option>
		         			<option value="3" <c:if test="${AnswerVo.hakneon eq '3'}">selected</c:if>>3학년</option>
						</select>
						
						<label for="weekvalue">주차From</label>
						<select name='weekvalue' id='weekvalue' style="width:150px;">
	      							<option value="">선택</option>
	         				<c:forEach var="weeklist" items="${weeklist}" varStatus="status">
								<option value="${weeklist.weekvalue}" <c:if test="${weeklist.weekvalue eq AnswerVo.weekvalue}">selected</c:if>>${weeklist.weekview}</option>
							</c:forEach>
						</select>
						<label for="weekvalueto">주차To</label>
						<select name='weekvalueto' id='weekvalueto' style="width:150px;">
	      							<option value="">선택</option>
	         				<c:forEach var="weeklist" items="${weeklist}" varStatus="status">
								<option value="${weeklist.weekvalue}" <c:if test="${weeklist.weekvalue eq AnswerVo.weekvalueto}">selected</c:if>>${weeklist.weekview}</option>
							</c:forEach>
						</select>
				    	
						<input type="button" value="검색" class="admin_search"  onclick="javascript:Search(1)"/>
					</p>
				</fieldset>
			</div>
		</form>
		<div class="table_list table_list_style5">
			<table>
				<colgroup><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="15%" /><col width="15%" /><col width="20%" /></colgroup>
				<thead>
					<tr>
						<th>학원명</th>
						<th>학생ID</th>
						<th>학년</th>
						<th>학생명</th>
						<th>정답개수</th>
						<th>오답개수</th>
						<th>전체문항수</th>
						<th>오답노트생성</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty answerwrongststsList}">
						<tr>
							<c:if test="${empty AnswerVo.hakwon_cd}">
								<td colspan="8">학원을 선택후 검색버튼을 클릭해 주세요.</td>
							</c:if>
							<c:if test="${!empty AnswerVo.hakwon_cd}">
								<td colspan="8">검색결과가 없습니다.</td>
							</c:if>
						</tr>
					</c:if>
					
					<c:if test="${!empty answerwrongststsList}">
						<c:forEach var="answerwrongststsList" items="${answerwrongststsList}" varStatus="status">
							<tr>
								<td>${answerwrongststsList.hakwon_nm}</td>
								<td>${answerwrongststsList.stud_id}</td>
								<td>${answerwrongststsList.hakneon}</td>
								<td>${answerwrongststsList.stud_nm}</td>
								<td>${answerwrongststsList.rightcnt}</td>
								<td>${answerwrongststsList.wrongcnt}</td>
								<td>${answerwrongststsList.allcnt}</td>
								<td>
									<c:if test="${answerwrongststsList.rightcnt ne answerwrongststsList.allcnt}">
										<span class="sb_type_s"><a href="javascript:wrongnotemakeone('${answerwrongststsList.stud_cd}')">
										학생오답노트생성
										</a></span>
										<!-- a href="javascript:wrongnotemakeoneprint('${answerwrongststsList.stud_cd}')">
										학생오답노트출력
										</a-->
									</c:if>
									
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="right_btn_wrap2">
		<c:if test="${!empty answerwrongststsList}">
			<span class="sb_type_s"><a href="javascript:wrongnotemakeone('')">전체오답노트생성</a></span>
			<span class="sb_type_s"><a href="javascript:deleteanswernodayvalue('')">오답노트생성오류처리</a></span>
			<!-- a href="javascript:wrongnotemakeoneprint('')">전체오답노트출력</a-->
		</c:if>
		</div>
	</div>
</div>

<form id="frm_insert" name="frm_insert" method="post" action="<c:url value="/admin/wrongnote_aftermake.do" />">
	<input type="hidden" name="stud_cd" />
	<input type="hidden" name="hakwon_cd" />
	<input type="hidden" name="weekvalue" />
	<input type="hidden" name="weekvalueto" />
	
	<input type="hidden" name="dayvalue" />
	<input type="hidden" name="print" />
	<input type="hidden" name="hakneon" />
	
</form>

<form id="frm_update" name="frm_update" method="post" action="<c:url value="/admin/deleteanswernodayvalue.do" />">
</form>