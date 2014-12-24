<%
/**   
 * @Title: CI_info_fourth.jsp
 * @Description: ��ͯ��Ϣ
 * @author xugy
 * @date 2014-11-20����3:17:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data=(Data)request.getAttribute("data");

String CI_ID = data.getString("CI_ID");//
%>
<BZ:html>
<BZ:head>
	<title>��ͯ��Ϣ</title>
	<BZ:webScript edit="true" tree="true"/>
	<up:uploadResource/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	dyniframesize(['CIFrame','mainFrame']);//�������ܣ����Ԫ������Ӧ
	//intoiframesize('CIFrame');
});
</script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;CHILD_TYPE;ETSFLX;">
<%-- <%=path%>/match/showCIInfoFourth.action?CI_ID=<%=CI_ID%> --%>
	<table class="bz-edit-data-table" border="0">
		<tr>
			<td class="bz-edit-data-title" width="15%">ʡ��</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/>
			</td>
			<td class="bz-edit-data-title" width="15%">����Ժ</td>
			<td class="bz-edit-data-value" width="23%">
				<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
				<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="CI" packageId="<%=CI_ID%>" smallType="<%=AttConstants.CI_IMAGE %>"/>'></img>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">�Ա�</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title">��ͯ����</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" codeName="CHILD_TYPE"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͯ����</td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" codeName="ETSFLX"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">�����˵�ַ</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
	</table>
</BZ:body>
</BZ:html>