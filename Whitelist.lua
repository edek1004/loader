local HttpService = game:GetService("HttpService")

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
end
