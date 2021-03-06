<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	
	String path = request.getContextPath();
	//收养组织ID
	String id = (String)request.getAttribute("ID");
	
	Data data = (Data)request.getAttribute("data");
	String linkManId = "";
	if(data != null){		
		linkManId = data.getString("ID");
	}
%>
<BZ:html>
	<BZ:head>
		<title>在华联系人</title>
		<BZ:webScript list="true" edit="true"/>
		<script type="text/javascript" src="<%=path %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['iframeC','iframe','mainFrame']);
			var linkManId = "<%=linkManId%>";
			var id = "<%=id%>";
			if(linkManId != "" && linkManId != "null"){
				iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/linkManModifyEn.action?linkManId="+linkManId+"&ID="+id;
			}
		});
		//添加在华联系人信息
		function _create(){
			document.getElementById("linkManDiv").style.display='block';
			var id = "<%=id%>";
			iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/linkManModifyEn.action?ID="+id;
		}

		//修改在华联系人信息
		function showContact(){
			document.getElementById("linkManDiv").style.display='block';
			var id="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
				}
			}
			iframeC.location = "<%=request.getContextPath() %>/mkr/organSupp/linkManModifyEn.action?linkManId="+id;
		}

		//删除在华联系人信息
		function _delete(){
			var num = 0;
			var id="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				document.srcForm.action = path+"mkr/organSupp/deleteLinkManEn.action?linkManId="+id;
				document.srcForm.submit();
			}
			document.location= "<%=request.getContextPath() %>/mkr/organSupp/linkManOrganListEn.action?ID=<%=id%>";
		}
	</script>
	<BZ:body property="data" codeNames="ADOPTER_CHILDREN_SEX;CARD_CODE;">
		<BZ:form name="srcForm" method="post" action="mkr/organSupp/linkManOrganListEn.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="ID" value="<%=id %>"/>
		<input type="hidden" name="compositor" value="<%=compositor %>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype %>"/>
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="新&nbsp;&nbsp;增" class="btn btn-sm btn-primary" onclick="_create()"/>&nbsp;
					<input type="button" value="删&nbsp;&nbsp;除" class="btn btn-sm btn-primary" onclick="_delete()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 5%;">
									<div class="sorting_disabled">
										<!-- <input type="checkbox" class="ace"> -->
									</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting_disabled">序号English</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ID_TYPE">身份证明种类</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ID_NUMBER">身份证明号码</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="TELEPHONE">电话</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FAX">传真</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MOBEL">手机</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="EMAIL">电子邮件</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ADDR">联系地址</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="dataList">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" onclick="showContact()" type="radio" value="<BZ:data field="ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX"  defaultValue="" codeName="ADOPTER_CHILDREN_SEX" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ID_TYPE" defaultValue="" codeName="CARD_CODE" onlyValue="true"/></td>
								<td><BZ:data field="ID_NUMBER" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TELEPHONE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FAX" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MOBEL" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="EMAIL" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ADDR" defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="dataList" /></td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		<div id="linkManDiv" style="width:100%; margin: 0 auto;display: none">
		 <iframe id="iframeC" scrolling="no" src="" style="border:none; width:100%; height:900px; overflow:hidden;  frameborder="0"></iframe>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>