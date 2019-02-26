package = "kong-plugin-td-kong-plugin"
version = "1.1-1"
supported_platforms = {"linux", "macosx"}
source = {
  url = "git://github.com/xiaopengkuang/custom-kong",
  tag = "1.1",
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
    ["kong.plugins.td-sso.handler"] = "kong/plugins/td-sso/handler.lua",
    ["kong.plugins.td-sso.schema"] = "kong/plugins/td-sso/schema.lua",
    ["kong.plugins.http-log-extended.handler"] = "kong/plugins/http-log-extended/handler.lua",
    ["kong.plugins.http-log-extended.schema"] = "kong/plugins/http-log-extended/schema.lua",
    ["kong.plugins.http-log-extended.serializer"] = "kong/plugins/http-log-extended/serializer.lua"
  }
}