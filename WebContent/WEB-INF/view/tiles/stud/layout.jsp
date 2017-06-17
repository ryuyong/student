<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html> 
<html lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Cache-Control" content="no-cache" />
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="imagetoolbar" content="no" />
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/student.css" />" />
		<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
		<script src="<c:url value="/js/student.js" />"></script>
        <script type="text/javascript">
        //<![CDATA[            
            $(document).ready(function(){
            	var message = '${sessionScope.message}';
            	if(message != '') {
            		alert(message);
            	}
            	<%
            		session.removeAttribute("message");
            	%>
            });
            
            
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
        	function gologout() {
        		var frm_logout = $('#frm_logout')[0];
        		frm_logout.submit();
        	}
        //]]>
        </script>
        
		<title><tiles:getAsString name="title"/></title>
	</head>
	<body onkeypress="if(event.keyCode==13){keypressSearch();};">
		<!-- wrap_area :: START -->
		<div id="wrap">
		    <!-- new header :: START -->
		    <div>
		        <tiles:insertAttribute name="header" flush="false"/>
            </div>
            <!-- header :: END -->
		    <!-- container :: START -->
		    <div id="container">
		    	<!-- div class="left_container">
		    		<tiles:insertAttribute name="menu" flush="false"/>
		    	</div-->
				<!-- left_container : end -->
		     	<tiles:insertAttribute name="contents" flush="true"/>
		     	
		     </div>

		</div>
		<form id="frm_bbs" name="frm_bbs" method="post" action="<c:url value="/stud/bbs_list.do" />">
			<input type="hidden" name="bbs_gubun" value="" />
		</form>
		<form id="frm_qna" name="frm_qna" method="post" action="<c:url value="/stud/qna_list.do" />">
		</form>
		
		<form id="frm_question" name="frm_question" method="post" action="<c:url value="/stud/question_list.do" />">
		</form>
		
		<form id="frm_logout" name="frm_logout" method="post" action="<c:url value="/slogout.do" />">
		</form>
		<!-- wrap_area :: END -->
		<iframe src="" name="summitframe" id="summitframe" width="0" height="0" />
	</body>
</html>
