-- The Head
-- Import necessary libraries
local stdnse = require "stdnse"

description = [[
This is a simple NSE Hello World scrtipt.  It simply runs the script for every open host.
]]
-- NSEDoc strings
---
-- @usage nmap --script hello-world.nse <target>
--
-- @args None
--
-- @output
-- PORT STATE SERVICE VERSION
-- 80/tcp open http
-- 
-- Host script results
-- | hello-world: 
-- |_ Hello from your NSE Script!
--
-- @see hello-world.nse
---

categories = {"safe", "default"}
author = "Jon Gorenflo, @flakpaket"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"


-- The Rules
-- Nmap will check every port that is open to see if it should run this script against it.
-- The function below will run the script against every open port.
hostrule = function()
    return true
end

-- The Action
action = function(host, port)
    return stdnse.format_output(true, "Hello from your NSE Script!")
end