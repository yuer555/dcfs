<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@page import="com.hx.framework.shortinfo.vo.Sms_ShortInfo_Manager"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<% 
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	String magzine_id = (String)request.getAttribute(Sms_ShortInfo_Manager.MAGZINE_ID);
	
%>
<BZ:html>  
<BZ:head>
<title>�б�</title>
<BZ:script isList="true" />
  <script type="text/javascript">
	function _onload() {
		
	}
  
	function _delete() {
	 	var sfdj=0;
	  	var uuid="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++) {
			if(document.getElementsByName('xuanze')[i].checked) {
				uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
			  	sfdj++;
			}
		}
		if(sfdj=="0") {
			 alert('��ѡ��Ҫɾ��������');
			 return;
		} else {
			if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')) {
				document.getElementById("deleteuuid").value=uuid;
				document.srcForm.action=path+"shortInfoManager/delete.action";
				document.srcForm.submit();
			} else {
			 	return;
			}
		}
	}
	
	function add(){
		document.srcForm.action = path + "shortInfoManager/toadd.action";
		document.srcForm.submit();
	}
	
	function modify(){
		var sfdj=0;
 		var ID="";
 		for(var i=0;i<document.getElementsByName('xuanze').length;i++) {
 			if(document.getElementsByName('xuanze')[i].checked) {
	 			ID=document.getElementsByName('xuanze')[i].value;
	 			sfdj++;
 		  	}
		}
	 	if(sfdj!="1") {
	  		alert('��ѡ��һ������');
	  		return;
	 	} else {
	 		document.srcForm.action=path+"shortInfoManager/tomodify.action?ID="+ID;
	 		document.srcForm.submit();
	 	}
	}
	
	function chakan() {
		var sfdj=0;
 		var ID="";
 		for(var i=0;i<document.getElementsByName('xuanze').length;i++) {
 			if(document.getElementsByName('xuanze')[i].checked) {
	 			ID=document.getElementsByName('xuanze')[i].value;
	 			sfdj++;
 		  	}
		}
	 	if(sfdj!="1") {
	  		alert('��ѡ��һ������');
	  		return;
	 	} else {
	 		document.srcForm.action=path+"log/Log!lookLog.action?ID="+ID;
	 		document.srcForm.submit();
	 	}
	}
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<form name="srcForm" method="post" action="<%=request.getContextPath() %>/shortInfoManager/list.action">
<input type="hidden" name="deleteuuid" />
<input type="hidden" name="<%=Sms_ShortInfo_Manager.MAGZINE_ID %>" value="<%=magzine_id %>"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<div class="kuangjia">
<div class="list">
<div class="heading">�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
	<BZ:th name="���" sortType="none" width="6%" sortplan="jsp"/>
	<BZ:th name="����" sortType="string" width="40%" sortplan="jsp"/>
	<BZ:th name="��������" sortType="string" width="19%" sortplan="jsp"/>
	<BZ:th name="������" sortType="none" width="19%" sortplan="jsp"/>
	<BZ:th name="����״̬" sortType="string" width="10%" sortplan="jsp"/>   
	<BZ:th name="�����" sortType="string" width="6%" sortplan="jsp"/>   
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
	<td><BZ:data field="CONTENT" defaultValue=""/></td>
	<td><BZ:data field="SEND_TIME" defaultValue=""/></td>
	<td><BZ:data field="RECIEVERS" defaultValue=""/></td>
	<td><BZ:data field="STATUS" defaultValue=""/></td>
	<td><BZ:data field="SORTID" defaultValue=""/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="dataList"/></td>
</tr>
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
	<input type="button" value="����" class="button_select" onclick="add()"/>&nbsp;&nbsp;
	<input type="button" value="�޸�" class="button_update" onclick="modify()"/>&nbsp;&nbsp;
	<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</div>
</form>
</BZ:body>
</BZ:html>