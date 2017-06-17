<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">
$(document).ready(function(){
	var hakwon_cd = '${AnswerVo.hakwon_cd}';
	//alert(weekvalue+"ss"+dayvalue);
	if(hakwon_cd != '') {
		changestudfirst();	
	}
	
	var redirect = '${AnswerVo.redirect}';
	if(redirect == 'Y') {
		var stud_cd = '${AnswerVo.stud_cd}';
		var clinictype = '${AnswerVo.clinictype}';
		var frm_reinsert = $('#frm_reinsert')[0];
		
		frm_reinsert.hakwon_cd.value = hakwon_cd;
		frm_reinsert.stud_cd.value = stud_cd;
		frm_reinsert.clinictype.value = clinictype;
		frm_reinsert.redirect.value = redirect;
		frm_reinsert.target = 'summitframe';
		frm_reinsert.submit();
	}
});
function changestudfirst() {
	var hakwon_cd = '${AnswerVo.hakwon_cd}';
	var stud_cd = '${AnswerVo.stud_cd}';
	//var depart_no = $('#depart_no').val();
	//alert(hakwon_cd + ":"+ stud_cd);
	if(hakwon_cd == '') {
		return;
	}
	$.ajax({
        url:"<%=request.getContextPath()%>/admin/stud_selectlist.do",
        type:"POST",
        timeout:3000,
        async:true,
        datatype:"String",
        data:{
        	"hakwon_cd":hakwon_cd,
        	"stud_cd":stud_cd
        },
        success:function(data){
        	if(data == '') {
        		var setData = "<option value=''>선택</option>";
        		$("#stud_cd").html(setData);
        	} else {
        		$("#stud_cd").html(data);
        		//$('#school_cd').val(school_cd);
        		//$('#gaeyeul_nm').val(gaeyeul_nm);
        	}
        },
        error: function(error){
            alert("에러발생");
        }
    });
}

function changestud() {
	var hakwon_cd = $('#hakwon_cd').val();
	if(hakwon_cd == '') {
		return;
	}
	//alert(hakwon_cd);
	$.ajax({
        url:"<%=request.getContextPath()%>/admin/stud_selectlist.do",
        type:"POST",
        timeout:3000,
        async:true,
        datatype:"String",
        data:{
        	"hakwon_cd":hakwon_cd
        },
        success:function(data){
        	if(data == '') {
        		var setData = "<option value=''>선택</option>";
        		$("#stud_cd").html(setData);
        	} else {
        		$("#stud_cd").html(data);
        		//$('#school_cd').val(school_cd);
        		//$('#gaeyeul_nm').val(gaeyeul_nm);
        	}
        },
        error: function(error){
            alert("에러발생");
        }
    });
}


function clinicmake() {
	var frm_insert = $('#frm_insert')[0];
	var hakwon_cd = $('#hakwon_cd').val();
	var weekvalue = $('#weekvalue').val();
	var clinictype = $('#clinictype').val();
	var titlevalue = $('#titlevalue').val();
	
	if(hakwon_cd == '') {
		alert('학원을 선택해 주세요.');
		return;
	}
	if(weekvalue == '') {
		alert('주차를 선택해 주세요.');
		return;
	}
	if(titlevalue == '') {
		alert('표지를 선택해 주세요.');
		return;
	}
	/*if(clinictype == '') {
		alert('클리닉유형을 입력해 주세요.');
		return;
	}*/
	/*if(clinictype != '') {
		if(/[^A-Z]/g.test(clinictype)) {
			alert('클리닉 유형은 영문대문자로 입력해 주세요.');
			return;
		}
	}*/
	if(confirm("클리닉을 생성하시겠습니까?")) {
		frm_insert.target = 'summitframe';
		frm_insert.submit();
	}
}

</script>

<div class="content_wrap">
	<div class="content content_style1">
		<hr>
		<div>
			클리닉 유형 미입력 : 저장된 학생별 클리닉 유형의 값으로 파일이 생성됨(단 저장된 클리닉 유형이 없는경우 생성안됨)<br/>
			학생 미선택  : 해당학원의 학생별 클리닉 파일이 일괄 생성
		</div>
		<h4 class="c_bullet bold">클리닉생성</h4>
		<form id="frm_insert" name="frm_insert" method="post" action="<c:url value="/admin/clinic_aftermake.do" />">
			<div class="search" style="height:100px;">
				<fieldset>
					<p class="mgt_10 mgl_10 left">
						<label for="hakwon_cd">학원</label>
						<select name='hakwon_cd' id='hakwon_cd' style="width:150px;" onchange="javascript:changestud()">
       						<option value="">선택</option>
		         			<c:forEach var="hakwonList" items="${hakwonList}" varStatus="status">
								<option value="${hakwonList.hakwon_cd}" <c:if test="${hakwonList.hakwon_cd eq AnswerVo.hakwon_cd}">selected</c:if>>${hakwonList.hakwon_nm}</option>
							</c:forEach>
						</select>
						
						<label for="weekvalue">주차</label>
						<select name='weekvalue' id='weekvalue' style="width:150px;">
	      					<option value="">선택</option>
	         				<c:forEach var="weeklist" items="${weeklist}" varStatus="status">
								<option value="${weeklist}" <c:if test="${weeklist eq AnswerVo.weekvalue}">selected</c:if>>${weeklist}</option>
							</c:forEach>
						</select>
						<label for="weekvalue">표지선택</label>
						<select name='titlevalue' id='titlevalue' style="width:150px;">
	      					<option value="">선택</option>
	         				<c:forEach var="titlelist" items="${titlelist}" varStatus="status">
								<option value="${titlelist}" <c:if test="${titlelist eq AnswerVo.titlevalue}">selected</c:if>>${titlelist}</option>
							</c:forEach>
						</select>
					</p>
					<p class="mgt_10 mgl_10 left">
						<label for="clinictype">클리닉유형</label>
						<input type="text" name="clinictype" style="width:250px;" id="clinictype" value="" maxlength="20" />
						
						<label for="stud_cd">학생</label>
						<select name='stud_cd' id='stud_cd' style="width:150px;">
	      					<option value="">선택</option>
						</select>
					</p>
				</fieldset>
			</div>
		</form>
		<div class="default_btn_wrap">
			<span class="sb_type_s"><a href="javascript:clinicmake('')">클리닉생성</a></span>
		</div>
	</div>
</div>

<form id="frm_reinsert" name="frm_reinsert" method="post" action="<c:url value="/admin/clinic_aftermake.do" />">
	<input type="hidden" name="hakwon_cd" value = "" />
	<input type="hidden" name="stud_cd" value = "" />
	<input type="hidden" name="clinictype" value = "" />
	<input type="hidden" name="redirect" value = "" />
	
	
</form>