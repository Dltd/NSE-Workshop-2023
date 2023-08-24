-- The Head
-- Import necessary libraries
local stdnse = require "stdnse"

description = [[
Insert a description.
]]
---
-- @usage nmap -p <port> --script <name>.nse <target>
--
-- @args None
--
-- @output
-- PORT      STATE SERVICE VERSION
-- 80/tcp open  http    Apache
-- | <script-name>: 
-- |_  <Sampe script output>
--
-- @see <reference>.nse
---

categories = {"safe", "default"} -- Edit categories as approriate
author = "Your Name"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"

-- The Rule
portrule = function()
    -- Insert functionality to determine if the script should run.
    return true
end

-- The Action
action = function(host, port)
    -- Insert the functionality of your script.

    -- Return the results to the user
    return stdnse.format_output(true, "Hello from your NSE Script!")
end