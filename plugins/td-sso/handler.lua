--
-- Created by IntelliJ IDEA.
-- User: kuangxiaopeng
-- Date: 2019/2/23
-- Time: 17:17
-- To change this template use File | Settings | File Templates.
--

local BasePlugin = require "kong.plugins.base_plugin"
--local http = require "resty.http"
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

    ngx.log(ngx.ERR, "token cookie_token_key: \n")
    ngx.log(ngx.ERR, conf.cookie_token_key)

    ngx.log(ngx.ERR, "token cookie_client_key: \n")
    ngx.log(ngx.ERR, conf.cookie_client_key)

    if not accessTokenErr then
        ngx.log(ngx.ERR, "token error \n")
        ngx.log(ngx.ERR, accessTokenErr)
        ngx.log(ngx.ERR, accessToken)
        ngx.redirect(conf.oauth_login_url)
    end

    local clientId, ClientErr = ck:get(conf.cookie_client_key)
    if not ClientErr then
        ngx.log(ngx.ERR, "ClientErr error \n")
        ngx.log(ngx.ERR, ClientErr)
        ngx.log(ngx.ERR, clientId)
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
    end
    --TODO 校验cookie
    ngx.log(ngx.ERR, "================\n")
    ngx.log(ngx.ERR, "设置header\n")
    ngx.log(ngx.ERR, "access herer\n" .. clientId)
    --    local httpc = http:new()
    --    local res, err = httpc:request_uri(conf.oauth_check_url .. "?appVersion=1.0&requestClientId=" .. clientId .. "&access_token=" .. accessToken, {
    --        method = "GET",
    --        ssl_verify = false,
    --        headers = {
    --            ["Content-Type"] = "application/x-www-form-urlencoded",
    --        }
    --    })
    --
    --    if not err then
    --        ngx.log(ngx.ERR, "err =====\n")
    --        ngx.log(ngx.ERR, err)
    --        ngx.log(ngx.ERR, "res===\n")
    --        ngx.log(ngx.ERR, res)
    --        ngx.say(err)
    --        ngx.exit(ngx.HTTP_UNAUTHORIZED)
    --    end
    --
    --    ngx.log(ngx.ERR, "================\n")
    --    ngx.log(ngx.ERR, "认证结果\n")
    --    ngx.log(ngx.ERR, res)
    --    ngx.log(ngx.ERR, "\n================\n")
end

return TdSsoHandler
