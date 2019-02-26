--
-- Created by IntelliJ IDEA.
-- User: kuangxiaopeng
-- Date: 2019/2/26
-- Time: 19:09
-- To change this template use File | Settings | File Templates.
--

local _M = {}

function _M.checkToken(conf, accessToken, clientId)
    if accessToken and clientId then
        local httpc = http:new()
        local res, err = httpc:request_uri(conf.token_url, {
            method = "POST",
            ssl_verify = false,
            body = "appVersion=1.0&requestClientId=" .. clientId .. "&access_token=" .. accessToken,
            headers = {
                ["Content-Type"] = "application/x-www-form-urlencoded",
            }
        })

        if not err then
            ngx.say(err)
            ngx.exit(ngx.HTTP_UNAUTHORIZED)
        end

        ngx.log(ngx.ERR, "================\n")
        ngx.log(ngx.ERR, "认证结果\n")
        ngx.log(ngx.ERR, res)
        ngx.log(ngx.ERR, "\n================\n")
    else
        ngx.say("{\"code\":\"50000\",\"success\":\"false\",\"\": \"missing token or client info\"}")
        ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end
end

return _M

