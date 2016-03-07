%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%
<style type="text/css">
#sideBar{
    border-right: 0 solid #D3D3D3 !important;
    float: left;
    padding: 0 0 10px 0;
    width: 170px;
    background: #fff;
}
.tableContent {
    background: none repeat scroll 0 0 #f5f6f7;
    padding: 0;
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
</style>

    <!--左侧功能菜单-->
    <div class="sideBar" id="sideBar">
        <div class="catalogList">
            <ul id="menu">
                <a class="nav-header" style="border-top:none !important;"><b class="base">公众号</b></a>
                <ul class="ckit" style="display:none">
                    <li class="subCatalogList"><g:link controller="weChatAccount">公众号列表</g:link></li>
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
                <a class="nav-header nav-header-current"><b class="site">用户/权限</b></a>
                <ul class="ckit" style="display:none">
                    <li class="subCatalogList"><g:link controller="user">用户号列表</g:link></li>
                    <li class="subCatalogList"><g:link controller="role">权限列表</g:link></li>
                    <li class="subCatalogList"><g:link controller="requestmap">页面权限列表</g:link></li>
                </ul>
                <a class="nav-header nav-header-current"><b class="site">系统管理</b></a>
                <ul class="ckit" style="display:none">
                    <li class="subCatalogList"><g:link controller="requestmap">页面权限</g:link></li>
                    <li class="subCatalogList"><g:link controller="quartz" action="list">批处理任务</g:link></li>
                    <li class="subCatalogList"><g:link controller="server" action="index">服务器配置</g:link></li>
                    <li class="subCatalogList"><g:link controller="alipayContext" action="index">支付宝配置</g:link></li>
                    <li class="subCatalogList"><g:link controller="link" action="index">短链接配置</g:link></li>
                    <li class="subCatalogList"><g:link controller="randomLink" action="index">随机链接配置</g:link></li>
                </ul>
                <a class="nav-header nav-header-current"><b class="site">页面管理</b></a>
                <ul class="ckit" style="display:none">
                    <li class="subCatalogList"><g:link controller="home" action="edit">编辑首页</g:link></li>
                    <li class="subCatalogList"><g:link controller="about" action="edit" id="1">编辑关于</g:link></li>
                </ul>
                <a class="nav-header nav-header-current"><b class="site">供应商管理</b></a>
                <ul class="ckit" style="display:none">
                    <li class="subCatalogList"><g:link controller="express">快递管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="sfSetting">顺丰系统对接</g:link></li>
                    <li class="subCatalogList"><g:link controller="smsSetting" action="show">云片网对接</g:link></li>
                </ul>
                <a class="nav-header nav-header-current"><b class="site">电商系统</b></a>
                <ul class="ckit" style="display:none">
                    <li class="subCatalogList"><g:link controller="producer">生产者管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="category">商品分类管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="product">商品管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="batch">批次管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="productOrder">订单管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="delivery" action="list">发货管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="lxGroup">领鲜群主管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="payment">流水管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="comment">评价管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="suggestion">建议管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="couponTemplate">优惠券</g:link></li>
                    <li class="subCatalogList"><g:link controller="promotionCode"><g:message
                            code="promotionCode.label" default="推广码"/></g:link></li>
                    <li class="subCatalogList"><g:link controller="weChatCoupon"><g:message
                            code="weChatCoupon.label" default="微信代金券"/></g:link></li>
                    <li class="subCatalogList"><g:link controller="commission">佣金管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="qrCodeSetting">二维码</g:link></li>
                </ul>
                <a class="nav-header nav-header-current"><b class="site">CRM</b></a>
                <ul class="ckit" style="display:none">
                    <li class="subCatalogList"><g:link controller="userInfo">客户管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="weChatFans">粉丝管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="weChatGroup">分组管理</g:link></li>
                </ul>
                <a class="nav-header nav-header-current"><b class="site">农店通</b></a>
                <ul class="ckit" style="display:none">
                    <li class="subCatalogList"><g:link controller="warehouse">仓库管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="shopProduct">产品管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="shop">店铺管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="shopFans">店铺访问权限</g:link></li>
                    <li class="subCatalogList"><g:link controller="miaoXinWorkflow">淼鑫工作流</g:link></li>
                    <li class="subCatalogList"><g:link controller="shopOrder">订单管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="stockMove">库存移动</g:link></li>
                    <li class="subCatalogList"><g:link controller="stockItem">库存产品</g:link></li>
                    <li class="subCatalogList"><g:link controller="source">货主管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="procurement">采购管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="manufacture">生产管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="shopDelivery">配送管理</g:link></li>
                    <li class="subCatalogList"><g:link controller="miaoXinProcess">淼鑫记录</g:link></li>
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