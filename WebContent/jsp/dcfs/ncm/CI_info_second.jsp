<%
/**   
 * @Title: CI_info_second.jsp
 * @Description: 儿童信息
 * @author xugy
 * @date 2014-11-3下午9:24:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data=(Data)request.getAttribute("data");

String LANG = (String)request.getAttribute("LANG");//语言
%>
<BZ:html>
<BZ:head>
	<title>儿童信息</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	dyniframesize(['CIFrame','mainFrame']);//公共功能，框架元素自适应
	//intoiframesize('CIFrame');
});
</script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;CHILD_TYPE;ETSFLX;">
<%-- <%=path%>/match/showCIInfoSecond.action?CI_ID=<%=CI_ID%> --%>
	<table class="bz-edit-data-table" border="0">
		<%
		if("EN".equals(LANG)){
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">省份<br/>Province</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" isShowEN="true" codeName="PROVINCE"/>
			</td>
			<td class="bz-edit-data-title" width="15%">福利院<br/>SWI</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="WELFARE_NAME_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">姓名<br/>Name(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">性别<br/>Sex</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" isShowEN="true" codeName="ETXB"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">出生日期<br/>D.O.B</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title">儿童类型<br/>Type of children</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" isShowEN="true" codeName="CHILD_TYPE"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">儿童身份<br/></td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" isShowEN="true" codeName="ETSFLX"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">送养人<br/></td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SENDER_EN" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">送养人地址<br/></td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		}else{
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">省份</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/>
			</td>
			<td class="bz-edit-data-title" width="15%">福利院</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">姓名</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">性别</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">出生日期</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title">儿童类型</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" codeName="CHILD_TYPE"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">儿童身份</td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" codeName="ETSFLX"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">送养人</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">送养人地址</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%} %>
	</table>
</BZ:body>
</BZ:html>
