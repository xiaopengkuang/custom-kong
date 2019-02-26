--
-- Created by IntelliJ IDEA.
-- User: kuangxiaopeng
-- Date: 2019/2/23
-- Time: 17:17
-- To change this template use File | Settings | File Templates.
--

local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.td-sso.access"
local TdSsoHandler = BasePlugin:extend()


function TdSsoHandler:new()
    TdSsoHandler.super.new(self, "td-sso")
end

function TdSsoHandler:access(conf)
    TdSsoHandler.super.access(self)
    -- 获取cookies
    local cookie = require "resty.cookie"
    local ck = cookie:new()
    local accessToken, accessTokenErr = ck:get(conf.cookie_token_key)

    if not accessTokenErr then
        ngx.redirect(conf.oauth_login_url)
    end

    local clientId, ClientErr = ck:get(conf.cookie_client_key)
    if not ClientErr then
        ngx.redirect(conf.oauth_login_url)
    end
    ngx.log(ngx.ERR, "================\n")
    ngx.log(ngx.ERR, "oauthToken:\n")
    ngx.log(ngx.ERR, accessToken)
    ngx.log(ngx.ERR, "\n================\n")

    -- 如果cookie 不存在
    if not accessToken then
        ngx.log(ngx.ERR, "================\n")
        ngx.log(ngx.ERR, "跳转URL:\n")
        ngx.log(ngx.ERR, conf.oauth_login_url)
        ngx.log(ngx.ERR, "\n================\n")
        ngx.redirect(conf.oauth_login_url)
    else
        --TODO 校验cookie
        ngx.log(ngx.ERR, "================\n")
        ngx.log(ngx.ERR, "设置header\n")
        ngx.req.set_header("Authorization", "Bearer " .. accessToken)
        access.checkToken(conf, accessToken, clientId)
    end
end

return TdSsoHandler
