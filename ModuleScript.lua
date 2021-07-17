local module = {}

local requestQueue = {}

local flightid = script.Parent.flightID.Value



local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function module:SetPlayer(player)
	return setmetatable({
		Player = player
	},module)
end

function sendHttp(website,dataFields)
	if tick()-script.Parent.LastSend.Value < 1 then
		wait(0.5)
	end
	script.Parent.LastSend.Value = tick()
	local HttpService = game:GetService("HttpService")
	local URL = script.Parent.BaseURL.Value .. website
	print(URL,dataFields)
	local data = ""
	for k, v in pairs(dataFields) do
		data = data .. ("&%s=%s"):format(
			HttpService:UrlEncode(k),
			HttpService:UrlEncode(v)
		)
	end
	data = data:sub(2)
	return HttpService:PostAsync(URL, data, Enum.HttpContentType.ApplicationUrlEncoded, false)
end

function module.getSeatAssignment(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
		["flightid"] = flightid;
	}
	return sendHttp("getseat.php?field=0",dataFields)
end

function module.getCabin(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
		["flightid"] = flightid;
	}
	return sendHttp("getseat.php?field=1",dataFields)
end

function module.getCheckInTime(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
		["flightid"] = flightid;
	}
	return sendHttp("getseat.php?field=2",dataFields)
end

function module.getBoardedTime(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
		["flightid"] = flightid;
	}
	return sendHttp("getseat.php?field=3",dataFields)
end

function module.getBookingTime(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
		["flightid"] = flightid;
	}
	return sendHttp("getseat.php?field=4",dataFields)
end

function module.getConfirmationCode(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
		["flightid"] = flightid;
	}
	return sendHttp("getseat.php?field=5",dataFields)
end

function module.getPlatformID(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
		["flightid"] = flightid;
	}
	return sendHttp("getseat.php?field=6",dataFields)
end

function module.getUserStatus(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
	}
	return sendHttp("playerstatus.php?val=status",dataFields)
end

function module.getUserMiles(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
	}
	return sendHttp("playerstatus.php?val=miles",dataFields)
end

function module:setAsCheckedIn(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
		["flightid"] = flightid;
	}
	sendHttp("setas.php?action=checkin",dataFields)
end

function module:setAsBoarded(plrid)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
		["flightid"] = flightid;
	}
	sendHttp("setas.php?action=board",dataFields)
end

function dec(data)
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

function module:takeMiles(plrid,amt)
	local transaction = require(7107984991)
	return transaction:createGUI(plrid,amt)
end

function module:setAirlineStatus(plrid,status)
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
		["playerID"] = plrid;
		["status"] = status;
	}
	return sendHttp("setairlinestatus.php",dataFields)
end

return module
