<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildStateManager"%>
<%
  /**   
 * @Description: 材料接收列表（安置部）
 * @author wangzheng   
 * @date 2014-9-19
 * @version V1.0   
 */
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
  String path = request.getContextPath();

%>

<BZ:html>
	<BZ:head>
		<title>材料接收列表（安置部）</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/page.js"></script>
		
	</BZ:head>
	
<script type="text/javascript">
  	//iFrame高度自动调整
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
			area: ['950px','260px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}
	
	//检索
	function _search(){
		document.srcForm.action=path+"/cms/childManager/azbReceiveList.action";
		if(document.getElementById("S_IS_HOPE").checked)
			document.getElementById("S_IS_HOPE").value = "1";
		if(document.getElementById("S_IS_PLAN").checked)
			document.getElementById("S_IS_PLAN").value = "1";
		document.srcForm.submit();
	}

	//检索条件重置
	function _reset(){
		document.getElementById("S_PROVINCE_ID").value = "";
		document.getElementById("S_WELFARE_ID").value = "";
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_CHILD_TYPE").value = "";
		document.getElementById("S_SN_TYPE").value = "";
		document.getElementById("S_RECEIVE_STATE").value = "";
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
		document.getElementById("S_CHECKUP_DATE_START").value = "";
		document.getElementById("S_CHECKUP_DATE_END").value = "";
		document.getElementById("S_IS_HOPE").checked = false;
		document.getElementById("S_IS_HOPE").value = "";
		document.getElementById("S_IS_PLAN").checked = false;
		document.getElementById("S_IS_PLAN").value = "";
		document.getElementById("S_POST_DATE_START").value = "";
		document.getElementById("S_POST_DATE_END").value = "";
		document.getElementById("S_RECEIVE_DATE_START").value = "";
		document.getElementById("S_RECEIVE_DATE_END").value = "";
	}
  
	//查看信息
	function _view(){
		var arrays = document.getElementsByName("abc");
		var num = 0;
		var showuuid="";
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				showuuid=document.getElementsByName('abc')[i].value;
				num += 1;
			}
		}
		if(num != "1"){
			page.alert('请选择一条要查看的数据');
			return;
		}else{	 
			url = path+"/cms/childManager/show.action?type=show&UUID="+showuuid;
			_open(url, "儿童材料信息", 1000, 600);

		}
	}

    //导出
	function _export(){
		if(confirm('确认要导出为Excel文件吗?')){
			_exportFile(document.srcForm,'xls');
		}else{
			return;
		}
	}

