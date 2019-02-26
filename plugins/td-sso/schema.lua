--
-- Created by IntelliJ IDEA.
-- User: kuangxiaopeng
-- Date: 2019/2/23
-- Time: 17:17
-- To change this template use File | Settings | File Templates.
--

return {
  fields = {
    http_endpoint = { required = true, type = "url" },
    cookie_name = { type = "string", required = true },
    oauth_url = { type = "string", required = true },
    timeout = { default = 10000, type = "number" },
    keepalive = { default = 60000, type = "number" }
  }
}
