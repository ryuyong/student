<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>어드민로그인</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/login.css" />" />
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	function login(){
		var frm_login = $('#frm_login')[0];
		var validity_check = formCheck(frm_login); // 폼 유효성체크
    	if( !validity_check) return;
    	frm_login.target = "summitframe";
    	frm_login.submit();
	}
	
	function formCheck(frmObj){	
		
		var admin_id = $('#admin_id').val();
		var admin_pw = $('#admin_pw').val();

		if(admin_id.length < 1) {
			alert('ID를 입력해 주세요.');
			frmObj.admin_id.focus();
			return false;
		}
		if(admin_pw.length < 1) {
			alert('이름을 입력해 주세요.');
			frmObj.admin_pw.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body onkeypress="if(event.keyCode==13){login();};">
<form id="frm_login" name="frm_login" method="post" action="<c:url value="/login/adminlogin.do" />" onsubmit="return false;">
<div class="wrap">
	<!-- #container : start -->
	<div id="container">
		<div class="top_bg"></div>
		<div class="login_wrap">
			<div class="login">
				<table border="1px;" style="background-color: #f3f3f3;border-color: #333333;">
					<tr>
						<td>
							<b>아이디 :</b>
						</td>
						<td>
							<input type="text" id="admin_id" name="admin_id" class="in_logn"/>
						</td>
						<td rowspan="2"><a href="javascript:login();"><img src="<c:url value="/images/login/login_btn.jpg" />" border="0px;"/></a></td>
					</tr>
					<tr>
						<td>
							<b>비밀번호:</b>
						</td>
						<td>
							<input type="password" id="admin_pw" name="admin_pw" class="in_logn"/>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		<!-- login_wrap : end -->

	</div>
	<!-- #container : end -->

	<!-- #footer : start -->
	<div id="footer">
		<div class="copy">Copyright ⓒ Student. All rights reserved.</div>
	</div>
</div>
</form>
<iframe src="" name="summitframe" id="summitframe" width="0" height="0"></iframe>
</body>
</html>