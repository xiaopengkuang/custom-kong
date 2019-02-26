package = "kong-plugin-td-kong-plugin"
version = "1.1-1"
supported_platforms = {"linux", "macosx"}
source = {
  url = "git://github.com/xiaopengkuang/custom-kong",
  dir = "custom-kong"
}
description = {
  summary = "td-kong-plugin",
  license = "MIT",
  homepage = "https://github.com/xiaopengkuang/custom-kong"
}
dependencies = {
  "lua ~> 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.td-sso.handler"] = "custom-plugins/td-sso/handler.lua",
    ["kong.plugins.td-sso.schema"] = "custom-plugins/td-sso/schema.lua",
    ["kong.plugins.http-log-extended.handler"] = "custom-plugins/http-log-extended/handler.lua",
    ["kong.plugins.http-log-extended.schema"] = "custom-plugins/http-log-extended/schema.lua",
    ["kong.plugins.http-log-extended.serializer"] = "custom-plugins/http-log-extended/serializer.lua"
  }
}