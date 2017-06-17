<%@ page language="java"%><%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style type="text/css">
body {background-color:#f6f3e4;}
li {list-style:none;}
.wrap {width:1000px; margin:0 auto; overflow:hidden;}
.top {width:300px; height:40px; float:right; padding-bottom:20px;}
.top ul {float:right;}
.top ul li {float:left;}
.top ul li.top_txt {font-size:14px; margin-top:17px; margin-left:10px;}
.top_menu {width:1000px; margin:0 auto; clear:both; overflow:hidden;}
.top_menu ul {width:100%; padding:0;}
.top_menu ul li {float:left;}
</style>
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script>
$(document).ready(function(){
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
</script>
	<div class="wrap" style="text-align:center;">
    	<div class="top">
        	<ul>
            	<li><a onclick="javascript:gologout();"><img src="<c:url value="/images/newlogin/sp.gif" />" class="swapimg" /></a></li>
                <li class="top_txt"><strong>${sessionScope.stud.stud_nm}</strong>님</li>
            </ul>
        </div>
    	<div class="top_menu">
        	<ul>
            	<li><a onclick="javascript:gobbslist('1');"><img width="195px" src="<c:url value="/images/newlogin/sm1.gif" />" class="swapimg" /></a></li>
                <li><a onclick="javascript:goqna();"><img width="205px" src="<c:url value="/images/newlogin/sm2.gif" />" class="swapimg" /></a></li>
                <li><a onclick="javascript:goquestion();"><img width="224px" src="<c:url value="/images/newlogin/sm3.gif" />" class="swapimg" /></a></li>
                <li><a onclick="javascript:gobbslist('2');"><img width="195px" src="<c:url value="/images/newlogin/sm4.gif" />" class="swapimg" /></a></li>
                <li><a onclick="javascript:gobbslist('3');"><img width="162px" src="<c:url value="/images/newlogin/sm5.gif" />" class="swapimg" /></a></li>
            </ul>
        </div>        
    </div>
    <hr/>