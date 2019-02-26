--
-- Created by IntelliJ IDEA.
-- User: kuangxiaopeng
-- Date: 2019/2/23
-- Time: 17:17
-- To change this template use File | Settings | File Templates.
--

local BasePlugin = require "kong.plugins.base_plugin"
local ngx_log = ngx.log
local INFO = ngx.INFO

local TdSsoHandler = BasePlugin:extend()

function TdSsoHandler:new()
    TdSsoHandler.super.new(self, "td-sso")
end

function TdSsoHandler:header_filter(conf)
    TdSsoHandler.super.access(self)

    local request_uri = ngx.var.request_uri or ""
    ngx_log(INFO, "================")
    ngx_log(INFO, "request_uri")
    ngx_log(INFO, request_uri)
    ngx_log(INFO, "================")
    -- 获取cookies
    local cookie = require "resty.cookie"
    local ck = cookie:new()
    local oauthToken, err = ck:get(conf.cookie_name)
    ngx_log(INFO, "================")
    ngx_log(INFO, "request_uri")
    ngx_log(INFO, request_uri)
    ngx_log(INFO, "================")
    --
    --    -- 如果cookie 不存在
    --    if not oauthToken then
    --        ngx.log("================")
    --        ngx.log("跳转")
    --        ngx.log(conf.oauth_url)
    --        ngx.log("================")
    --        ngx.log(ngx.ERR, err)
    --        ngx.redirect(conf.oauth_url, ngx.HTTP_MOVED_PERMANENTLY)
    --    else
    --        ngx.log("================")
    --        ngx.log("跳转")
    --        ngx.log(oauthToken)
    --        ngx.log("================")
    --        --TODO 校验cookie
    --        ngx.req.set_header("Authorization", "Bearer " .. oauthToken)
    --    end
end

return TdSsoHandler
