<%
/**   
 * @Title: SYZZ_PP_feedback_list.jsp
 * @Description: 收养组织安置后报告反馈列表
 * @author xugy
 * @date 2014-10-9下午5:31:34
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

	 //1 获取排序字段、排序类型(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>the List of Post-placement report</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1700,1700);
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件(Query condition)",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"feedback/SYZZPPFeedbackList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_SIGN_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_NUM").value = "";
			document.getElementById("S_REPORT_DATE_START").value = "";
			document.getElementById("S_REPORT_DATE_END").value = "";
			document.getElementById("S_REPORT_STATE").value = "";
			document.getElementById("S_REMINDERS_STATE").value = "";
		}
		//
		function selectWelfare(node){
			var provinceId = node.value;
			//用于回显得福利机构ID
			var selectedId = '<%=data.getString("WELFARE_ID") %>';
			
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--Please select--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}
				}
			}else{
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--Please select--",""));
			}
		}
		//
		function _into(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var REPORT_STATE = id.split(",")[1];
					if(REPORT_STATE != "0" && REPORT_STATE != "9"){
						alert("please select a data to be submitted feedback");
						return;
					}
					var IS_FINISH = id.split(",")[3];
					if(IS_FINISH == "1"){
						alert('该收养的安置后报告已全部结束，请重新选择');
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"feedback/toSYZZPPFeedbackInto.action";
				document.srcForm.submit();
			}
		}
		//
		function _submit(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var REPORT_STATE = id.split(",")[1];
					if(REPORT_STATE != "0" && REPORT_STATE != "9"){
						alert("please select a data to be submitted feedback");
						return;
					}
					var ORG_NAME = id.split(",")[2];
					if(ORG_NAME == ""){
						alert("You cannot submit if you haven't finished uploading post-placement reports.");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data');
				return;
			}else{
				if(confirm('Are you sure you want to submit?')){
					document.getElementById("ids").value = ids;
					document.srcForm.action=path+"feedback/listSubmitSYZZPPFeedback.action";
					document.srcForm.submit();
				}else{
					return;
				}
			}
		}
		//打印首页
		function _printHomePage(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data');
				return;
			}else{
				window.open(path+"feedback/PPFeedbackHomePage.action?FB_REC_ID="+ids);
			}
		}
		//
		function _detail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"feedback/SYZZPPFeedbackDetail.action";
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;">
		<BZ:form name="srcForm" method="post" action="feedback/SYZZPPFeedbackList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">收文编号<br>Log-in No.</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength=""/>
								</td>
								
								<td class="bz-search-title">签批号<br>Application number</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_NO" id="S_SIGN_NO" defaultValue="" formTitle="签批号" maxlength="" />
								</td>
								
								<td class="bz-search-title">男方<br>Adoptive father</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男收养人" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">女方<br>Adoptive mother</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" maxlength="" />
								</td>
								
								<td class="bz-search-title">省份<br>Province</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isShowEN="true" isCode="true" codeName="PROVINCE"  width="148px" onchange="selectWelfare(this)" formTitle="省份" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">福利院<br>SWI</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px" formTitle="福利院">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							
							</tr>
							<tr>
								<td class="bz-search-title">姓名拼音<br>Name(EN)</td>
								<td>
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								
								<td class="bz-search-title">次第数<br>Number</td><!--  of post-placement reports -->
								<td>
									<BZ:input prefix="S_" field="NUM" id="S_NUM" defaultValue="" formTitle="次第数" maxlength="" />
								</td>
								
								<td class="bz-search-title">提交日期<br>Submission date</td>
								<td>
									<BZ:input prefix="S_" field="REPORT_DATE_START" id="S_REPORT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REPORT_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始反馈日期" />~
									<BZ:input prefix="S_" field="REPORT_DATE_END" id="S_REPORT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REPORT_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止反馈日期" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">报告状态<br>Report status</td>
								<td>
									<BZ:select prefix="S_" field="REPORT_STATE" id="S_REPORT_STATE" width="148px" formTitle="报告状态" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">waiting-for feedback</BZ:option>
										<BZ:option value="1">feedback given</BZ:option>
										<BZ:option value="7">in process of reviewing</BZ:option>
										<BZ:option value="8">approved</BZ:option>
										<BZ:option value="9">returned</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">催交状态<br>Reminder result</td>
								<td>
									<BZ:select prefix="S_" field="REMINDERS_STATE" id="S_REMINDERS_STATE" width="148px" formTitle="催交状态" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">未催交</BZ:option>
										<BZ:option value="1">已催交</BZ:option>
									</BZ:select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="Search" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="Reset" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="Upload" class="btn btn-sm btn-primary" onclick="_into()"/>&nbsp;
					<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;
					<input type="button" value="Print first page" class="btn btn-sm btn-primary" onclick="_printHomePage()"/>&nbsp;
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive" style="overflow-x:scroll;">
				<div id="scrollDiv">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号<br/>(No.)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FILE_NO">收文编号<br/>(Log-in No.)</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="SIGN_NO">签批号<br/>(Application number)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NUM">次第数<br/>(Number)</div><!--  of post-placement reports -->
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">男方<br/>(Adoptive father)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">女方<br/>(Adoptive mother)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PROVINCE_ID">省份<br/>(Province)</div>
								</th>
								<th style="width: 18%;">
									<div class="sorting" id="WELFARE_NAME_EN">福利院<br/>(SWI)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_PINYIN">姓名拼音<br/>(Name(EN))</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="REPORT_DATE">提交日期<br/>(Submission date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REPORT_STATE">报告状态<br/>(Report status)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REMINDERS_STATE">催交状态(Reminder result)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="FB_REC_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="REPORT_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="ORG_NAME" defaultValue="" onlyValue="true"/>,<BZ:data field="IS_FINISH" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="FILE_NO" defaultValue="" /></td>
								<td><BZ:data field="SIGN_NO" defaultValue="" /></td>
								<td><BZ:data field="NUM" defaultValue="" /></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" isShowEN="true" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_EN" defaultValue="" /></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" /></td>
								
								<td><BZ:data field="REPORT_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="REPORT_STATE" defaultValue="" checkValue="0=waiting-for feedback;1=feedback given;2=feedback given;3=feedback given;4=feedback given;5=feedback given;6=feedback given;7=in process of reviewing;8=approved;9=returned;"/></td>
								<td><BZ:data field="REMINDERS_STATE" defaultValue="" checkValue="0=未催交;1=已催交;"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				</div>
				<!--查询结果列表区End -->
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page isShowEN="true" form="srcForm" property="List" type="EN" exportXls="true" exportTitle="安置后反馈报告数据" exportCode="PROVINCE_ID=CODE,PROVINCE;REPORT_STATE=FLAG,0:waiting-for feedback&1:feedback given&2:feedback given&3:feedback given&4:feedback given&5:feedback given&6:feedback given&7:in process of reviewing&8:approved&9:returned;REMINDERS_STATE=FLAG,0:未催交&1:已催交;REPORT_DATE=DATE,yyyy/MM/dd" exportField="FILE_NO=收文编号(Log-in No.),15,20;SIGN_NO=签批号(Application number),15;MALE_NAME=男方(Adoptive father),15;FEMALE_NAME=女方(Adoptive mother),15;PROVINCE_ID=省份(Province),15;WELFARE_NAME_EN=福利院(SWI),15;NAME_PINYIN=姓名拼音(Name(EN)),15;NUM=次第数(Number),15;REPORT_DATE=提交日期(Submission date),15;REPORT_STATE=报告状态(Report status),15;REMINDERS_STATE=催交状态(Reminder result),15;"/></td>
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