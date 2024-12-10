local HttpService = game:GetService("HttpService")
local Start_runing = tick()

local request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local Hwid = request({Url = "https://httpbin.org/get", Method = "GET"}).Body
      Hwid = HttpService:JSONDecode(Hwid)

for i,v in next, Hwid.headers do
    if i:find("Fingerprint") then
        Hwid = v
        break
    end
end


local Userdata = HttpService:JSONEncode({["Key"] = getgenv().Key or "", ["Hwid"] = Hwid})


local Whitelist = request({
	Url = "https://pink-judith-43.tiiny.io/",
    Body = Userdata,
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Method = "POST"
}).Body

if Whitelist:lower():match("error", 1, true) then
    game:GetService("Players").LocalPlayer:Kick(Whitelist)
else
    local tim = tick() - Start_runing
    local str = Whitelist.." In: "..tostring(math.floor(tim) % (9e9 * 9e9))..string.format(".%09d", (tim % 1) * 1000)
    local spc = ""

    for i = 1, #str do
        spc = spc.."-"
    end
    warn(spc)
    warn(str)
    warn(spc)
end
