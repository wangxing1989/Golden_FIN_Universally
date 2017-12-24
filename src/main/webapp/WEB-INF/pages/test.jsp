<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
	<head>
	<title>客户管理页-平台头寸</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<link href="./css/style1.css" type="text/css" rel="stylesheet" />
	<style type="text/css">
    #login
    {
        display:none;
        border:1em solid #3366FF;
        height:30%;
        width:50%;
        position:absolute;/*让节点脱离文档流,我的理解就是,从页面上浮出来,不再按照文档其它内容布局*/
        top:24%;/*节点脱离了文档流,如果设置位置需要用top和left,right,bottom定位*/
        left:24%;
        z-index:2;/*个人理解为层级关系,由于这个节点要在顶部显示,所以这个值比其余节点的都大*/
        background: white;
    }
    #over
    {
        width: 100%;
        height: 100%;
        opacity:0.8;/*设置背景色透明度,1为完全不透明,IE需要使用filter:alpha(opacity=80);*/
        filter:alpha(opacity=80);
        display: none;
        position:absolute;
        top:0;
        left:0;
        z-index:1;
        background: silver;
    }
	</style>
	<script type="text/javascript">
		function searchVariety() {
			var varietyCode = document.getElementById("variety");
			window.location.herf = "index?varietyName=" + varietyCode;
		}
		
		    function show()
		    {
				var login = document.getElementById('login');
				var over = document.getElementById('over');
		        login.style.display = "block";
		        over.style.display = "block";
		    }
		    function hide()
		    {
				var login = document.getElementById('login');
				var over = document.getElementById('over');
	
		        login.style.display = "none";
		        over.style.display = "none";
		    }
	</script>
	</head>
	<body>
		<!-- 整体大背景的div -->
		<div id="page">
			<%@ include file="/common/header.jsp"%>
			<div class="div2">
				<!-- 把div2分成左右两个部分 -->
				<div class="div3"></div>
				<div class="div4">
					<!-- 品种查询div -->
					<div class="search1">
						<p>
							<span style="font-family: '微软雅黑';">品种：</span>
						</p>
						<select id="variety">
							<c:forEach items="${varietyList }" var="varietyList">
								<option value="${varietyList.varietyName }">${varietyList.varietyName }</option>
							</c:forEach>
						</select>
						<button onclick="searchVariety();">查询</button>
					</div>
					<div class="jingtoucun">
						<div class="font1">
							<font size="6px">${statisticsVo.netPosition }</font>
							<font size="3px">(${statisticsVo.netPositionHourly })</font>
						</div>
						<div class="font2">
							净头寸(一小时头寸)
						</div>
						<div class="font3">
							多总持仓：${statisticsVo.multipleTotalHolding }<br>
							空总持仓：${statisticsVo.emptyTotalHolding }
						</div>
					</div>
					<div class="zhongjianjia">
						<div class="font1">
							<font size="6px"><fmt:formatNumber pattern="#.00" value="${statisticsVo.middlePrice}"/></font>
						</div>
						<div class="font2">
							中间价
						</div>
						<div class="font3">
							多总均价：${statisticsVo.multipleTotalAveragePrice }<br>
							空总均价：${statisticsVo.emptyTotalAveragePrice }
						</div>
					</div>
					<div class="shijia">
						<div class="font1">
							<font size="6px">${statisticsVo.marketBuyPrice }</font>
							<font size="3px">(${statisticsVo.marketSellPrice })</font>
						</div>
						<div class="font2">市价</div>
						<div class="font3">
							多爆点：${statisticsVo.multipleDetonatingPoint }<br>
							空爆点：${statisticsVo.emptyDetonatingPoint }
						</div>
					</div>
					<div class="yingkui">
						<div class="font1">
							<font size="6px"><fmt:formatNumber pattern="#.####" value="${statisticsVo.totalProfitAndLoss }"/></font>
						</div>
						<div class="font2">客户总盈亏</div>
						<div class="font3">
							平仓盈亏：<fmt:formatNumber pattern="#.####" value="${statisticsVo.offsetGainAndLoss }"/><br>
							持仓盈亏：<fmt:formatNumber pattern="#.####" value="${statisticsVo.opsitionGainAndLoss }"/>
						</div>
					</div>
						<table class="platformTable" >
							<tr style="background-color: #c0c0c0" align="center">
								<td><strong>平台名</strong></td>
								<td><strong>买入手数</strong></td>
								<td><strong>买入价</strong></td>
								<td><strong>卖出手数</strong></td>
								<td><strong>卖出价</strong></td>
								<td><strong>净头寸</strong></td>
								<td><strong>1小时头寸</strong></td>
								<td><strong>中间价</strong></td>
								<td><strong>多爆点</strong></td>
								<td><strong>空爆点</strong></td>
								<td><strong>持仓盈亏</strong></td>
								<td><strong>平仓盈亏</strong></td>
								<td><strong>总盈亏</strong></td>
								<td><strong>操作</strong></td>
							<c:forEach items="${staList }" var="staList">
								<tr align="center">
									<td>${staList.platformName }</td>
									<td>${staList.multipleTotalHolding }</td>
									<td>${staList.multipleTotalAveragePrice }</td>
									<td>${staList.emptyTotalHolding }</td>
									<td>${staList.emptyTotalAveragePrice }</td>
									<td>${staList.netPosition }</td>
									<td>${staList.netPositionHourly }</td>
									<td>${staList.middlePrice }</td>
									<td>${staList.multipleDetonatingPoint }</td>
									<td>${staList.emptyDetonatingPoint }</td>
									<td><fmt:formatNumber pattern="#.####" value="${staList.opsitionGainAndLoss }"/></td>
									<td><fmt:formatNumber pattern="#.####" value="${staList.offsetGainAndLoss }"/></td>
									<td><fmt:formatNumber pattern="#.####" value="${staList.totalProfitAndLoss }"/></td>
									<td>跟单</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					</div>
					<div class="addAccountDivClass" align="right">
						<input type="button" value="添加交易账号" onclick="javascript:show()" />
					</div>
					<div class="accountTable">
					  <div id="login">
					  </div>
					  <div id="over">
					  	<form action="account/add" method="post">
						  	<table>
						  		平台:
						  		<select id="platform" name="platform.id">
									<c:forEach items="${tradePlatformList}" var="platform">
										<option value="${platform.id}">${platform.name}</option>
									</c:forEach>
								</select>
						  		<br/>
						  		账号:<input type="text" name="username"/><br/>
						  		密码:<input type="text" name="password"/><br/>
						  		<input type="submit" value="保存"/>
						  		<input type="button" value="取消"/>
							</table>
						</form>
					  </div>
						<table style="height: 100%; width: 100%;" border=1>
							<tr>
								<td>平台</td>
								<td>帐户名</td>
								<td>操作</td>
							</tr>
							<c:forEach items="${allAccounts }" var="account">
								<tr>
									<td>
										${account.platformName}
									</td>
									<td>
										${account.userName}
									</td>
									<td>
										修改 删除
									</td>
								</tr>	
							</c:forEach>
						</table>
					</div>
					</div>
	</body>
</html>