local module = {}

function module:createGUI(plrid,amt)
local gui = Instance.new("ScreenGui",game.Players:GetPlayerByUserId(plrid).PlayerGui)
local frame = Instance.new("Frame",gui)
frame.Size = UDim2.new(0.5,0,0.5,0)
frame.Position = UDim2.new(0.25,0,0.25,0)
local question = Instance.new("TextLabel",frame)
question.BorderSizePixel = 0
question.Size = UDim2.new(0.8,0,0.4,0)
question.Position = UDim2.new(0.1,0,0.1,0)
question.TextScaled = true
question.TextXAlignment = "Center"
question.Text = "Are you sure you would like to complete this transaction? Your miles will be reduced by " .. amt .. "."
local nobtn = Instance.new("TextButton",frame)
nobtn.Size = UDim2.new(0.5,0,0.3,0)
nobtn.Position = UDim2.new(0.5,0,0.7,0)
nobtn.BackgroundColor3 = Color3.new(0, 0.430228, 0)
nobtn.BorderSizePixel = 0
nobtn.Text = "YES"
nobtn.TextColor3 = Color3.new(0.999893, 1, 0.999847)
local yesbtn = Instance.new("TextButton",frame)
yesbtn.Size = UDim2.new(0.5,0,0.3,0)
yesbtn.Position = UDim2.new(0,0,0.7,0)
yesbtn.BackgroundColor3 = Color3.new(0.547143, 0, 0)
yesbtn.BorderSizePixel = 0
yesbtn.Text = "NO"
yesbtn.TextColor3 = Color3.new(0.999893, 1, 0.999847)
yesbtn.MouseButton1Click:Connect(function()
	-- NO
	question.Text = "Transaction cancelled."
	nobtn.Visible = false
	yesbtn.Visible = false
	wait(2)
	gui:Destroy()
end)
nobtn.MouseButton1Click:Connect(function()
	-- YES
	local dataFields = {
		["api_key"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("API KEY").Value;   
		["api_pass"] = script.Parent:FindFirstChild("EDITME - DEV INFO"):FindFirstChild("PASSWORD").Value;
			["playerID"] = plrid;
			["amt"] = amt;
	}
		local HttpService = game:GetService("HttpService")
		local URL = "https://aeroxplorer.com/roblox/api/takemilerequest.php"
		print(URL,dataFields)
		local data = ""
		for k, v in pairs(dataFields) do
			data = data .. ("&%s=%s"):format(
				HttpService:UrlEncode(k),
				HttpService:UrlEncode(v)
			)
		end
		data = data:sub(2)
		local info = HttpService:PostAsync(URL, data, Enum.HttpContentType.ApplicationUrlEncoded, false)
		if info == "TRUE" then
			return true
		else
			return false
		end
	end)
end

return module