//接收
  function _receive(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var uuid="";
	var isreceive = "true";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			uuid=uuid+"#"+document.getElementsByName('abc')[i].value;
			if("<%=ChildStateManager.CHILD_RECEIVE_STATE_TODO%>"!=document.getElementsByName('abc')[i].getAttribute("RECEIVE_STATE")){
				isreceive = "false";
			}
			num += 1;			
		}
	}
	if(num == "0"){
		page.alert('请选择材料接收！');
		return;
	}else{
		if(isreceive == "false"){
			page.alert('请选择接收状态为待接收的材料接收！');
			return;
		}
		if(confirm('确认要接收选中材料吗?')){
			document.getElementById("uuid").value=uuid;
			document.srcForm.action=path+"/cms/childManager/azbBatchReceive.action";
			document.srcForm.submit();
			document.srcForm.action=path+"/cms/childManager/azbReceiveList.action";
		}
	 }
  }
	
	//修改
  function _revise(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var showuuid="";
	var ismod = "true";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			showuuid=document.getElementsByName('abc')[i].value;
			alert(document.getElementsByName('abc')[i].getAttribute("AUD_STATE"));
			if("<%=ChildStateManager.CHILD_AUD_STATE_SDS%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") && "<%=ChildStateManager.CHILD_AUD_STATE_SSHZ%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") ){
				ismod = "false";
			}
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('请选择一条要修改的记录！');
		return;
	}else{
	 if(ismod == "false"){
		page.alert('已寄送的记录无法修改！');
		return;
	 }
	 document.srcForm.action=path+"/cms/childManager/show.action?type=mod&UUID="+showuuid;
	 document.srcForm.submit();
	 document.srcForm.action=path+"/cms/childManager/azbReceiveList.action";
	 }
  }

  	//条码打印
	function _print(){
		var num = 0;
		var printuuid = [];
		var arrays = document.getElementsByName('abc');
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				printuuid[num++] = arrays[i].value.split("#")[0];
			}
		}
		if(num < 1){
			page.alert('请选择要打印的材料！');
			return;
		}else{
			document.getElementById("printuuid").value = printuuid.join("#");
			window.open(path + "cms/childManager/receivePrint.action?printuuid="+printuuid,"newwindow","height=842,width=680,top=100,left=350,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
			//document.srcForm.action=path+"cms/childManager/receivePrint.action";
			//document.srcForm.submit();
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
	<BZ:body property="data"  codeNames="PROVINCE;ETSFLX;BCZL;ETXB;CHILD_TYPE;CLJSZT">
    <BZ:form name="srcForm" method="post" action="/cms/childManager/azbReceiveList.action">
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">省份</td>
								<td style="width: 15%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="100%"  isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
					 	                <BZ:option value="">--请选择省份--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="福利院">福利院</span></td>
								<td style="width: 15%">
								   <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="">
						              <BZ:option value="">--请选择福利院--</BZ:option>
					               </BZ:select>
								
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="寄送日期">寄送日期</span></td>
								<td style="width: 40%">
									<BZ:input prefix="S_" field="POST_DATE_START" id="S_POST_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_POST_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="POST_DATE_END" id="S_POST_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_POST_DATE_START\\')}',readonly:true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" style="width: 10%"><span title="姓名">姓名</span></td>
								<td style="width:15%">
								<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue=""/>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="性别">性别</span></td>
								<td style="width: 15%">
									<BZ:select prefix="S_"  field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别">
										<option value="">--请选择--</option>
									</BZ:select>
								</td>
								<td class="bz-search-title"  style="width: 10%"><span title="出生日期">出生日期</span></td>
								<td style="width: 40%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title"><span title="儿童类型">儿童类型</span></td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="病残种类">病残种类</span></td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL"  defaultValue="" formTitle="病残种类">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="体检日期">体检日期</span></td>
								<td colspan="5">
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_CHECKUP_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_CHECKUP_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true"/>
								</td>		
							</tr>
							<tr>
								<td class="bz-search-title"><span title="特殊活动">特殊活动</span></td>
								<td class="bz-search-value">
									<input type="checkbox" name="S_IS_PLAN" id="S_IS_PLAN" value="" <BZ:dataValue field="IS_PLAN" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>明天计划&nbsp;&nbsp;
									<input type="checkbox" name="S_IS_HOPE" id="S_IS_HOPE" value="" <BZ:dataValue field="IS_HOPE" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>希望之旅
								</td>
								<td class="bz-search-title"><span title="接收状态">接收状态</span></td>
								<td>
									<BZ:select prefix="S_" field="RECEIVE_STATE" id="S_RECEIVE_STATE" isCode="true" codeName="CLJSZT" defaultValue="" formTitle="接收状态">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="接收日期">接收日期</span></td>
								<td>
									<BZ:input prefix="S_" field="RECEIVE_DATE_START" id="S_RECEIVE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="RECEIVE_DATE_END" id="S_RECEIVE_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_START\\')}',readonly:true"/>
								</td>								
							</tr>						 
						</table>
					</td>
				</tr>
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
    <input type="hidden" name="uuid" id="uuid" value="" />	     
	<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
	<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	<input type="hidden" id="printuuid" name="printuuid" value=""/>
	<div class="page-content">
	<BZ:frameDiv property="clueTo" className="kuangjia">	 
    <div class="wrapper">		
		<!-- 功能按钮操作区Start -->
		<div class="table-row table-btns" style="text-align: left">
			<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;		
			<input type="button" value="接&nbsp;&nbsp;收" class="btn btn-sm btn-primary" onclick="_receive()"/>&nbsp;
			<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
			<input type="button" value="条码打印" class="btn btn-sm btn-primary" onclick="_print()"/>&nbsp;
			<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
		</div>
		<div class="blue-hr"></div>
		<!-- 功能按钮操作区End -->		
		<!--查询结果列表区Start -->
		<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
			<thead>
				<tr class="emptyData">
					<th class="center" style="width:2%;">
						<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
					</th>
					<th style="width:3%;">
						<div class="sorting_disabled">序号</div>
					</th>
					<th style="width:6%;">
						<div class="sorting" id="PROVINCE_ID">省份</div>
					</th>
					<th style="width:12%;">
						<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="NAME">姓名</div>
					</th>
					<th style="width:4%;">
						<div class="sorting" id="SEX">性别</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="BIRTHDAY">出生日期</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="CHILD_TYPE">儿童类型</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="SN_TYPE">病残种类</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="CHECKUP_DATE">体检日期</div>
					</th>
					<th style="width:8%;">
						<div  class="sorting_disabled" id="TCHD">特殊活动</div>
					</th>
					
					<th style="width:8%;">
						<div class="sorting" id="POST_DATE">寄送日期</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="RECEIVE_DATE">接收日期</div>
					</th>
					<th style="width:6%;">
						<div class="sorting" id="RECEIVE_STATE">接收状态</div>
					</th>
				</tr>
				</thead>
				<tbody>	
					<BZ:for property="List">
						<tr>
							<td class="center">
								<input name="abc" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>" class="ace" AUD_STATE="<BZ:data field="AUD_STATE" onlyValue="true"/>" RETURN_STATE="<BZ:data field="RETURN_STATE" onlyValue="true"/>" RECEIVE_STATE="<BZ:data field="RECEIVE_STATE" onlyValue="true"/>">
							</td>
							<td class="center">
								<BZ:i/>
							</td>
							<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/></td>
							<td><BZ:data field="SN_TYPE"  codeName="BCZL" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CHECKUP_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td>
							<BZ:data field="IS_HOPE" onlyValue="true" defaultValue="" checkValue="0= ;1=希望之旅"/>
							<BZ:data field="IS_PLAN" onlyValue="true" defaultValue="" checkValue="0= ;1=明天计划"/>
							</td>
							<td align="center"><BZ:data field="POST_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="RECEIVE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="RECEIVE_STATE"  codeName="CLJSZT" defaultValue="" onlyValue="true"/></td>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="儿童材料接收数据" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;SN_TYPE=CODE,BCZL;CHECKUP_DATE=DATE;IS_HOPE=FLAG,0:否&1:是;IS_PLAN=FLAG,0:否&1:是;POST_DATE=DATE;RECEIVE_DATE=DATE;RECEIVE_STATE=CODE,CLJSZT;" exportField="PROVINCE_ID=省份,15,20;WELFARE_NAME_CN=福利院,25;NAME=姓名,15;SEX=性别,10;BIRTHDAY=出生日期,15;CHILD_TYPE=儿童类型,10;SN_TYPE=病残种类,25;CHECKUP_DATE=体检日期,15;IS_PLAN=明天计划,10;IS_HOPE=希望之旅,10;POST_DATE=寄送日期,15;RECEIVE_DATE=接收日期,15;RECEIVE_STATE=接收状态,15;"/></td>				
				</tr>
			</table>
		</div>
		<!--分页功能区End -->
	</div>
</div>
<form name="frmprint" method="post" action="<%=path%>/cms/childManager/postPrint.action" target="<%=path%>/cms/childManager/postPrint.action">
	<input type="hidden" id="printid" name="printid">
</form>
<br><br><br><br><br>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>
