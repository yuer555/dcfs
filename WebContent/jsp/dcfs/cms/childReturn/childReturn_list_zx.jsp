<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
	/**   
	 * @Title: childAddition_list_fly.jsp
	 * @Description:  儿童材料补充列表(福利院)
	 * @author furx   
	 * @date 2014-9-4 上午12:12:34 
	 * @version V1.0   
	 */
	 //1 获取排序字段、排序类型(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	Data da = (Data)request.getAttribute("data");
	String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>儿童材料退材料列表(中心)</title>
		<BZ:webScript list="true" isAjax="true" />
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			initProvOrg();
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1000px','200px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"cms/childreturn/returnListZX.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_RETURN_REASON").value = "";
			document.getElementById("S_BACK_TYPE").value = "";
			document.getElementById("S_BACK_RESULT").value = "";
			document.getElementById("S_APPLE_DATE_START").value = "";
			document.getElementById("S_APPLE_DATE_END").value = "";
		}	
		//福利院儿童材料补充列表导出
		function _exportExcel(){
			if(confirm('确认要导出为Excel文件吗?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//进入儿童材料退材料选择列表页面
		function _childReturn(){
			var url = path + "cms/childreturn/returnSelectZX.action";
			//var returnVal=window.open(url,"window",'height=700,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
			//alert("返回值:"+returnVal);
			_open(url, "window", 1050, 680);
			}
		//进入儿童材料退材料申请页面
		function _toReturn(CI_ID){
			document.srcForm.action=path+"cms/childreturn/toReturnAdd.action?CI_ID="+CI_ID+"&RETURN_LEVEL=3";
			document.srcForm.submit();
		}
		//进入退材料确认页面
		function _confirm(){
			var num = 0;
			var AR_ID = "";
			var RETURN_STATE="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					AR_ID =arrays[i].value.split("#")[0];
					RETURN_STATE=arrays[i].value.split("#")[1];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("请选择一条要确认的退材料信息！");
				return;
			}else{
				if(RETURN_STATE!="2"){
				   page.alert("只能确认退材料状态为待中心确认的退材料信息，请重新选择！");
				   return;
			    }
				document.srcForm.action=path+"cms/childreturn/toConfirm.action?AR_ID="+AR_ID+"&CONFIRM_LEVEL=3";
				document.srcForm.submit();
			}
		}
		//省厅福利院查询条件联动所需方法
		function selectWelfare(node){
			var provinceId = node.value;
			//用于回显得福利机构ID
			var selectedId = '<%=WELFARE_ID%>';
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
						var option = document.getElementById("S_WELFARE_ID");
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}else{					
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					}
				}
			}else{
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--",""));
			}
		}
		//省厅福利院查询条件联动所需方法
		function initProvOrg(){
			var str = document.getElementById("S_PROVINCE_ID");
		     selectWelfare(str);
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;TCLFLZX;PROVINCE;">
		<BZ:form name="srcForm" method="post" action="cms/childreturn/returnListZX.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="150" style="width: 65%"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</td>
								<td style="width: 16%">
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="" width="70%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
	                            <td class="bz-search-title" style="width: 10%">出生日期</td>
								<td style="width: 36%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >省份</td>
								<td >
								    <BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"    isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
					 	                <BZ:option value="">--请选择省份--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title">福利院</td>
								<td colspan="3">
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="" width="40%">
						              <BZ:option value="">--请选择福利院--</BZ:option>
					                </BZ:select>
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >退文类型</td>
								<td >
									<BZ:select prefix="S_" field="BACK_TYPE" id="S_BACK_TYPE" isCode="true" codeName="TCLFLZX" formTitle="退文类型" defaultValue="" width="70%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>	
								
								<td class="bz-search-title">状态</td>
								<td>
									<BZ:select prefix="S_" field="BACK_RESULT" id="S_BACK_RESULT"  formTitle="状态" defaultValue="" width="70%">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">已确认</BZ:option>
										<BZ:option value="0">未确认</BZ:option>
									</BZ:select>
								    
								</td>
							
								<td class="bz-search-title">申请日期</td>
								<td>
									<BZ:input prefix="S_" field="APPLE_DATE_START" id="S_APPLE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_APPLE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始申请日期" />~
									<BZ:input prefix="S_" field="APPLE_DATE_END" id="S_APPLE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_APPLE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止申请日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">退材料原因</td>
								<td colspan="5">
								    <BZ:input prefix="S_" field="RETURN_REASON" id="S_RETURN_REASON" defaultValue="" formTitle="退材料原因"  maxlength="1000" style="width: 70%"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="搜&nbsp;&nbsp;索" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
		<div class="page-content">
			<div class="wrapper" >
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch();"/>&nbsp;
					<input type="button" value="确&nbsp;&nbsp;认" class="btn btn-sm btn-primary" onclick="_confirm();"/>&nbsp;
					<input type="button" value="代&nbsp;&nbsp;录" class="btn btn-sm btn-primary" onclick="_childReturn();"/>
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace"/>
									</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">省厅</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="APPLE_DATE">申请日期</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="BACK_TYPE">退文类型</div>
								</th>
								<th style="width: 17%;">
									<div class="sorting" id="RETURN_REASON">退材料原因</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BACK_DATE">退材料日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="BACK_RESULT">状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value='<BZ:data field="AR_ID" onlyValue="true"/>#<BZ:data field="RETURN_STATE" onlyValue="true"/>' class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="APPLE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BACK_TYPE" defaultValue=""  codeName="TCLFLZX"  onlyValue="true"/></td>
								<td ><BZ:data field="RETURN_REASON" defaultValue="" onlyValue="true"/></td>
								<td class="center" ><BZ:data field="BACK_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BACK_RESULT" defaultValue="" checkValue="0=未确认;1=已确认;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List"  exportXls="true" exportTitle="儿童材料退材料" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;APPLE_DATE=DATE;BACK_TYPE=CODE,TCLFLZX;BACK_DATE=DATE;BACK_RESULT=FLAG,0:未确认&1:已确认;" exportField="PROVINCE_ID=省份,10,20;WELFARE_NAME_CN=福利院,20;NAME=姓名,10;SEX=性别,8;BIRTHDAY=出生日期,10;APPLE_DATE=申请日期,10;BACK_TYPE=退文类型,15;RETURN_REASON=退材料原因,50;BACK_DATE=退材料日期,15;BACK_RESULT=状态,15;"/></td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>