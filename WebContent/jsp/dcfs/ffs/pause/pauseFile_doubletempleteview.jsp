<%
/**   
 * @Title: pauseFile_doubletempleteview.jsp
 * @Description:  文件信息双亲收养查看页面
 * @author panfeng   
 * @date 2014-9-11 上午10:12:06 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<BZ:html>
	<BZ:head>
		<title>双亲收养查看页面</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			/* 初始化查看页面数据   */
			if($("#R_MALE_MARRY_TIMES").val() != ""){
				$(".MARRY_TIMES").show();
			}
			if($("#R_UNDERAGE_NUM").val() != ""){
				$("#UNDERAGE_NUMBER").show();
			}
			if($("#R_INTERVIEW_TIMES").val() != ""){
				$("#MEET_TIMES").show();
			}
			if($("#R_RECOMMENDATION_NUM").val() != ""){
				$("#LETTER_NUM").show();
			}
			if($("#R_APPROVE_CHILD_NUM").val() != ""){
				$("#APPROVE_NUM").show();
			}
			if($("#R_AGE_FLOOR").val() != ""){
				$(".CHILD_AGE").show();
			}
			
			//根据男、女收养人的出生日期计算其年龄
			var male_birth = $("#R_MALE_BIRTHDAY").val();
			var female_birth = $("#R_FEMALE_BIRTHDAY").val();
			if(male_birth != ""){
				$("#MALE_AGE").text(_getAge(male_birth));
			}
			if(female_birth != ""){
				$("#FEMALE_AGE").text(_getAge(female_birth));
			}
			
			
			//初始化健康说明
			var male_health = $("#R_MALE_HEALTH").val();
			var female_health = $("#R_FEMALE_HEALTH").val();
			if(male_health == "2"){
				$("#MALE_HEALTH_CONTENT").text($("#R_MALE_HEALTH_CONTENT_EN").val());
			}
			if(female_health == "2"){
				$("#FEMALE_HEALTH_CONTENT").text($("#R_FEMALE_HEALTH_CONTENT_EN").val());
			}
			
			//初始化身高体重的显示方式
			var measurement = $("#R_MEASUREMENT").val();
			var male_height = $("#R_MALE_HEIGHT").val();	//男收养人身高
			var female_height = $("#R_FEMALE_HEIGHT").val();	//女收养人身高
			if(measurement == "0"){
				$("#MALE_HEIGHT_INCH").hide();
				$("#MALE_HEIGHT_METRE").show();
				$("#FEMALE_HEIGHT_INCH").hide();
				$("#FEMALE_HEIGHT_METRE").show();
				$("#MALE_WEIGHT_POUNDS").hide();
				$("#MALE_WEIGHT_KILOGRAM").show();
				$("#FEMALE_WEIGHT_POUNDS").hide();
				$("#FEMALE_WEIGHT_KILOGRAM").show();
				
			}else if(measurement == "1"){
				$("#MALE_HEIGHT_INCH").show();
				$("#MALE_HEIGHT_METRE").hide();
				$("#FEMALE_HEIGHT_INCH").show();
				$("#FEMALE_HEIGHT_METRE").hide();
				$("#MALE_WEIGHT_POUNDS").show();
				$("#MALE_WEIGHT_KILOGRAM").hide();
				$("#FEMALE_WEIGHT_POUNDS").show();
				$("#FEMALE_WEIGHT_KILOGRAM").hide();
				
				var maletempfeet = parseInt(male_height) / 30.48 + "";
				var malefeet = maletempfeet.split(".")[0];
				var maleinch = maletempfeet.split(".")[1] * 12;
				$("#MALE_HEIGHT_INCH").text(malefeet + " 英尺(Feet)" + maleinch + " 英寸(Inch)");
				
				var femaletempfeet = parseInt(female_height) / 30.48 + "";
				var femalefeet = femaletempfeet.split(".")[0];
				var femaleinch = femaletempfeet.split(".")[1] * 12;
				$("#FEMALE_HEIGHT_INCH").text(femalefeet + " 英尺(Feet)" + femaleinch + " 英寸(Inch)");
				
				var male_weight = $("#R_MALE_WEIGHT").val();	//男收养人体重
				var female_weight = $("#R_FEMALE_WEIGHT").val();	//女收养人体重
				$("#R_MALE_WEIGHT").text(parseFloat(parseInt(male_weight) / 0.45359237).toFixed(2));
				$("#R_FEMALE_WEIGHT").text(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));
			}
			
			//违法行为及刑事处罚
			var male_punishment_flag = $("#R_MALE_PUNISHMENT_FLAG").val();
			var female_punishment_flag = $("#R_FEMALE_PUNISHMENT_FLAG").val();
			if(male_punishment_flag == "1"){
				$("#R_MALE_PUNISHMENT_EN").show();
				$("#R_MALE_PUNISHMENT").hide();
			}else{
				$("#R_MALE_PUNISHMENT_EN").hide();
				$("#R_MALE_PUNISHMENT").show();
			}
			if(female_punishment_flag == "1"){
				$("#R_FEMALE_PUNISHMENT_EN").show();
				$("#R_FEMALE_PUNISHMENT").hide();
			}else{
				$("#R_FEMALE_PUNISHMENT_EN").hide();
				$("#R_FEMALE_PUNISHMENT").show();
			}
			
			//不良嗜好
			var male_illegalact_flag = $("#R_MALE_ILLEGALACT_FLAG").val();
			var female_illegalact_flag = $("#R_FEMALE_ILLEGALACT_FLAG").val();
			if(male_illegalact_flag == "1"){
				$("#R_MALE_ILLEGALACT_EN").show();
				$("#R_MALE_ILLEGALACT").hide();
			}else{
				$("#R_MALE_ILLEGALACT_EN").hide();
				$("#R_MALE_ILLEGALACT").show();
			}
			if(female_illegalact_flag == "1"){
				$("#R_FEMALE_ILLEGALACT_EN").show();
				$("#R_FEMALE_ILLEGALACT").hide();
			}else{
				$("#R_FEMALE_ILLEGALACT_EN").hide();
				$("#R_FEMALE_ILLEGALACT").show();
			}
			
			//结婚时长
			var marry_date = $("#R_MARRY_DATE").val();
			if(marry_data != ""){
				var length = _getAge(marry_date);
				$("#MARRY_LENGTH").text(length + "年(Year)");
			}
			
			//家庭净资产
			var total_asset = $("#R_TOTAL_ASSET").val();
			var total_debt = $("#R_TOTAL_DEBT").val();
			$("#TOTAL_MANNY").text(total_asset - total_debt);
			
			//有效期限
			var valid_period = $("#R_VALID_PERIOD").val();
			if(valid_period != "-1" && valid_period != ""){
				$("#R_PERIOD").text(valid_period + " 月(Month)");
			}else if(valid_period == "-1"){
				$("#R_PERIOD").text("长期");
			}
		});
		
		//根据出生日期获取周岁年龄
		function _getAge(strBirthday){       
		    var returnAge;
		    var strBirthdayArr=strBirthday.split("-");
		    var birthYear = strBirthdayArr[0];
		    var birthMonth = strBirthdayArr[1];
		    var birthDay = strBirthdayArr[2];
		    
		    d = new Date();
		    var nowYear = d.getFullYear();
		    var nowMonth = d.getMonth() + 1;
		    var nowDay = d.getDate();
		    
		    if(nowYear == birthYear){
		        returnAge = 0;//同年 则为0岁
		    }else{
		        var ageDiff = nowYear - birthYear ; //年之差
		        if(ageDiff > 0){
		            if(nowMonth == birthMonth){
		                var dayDiff = nowDay - birthDay;//日之差
		                if(dayDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }else{
		                var monthDiff = nowMonth - birthMonth;//月之差
		                if(monthDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }
		        }else{
		            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
		        }
		    }
		    
		    return returnAge;//返回周岁年龄
		    
		}
	</script>
</BZ:html>
<BZ:body property="data" codeNames="WJLX_DL;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ORG_LIST">
	<!-- 隐藏区域begin -->
	<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_FEMALE_HEALTH_CONTENT_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MEASUREMENT" id="R_MEASUREMENT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEIGHT" id="R_MALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_WEIGHT" id="R_MALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_WEIGHT" id="R_FEMALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG" id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG" id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG" id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG" id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_MARRY_TIMES" id="R_MALE_MARRY_TIMES" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="VALID_PERIOD" id="R_VALID_PERIOD" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="UNDERAGE_NUM" id="R_UNDERAGE_NUM" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="INTERVIEW_TIMES" id="R_INTERVIEW_TIMES" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="RECOMMENDATION_NUM" id="R_RECOMMENDATION_NUM" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="APPROVE_CHILD_NUM" id="R_APPROVE_CHILD_NUM" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="AGE_FLOOR" id="R_AGE_FLOOR" defaultValue=""/>
	<!-- 隐藏区域end -->
	<!-- 查看区域begin -->
	<div class="bz-edit clearfix" desc="查看区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">收养组织(CN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">收养组织(EN)</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">文件类型</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX_DL" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">收养类型</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="bz-edit clearfix" desc="查看区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>收养人基本信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="16%">&nbsp;</td>
						<td class="bz-edit-data-title" colspan="2" style="text-align:center">男收养人</td>
						<td class="bz-edit-data-title" colspan="2" style="text-align:center">女收养人</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">外文姓名</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="16%">出生日期</td>
						<td class="bz-edit-data-value" width="24%">
							<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-value" width="20%" rowspan="4">
							<img src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'/>
						</td>
						<td class="bz-edit-data-value" width="24%">
							<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-value" width="16%" rowspan="4">
							<img src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">年龄</td>
						<td class="bz-edit-data-value">
							<span id="MALE_AGE"></span>
						</td>
						<td class="bz-edit-data-value">
							<span id="FEMALE_AGE"></span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">国籍</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NATION" codeName="GJ" defaultValue=""/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NATION" codeName="GJ" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">护照号码</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">受教育情况</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">职业</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_JOB_EN" defaultValue=""/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_JOB_EN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">健康状况</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>&nbsp;&nbsp;
							<span id="MALE_HEALTH_CONTENT"></span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>&nbsp;&nbsp;
							<span id="FEMALE_HEALTH_CONTENT"></span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">身高</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MEASUREMENT" checkValue="0=公制;1=英制;" defaultValue=""/>
							<span id="MALE_HEIGHT_INCH"></span>
							<span id="MALE_HEIGHT_METRE" style="display: none;">
								<BZ:dataValue field="MALE_HEIGHT" defaultValue=""/>厘米
							</span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<span id="FEMALE_HEIGHT_INCH"></span>
							<span id="FEMALE_HEIGHT_METRE" style="display: none;">
								<BZ:dataValue field="FEMALE_HEIGHT" defaultValue=""/>厘米
							</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">体重</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_WEIGHT" defaultValue=""/>
							<span id="MALE_WEIGHT_POUNDS" style="display: none;">磅</span>
							<span id="MALE_WEIGHT_KILOGRAM" style="display: none;">千克</span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_WEIGHT" defaultValue=""/>
							<span id="FEMALE_WEIGHT_POUNDS" style="display: none;">磅</span>
							<span id="FEMALE_WEIGHT_KILOGRAM" style="display: none;">千克</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">体重指数</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_BMI" defaultValue=""/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_BMI" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">违法行为及刑事处罚</td>
						<td class="bz-edit-data-value" colspan="2">
							<span id="R_MALE_PUNISHMENT">
								<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
							</span>
							<span id="R_MALE_PUNISHMENT_EN">
								<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue=""/>
							</span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<span id="R_FEMALE_PUNISHMENT">
								<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
							</span>
							<span id="R_FEMALE_PUNISHMENT_EN">
								<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue=""/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">有无不良嗜好</td>
						<td class="bz-edit-data-value" colspan="2">
							<span id="R_MALE_ILLEGALACT">
								<BZ:dataValue field="MALE_ILLEGALACT_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
							</span>
							<span id="R_MALE_ILLEGALACT_EN">
								<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue=""/>
							</span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<span id="R_FEMALE_ILLEGALACT">
								<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
							</span>
							<span id="R_FEMALE_ILLEGALACT_EN">
								<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue=""/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">宗教信仰</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_RELIGION_EN" defaultValue=""/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_RELIGION_EN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">货币单位</td>
						<td class="bz-edit-data-value" colspan="4">
							<BZ:dataValue field="CURRENCY" codeName="HBBZ" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">年收入</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">前婚次数</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_MARRY_TIMES" defaultValue=""/><span class="MARRY_TIMES" style="display: none;">次</span>
						</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue=""/><span class="MARRY_TIMES" style="display: none;">次</span>
						</td>
					</tr>
				</table>
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">婚姻状况</td>
						<td class="bz-edit-data-value" width="18%">已婚</td>
						<td class="bz-edit-data-title" width="15%">结婚日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="MARRY_DATE" defaultValue="" type="Date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">婚姻时长</td>
						<td class="bz-edit-data-value" width="19%">
							<span id="MARRY_LENGTH"></span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">家庭总资产</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">家庭总债务</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">家庭净资产</td>
						<td class="bz-edit-data-value" width="19%">
							<span id="TOTAL_MANNY"></span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">18周岁以下子女数量</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="UNDERAGE_NUM" defaultValue=""/><span id="UNDERAGE_NUMBER" style="display: none;">个</span>
						</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="18%">&nbsp;</td>
						<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						<td class="bz-edit-data-value" width="19%">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">子女数量及情况</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="CHILD_CONDITION_EN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">家庭住址</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADDRESS" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">收养要求</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>家庭调查及组织意见信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">完成家调组织名称</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">家庭报告完成日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FINISH_DATE" defaultValue="" type="Date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">会见次数</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="INTERVIEW_TIMES" defaultValue=""/><span id="MEET_TIMES" style="display: none;">次</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">推荐信</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECOMMENDATION_NUM" defaultValue=""/><span id="LETTER_NUM" style="display: none;">封</span>
						</td>
						<td class="bz-edit-data-title">心里评估报告</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEART_REPORT" defaultValue="" codeName="ADOPTER_HEART_REPORT"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收养动机</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="ADOPT_MOTIVATION" defaultValue="" codeName="ADOPTER_ADOPT_MOTIVATION"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">家中10周岁及以上孩子对收养的意见</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILDREN_ABOVE" defaultValue="" codeName="ADOPTER_CHILDREN_ABOVE"/>
						</td>
						<td class="bz-edit-data-title">有无指定监护人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FORMULATE" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">不遗弃不虐待声明</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="IS_ABUSE_ABANDON" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">抚育计划</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_MEDICALRECOVERY" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">收养前准备</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADOPT_PREPARE" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">风险意识</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RISK_AWARENESS" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">同意递交安置后报告声明</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_SUBMIT_REPORT" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">家中有无其他人同住</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">家中其他人同住说明</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_EN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">育儿经验</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PARENTING" checkValue="0=无;1=有;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">社工意见</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SOCIALWORKER" checkValue="1=支持;2=保留意见;3=不支持;" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">&nbsp;</td>
						<td class="bz-edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">家庭需说明的其他事项</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REMARK_EN" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>政府批准信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">批准日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">有效期限</td>
						<td class="bz-edit-data-value" width="18%">
							<span id="R_PERIOD"></span>
						</td>
						<td class="bz-edit-data-title" width="15%">批准儿童数量</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue=""/><span id="APPROVE_NUM" style="display: none;">个</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">收养儿童年龄</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="AGE_FLOOR" defaultValue=""/><span class="CHILD_AGE" style="display: none;">岁~</span>
							<BZ:dataValue field="AGE_UPPER" defaultValue=""/><span class="CHILD_AGE" style="display: none;">岁</span>
						</td>
						<td class="bz-edit-data-title" width="15%">收养儿童性别</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="CHILDREN_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收养儿童健康状况</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="CHILDREN_HEALTH_EN" defaultValue="" codeName="ADOPTER_CHILDREN_HEALTH"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 查看区域end -->
</BZ:body>