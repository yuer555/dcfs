
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String compositor=(String)request.getParameter("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getParameter("ordertype");
if(ordertype==null){
	ordertype="";
}
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<base target="_self"/>
<BZ:script isList="true"/>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function _onload(){

	}
	function search(){
	document.srcForm.action=path+"";
	document.srcForm.submit();
	}

	function add(){
	document.srcForm.action=path+"role/Role!toAdd.action";
	document.srcForm.submit();
	}

	//分配角色给角色组
	function allotRole(){

	var ID = document.getElementById("GROUP_ID").value;
	//弹出
	var PARENT_ID = document.getElementById("PARENT_ID").value;
	window.showModalDialog("role/RoleGroup!queryNoRoles.action?<%=RoleGroup.ID %>="+ID+"&<%=RoleGroup.PARENT_ID %>="+PARENT_ID, this, "dialogWidth=600px;dialogHeight=350px;scroll=auto");
	//回调
	document.srcForm.action = "role/RoleGroup!queryRoles.action?<%=RoleGroup.ID %>="+ID;
	document.srcForm.submit();
	}

	function _back(){
	document.srcForm.action=path+"role/RoleGroup!queryChildrenPage.action";
	document.srcForm.submit();
	}

	function _delete(){
		var sfdj=0;
		var uuid="";
		var roleids="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			var di=document.getElementsByName('xuanze')[i].value.split(",");
				uuid=uuid+di[0]+"#";
				roleids=roleids+di[1]+"#";
				sfdj++;
		}
		}
		if(sfdj=="0"){
		alert('请选择要移除的数据');
		return;
		}else{
		if(confirm('确认要移除选中信息吗?')){
		document.getElementById("DELETE_IDS").value=uuid;
		document.getElementById("APP_IDS").value=roleids;
		document.srcForm.action=path+"role/Authorize!removeOrgApp.action";
		document.srcForm.submit();
		}else{
		return;
		}
		}
		}
	</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="role/RoleGroup!allotRole.action">
<div class="kuangjia">
<input id="DELETE_IDS" name="DELETE_IDS" type="hidden"/>
<input id="APP_IDS" name="APP_IDS" type="hidden"/>
<!-- 选中的组织机构ID -->
<input name="ORG_IDS" id="ORG_IDS" type="hidden" value="<%=request.getAttribute("ORG_IDS")!=null?request.getAttribute("ORG_IDS"):"" %>"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<div class="list">
<div class="heading">角色权限列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="20%" sortplan="jsp"/>
<BZ:th name="应用名称" sortType="string" width="80%" sortplan="database" sortfield="CNAME"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>,<BZ:data field="APP_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
<input type="button" value="移除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<input type="button" value="关闭" class="button_back" onclick="window.close();"/>
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>