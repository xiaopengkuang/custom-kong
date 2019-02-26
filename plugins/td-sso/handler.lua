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
    ngx.log(ngx.ERR, "================")
    ngx.log(ngx.ERR, "request_uri:")
    ngx.log(ngx.ERR, request_uri)
    ngx.log(ngx.ERR, "================")
    -- 获取cookies
    local cookie = require "resty.cookie"
    local ck = cookie:new()
    local oauthToken, err = ck:get(conf.cookie_name)
    ngx.log(ngx.ERR, "================\n")
    ngx.log(ngx.ERR, "oauthToken:\n")
    ngx.log(ngx.ERR, oauthToken)
    ngx.log(ngx.ERR, "\n================\n")

    -- 如果cookie 不存在
    if not oauthToken then
        ngx.log(ngx.ERR, "================\n")
        ngx.log(ngx.ERR, "跳转URL:\n")
        ngx.log(ngx.ERR, conf.oauth_url)
        ngx.log(ngx.ERR, "\n================\n")
        ngx.redirect(conf.oauth_url, ngx.HTTP_MOVED_PERMANENTLY)
    else
        ngx.log(ngx.ERR, "================\n")
        ngx.log(ngx.ERR, "设置header\n")
        --TODO 校验cookie
        ngx.req.set_header("Authorization", "Bearer " .. oauthToken)
        ngx.log(ngx.ERR, "================\n")
    end
end

return TdSsoHandler
