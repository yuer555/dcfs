<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%
String NAV_ID=(String)request.getAttribute("NAV_ID");
String PNAME=(String)request.getAttribute("PNAME");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<BZ:script/>
<title>�˵�</title>
<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
</script>
</head>
<body>
	<table width="100%" height="100%">
		<tr height="100%">
			<td width="25%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/menu/menuTree.action?NAV_ID=<%=NAV_ID %>" id="leftFrame" name="leftFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
			<td width="75%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/menu/menuList.action?NAV_ID=<%=NAV_ID %>&PARENT_ID=0" id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
		</tr>
	</table>

</body>
<noframes>
	<body></body>
</noframes>
</html>