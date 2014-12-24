<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.transfercode.TransferCode"%>
<%@page import="hx.util.DateUtility"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Description:�ƽ���ϸ�鿴
	 * @author wangzheng
	 * @date 2014-11-18 
	 * @version V1.0   
	 */
	
	//��ȡ���ݶ����б�
    Data da=(Data)request.getAttribute("transferChildinfo_print_data");
    String tc ="";
    String code=da.getString("TRANSFER_CODE",null);
    DataList dlist = (DataList)request.getAttribute("transferChildinfo_print_list");
    int sumTotal = 0;
    int sumSpecial = 0;
    int sumNormal = 0;
    if(dlist!=null){
    	sumTotal = dlist.size();
    }
    for(int j=0;j<dlist.size();j++){
    	if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(dlist.getData(j).getString("CHILD_TYPE"))){
    		sumSpecial++;
    	}else{
    		sumNormal++;
    	}
    }
    
%>
<BZ:html>
<BZ:head>
	<title>���Ͻ��ӵ��鿴</title>
	<BZ:webScript list="true" edit="true" />
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>
	
</BZ:head>
<script>
	function _close(){
		window.close();
	}
</script>
<BZ:body property="transferChildinfo_print_data" codeNames="ETXB;PROVINCE;CHILD_TYPE">	
	<div class="page-content"  style="width:100%">
		<div class="wrapper">

			
            <div align="center"><font size="+2"><span class="title3"><%=TransferCode.getPrintTitle0ByTransferCode(code) %></span></font>
            </div> 
            <div align="center"><font size="+1"><span class="title4"><%=TransferCode.getPrintTitleByTransferCode(code) %></span></font></div>
			
			<!--list:start-->
			<div class="table-responsive">
				<!--��ѯ����б���Start -->
					
					<table class="table table-striped table-bordered table-hover dataTable table-print" border="1" adsorb="both" init="true" id="table" width="98%s">							
							<thead>
							<tr>
								<th style="width:5%;">���</th>
								<th style="width:10%;">��ͯ���</th>
								<th style="width:8%;">ʡ��</th>
								<th style="width:20%;">����Ժ</th>
								<th style="width:10%;">����</th>
								<th style="width:5%;">�Ա�</th>
								<th style="width:12%;">��������</th>
								<th style="width:8%;">��������</th>
								<th style="width:8%;">�ر��ע</th>
								<th style="width:10%;">��ע</th>
							</tr>
							</thead>
							<BZ:for property="transferChildinfo_print_list">
								<tr class="emptyData">
									<td class="center"><BZ:i /></td>
									<td style="text-align:center"><BZ:data  field="CHILD_NO" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data codeName="PROVINCE" field="PROVINCE_ID" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
									<td style="text-align:center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true" /></td>
									<td style="text-align:center">
									<BZ:data type="date" field="BIRTHDAY" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
									</td>
									<td style="text-align:center"><BZ:data codeName="CHILD_TYPE" field="CHILD_TYPE" defaultValue="" onlyValue="true"/></td>
									<td style="text-align:center"><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/></td>
									<td>&nbsp;</td>
								</tr>
							</BZ:for>
					</table>
					</div>
					
			</div>
			<!--list:end-->	

		<br>
        <div class="blue-hr" id="print1" style="text-align:center;"> 
			<button class="btn btn-sm btn-primary" onclick="_close()">�ر�</button>
		</div>
	</div>
   
</BZ:body>

</BZ:html>