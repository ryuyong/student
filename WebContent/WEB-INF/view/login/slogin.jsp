<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>로그인</title>
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>

<style type="text/css">
body {background:url('<c:url value="/images/newlogin/bg.gif" />') repeat;}
li {list-style:none;}
.wrap {width:1000px; margin:0 auto; overflow:hidden;}
.title {width:1000px; margin:0 auto;}
.title img{text-align:center;}
.top_menu {width:825px; margin:0 auto;}
.top_menu ul {overflow:hidden; padding:0;}
.top_menu ul li {float:left; margin-left:10px;}
.onoff {clear:both; width:120px; margin:0 auto;left:50%;padding-top:20px; padding-bottom:20px;}
.bottom_menu ul {overflow:hidden; padding:0;}
.bottom_menu {width:880px; margin:0 auto; overflow:hidden;}
.bottom_menu ul li {float:left; margin-left:10px;}
.onoff2 {clear:both; width:260px; margin:0 auto; padding-top:20px; padding-bottom:20px;}

input.text {width:240px; height:25px; margin:0; padding:4px; background:#fafafa; border:1px solid #cccccc; font-size:14px; color:#000; vertical-align:middle;}
input.text:hover {border-color:#acb8fc !important;}
</style>


<script>
/*! http://mths.be/placeholder v2.0.8 by @mathias */
;(function(window, document, $) {

	var isOperaMini = Object.prototype.toString.call(window.operamini) == '[object OperaMini]';
	var isInputSupported = 'placeholder' in document.createElement('input') && !isOperaMini;
	var isTextareaSupported = 'placeholder' in document.createElement('textarea') && !isOperaMini;
	var prototype = $.fn;
	var valHooks = $.valHooks;
	var propHooks = $.propHooks;
	var hooks;
	var placeholder;

	if (isInputSupported && isTextareaSupported) {

		placeholder = prototype.placeholder = function() {
			return this;
		};

		placeholder.input = placeholder.textarea = true;

	} else {

		placeholder = prototype.placeholder = function() {
			var $this = this;
			$this
				.filter((isInputSupported ? 'textarea' : ':input') + '[placeholder]')
				.not('.placeholder')
				.bind({
					'focus.placeholder': clearPlaceholder,
					'blur.placeholder': setPlaceholder
				})
				.data('placeholder-enabled', true)
				.trigger('blur.placeholder');
			return $this;
		};

		placeholder.input = isInputSupported;
		placeholder.textarea = isTextareaSupported;

		hooks = {
			'get': function(element) {
				var $element = $(element);

				var $passwordInput = $element.data('placeholder-password');
				if ($passwordInput) {
					return $passwordInput[0].value;
				}

				return $element.data('placeholder-enabled') && $element.hasClass('placeholder') ? '' : element.value;
			},
			'set': function(element, value) {
				var $element = $(element);

				var $passwordInput = $element.data('placeholder-password');
				if ($passwordInput) {
					return $passwordInput[0].value = value;
				}

				if (!$element.data('placeholder-enabled')) {
					return element.value = value;
				}
				if (value == '') {
					element.value = value;
					// Issue #56: Setting the placeholder causes problems if the element continues to have focus.
					if (element != safeActiveElement()) {
						// We can't use `triggerHandler` here because of dummy text/password inputs :(
						setPlaceholder.call(element);
					}
				} else if ($element.hasClass('placeholder')) {
					clearPlaceholder.call(element, true, value) || (element.value = value);
				} else {
					element.value = value;
				}
				// `set` can not return `undefined`; see http://jsapi.info/jquery/1.7.1/val#L2363
				return $element;
			}
		};

		if (!isInputSupported) {
			valHooks.input = hooks;
			propHooks.value = hooks;
		}
		if (!isTextareaSupported) {
			valHooks.textarea = hooks;
			propHooks.value = hooks;
		}

		$(function() {
			// Look for forms
			$(document).delegate('form', 'submit.placeholder', function() {
				// Clear the placeholder values so they don't get submitted
				var $inputs = $('.placeholder', this).each(clearPlaceholder);
				setTimeout(function() {
					$inputs.each(setPlaceholder);
				}, 10);
			});
		});

		// Clear placeholder values upon page reload
		$(window).bind('beforeunload.placeholder', function() {
			$('.placeholder').each(function() {
				this.value = '';
			});
		});

	}

	function args(elem) {
		// Return an object of element attributes
		var newAttrs = {};
		var rinlinejQuery = /^jQuery\d+$/;
		$.each(elem.attributes, function(i, attr) {
			if (attr.specified && !rinlinejQuery.test(attr.name)) {
				newAttrs[attr.name] = attr.value;
			}
		});
		return newAttrs;
	}

	function clearPlaceholder(event, value) {
		var input = this;
		var $input = $(input);
		if (input.value == $input.attr('placeholder') && $input.hasClass('placeholder')) {
			if ($input.data('placeholder-password')) {
				$input = $input.hide().next().show().attr('id', $input.removeAttr('id').data('placeholder-id'));
				// If `clearPlaceholder` was called from `$.valHooks.input.set`
				if (event === true) {
					return $input[0].value = value;
				}
				$input.focus();
			} else {
				input.value = '';
				$input.removeClass('placeholder');
				input == safeActiveElement() && input.select();
			}
		}
	}

	function setPlaceholder() {
		var $replacement;
		var input = this;
		var $input = $(input);
		var id = this.id;
		if (input.value == '') {
			if (input.type == 'password') {
				if (!$input.data('placeholder-textinput')) {
					try {
						$replacement = $input.clone().attr({ 'type': 'text' });
					} catch(e) {
						$replacement = $('<input>').attr($.extend(args(this), { 'type': 'text' }));
					}
					$replacement
						.removeAttr('name')
						.data({
							'placeholder-password': $input,
							'placeholder-id': id
						})
						.bind('focus.placeholder', clearPlaceholder);
					$input
						.data({
							'placeholder-textinput': $replacement,
							'placeholder-id': id
						})
						.before($replacement);
				}
				$input = $input.removeAttr('id').hide().prev().attr('id', id).show();
				// Note: `$input[0] != input` now!
			}
			$input.addClass('placeholder');
			$input[0].value = $input.attr('placeholder');
		} else {
			$input.removeClass('placeholder');
		}
	}

	function safeActiveElement() {
		// Avoid IE9 `document.activeElement` of death
		// https://github.com/mathiasbynens/jquery-placeholder/pull/99
		try {
			return document.activeElement;
		} catch (err) {}
	}

}(this, document, jQuery));
  </script>
  
<script type="text/javascript">
$(document).ready(function(){
	
	
	var stud_cd = '${sessionScope.stud.stud_cd}';
	if(stud_cd != '') {
		$('#logininput').hide();
		$('#gologininput').show();
	} 
	
	
	 $(".swapimg").mouseover(function (){
	  var file = $(this).attr('src').split('/');
	  var filename = file[file.length-1];
	  var path = '';
	  for(i=0 ; i < file.length-1 ; i++){
	   path = ( i == 0 )?path + file[i]:path + '/' + file[i];
	  }
	  $(this).attr('src',path+'/'+filename.replace('.gif','_on.gif'));
	  
	 }).mouseout(function(){
	  var file = $(this).attr('src').split('/');
	  var filename = file[file.length-1];
	  var path = '';
	  for(i=0 ; i < file.length-1 ; i++){
	   path = ( i == 0 )?path + file[i]:path + '/' + file[i];
	  }
	  $(this).attr('src',path+'/'+filename.replace('_on.gif','.gif'));
	 });
	});
	
	
	function login(){
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
		var hakneon = $('#hakneon').val();
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
		if(hakneon.length < 1) {
			alert('학년을 선택해 주세요.');
			frmObj.hakneon.focus();
			return false;
		}
		return true;
	}
	
	function openbanner(gubun) {
		var LeftPosition = (screen.width) ? (screen.width-1000)/2 : 0; 
	    var TopPosition = (screen.height) ? (screen.height-640)/2 : 0; 
		window.open('','bannerPop','scrollbars=yes,toolbar=no,resizable=yes,status=no,menubar=no,width=1000,height=640,left='+LeftPosition+',top='+TopPosition);
		var frm_update = $('#frm_update')[0];
		frm_update.target="bannerPop";
		frm_update.gubun.value = gubun;
		frm_update.submit();
	}
	
	function loginview() {
		//alert('test11');
		//$("#stud_id").placeholder();
		$('input, textarea').placeholder();
		var stud_cd = '${sessionScope.stud.stud_cd}';
		if(stud_cd == '') {
			$('#logininput').show();
			$('#gologininput').hide();
			return;
		} else {
			alert('이미 로그인 하셨습니다');
			return;
		}
	}
	
	function gobbslist(bbs_gubun) {
		var frm_bbs = $('#frm_bbs')[0];
		frm_bbs.bbs_gubun.value = bbs_gubun;
		frm_bbs.submit();
	}
	
	function goquestion() {
		var frm_question = $('#frm_question')[0];
		frm_question.submit();
	}
	function goqna() {
		var frm_qna = $('#frm_qna')[0];
		frm_qna.submit();
	}
</script>
</head>

<body>
	<div class="wrap" style="text-align:center;">
    	<div class="title"><img src="<c:url value="/images/newlogin/top_title.gif" />"/></div>
    	<div class="top_menu">        	
        	<ul>
            	<li><a onclick="javascript:openbanner('1');"><img width="145px" src="<c:url value="/images/newlogin/m1.gif" />" class="swapimg" /></a></li>
                <li><a onclick="javascript:openbanner('2');"><img width="145px" src="<c:url value="/images/newlogin/m2.gif" />" class="swapimg" /></a></li>
                <li><a onclick="javascript:openbanner('3');"><img width="145px" src="<c:url value="/images/newlogin/m3.gif" />" class="swapimg" /></a></li>
                <li><a onclick="javascript:openbanner('4');"><img width="145px" src="<c:url value="/images/newlogin/m4.gif" />" class="swapimg" /></a></li>
                <li><a onclick="javascript:openbanner('5');"><img width="145px" src="<c:url value="/images/newlogin/m5.gif" />" class="swapimg" /></a></li>
            </ul>
        </div>
        
        <div class="onoff2" id="logininput" style="display:none;text-align:center;">
        	<form id="frm_login" name="frm_login" method="post" action="<c:url value="/login/studlogin.do" />" onsubmit="return false;">
			   <table id="contact_table">
					<tbody>
						<tr>		
							<td colspan="2"><input class="text" type="text" id="stud_id" name="stud_id" placeholder="아이디"></td>
						</tr>
						<tr>
							<td colspan="2"><input class="text" type="text" id="stud_nm" name="stud_nm" placeholder="학생명"></td>
						</tr>
						<tr>
							<td>
								<b>학년:</b>
							</td>
							<td>
								<select name='hakneon' id='hakneon' style="width:195px;">
	       						<option value="">선택</option>
			         			<option value="1">1학년</option>
			         			<option value="2">2학년</option>
			         			<option value="3">3학년</option>
								</select>
							</td>
						</tr>
			            <tr>				
							<td colspan="2"><a onclick="javascript:login();"><img src="<c:url value="/images/newlogin/login.gif" />" /></a></td>
						</tr>
					</tbody>
				</table>
			</form>
        </div>
        
        
        <div class="onoff" id="gologininput" style="display:block;text-align:center;">
        	<a onclick="javascript:loginview();"><img src="<c:url value="/images/newlogin/p.gif" />" width="100px" height="100px" class="swapimg" /></a>
        </div>
        <br/>
        <div class="title"><img src="<c:url value="/images/newlogin/bottom_title.gif" />"/></div>
        <div class="bottom_menu">
        	<ul>
        		<c:if test="${!empty sessionScope.stud}">
	            	<li><a onclick="javascript:gobbslist('1');"><img src="<c:url value="/images/newlogin/m6.gif" />" class="swapimg" /></a></li>
	                <li><a onclick="javascript:goqna();"><img src="<c:url value="/images/newlogin/m7.gif" />" class="swapimg" /></a></li>
	                <li><a onclick="javascript:goquestion();" ><img src="<c:url value="/images/newlogin/m8.gif" />" class="swapimg" /></a></li>
	                <li><a onclick="javascript:gobbslist('2');"><img src="<c:url value="/images/newlogin/m9.gif" />" class="swapimg" /></a></li>
	                <li><a onclick="javascript:gobbslist('3');"><img src="<c:url value="/images/newlogin/m10.gif" />" class="swapimg" /></a></li>
            	</c:if>
        		<c:if test="${empty sessionScope.stud}">
	            	<li><img src="<c:url value="/images/newlogin/m6.gif" />"  /></li>
	                <li><img src="<c:url value="/images/newlogin/m7.gif" />"  /></li>
	                <li><img src="<c:url value="/images/newlogin/m8.gif" />"  /></li>
	                <li><img src="<c:url value="/images/newlogin/m9.gif" />"  /></li>
	                <li><img src="<c:url value="/images/newlogin/m10.gif" />"  /></li>
            	</c:if>
            </ul>
        </div>
    </div>
    
<form id="frm_update" name="frm_update" method="post" action="<c:url value="/common/bannerview.do" />">
	<input type="hidden" name="gubun" value="" />
</form>

<form id="frm_bbs" name="frm_bbs" method="post" action="<c:url value="/stud/bbs_list.do" />">
	<input type="hidden" name="bbs_gubun" value="" />
</form>

<form id="frm_qna" name="frm_qna" method="post" action="<c:url value="/stud/qna_list.do" />">
</form>

<form id="frm_question" name="frm_question" method="post" action="<c:url value="/stud/question_list.do" />">
</form>

<iframe src="" name="summitframe" id="summitframe" width="0" height="0"/>    
</body>
</html>