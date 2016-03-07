<style type="text/css">
#sideBar{
    border-right: 0px solid #D3D3D3 !important;
    float: left;
    padding: 0 0 10px 0;
    width: 170px;
    background: #fff;
}
.tableContent {
    background: none repeat scroll 0 0 #f5f6f7;
    padding: 0;
}
.tableContent .content {
    border-left: 1px solid #D7DDE6 !important;
}
ul#menu, ul#menu ul {
    list-style-type:none;
    margin: 0;
    padding: 0;
    background: #fff;
}

ul#menu a {
    display: block;
    text-decoration: none;
}

ul#menu li {
    margin: 1px;
}
ul#menu li ul li{
    margin: 1px 0;
}
ul#menu li a {
    background: #EBEEF1;
    color: #464D6A;
    padding: 0.5em;
}
ul#menu li .nav-header{
    font-size:14px;
    border-bottom: 1px solid #D7DDE6;
}
ul#menu li .nav-header:hover {
    background: #DDE4EB;
}

ul#menu li ul li a {
    background: #FCFCFC;
    color: #8288A4;
    padding-left: 20px;
}
ul#menu li ul li:last-child {
    border-bottom: 1px solid #D7DDE6;
}
ul#menu li ul li a:hover {
    background: #fff;
    border-left: 5px #4A98E0 solid;

}
ul#menu li.selected a{
    background: #fff;
    border-left: 5px #4A98E0 solid;
    padding-left: 15px;
    color: #4A98E0;
}
.code { border: 1px solid #ccc; list-style-type: decimal-leading-zero; padding: 5px; margin: 0; }
.code code { display: block; padding: 3px; margin-bottom: 0; }
.code li { background: #ddd; border: 1px solid #ccc; margin: 0 0 2px 2.2em; }
.indent1 { padding-left: 1em; }
.indent2 { padding-left: 2em; }
.tableContent .content{min-height: 600px;}
</style>

<g:if test="${context}">
<div class="appTitle normalTitle2">
    <div class="vipuser">
        <div class="logo">
            <img src="${context?.headerPic}" width="100" height="100"/>
        </div>

        <div id="nickname">
            <strong><a href="">${context?.name}</a></strong>
            <a href="#" target="_blank" class="vipimg" title=""></a>
        </div>

        <div id="weixinid">微信号:${context?.weChatId}</div>
    </div>

    <div class="accountInfo">
        <table class="vipInfo" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td><strong>图文自定义：</strong></td>
                <td><strong>活动创建数：</strong></td>
                <td><strong>请求数：</strong></td>
            </tr>
            <tr>
                <td><strong>请求数剩余：</strong></td>
                <td><strong>已使用：</strong></td>
                <td><strong>当月赠送请求数：</strong></td>
                <td><strong>当月剩余请求数：</strong></td>
            </tr>
        </table>
    </div>
</div>

<div class="tableContent">
    <!--左侧功能菜单-->
    <div class="sideBar" id="sideBar">
        <div class="catalogList">
            <ul id="menu">
                <a class="nav-header" style="border-top:none !important;"><b class="base">基础设置</b></a>
                <ul class="ckit">
                    <li class="subCatalogList"><g:link controller="areply">关注时回复</g:link></li>
                    <li class="subCatalogList"><g:link controller="text">微信－文本回复</g:link></li>
                    <li class="subCatalogList"><g:link controller="image">微信－图文回复</g:link></li>
                    <li class="subCatalogList"><g:link controller="multiimage">微信－多图文回复</g:link></li>
                    <li class="subCatalogList"><g:link controller="message">微信－群发消息</g:link></li>
                    <li class="subCatalogList"><g:link controller="template">微信－模板消息</g:link></li>
                    <li class="subCatalogList"><a href="#">自定义LBS回复</a></li>
                    <li class="subCatalogList"><g:link controller="media">素材管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="classification">分类管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="weChatMenu">自定义菜单</g:link></li>
                    <li class="subCatalogList"><a href="#">微信用户信息授权</a></li>
                    <li class="subCatalogList"><a href="#">回答不上来的配置</a></li>
                </ul>
                <div style="clear:both"></div>
            </ul>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function(){
            $(".nav-header").mouseover(function(){
                $(this).addClass('navHover');
            }).mouseout(function(){
                $(this).removeClass('navHover');
            }).click(function(){
                $(this).toggleClass('nav-header-current');
                $(this).next('.ckit').slideToggle();
            })
        });
    </script>
</g:if>