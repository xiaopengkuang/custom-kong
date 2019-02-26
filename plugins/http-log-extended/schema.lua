--
-- Created by IntelliJ IDEA.
-- User: kuangxiaopeng
-- Date: 2019/2/20
-- Time: 00:32
-- To change this template use File | Settings | File Templates.
--

return {
  no_consumer = true,
  fields = {
    http_endpoint = { required = true, type = "url" },
    timeout = { default = 10000, type = "number" },
    keepalive = { default = 60000, type = "number" },
    log_request_body = { type = "boolean", default = false },
    log_response_body = { type = "boolean", default = false }
  }
}
