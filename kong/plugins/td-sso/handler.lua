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

  if conf.oauth_url then
    ngx.redirect(conf.oauth_url, ngx.HTTP_MOVED_PERMANENTLY)
  end
end

return TdSsoHandler
