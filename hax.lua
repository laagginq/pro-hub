local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "Pro Hax Hub",
   LoadingTitle = "Pro Hax Hub",
   LoadingSubtitle = "by xz#1111",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "xzhub", -- Create a custom folder for your hub/game
      FileName = "config"
   },
   Discord = {
      Enabled = false,
      Invite = "asdasdff", -- The Discord invite code, do not include discord.gg/
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Pro Hax Hub",
      Subtitle = "Key System",
      Note = "Key: pro",
      FileName = "xzkey",
      SaveKey = false,
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = "pro"
   }
})

local function notify(title,text,duration) 
    Rayfield:Notify({
        Title = title,
        Content = text,
        Duration = duration,
        Image = 4483362458,
        Actions = { -- Notification Buttons
           Ignore = {
              Name = "Okay",
        },
     },
     })
end

local function FindPlrName(plr)
	for i,v in pairs(game.Players:GetChildren()) do
		if (string.sub(string.lower(v.Name),1,string.len(plr))) == string.lower(plr) then
			return v.Name
        else
            return nil
		end
	end
end

local function FindPlr(plr)
	for i,v in pairs(game.Players:GetChildren()) do
		if (string.sub(string.lower(v.Name),1,string.len(plr))) == string.lower(plr) then
			return v
        else
            return nil
		end
	end
end

local function IsPlr(plr) 
    if game.Players:FindFirstChild(plr) then 
        return true
    else
        return false
    end
end

local Aimlock = Window:CreateTab("Aimlock", 4483362458)

Aimlock:CreateButton({
   Name = "Execute",
   Callback = function()

    local Area = game:GetService("Workspace")
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local MyCharacter = LocalPlayer.Character
    local MyRoot = MyCharacter:FindFirstChild("HumanoidRootPart")
    local MyHumanoid = MyCharacter:FindFirstChild("Humanoid")
    local Mouse = LocalPlayer:GetMouse()
    local MyView = Area.CurrentCamera
    local MyTeamColor = LocalPlayer.TeamColor
    local HoldingM2 = false
    local Active = false
    local Lock = false
    local Epitaph = 0.0001 ---Note: The Bigger The Number, The More Prediction.
    local HeadOffset = Vector3.new(0, .1, 0)

    _G.TeamCheck = false
    _G.AimPart = "Head"
    _G.Sensitivity = 0
    _G.CircleSides = 64
    _G.CircleColor = Color3.fromRGB(255, 0, 130)
    _G.CircleTransparency = 0
    _G.CircleRadius = 200
    _G.CircleFilled = false
    _G.CircleVisible = true
    _G.CircleThickness = 1

    local FOVCircle = Drawing.new("Circle")
    FOVCircle.Position = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness

    local function UnLockCursor()
        HoldingM2 = false Active = false Lock = false 
    end
    function FindNearestPlayer()
        local dist = math.huge
        local Target = nil
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") and v then
                local TheirCharacter = v.Character
                local CharacterRoot, Visible = MyView:WorldToViewportPoint(TheirCharacter[_G.AimPart].Position)
                if Visible then
                    local RealMag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(CharacterRoot.X, CharacterRoot.Y)).Magnitude
                    if RealMag < dist and RealMag < FOVCircle.Radius then
                        dist = RealMag
                        Target = TheirCharacter
                    end
                end
            end
        end
        return Target
    end

    local enabled = false

    UIS.InputBegan:Connect(function(Input)
        if Input.KeyCode == Enum.KeyCode.Q then
            if enabled == false then 
                enabled = true
                HoldingM2 = true
                Active = true
                Lock = true
                if Active then
                    local The_Enemy = FindNearestPlayer()
                    while HoldingM2 do task.wait(.000001)
                        if Lock and The_Enemy ~= nil then
                            local Future = The_Enemy.HumanoidRootPart.CFrame + (The_Enemy.HumanoidRootPart.Velocity * Epitaph + HeadOffset)
                            MyView.CFrame = CFrame.lookAt(MyView.CFrame.Position, Future.Position)
                        end
                    end
                end
            else
                enabled = false
                UnLockCursor()
            end
        end
    end)

    game.StarterGui:SetCore("SendNotification", {Title = "Working.", Text = "Success, Script Loaded.", Duration = 4,})
   end,
})

Aimlock:CreateToggle({
   Name = "Teamcheck",
   CurrentValue = false,
   Flag = "Teamcheck", 
   Callback = function(v)
    _G.TeamCheck = v
   end,
})


notify("Notification","Loaded",5)
