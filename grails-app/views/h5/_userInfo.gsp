%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<div class="view" id="login-container">
    <div class="pages" style="margin-top: 0 !important;">
        <div class="panel" id="login" style="background-color: #edeef1 !important;">
        <a href="#main" data-transition="up-reveal:dismiss" class="close"><i class="fa fa-times"></i></a>

        <h3 role="loginTip" class="page-header">绑定手机号码</h3>
        <form id="user-info-form">
            <div class="login-wrap">
                <div class="input-group">
                    <div role="phoneNumber" class="input-row"><div>手机号码</div>

                        <div><input type="tel" id="login-mobile" class="phoneNumber" name="mobile" pattern="^\d{11}$"
                                    placeholder="填写你的手机号码" oninvalid="invalidMobile(event);" title="11位手机号码"
                                    value="">
                        </div>
                        <i class="fa fa-check-square-o verified" style="display: none;"></i>
                    </div>

                    <div role="loginRemind" class="login-remind">寻真记的交易通知短信会发到这个手机号码</div>

                    <div class="incorrect-mobile">请检查11位手机号码</div>

                    <div role="mobileCaptcha" class="input-row" style="display: none;">
                        <div>验证码(<span id="seq"></span>)</div>
                        <div><input id='mobileCode' type="tel" pattern="[0-9]{4}" placeholder="输入数字验证码"
                                    oninput="matchMobileCaptcha();" title="4位数字验证码" name="mobileCode"></div>

                        <div><a role="reGetMobileCaptcha" class="btn btn-xs btn-white" onclick="validateMobile();"></a></div>
                        <input id="seqValue" type="hidden" name="seq">
                    </div>

                    <div role="randomCaptcha" class="input-row" style="display: none;">
                        <div>随机验证码</div>
                        <div><input id='randomCode' type="text" pattern="\w{4}" placeholder="输入随机验证码"
                                    oninput="matchRandomCaptcha(event);" title="4位随机验证码" name="randomCode"></div>

                        <div><a role="reGetRandomCaptcha" onclick="refreshRandomCaptcha();">
                            <img class='lazy' data-original="${createLink(controller: "captcha", action: "genRandomCode")}" ></a>
                        </div>
                    </div>
                    <div class="incorrect-code">验证码不正确</div>

                    <div role="userDetail" style="display: none;">
                        <div role="setPassword" class="input-row">
                            <div>设置密码</div>

                            <div><input id="password" type="password" required="required" pattern=".{6,}"
                                        oninvalid="invalidPassword(event);" placeholder="输入6位或以上登录密码"
                                        title="6位或以上登录密码" name="setPassword"></div>
                        </div>

                        <div class="incorrect-password">登录密码至少6位以上</div>

                        <div role="realName" class="input-row">
                            <div>姓名</div>

                            <div><input type="text" required="required" oninvalid="invalidName(event);"
                                        placeholder="输入用户姓名" name="name"></div>
                        </div>

                        <div class="incorrect-name">用户姓名不能为空</div>
                    </div>

                    <div role="loginPassword" class="input-row" style="display: none;">
                        <div>登录密码</div>

                        <div><input type="password" placeholder="输入寻真记登录密码" name="loginPassword"></div>
                    </div>
                </div>

                <div style="padding:30px 15px 30px 15px">
                    <div class="flex-item">
                        <a role="confirmMobile" class="btn btn-block btn-green btn-lg" onclick="validateMobile();">确认手机号码</a>
                    </div>

                    <div class="flex-item">
                        <a role="confirmInfo" class="btn btn-block btn-green btn-lg" onclick="userInfoSubmit();">确认信息</a>
                    </div>

                    <div class="flex-item">
                        <a role="login" class="btn btn-block btn-green btn-lg" onclick="userLogin();">登录</a>
                    </div>
                </div>

                <div role="registerTerm" class="register-term" style="display: none;">注册即表示同意我们的<a href=""
                        role="buyers_agreement" class="text-blue">服务条款使用守则</a>
                </div>
            </div>
        </form>
        </div>
    </div>
</div>