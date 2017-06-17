<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
	var weekvalue = $('#weekvalue').val();
	var dayvalue = '${AnswerVo.dayvalue}';
	//alert(weekvalue+"ss"+dayvalue);
	if(weekvalue != '' && dayvalue != '') {
		changedayfirst();	
	}
});


function changedayfirst() {
	var weekvalue = $('#weekvalue').val();
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

function SearchQuestion() {
	var frmObj = $('#frm_search')[0];
	var weekvalue = $('#weekvalue').val();
	var dayvalue = $('#dayvalue').val();
	if(weekvalue.length < 1) {
		alert('주차를 선택해 주세요.');
		frmObj.weekvalue.focus();
		return;
	}
	if(dayvalue.length < 1) {
		alert('일자를 선택해 주세요.');
		frmObj.dayvalue.focus();
		return;
	}
	frmObj.submit();
}

function questioninsert() {
	var frm = $('#frm_insert')[0];
	var cnt = 1;
	var answers = '';
	var questions = '';
	var answercheck = false;
	var alertval = '';
	$("input[name=answercnt]").each(function() {
		questions += this.value + ":::::";
		
		if ($('input:radio[name=answer'+cnt+']:checked').length != 0) {
			answercheck = true;
		} else {
			alertval += cnt+ ' ';
		}
		$("input[name=answer"+cnt+"]").each(function() {
			if(this.checked) {
				answers += this.value + ':::::';
			}
		});
		cnt++;
	});
	
	if(alertval != '') {
		alert(alertval + "문제의 답변을 선택해 주세요.");
		return;
	}
	
	//alert(questions + ":" + answers);
	
	var weekvalue = $('#weekvalue').val();
	var dayvalue = $('#dayvalue').val();
	
	if(confirm("답변을 등록 하시겠습니까?")) {
		frm.answers.value = answers;
		frm.questions.value = questions;
		frm.weekval.value = weekvalue;
		frm.dayval.value = dayvalue;
		frm.submit();
	}
}


function fn_downFile(){
	var weekvalue = $('#weekvalue').val();
	var dayvalue = $('#dayvalue').val();
	
	window.open("<c:url value='/common/fildDownload.do?weekvalue="+weekvalue+"&dayvalue="+dayvalue+"'/>");
}	

</script>
<form id="frm_search" name="frm_search" method="post" action="<c:url value="/stud/question_list.do" />">
<div class="content">
	<div class="state">
		<h2><span>문제리스트</span></h2>
	</div>
	
	<div class="search" style="height:40px;">
		<fieldset>
			<div class="selbox" style="width:100%;vertical-align:middle;">
				<label><b>주차선택:</b></label>
				<select name='weekvalue' id='weekvalue' style="width:150px;" onchange="javascript:changeday()">
     							<option value="">선택</option>
        				<c:forEach var="weeklist" items="${weeklist}" varStatus="status">
						<option value="${weeklist.weekvalue}" <c:if test="${weeklist.weekvalue eq AnswerVo.weekvalue}">selected</c:if>>${weeklist.weekview}</option>
					</c:forEach>
				</select>
				<label><b>일차선택:</b></label>
				<select name='dayvalue' id='dayvalue' class="selform3" style="width:150px;">
	         			<option value="">선택</option>
		    	</select>
		    	<input type="button" value="검색" class="btn_search" onclick="javascript:SearchQuestion();" />
			</div>
		</fieldset>
	</div>
	<br/>	
	<div class="table_list board_style">
		<table>
			<colgroup><col width="10%" /><col width="90%" /></colgroup>
			<thead>
				<tr>
					<th>질문번호</th>
					<th>문제정답</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty answerlist}">
					<c:if test="${empty AnswerVo.dayvalue}">
						<tr>
							<td colspan="3">주차와 일차를 먼저 선택해 주세요</td>
						</tr>
					</c:if>
					<c:if test="${!empty AnswerVo.dayvalue}">
						<c:if test="${empty questionlist}">
							<tr>
								<td colspan="2">검색결과가 없습니다.</td>
							</tr>
						</c:if>
					</c:if>
				</c:if>
				<c:if test="${!empty answerlist}">
					<c:forEach var="answerlist" items="${answerlist}" varStatus="status">
					<tr>
						<td>${answerlist.questionvalue} 번</td>
						<td>
							<c:if test="${answerlist.rightyn eq 'Y'}">
								<font color="#0000ff">정답입니다</font>(정답 : ${answerlist.rightanswer}번)
							</c:if>
							<c:if test="${answerlist.rightyn eq 'N'}">
								<font color="#ff0000">오답입니다</font> (답변 : ${answerlist.studanswer}번 | 정답 : ${answerlist.rightanswer}번)
							</c:if>
							
						</td>
					</tr>
					</c:forEach>
				</c:if>
				
				<c:if test="${empty answerlist}">
					<c:if test="${!empty questionlist}">
						<c:forEach var="questionlist" items="${questionlist}" varStatus="status">
							<input type="hidden" name="answercnt" id="answercnt" value="${questionlist}"/>
							<tr>
								<td>${questionlist}번</td>
								<td><input type="radio" name="answer${status.count}" value="1" />1
								<input type="radio" name="answer${status.count}" value="2" />2
								<input type="radio" name="answer${status.count}" value="3" />3
								<input type="radio" name="answer${status.count}" value="4" />4
								<input type="radio" name="answer${status.count}" value="5" />5
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</c:if>
			</tbody>
			
		</table>
		<c:if test="${!empty answerlist}">
			<div class="default_btn_wrap">	
				<a href="javascript:fn_downFile();" class="btype_m"><span>해설지다운</span></a>
			</div>
		</c:if>
		<c:if test="${!empty questionlist and empty answerlist}">
			<div class="default_btn_wrap">	
				<a href="javascript:questioninsert();" class="btype_m"><span>답변제출</span></a>
			</div>
		</c:if>
	</div>

</div>
</form>

<form id="frm_insert" name="frm_insert" method="post" action="<c:url value="/stud/answer_insert.do" />">
	<input type="hidden" id="answers" name="answers" value="" />
	<input type="hidden" id="questions" name="questions" value="" />
	<input type="hidden" id="weekval" name="weekval" value="" />
	<input type="hidden" id="dayval" name="dayval" value="" />
</form>