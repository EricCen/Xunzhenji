%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<div data-title="建议" id="suggestion" class="panel">
   <div>有了您的建议，我们才能走得更远！</div>

    <textarea id="suggTxt" class="form-control" rows="3" placeholder="这里留下您的建议"></textarea>

    <div style="padding-left: 8px">
        <span><img id="captchaImg" src="/captcha/genRandomCode"></span>
        <span>请输入验证码：</span><input id="captchaTxt" maxlength="4" style="width:50px">
        <button id="suggBtn" class="btn">提交</button>
    </div>
    最新建议：
    <div id="suggList" total=""></div>
    <div id="showMore" align="center">显示更多...</div>
</div>


<!-- template -->
<div id="tpl-suggestion" style="display: none;">
    <ul class="list-group">
        {{#model}}
            <li class="list-group-item">
                {{#headImgUrl}}
                    <img class="img-circle small-circle lazy" data-original="{{headImgUrl}}">
                {{/headImgUrl}}
                {{^headImgUrl}}
                    <asset:image src="profile.png" class="img-circle small-circle lazy"/>
                {{/headImgUrl}}
                <b>  {{nickName}}：</b> {{time}}
                <br/>
                {{content}}
                <br/>
            {{#reply}}
                <hr/>
                客服回复：{{reply}}  {{replyDate}}
            {{/reply}}
        </li>
        {{/model}}
    </ul>
</div>