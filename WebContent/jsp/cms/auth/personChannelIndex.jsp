<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>��Ա������Ŀ</title>
<BZ:script/>
<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
</script>
</BZ:head>
<BZ:body style="margin:0">
	<table width="100%" height="100%">
		<tr height="100%">
			<td width="22%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/cms_auth/Auth!toAlotChannelsNoConditions.action?treeDispatcher=allotPersonsChannelsTree" id="left1Frame" name="left1Frame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
			</td>
			<td width="22%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/cms_auth/Auth!generateOrganTree.action?treeDispatcher=channelsOrganTree" id="left2Frame" name="left2Frame"  marginwidth="0" marginheight="0" frameborder="0" scrolling="no"  ></iframe>
			</td>
			<td width="56%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/cms_auth/Auth!personList.action?ORG_ID=0" id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"  ></iframe>
			</td>
		</tr>
	</table>
</BZ:body>
<noframes>
	<body>
		<form id="srcForm" name="srcForm" action="role/RoleGroup">
			<input type="hidden" name="ROLE" id="ROLE" value="jie"/>
			<input type="hidden" name="" id=""/>
		</form>
	</body>
</noframes>
</BZ:html>