<%@ page language="java"%>
<%@ page pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
	<head>
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Cache-Control" content="no-cache" />
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="imagetoolbar" content="no" />
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/admin.css" />" />
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
        //]]>
        </script>
        
		<title><tiles:getAsString name="title"/></title>
	</head>
	<body onkeypress="if(event.keyCode==13){keypressSearch();};">
		<!-- wrap_area :: START -->
		<div id="wrap">
		    <!-- new header :: START -->
		    <div id="header" class="header_style">
		        <tiles:insertAttribute name="header" flush="false"/>
            </div>
            <!-- header :: END -->
		    <!-- container :: START -->
		    <div id="container">
		    	<div class="left_container">
		    		<tiles:insertAttribute name="menu" flush="false"/>
		    	</div>
				<!-- left_container : end -->
		     	<tiles:insertAttribute name="contents" flush="true"/>
		     	
		     </div>
		     <div id="footer">
		        <tiles:insertAttribute name="footer" flush="false"/>
		     </div> 
		</div>
		<!-- wrap_area :: END -->
		<iframe src="" name="summitframe" id="summitframe" width="0" height="0" />
	</body>
</html>
