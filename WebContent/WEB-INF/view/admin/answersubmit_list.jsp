<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
	var weekvalue = '${AnswerVo.weekvalue}';
	//alert(weekvalue+"ss"+dayvalue);
	if(weekvalue != '') {
		changedayfirst();	
	}
});


function changedayfirst() {
	var weekvalue = '${AnswerVo.weekvalue}';
	var dayvalue = '${AnswerVo.dayvalue}';
	var hakneon = '${AnswerVo.hakneon}';
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
        	"dayvalue":dayvalue,
        	"hakneon":hakneon
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
	var hakneon = $('#hakneon').val();
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
        	"hakneon":hakneon
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
	
	frm_search.submit();
}

function deleteanswer(stud_cd, weekvalue,dayvalue) {
	var frm_delete = $('#frm_delete')[0];
	frm_delete.stud_cd.value = stud_cd;
	frm_delete.weekvalue.value = weekvalue;
	frm_delete.dayvalue.value = dayvalue;
	
	if(confirm("제출한답변을 삭제하겠습니까?")) {
		frm_delete.submit();
	}
}
</script>

<div class="content_wrap">
	<div class="content content_style1">
		<hr>
		<h4 class="c_bullet bold">학생별제출리스트</h4>
		<form id="frm_search" name="frm_search" method="post" action="<c:url value="/admin/answersubmit_list.do" />">
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
		         			<option value="1" <c:if test="${AnswerVo.hakneon eq '1'}">selected</c:if>>1학년</option>
		         			<option value="2" <c:if test="${AnswerVo.hakneon eq '2'}">selected</c:if>>2학년</option>
		         			<option value="3" <c:if test="${AnswerVo.hakneon eq '3'}">selected</c:if>>3학년</option>
						</select>
						<label for="weekvalue">주차</label>
						<select name='weekvalue' id='weekvalue' style="width:150px;" onchange="javascript:changeday()">
	      							<option value="">선택</option>
	         				<c:forEach var="weeklist" items="${weeklist}" varStatus="status">
								<option value="${weeklist.weekvalue}" <c:if test="${weeklist.weekvalue eq AnswerVo.weekvalue}">selected</c:if>>${weeklist.weekview}</option>
							</c:forEach>
						</select>
						<label for="weekvalue">일자</label>
						<select name='dayvalue' id='dayvalue' class="selform3" style="width:150px;">
			         			<option value="">선택</option>
				    	</select>
				    	
						<input type="button" value="검색" class="admin_search" onclick="javascript:Search(1)"/>
					</p>
				</fieldset>
			</div>
		</form>
		<div class="table_list table_list_style5">
			<table>
				<colgroup><col width="20%" /><col width="20%" /><col width="20%" /><col width="20%" /><col width="10%" /><col width="10%" /></colgroup>
				<thead>
					<tr>
						<th>주차</th>
						<th>일자</th>
						<th>학생ID</th>
						<th>학생명</th>
						<th>제출여부</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty answersubmitststsList}">
						<tr>
							<c:if test="${empty AnswerVo.hakwon_cd}">
								<td colspan="6">학원을 선택후 검색버튼을 클릭해 주세요.</td>
							</c:if>
							<c:if test="${!empty AnswerVo.hakwon_cd}">
								<td colspan="6">검색결과가 없습니다.</td>
							</c:if>
						</tr>
					</c:if>
					<c:if test="${!empty answersubmitststsList}">
						<c:forEach var="answersubmitststsList" items="${answersubmitststsList}" varStatus="status">
							<tr>
								<td>${answersubmitststsList.weekvalue}주차</td>
								<td>${answersubmitststsList.dayvalue}일자</td>
								<td>${answersubmitststsList.stud_id}</td>
								<td>${answersubmitststsList.stud_nm}</td>
								<td>
									<c:if test="${!empty answersubmitststsList.submitcnt}">O</c:if>
									<c:if test="${empty answersubmitststsList.submitcnt}">X</c:if>
									
								</td>
								<td>
									<c:if test="${!empty answersubmitststsList.submitcnt}">
										<span class="sb_type_s"><a href="javascript:deleteanswer('${answersubmitststsList.stud_cd}','${answersubmitststsList.weekvalue}','${answersubmitststsList.dayvalue}')">삭제</a></span>
									</c:if>
									<c:if test="${empty answersubmitststsList.submitcnt}">
										&nbsp;
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>


<form id="frm_delete" name="frm_delete" method="post" action="<c:url value="/admin/deleteanswer.do" />">
	<input type="hidden" name="stud_cd" value="" />
	<input type="hidden" name="weekvalue" value="" />
	<input type="hidden" name="dayvalue" value="" />
</form>