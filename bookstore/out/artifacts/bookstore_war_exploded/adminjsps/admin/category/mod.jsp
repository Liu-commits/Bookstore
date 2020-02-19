<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>修改分类</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
	body {background: rgb(254,238,189);}
</style>
<script type="text/javascript">
	function con(){
	var cname = document.getElementById("ipt").value;
	if (!confirm("确认要修改 ${category.cname} 为"+" "+cname+" 吗？")) {
		window.event.returnValue = false;
	}
	}
</script>
  </head>
  
  <body>
    <h1>修改分类</h1>
    <form action="<c:url value='/admin/AdminCategoryServlet'/>" method="post">
    	<input type="hidden" name="method" value="edit" />
    	<input type="hidden" name="cid" value="${category.cid }" />
    	
    	分类名称：<input id="ipt" type="text" name="cname" value="${category.cname }"/>
    	<input type="submit" value="修改分类" onclick="con()"/>
    </form>
  </body>
</html>
