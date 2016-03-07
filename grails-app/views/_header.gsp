<div id="header-box">
    <header id="header" class="sticky">
        <div class="header-content centered">
            <a id="logo" href="/"></a>
            <span id="slogen"></span>
            <div class="default-content">
                <ul id="user-menu" class="dropdown-menu">
                    <sec:ifNotLoggedIn>
                    <li id="login" class="menu menu-box">
                        <g:link controller="login">登录</g:link>
                    </li>
                    </sec:ifNotLoggedIn>
                    <sec:ifLoggedIn>
                    <li id="user-title" class="menu" haschildren="">
                        <a><sec:loggedInUserInfo field="username"/></a><span class="down-arrow"></span>
                        <ul>
                            <li><g:link controller="weChatAccount"><span class="icon"></span>进入后台</g:link></li>
                            <li><g:link controller="logout"><span class="icon"></span>退出</g:link></li>
                        </ul>
                    </li>
                    </sec:ifLoggedIn>
                </ul>

                <nav>
                    <ul id="nav">
                    <li>
                        <g:link controller="about">关于我们</g:link>
                    </li>
                </ul>
                </nav>
            </div>
            <div id="leaf_div">
                <asset:image src="leaf.png" id="leaf"/>
            </div>
        </div>
    </header>
</div>
