<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>로그인</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/studlogin.css" />" />
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	function login(){
		//alert('test');
		var frm_login = $('#frm_login')[0];
		var validity_check = formCheck(frm_login); // 폼 유효성체크
    	if( !validity_check) return;
    	frm_login.target = "summitframe";
    	frm_login.submit();
	}
	
	function formCheck(frmObj){	
		//var hakwon_cd = $('#hakwon_cd').val();
		var stud_id = $('#stud_id').val();
		var stud_nm = $('#stud_nm').val();
		/*if(hakwon_cd.length < 1) {
			alert('학원을 선택해 주세요.');
			frmObj.hakwon_cd.focus();
			return false;
		}*/
		if(stud_id.length < 1) {
			alert('ID를 입력해 주세요.');
			frmObj.stud_id.focus();
			return false;
		}
		if(stud_nm.length < 1) {
			alert('이름을 입력해 주세요.');
			frmObj.stud_nm.focus();
			return false;
		}
		return true;
	}
	
	function openbanner() {
		var LeftPosition = (screen.width) ? (screen.width-1000)/2 : 0; 
	    var TopPosition = (screen.height) ? (screen.height-640)/2 : 0; 
		window.open('','bannerPop','scrollbars=yes,toolbar=no,resizable=yes,status=no,menubar=no,width=1000,height=640,left='+LeftPosition+',top='+TopPosition);
		var frm_update = $('#frm_update')[0];
		frm_update.target="bannerPop";
		frm_update.submit();
	}
</script>
</head>
<body onkeypress="if(event.keyCode==13){login();};" bgcolor="#FFFFFF" text="#000000">
<form id="frm_login" name="frm_login" method="post" action="<c:url value="/login/studlogin.do" />" onsubmit="return false;">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
  	<td align="center" background="<c:url value="/images/login/login_bg.gif" />"><a href="javascript:openbanner();"><img src="<c:url value="/images/banner/login_bg.gif" />" width="784" height="81" /></a></td>
  </tr>
  <tr>
    <td align="center" valign="top" background="<c:url value="/images/login/login_bg.gif" />">
      <table width="567" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td colspan="3"><br/><img src="<c:url value="/images/login/login_top.gif" />" width="567" height="26" /></td>
        </tr>
        <tr>
          <td width="21" background="<c:url value="/images/login/login_left.gif" />" width="21" height="12"></td>
          <td width="525">
            <table width="525" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#FFFFFF">
                <td colspan="3" height="7"></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="10">&nbsp;</td>
                <td valign="bottom" style="padding-left:10pt;">
                    <hr /><br />
                    안녕하세요. 고창영의 영어교실입니다.<br>데일리테스트  답안입력 및 듣기 파일 다운로드를 하실려면 <b><font color="037BEF">로그인</font></b>해주세요.<br /><br />
                    <hr />
                </td>
                <td width="68" height="51"><img src="<c:url value="/images/login/login_logo.gif" />" width="63" height="51" ondblclick="javascript:fncLogin_dbl();"></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="25" height="40">&nbsp;</td>
                <td height="40">&nbsp;</td>
                <td height="40">&nbsp;</td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="25">&nbsp;</td>
                <td>
                  <table width="430" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="300" colspan="5">
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="27" width="220">&nbsp;</td>
                            <td height="27" width="180" align="center"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td width="50">&nbsp;</td>
                      <td width="43"><img src="<c:url value="/images/login/bn_key.gif" />" width="40" height="54" /></td>
                      <td width="16"><img src="<c:url value="/images/login/login_img.gif" />" width="15" height="59" /></td>
                      <td width="13">&nbsp;</td>
                      <td width="249">
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="27" width="50"><img src="<c:url value="/images/login/t_id.gif" />" /></td>
                            <td height="27" width="15">&nbsp;</td>
                            <td height="27" width="80"><input type="text" name="stud_id" id="stud_id" style="border:2px solid" size="20" /></td>
							<td style="padding-left:10"></td>
                          </tr>
                          <tr>
                            <td height="5" width="50"></td>
                            <td height="5" width="10"></td>
                            <td height="5" width="80"></td>
							<td></td>
                          </tr>
                          <tr>
                            <td height="27" width="50"><img src="<c:url value="/images/login/t_key.gif" />" /></td>
                            <td height="27" width="10">&nbsp;</td>
                            <td height="27" width="80"><input type="text" id="stud_nm" name="stud_nm" style="border:2px solid" size="20" /></td>
							<td style="padding-left:30px;"><span id="sp_login"><a style="cursor:hand;" onclick="javascript:login();"><img src="<c:url value="/images/login/bt_login.gif" />" /></a></span></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
                <td>&nbsp;</td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="25" height="37">&nbsp;</td>
                <td height="37" colspan=2>
                    <br /><b>※ 경고 ※</b><font color="red">
                    <br />본 사이트를 수강생 및 학부모 이외 불법적으로 이용 시는 
                    <br />법적인 제재가 가해질 수 있으며, 이는 배상의 책임이 있음을 알려드립니다.</font>
                </td>
              </tr>
            </table>
          </td>
          <td width="21" background="<c:url value="/images/login/login_right.gif" />" width="21" height="8"></td>
        </tr>
        <tr>
          <td colspan="3"><img src="<c:url value="/images/login/login_bottom.gif" />" width="567" height="26"></td>
        </tr>
      </table>
    </td>
  </tr>

</table>

</form>
<form id="frm_update" name="frm_update" method="post" action="<c:url value="/common/bannerview.do" />">
</form>

<iframe src="" name="summitframe" id="summitframe" width="0" height="0"/>
</body>
</html>