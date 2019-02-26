--
-- Created by IntelliJ IDEA.
-- User: kuangxiaopeng
-- Date: 2019/2/23
-- Time: 17:17
-- To change this template use File | Settings | File Templates.
--

local BasePlugin = require "kong.plugins.base_plugin"

local TdSsoHandler = BasePlugin:extend()

function TdSsoHandler:new()
    TdSsoHandler.super.new(self, "td-sso")
end

function TdSsoHandler:access(conf)
    TdSsoHandler.super.access(self)

    local request_uri = ngx.var.request_uri or ""
    print("================")
    print("request_uri")
    print(request_uri)
    print("================")
    -- 获取cookies
    local cookie = require "resty.cookie"
    local ck = cookie:new()
    local oauthToken, err = ck:get(conf.cookie_name)

    -- 如果cookie 不存在
    if not oauthToken then
        print("================")
        print("跳转")
        print(conf.oauth_url)
        print("================")
        ngx.log(ngx.ERR, err)
        ngx.redirect(conf.oauth_url, ngx.HTTP_MOVED_PERMANENTLY)
    else
        print("================")
        print("跳转")
        print(oauthToken)
        print("================")
        --TODO 校验cookie
        ngx.req.set_header("Authorization", "Bearer " .. oauthToken)
    end
end

return TdSsoHandler
