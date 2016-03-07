<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 2015/5/23
  Time: 13:26
--%>

<%@ page import="net.xunzhenji.util.FormatUtil" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>粉丝管理</title>
    <asset:stylesheet href="cymain.css" />
</head>

<body>
<div class="content">

    <div class="cLineB">
        <h4 class="left">关注粉丝管理</h4>
        <div class="searchbar right">
            <form method="post" action="">
                <input type="text" id="msgSearchInput" class="txt left" placeholder="输入昵称搜索" name="keyword" value="">
                <input type="submit" value="搜索" id="msgSearchBtn" href="" class="btnGrayS" title="搜索">
            </form>
        </div>
        <div class="clr"></div>
    </div>

    <pigcmsif where="$showStatistics eq 1">
        <div id="chartdiv1" align="center"></div>
        <script type="text/javascript">
            var chart = new FusionCharts("/fushionCharts/Charts/Pie3D.swf", "ChartId", "600", "400", "0", "1");
            //chart.setTransparent("false");
            chart.setDataXML('{pigcms:$xml}');
            //chart.setDataURL("data.html");
            chart.render("chartdiv1");
        </script>
    </pigcmsif>

    <div class="cLine">
        <div class="pageNavigator left">
            <g:link action="syncFans" class="btnGrayS vm bigbtn">
                <asset:image src="text.png" class="vm"/>更新列表
            </g:link>
            <g:link action="updateFansInfo" class="btnGrayS vm bigbtn">
                <asset:image src="text.png" class="vm"/>刷新所有粉丝信息
            </g:link>
            <g:link action="activeFans" class="btnGrayS vm bigbtn">
                <asset:image src="text.png" class="vm"/>互动粉丝
            </g:link>

        </div>
        <div class="clr"></div>
    </div>
    <div class="msgWrap" style="border-top:1px solid #ccc;padding-top:10px;margin-top:10px;">

        <div style="margin:10px 0">
            <div style="float:right;width:25%;text-align:right">
                <g:form method="post" action="searchFans">
                    <input type="text" id="msgSearchInput" class="px" placeholder="输入昵称搜索" name="keyword" value="">
                    <input type="submit" value="搜索" id="msgSearchBtn" href="" class="btnGrayS" title="搜索">
                </g:form>
            </div>
            <g:form method="post" action="setGroup">
                <div style="width:70%;float:left">将选中粉丝转移到分组中<select name="groupId">
                        <g:each in="${weChatGroups}" var="group">
                            <option value="${group.id}">${group.name}</option>
                        </g:each>
                    </select>
                    <input type="submit" value="转移" id="msgSearchBtn" href="" class="btnGrayS" title="转移">&nbsp;&nbsp;按分组查看粉丝
                    <select id="groupId" onchange="location.href='?groupId='+this.value">
                    <g:each in="${weChatGroups}" var="group">
                        <option value="${group.id}" ${groupId == group.id ? 'selected':''}>${group.name}</option>
                    </g:each>
                </select>
                </div>

                <div style="clear:both"></div>
        </div>

        <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
            <thead>
            <tr>
                <th class="select"><input type="checkbox" value="" id="check_box" onclick="selectall('id[]');"></th>
                <th class="select">编号</th>
                <th>OpenId</th>
                <th>粉丝昵称</th>
                <th>性别 </th>
                <th>分组名</th>
                <th>省(直辖市) </th>
                <th>城市 </th>
                <th>头像</th>
                <th>关注时间</th>
                <th>互动时间</th>
                <th class="norightborder">操作</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${weChatFans}" var="fans">
                <tr>
                    <td><input type="checkbox" value="${fans.id}" class="cbitem" name="id_${fans.id}"></td>
                    <td><g:link action="show" id="${fans.id}">${fans.id}</g:link></td>
                    <td>${fans.openId}</td>
                    <td>${fans.nickName}<br>
                        <g:if test="${fans.userInfo}">${fans.userInfo.name}</g:if>
                    </td>
                    <td>${fans.sex == 0 ? '未知' : fans.sex == 1 ? '男' : '女'}</td>
                    <td>${fans.weChatGroup?.name}</td>
                    <td>${fans.province}</td>
                    <td>${fans.city}</td>
                    <td>
                        <div class="cateimg">
                            <img src="${fans.headImgUrl}" class="cateimg_small"  />
                        </div>
                    </td>
                    <td>${org.apache.commons.lang.time.DateFormatUtils.format(new Date(fans.subscribeTime*1000), 'yyyy-MM-dd')}</td>
                    <td>${fans.lastActivityTime ? net.xunzhenji.util.FormatUtil.formatDurationUtilNow(fans.lastActivityTime) : ""}</td>
                    <td class="norightborder">
                        <a href=""><g:link controller="weChatFansActivity"
                                           params="[fansId: fans.id]">粉丝行为管理</g:link></a>　
                    </td>
                </tr>
            </g:each>
            <tr>

            </tr>
            </tbody>
        </table>

        <div class="pagination">
            <g:paginate total="${weChatFansTotal ?: 0}"/>
            <span>共${weChatFansTotal ?: 0}行</span>
        </div>
    </g:form>
    </div>
    <div class="cLine">
        <div class="pageNavigator right">
            <div class="pages"></div>
        </div>
        <div class="clr"></div>
    </div>
</div>

<script src="/fushionCharts/JSClass/FusionCharts.js" type="text/javascript"></script>
<script>
    function selectall(name) {
        var checkItems=$('.cbitem');
        if ($("#check_box").attr('checked')==false) {
            $.each(checkItems, function(i,val){
                val.checked=false;
            });

        } else {
            $.each(checkItems, function(i,val){
                val.checked=true;
            });
        }
    }
</script>
</body>
</html>