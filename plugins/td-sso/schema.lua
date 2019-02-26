--
-- Created by IntelliJ IDEA.
-- User: kuangxiaopeng
-- Date: 2019/2/23
-- Time: 17:17
-- To change this template use File | Settings | File Templates.
--

return {
    no_consumer = true,
    fields = {
        cookie_token_key = { type = "string", required = true },
        cookie_client_key = { type = "string", required = true },
        oauth_check_url = { required = true, type = "url" },
        oauth_login_url = { required = true, type = "url" },
        timeout = { default = 10000, type = "number" },
        keepalive = { default = 60000, type = "number" }
    }
}
