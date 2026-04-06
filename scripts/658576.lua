print([[  
$$\    $$\                      $$\               
$$ |   $$ |                     $$ |              
$$ |   $$ | $$$$$$\  $$$$$$$\ $$$$$$\   $$\   $$\ 
\$$\  $$  |$$  __$$\ $$  __$$\\_$$  _|  $$ |  $$ |
 \$$\$$  / $$$$$$$$ |$$ |  $$ | $$ |    $$ |  $$ |
  \$$$  /  $$   ____|$$ |  $$ | $$ |$$\ $$ |  $$ |
   \$  /   \$$$$$$$\ $$ |  $$ | \$$$$  |\$$$$$$$ |
    \_/     \_______|\__|  \__|  \____/  \____$$ |
                                        $$\   $$ |
                                        \$$$$$$  |
                                         \______/ 
                Venty Menu
]])

local VIP = true

local http = game:HttpGet("https://ventydevs.pages.dev/premium-whitelist.json")
local hwidList = {}

for line in string.gmatch(http, "[^\r\n]+") do
    local hwid = line:match("^[^:]+:([^:]+)")
    if hwid then
        hwidList[hwid] = true
    end
end

local currentHWID = game:GetService("RbxAnalyticsService"):GetClientId()

if hwidList[currentHWID] and VIP then

local VentyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Venty5/VentyUi/refs/heads/main/.lua"))()

local MiscSettings = {
    bypassActive = false
}

local UserConfig = {
    Bypass = {
        AntiCheatActive = false
    }
}

local Window = VentyLib:MakeWindow({
    Name = "Venty Development - ER:LC",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "venty-erlc"
})

--Tabs

local BypassTab = Window:MakeTab({ 
    Name = "Bypass", 
    Icon = "rbxassetid://113978382940267", 
    PremiumOnly = false 
})

local SilentTab = Window:MakeTab({ 
    Name = "Silent Aim", 
    Icon = "rbxassetid://98232288704820", 
    PremiumOnly = false 
})

local AimbotTab = Window:MakeTab({ 
    Name = "Aimbot", 
    Icon = "rbxassetid://98232288704820", 
    PremiumOnly = false 
})

local VisualsTab = Window:MakeTab({ 
    Name = "Visuals", 
    Icon = "rbxassetid://132069634751309", 
    PremiumOnly = false 
})

local VehicleTab = Window:MakeTab({ 
    Name = "Vehicle Mods", 
    Icon = "rbxassetid://10709789810", 
    PremiumOnly = false 
})

local WeaponTab = Window:MakeTab({ 
    Name = "Weapon Mods", 
    Icon = "rbxassetid://6116845225", 
    PremiumOnly = false 
})

local PlayerTab = Window:MakeTab({ 
    Name = "Player", 
    Icon = "rbxassetid://107735713113844", 
    PremiumOnly = false 
})

local GraphicTab = Window:MakeTab({ 
    Name = "Graphics", 
    Icon = "rbxassetid://125373696632586", 
    PremiumOnly = false 
})

local TrollingTab = Window:MakeTab({ 
    Name = "Trolling", 
    Icon = "rbxassetid://140097947197695", 
    PremiumOnly = false 
})

local MiscTab = Window:MakeTab({ 
    Name = "Misc", 
    Icon = "rbxassetid://7743878358", 
    PremiumOnly = false 
})

local SocialTab = Window:MakeTab({ 
    Name = "Social", 
    Icon = "rbxassetid://117281710784951", 
    PremiumOnly = false 
})

local InfoTab = Window:MakeTab({ 
    Name = "Info", 
    Icon = "rbxassetid://7733956210", 
    PremiumOnly = false 
})

_G.ACBypass = {
    BLOCKED = {
        ["e29cfe0e-3520-40a1-8c0d-662158c150bb"] = true,
        ["e37fa0bd-4679-4293-a5e0-7a50f3b50d47"] = true,
        ["2328c9a3-b855-4e6b-abb5-14491dd3cd24"] = true
    },
    enabled = false,
    hook = nil,
    old = nil,
    mt = nil
}

do
    local s, f = pcall(function()
        return {getrawmetatable, setreadonly, newcclosure, getnamecallmethod}
    end)
    _G.ACBypass.supported = s and typeof(f[1]) == "function" and typeof(f[2]) == "function" and typeof(f[3]) == "function" and typeof(f[4]) == "function"

    function _G.ACBypass.enable()
        if _G.ACBypass.hook then return end
        pcall(function()
            _G.ACBypass.mt = _G.ACBypass.mt or f[1](game)
            _G.ACBypass.old = _G.ACBypass.old or _G.ACBypass.mt.__namecall
            f[2](_G.ACBypass.mt, false)
            _G.ACBypass.hook = f[3](function(self, ...)
                local m = f[4]()
                if (m == "FireServer" or m == "InvokeServer") and typeof(self) == "Instance" and (self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) and _G.ACBypass.BLOCKED[self.Name] then
                    return nil
                end
                return _G.ACBypass.old(self, ...)
            end)
            _G.ACBypass.mt.__namecall = _G.ACBypass.hook
            f[2](_G.ACBypass.mt, true)
        end)
    end

    function _G.ACBypass.disable()
        if not _G.ACBypass.hook then return end
        pcall(function()
            f[2](_G.ACBypass.mt, false)
            _G.ACBypass.mt.__namecall = _G.ACBypass.old
            f[2](_G.ACBypass.mt, true)
        end)
        _G.ACBypass.hook = nil
    end
end

BypassTab:AddSection({ 
    Name = "Anti Cheat" 
})

BypassTab:AddButton({
    Name = "Bypass Anti Cheat",
    Callback = function()
        if not _G.ACBypass.supported then 
            VentyLib:MakeNotification({
                Name = "Error",
                Content = "Your Executor is not Supported.",
                Time = 5
            })
            return 
        end
        
        MiscSettings.bypassActive = not MiscSettings.bypassActive
        _G.ACBypass.enabled = MiscSettings.bypassActive
        UserConfig.Bypass.AntiCheatActive = MiscSettings.bypassActive
        
        if not MiscSettings.bypassActive then
            _G.ACBypass.disable()
            VentyLib:MakeNotification({
                Name = "Anti Cheat Bypass",
                Content = "Anticheat is Working Again",
                Time = 3
            })
        else
            _G.ACBypass.enable()
            VentyLib:MakeNotification({
                Name = "Anti Cheat Bypass",
                Content = "Anticheat is bypassed",
                Time = 3
            })
        end
    end
})

BypassTab:AddButton({
    Name = "Check Anticheat",
    Callback = function()
        if _G.ACBypass.enabled then
            VentyLib:MakeNotification({
                Name = "Status",
                Content = "Anticheat is Disabled",
                Time = 5
            })
        else
            VentyLib:MakeNotification({
                Name = "Status",
                Content = "Anticheat is Enabled",
                Time = 5
            })
        end
    end
})

BypassTab:AddSection({ 
    Name = "Freecam" 
})

BypassTab:AddButton({
	Name = "Bypass Freecam",
	Callback = function()
		loadstring(game:HttpGet("https://pastebin.com/raw/4JrUuEqn"))()
		game.StarterGui:SetCore("SendNotification", {
			Title = "Freecam",
			Text = "Freecam is Bypassed Press Shift + P to Enable Freecam",
			Duration = 10
		})
	end    
})

BypassTab:AddSection({ 
    Name = "Scanner" 
})

BypassTab:AddButton({
	Name = "Scan Lobby for Venty Users",
	Callback = function()
        local Players = game:GetService("Players")
        local foundCount = 0

        for _, player in pairs(Players:GetPlayers()) do
            local hasVenty = false

            if player:FindFirstChild("Venty Menu") or player:FindFirstChild("VentyGui") then
                hasVenty = true
            end

            if player:GetAttribute("Venty") or player:GetAttribute("VentyMenu") then
                hasVenty = true
            end

            if hasVenty then
                foundCount = foundCount + 1
                VentyLib:MakeNotification({
                    Name = "User Found",
                    Content = player.Name .. " uses Venty Menu",
                    Time = 5
                })
            end
        end

        if foundCount == 0 then
            VentyLib:MakeNotification({
                Name = "Scanner",
                Content = "No Venty User Found in this Lobby",
                Time = 3
            })
        end
  	end    
})

SilentTab:AddSection({ 
    Name = "Hitbox Expander" 
})

local hitboxEnabled = false
local hitboxSize = 10

local function updateHitbox(player)
    local char = player.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    
    if hrp and hum then
        if hitboxEnabled and hum.Health > 1 and not hum.Sit then
            hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
            hrp.Transparency = 0.7
            hrp.BrickColor = BrickColor.new("Really blue")
            hrp.CanCollide = false
        else
            hrp.Size = Vector3.new(2, 2, 1)
            hrp.Transparency = 1
            hrp.CanCollide = false
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer then
            updateHitbox(player)
        end
    end
end)

SilentTab:AddToggle({
    Name = "Expand Hitbox",
    Default = false,
    Callback = function(v)
        hitboxEnabled = v
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game:GetService("Players").LocalPlayer then
                updateHitbox(player)
            end
        end
    end
})

SilentTab:AddSlider({
    Name = "Hitbox Size",
    Min = 2,
    Max = 100,
    Default = 10,
    Increment = 1,
    ValueName = "Size",
    Callback = function(v)
        hitboxSize = v
    end
})

SilentTab:AddParagraph("How does it Work",("if Player are sitting, or dead the hitbox will be not visible for every other player its working normally"))

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Settings = {
    Aimbot = {
        Enabled = false,
        Active = false,
        TeamCheck = false,
        KnockedCheck = false,
        PredictionEnabled = false,
        BasePrediction = 0.05,
        TargetPart = "Head",
        ShowFOV = false,
        Target = nil
    }
}

local AllSettings = {
    Aimbot = {
        FOV = 350,
        BasePrediction = 0.05,
        Mobile = false
    }
}

local function SaveAllSettings()
end

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.6
FOVCircle.NumSides = 100
FOVCircle.Filled = false
FOVCircle.Visible = false
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Radius = 350

function UpdateFOVPosition()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y * 0.5)
end

function GetNetworkPing()
    local stats = game:GetService("Stats")
    local network = stats:FindFirstChild("Network")
    if network then
        local ping = network:FindFirstChild("Ping") or network:FindFirstChild("Data Ping")
        if ping and ping:GetValue() > 0 then
            return ping:GetValue()
        end
    end
    return 50
end

function FindClosestTarget()
    local center = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y * 0.5)
    local closestDistance = math.huge
    local closestTarget = nil

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetPart = player.Character:FindFirstChild(Settings.Aimbot.TargetPart)
            if targetPart then
                if Settings.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                    continue
                end

                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if Settings.Aimbot.KnockedCheck and (not humanoid or humanoid.Health < 30) then
                    continue
                end

                local targetPos = targetPart.Position
                if Settings.Aimbot.PredictionEnabled then
                    local success, velocity = pcall(function()
                        return targetPart.AssemblyLinearVelocity
                    end)
                    if success and velocity then
                        targetPos = targetPos + velocity * Settings.Aimbot.BasePrediction
                    end
                end

                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if distance <= FOVCircle.Radius and distance < closestDistance then
                        closestDistance = distance
                        closestTarget = targetPart
                    end
                end
            end
        end
    end
    return closestTarget
end

RunService.RenderStepped:Connect(function()
    if Settings.Aimbot.ShowFOV then
        UpdateFOVPosition()
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end

    if Settings.Aimbot.Enabled and Settings.Aimbot.Active then
        if not Settings.Aimbot.Target or not Settings.Aimbot.Target.Parent then
            Settings.Aimbot.Target = FindClosestTarget()
        end

        if Settings.Aimbot.Target then
            local targetPos = Settings.Aimbot.Target.Position

            if Settings.Aimbot.PredictionEnabled then
                local success, velocity = pcall(function()
                    return Settings.Aimbot.Target.AssemblyLinearVelocity
                end)
                if success and velocity then
                    targetPos = targetPos + velocity * Settings.Aimbot.BasePrediction
                end
            end
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPos)
        end
    end
end)

AimbotTab:AddSection({ 
    Name = "Aimbot Settings" 
})

AimbotTab:AddToggle({
    Name = "Aimbot",
    Default = false,
    Callback = function(Value)
        Settings.Aimbot.Enabled = Value
        if not Value then
            Settings.Aimbot.Active = false
            Settings.Aimbot.Target = nil
        end
    end    
})

AimbotTab:AddToggle({
    Name = "Show Aimbot FOV",
    Default = false,
    Callback = function(Value)
        Settings.Aimbot.ShowFOV = Value
    end
})

AimbotTab:AddToggle({
    Name = "Team Check",
    Default = false,
    Callback = function(Value)
        Settings.Aimbot.TeamCheck = Value
    end
})

AimbotTab:AddToggle({
    Name = "Knocked Check",
    Default = false,
    Callback = function(Value)
        Settings.Aimbot.KnockedCheck = Value
    end
})

AimbotTab:AddToggle({
    Name = "Prediction",
    Default = false,
    Callback = function(Value)
        Settings.Aimbot.PredictionEnabled = Value
    end
})

AimbotTab:AddSlider({
    Name = "Aimbot FOV Size",
    Min = 50,
    Max = 1000,
    Default = 150,
    Increment = 10,
    ValueName = "px",
    Callback = function(Value)
        FOVCircle.Radius = Value
        AllSettings.Aimbot.FOV = Value
    end
})

AimbotTab:AddDropdown({
    Name = "Target Part",
    Default = "Head",
    Options = {"Head", "HumanoidRootPart"},
    Callback = function(Value)
        Settings.Aimbot.TargetPart = Value
    end
})

AimbotTab:AddBind({
    Name = "Aimbot Keybind",
    Default = Enum.KeyCode.Y,
    Hold = false,
    Callback = function()
        if not Settings.Aimbot.Enabled then return end
        Settings.Aimbot.Active = not Settings.Aimbot.Active
        if Settings.Aimbot.Active then
            Settings.Aimbot.Target = FindClosestTarget()
        else
            Settings.Aimbot.Target = nil
        end
    end
})

local usernameESP = false
local healthESP = false
local corneredESP = false
local skeletonESP = false
local teamColorESP = false
local showEquipped = false
local selfESP = false
local ShowAdminDetection = false
local ShowWanted = false
local renderRange = 1000

local AdminFlags = {}
local ESP_Data = {}
local CoreGui = game:GetService("CoreGui")

local function isWantedESP(player)
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart:GetAttribute("IsWanted") == true
end

local EspGui = Instance.new("ScreenGui")
EspGui.Name = "Ultra_ESP_Overlay"
EspGui.Parent = CoreGui
EspGui.IgnoreGuiInset = true

local function createLine()
    local line = Instance.new("Frame")
    line.BackgroundColor3 = Color3.new(1, 1, 1)
    line.BorderSizePixel = 0
    line.ZIndex = 4
    line.Visible = false
    line.Parent = EspGui
    return line
end

local function removeESP(player)
    local data = ESP_Data[player]
    if data then
        for _, v in pairs(data.Lines) do v:Destroy() end
        for _, v in pairs(data.Skeleton) do v:Destroy() end
        data.AdminTag:Destroy()
        data.WantedTag:Destroy()
        data.NameTag:Destroy()
        data.ItemTag:Destroy()
        data.TeamTag:Destroy()
        data.DistanceTag:Destroy()
        data.HealthBg:Destroy()
        ESP_Data[player] = nil
    end
    AdminFlags[player.UserId] = nil
end

local function setupPlayer(player)
    if ESP_Data[player] then return end
    local elements = {
        Lines = {
            TLH = createLine(), TLV = createLine(), TRH = createLine(), TRV = createLine(),
            BLH = createLine(), BLV = createLine(), BRH = createLine(), BRV = createLine()
        },
        Skeleton = {},
        AdminTag = Instance.new("TextLabel"),
        WantedTag = Instance.new("TextLabel"),
        NameTag = Instance.new("TextLabel"),
        ItemTag = Instance.new("TextLabel"),
        TeamTag = Instance.new("TextLabel"),
        DistanceTag = Instance.new("TextLabel"),
        HealthBg = Instance.new("Frame"),
        HealthBar = Instance.new("Frame")
    }
    for i = 1, 15 do table.insert(elements.Skeleton, createLine()) end
    
    local function styleLabel(label)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1, 1, 1)
        label.Font = Enum.Font.GothamBold
        label.TextStrokeTransparency = 0
        label.TextStrokeColor3 = Color3.new(0,0,0)
        label.Parent = EspGui
        label.Visible = false
    end
    
    styleLabel(elements.AdminTag)
    styleLabel(elements.WantedTag)
    styleLabel(elements.NameTag)
    styleLabel(elements.ItemTag)
    styleLabel(elements.TeamTag)
    styleLabel(elements.DistanceTag)
    
    elements.HealthBg.BackgroundColor3 = Color3.new(0, 0, 0)
    elements.HealthBg.BackgroundTransparency = 0.5
    elements.HealthBg.Parent = EspGui
    elements.HealthBar.Parent = elements.HealthBg
    ESP_Data[player] = elements
end

local function drawLine(line, p1, p2, thickness, color)
    local dist = (p1 - p2).Magnitude
    line.Size = UDim2.new(0, dist, 0, thickness)
    line.Position = UDim2.new(0, (p1.X + p2.X) / 2 - dist / 2, 0, (p1.Y + p2.Y) / 2 - thickness / 2)
    line.Rotation = math.atan2(p2.Y - p1.Y, p2.X - p1.X) * (180 / math.pi)
    line.BackgroundColor3 = color or Color3.new(1, 1, 1)
    line.Visible = true
end

local function updateESPVisuals()
    for player, e in pairs(ESP_Data) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")

        if (player == LocalPlayer and not selfESP) or not player.Parent then
            for _, l in pairs(e.Lines) do l.Visible = false end
            for _, l in pairs(e.Skeleton) do l.Visible = false end
            e.NameTag.Visible = false; e.DistanceTag.Visible = false; e.HealthBg.Visible = false; 
            e.ItemTag.Visible = false; e.TeamTag.Visible = false; e.AdminTag.Visible = false; e.WantedTag.Visible = false
            continue
        end

        if hrp and hum and hum.Health > 0 then
            local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
            local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            
            if onScreen and distance <= renderRange then
                local displayColor = (teamColorESP and player.TeamColor.Color) or Color3.new(1, 1, 1)
                local factor = 1 / (distance * (Camera.FieldOfView / 70)) * 1000
                local w, h = 4 * factor, 6 * factor
                local x, y = pos.X, pos.Y
                local nameSize = math.clamp(factor * 0.4, 9, 14)
                local thick = math.clamp(factor * 0.15, 1, 2)

                local currentTopOffset = h/2 + 2

                if teamColorESP then
                    e.TeamTag.Visible = true
                    e.TeamTag.Text = "[" .. (player.Team and player.Team.Name or "Neutral") .. "]"
                    e.TeamTag.TextColor3 = player.TeamColor.Color
                    e.TeamTag.TextSize = nameSize - 2
                    e.TeamTag.Position = UDim2.new(0, x - 50, 0, y - currentTopOffset - nameSize)
                    e.TeamTag.Size = UDim2.new(0, 100, 0, nameSize)
                    currentTopOffset = currentTopOffset + nameSize
                else e.TeamTag.Visible = false end

                if showEquipped then
                    local tool = char:FindFirstChildOfClass("Tool")
                    e.ItemTag.Visible = true
                    e.ItemTag.Text = tool and tool.Name or "Nothing"
                    e.ItemTag.TextColor3 = Color3.new(1, 1, 1)
                    e.ItemTag.TextSize = nameSize - 2
                    e.ItemTag.Position = UDim2.new(0, x - 50, 0, y - currentTopOffset - nameSize)
                    e.ItemTag.Size = UDim2.new(0, 100, 0, nameSize)
                    currentTopOffset = currentTopOffset + nameSize
                else e.ItemTag.Visible = false end

                if usernameESP then
                    e.NameTag.Visible = true
                    e.NameTag.Text = "@" .. player.Name
                    e.NameTag.TextColor3 = displayColor
                    e.NameTag.TextSize = nameSize
                    e.NameTag.Position = UDim2.new(0, x - 50, 0, y - currentTopOffset - nameSize)
                    e.NameTag.Size = UDim2.new(0, 100, 0, nameSize)
                    currentTopOffset = currentTopOffset + nameSize
                else e.NameTag.Visible = false end

                local currentBottomOffset = h/2 + 2

                e.DistanceTag.Visible = (usernameESP and player ~= LocalPlayer)
                if e.DistanceTag.Visible then
                    e.DistanceTag.Text = math.floor(distance) .. " studs"
                    e.DistanceTag.TextColor3 = Color3.new(0.7, 0.7, 0.7)
                    e.DistanceTag.TextSize = nameSize - 1
                    e.DistanceTag.Position = UDim2.new(0, x - 50, 0, y + currentBottomOffset)
                    e.DistanceTag.Size = UDim2.new(0, 100, 0, nameSize)
                    currentBottomOffset = currentBottomOffset + nameSize
                end

                if ShowWanted then
                    e.WantedTag.Visible = true
                    e.WantedTag.Text = isWantedESP(player) and "WANTED" or "Not Wanted"
                    e.WantedTag.TextColor3 = isWantedESP(player) and Color3.fromRGB(255, 208, 0) or Color3.fromRGB(128, 128, 128)
                    e.WantedTag.TextSize = nameSize - 2
                    e.WantedTag.Position = UDim2.new(0, x - 50, 0, y + currentBottomOffset)
                    e.WantedTag.Size = UDim2.new(0, 100, 0, nameSize)
                else e.WantedTag.Visible = false end

                if corneredESP then
                    local edge = w / 4
                    local function m(l, px, py, sx, sy)
                        l.Position = UDim2.new(0, px, 0, py); l.Size = UDim2.new(0, sx, 0, sy); 
                        l.BackgroundColor3 = displayColor; l.Visible = true
                    end
                    m(e.Lines.TLH, x-w/2, y-h/2, edge, thick) m(e.Lines.TLV, x-w/2, y-h/2, thick, edge)
                    m(e.Lines.TRH, x+w/2-edge, y-h/2, edge, thick) m(e.Lines.TRV, x+w/2, y-h/2, thick, edge)
                    m(e.Lines.BLH, x-w/2, y+h/2, edge, thick) m(e.Lines.BLV, x-w/2, y+h/2-edge, thick, edge)
                    m(e.Lines.BRH, x+w/2-edge, y+h/2, edge, thick) m(e.Lines.BRV, x+w/2, y+h/2-edge, thick, edge)
                else
                    for _, l in pairs(e.Lines) do l.Visible = false end
                end

                if skeletonESP then
                    local rig = (hum.RigType == Enum.HumanoidRigType.R15) and {{"UpperTorso", "Head"}, {"UpperTorso", "LowerTorso"}, {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"}, {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"}, {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"}, {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"}} or {{"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"}, {"Torso", "Left Leg"}, {"Torso", "Right Leg"}}
                    for i, joints in ipairs(rig) do
                        local p1, p2 = char:FindFirstChild(joints[1]), char:FindFirstChild(joints[2])
                        if p1 and p2 then
                            local vp1 = Camera:WorldToViewportPoint(p1.Position); local vp2 = Camera:WorldToViewportPoint(p2.Position)
                            drawLine(e.Skeleton[i], Vector2.new(vp1.X, vp1.Y), Vector2.new(vp2.X, vp2.Y), 1, Color3.new(1, 1, 1))
                        else e.Skeleton[i].Visible = false end
                    end
                else for _, l in pairs(e.Skeleton) do l.Visible = false end end

                if healthESP then
                    local barW = math.clamp(factor * 0.1, 2, 4)
                    e.HealthBg.Position = UDim2.new(0, x - w/2 - (barW + 4), 0, y - h/2)
                    e.HealthBg.Size = UDim2.new(0, barW, 0, h)
                    local hp = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                    e.HealthBar.Size = UDim2.new(1, 0, hp, 0)
                    e.HealthBar.Position = UDim2.new(0, 0, 1-hp, 0)
                    e.HealthBar.BackgroundColor3 = Color3.fromHSV(hp * 0.3, 1, 1)
                    e.HealthBg.Visible = true
                else e.HealthBg.Visible = false end
            else
                for _, l in pairs(e.Lines) do l.Visible = false end
                for _, l in pairs(e.Skeleton) do l.Visible = false end
                e.NameTag.Visible = false; e.DistanceTag.Visible = false; e.HealthBg.Visible = false; e.ItemTag.Visible = false; e.TeamTag.Visible = false; e.AdminTag.Visible = false; e.WantedTag.Visible = false
            end
        else
            for _, l in pairs(e.Lines) do l.Visible = false end
            for _, l in pairs(e.Skeleton) do l.Visible = false end
            e.NameTag.Visible = false; e.DistanceTag.Visible = false; e.HealthBg.Visible = false; e.ItemTag.Visible = false; e.TeamTag.Visible = false; e.AdminTag.Visible = false; e.WantedTag.Visible = false
        end
    end
end

VisualsTab:AddToggle({ 
    Name = "Show Player Name", 
    Default = false, 
    Callback = function(v) 
        usernameESP = v 
    end 
})

VisualsTab:AddToggle({ 
    Name = "Show Wanted Check", 
    Default = false, 
    Callback = function(v) 
        ShowWanted = v 
    end 
})

VisualsTab:AddToggle({ 
    Name = "Show Player Team", 
    Default = false, 
    Callback = function(v) 
        teamColorESP = v 
    end 
})

VisualsTab:AddToggle({ 
    Name = "Show Equipped Item", 
    Default = false, 
    Callback = function(v) 
        showEquipped = v 
    end 
})

VisualsTab:AddToggle({ 
    Name = "Show Player Health", 
    Default = false, 
    Callback = function(v) 
        healthESP = v 
    end 
})

VisualsTab:AddToggle({ 
    Name = "Show Skeleton", 
    Default = false, 
    Callback = function(v) 
        skeletonESP = v 
    end 
})

VisualsTab:AddToggle({ 
    Name = "Show Cornered Box", 
    Default = false, 
    Callback = function(v) 
        corneredESP = v 
    end 
})

VisualsTab:AddSection({
    Name = "Visuals Customization"
})

VisualsTab:AddToggle({ 
    Name = "Show Self ESP", 
    Default = false, 
    Callback = function(v) 
        selfESP = v 
    end 
})

VisualsTab:AddSlider({
    Name = "Render Range", 
    Min = 0, 
    Max = 5000, 
    Default = 1000, 
    Increment = 5, 
    ValueName = "Studs", 
    Callback = function(v) 
        renderRange = v 
    end
})

Players.PlayerRemoving:Connect(removeESP)
RunService.RenderStepped:Connect(updateESPVisuals)
Players.PlayerAdded:Connect(setupPlayer)
for _, p in ipairs(Players:GetPlayers()) do setupPlayer(p) end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local AccelerationRate = 0.01
local BrakeForce = 0.05
local SpeedLimit = 200
local FlightSpeed = 1
local FlightEnabled = false
local IsAccelerating = false
local IsBraking = false
local AccelerationKey = Enum.KeyCode.W
local BrakeKey = Enum.KeyCode.S
local StopKey = Enum.KeyCode.P
local FlipKey = Enum.KeyCode.F
local FlightConnection = nil
local HeartbeatConnection = nil
local OriginalCharacterParent = LocalPlayer.Character and LocalPlayer.Character.Parent
local DriftEnabled = false
local DriftStrength = 5
local DriftConnection = nil
local IsUnloaded = false
local SpeedLimiterConnection = nil

local function FindVehicleModel(part)
    if not part then return nil end
    return part:FindFirstAncestor(LocalPlayer.Name .. "'s Car")
        or (part:FindFirstAncestor("Body") and part:FindFirstAncestor("Body").Parent)
        or (part:FindFirstAncestor("Misc") and part:FindFirstAncestor("Misc").Parent)
        or part:FindFirstAncestorWhichIsA("Model")
end

local function GetCurrentVehicleSeat()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return nil end
    
    local seatPart = humanoid.SeatPart
    if seatPart and seatPart:IsA("VehicleSeat") then
        return seatPart
    end
    return nil
end

local function ApplySpeedLimiter(part)
    if not part then return end
    if SpeedLimit == math.huge then return end
    
    local velocity = part.AssemblyLinearVelocity
    local horizontalVelocity = Vector3.new(velocity.X, 0, velocity.Z)
    
    if horizontalVelocity.Magnitude > SpeedLimit then
        local limitedVelocity = horizontalVelocity.Unit * SpeedLimit
        part.AssemblyLinearVelocity = Vector3.new(limitedVelocity.X, velocity.Y, limitedVelocity.Z)
    end
end

local function FlipVehicle()
    local vehicleSeat = GetCurrentVehicleSeat()
    if not vehicleSeat then return end
    
    local vehicleModel = FindVehicleModel(vehicleSeat)
    if not vehicleModel or not vehicleModel:IsA("Model") then return end
    
    if not vehicleModel.PrimaryPart then
        vehicleModel.PrimaryPart = (vehicleSeat.Parent == vehicleModel and vehicleSeat) or vehicleModel:FindFirstChildWhichIsA("BasePart")
    end
    
    if not vehicleModel.PrimaryPart then return end
    
    local currentCFrame = vehicleModel:GetPrimaryPartCFrame()
    local position = currentCFrame.Position
    local forwardDirection = Vector3.new(currentCFrame.LookVector.X, 0, currentCFrame.LookVector.Z)
    
    if forwardDirection.Magnitude < 0.01 then
        forwardDirection = Vector3.new(1, 0, 0)
    else
        forwardDirection = forwardDirection.Unit
    end
    
    vehicleModel:SetPrimaryPartCFrame(CFrame.new(position + Vector3.new(0, 0.5, 0), position + Vector3.new(0, 0.5, 0) + forwardDirection))
    vehicleSeat.AssemblyLinearVelocity = Vector3.new()
    vehicleSeat.AssemblyAngularVelocity = Vector3.new()
end

local function ApplyMovementPhysics()
    if IsUnloaded then return end
    
    local vehicleSeat = GetCurrentVehicleSeat()
    if not vehicleSeat then
        if HeartbeatConnection then 
            HeartbeatConnection:Disconnect() 
            HeartbeatConnection = nil 
        end
        return
    end
    
    if FlightEnabled then return end
    if vehicleSeat.Anchored then return end
    
    local velocity = vehicleSeat.AssemblyLinearVelocity
    local cframe = vehicleSeat.CFrame
    local forward = cframe.LookVector
    local horizontalVelocity = Vector3.new(velocity.X, 0, velocity.Z)
    local dotProduct = horizontalVelocity:Dot(forward)
    
    if IsBraking then
        if dotProduct > 1 then
            vehicleSeat.AssemblyLinearVelocity = velocity * Vector3.new(1 - BrakeForce * 2, 1, 1 - BrakeForce * 2)
        elseif dotProduct < -0.5 then
            local brakeMultiplier = AccelerationRate * 0.5
            vehicleSeat.AssemblyLinearVelocity = velocity - forward * brakeMultiplier
        else
            vehicleSeat.AssemblyLinearVelocity = velocity * Vector3.new(1 - BrakeForce, 1, 1 - BrakeForce)
        end
    elseif IsAccelerating then
        if dotProduct < -1 then
            vehicleSeat.AssemblyLinearVelocity = velocity * (1 - BrakeForce * 3)
        else
            vehicleSeat.AssemblyLinearVelocity = velocity * Vector3.new(1 + AccelerationRate, 1, 1 + AccelerationRate)
        end
    else
        vehicleSeat.AssemblyLinearVelocity = velocity * Vector3.new(1 - BrakeForce * 0.1, 1, 1 - BrakeForce * 0.1)
    end
    
    ApplySpeedLimiter(vehicleSeat)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == AccelerationKey then
        IsAccelerating = true
        if not HeartbeatConnection then
            HeartbeatConnection = RunService.Heartbeat:Connect(ApplyMovementPhysics)
        end
    elseif input.KeyCode == BrakeKey then
        IsBraking = true
        if not HeartbeatConnection then
            HeartbeatConnection = RunService.Heartbeat:Connect(ApplyMovementPhysics)
        end
    elseif input.KeyCode == FlipKey then
        FlipVehicle()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == AccelerationKey then
        IsAccelerating = false
    elseif input.KeyCode == BrakeKey then
        IsBraking = false
    end
    
    if not IsAccelerating and not IsBraking and HeartbeatConnection then
        HeartbeatConnection:Disconnect()
        HeartbeatConnection = nil
    end
end)

SpeedLimiterConnection = RunService.Heartbeat:Connect(function()
    if IsUnloaded then return end
    local vehicleSeat = GetCurrentVehicleSeat()
    if vehicleSeat then 
        ApplySpeedLimiter(vehicleSeat) 
    end
end)


VehicleTab:AddSection({
    Name = "Performance"
})

VehicleTab:AddSlider({
    Name = "Acceleration",
    Min = 0,
    Max = 50,
    Default = 10,
    Increment = 1,
    ValueName = "x",
    Callback = function(Value)
        AccelerationRate = Value / 1000
    end
})

VehicleTab:AddSlider({
    Name = "Brake Force",
    Min = 0,
    Max = 300,
    Default = 50,
    Increment = 1,
    ValueName = "Force",
    Callback = function(Value)
        BrakeForce = Value / 1000
    end
})

VehicleTab:AddSlider({
    Name = "Speed Limit (0 = unlimited)",
    Min = 0,
    Max = 1000,
    Default = 200,
    Increment = 1,
    ValueName = "KmH",
    Callback = function(Value)
        SpeedLimit = (Value == 0) and math.huge or Value
    end
})

VehicleTab:AddSection({
    Name = "Vehicle Customization"
})

VehicleTab:AddTextbox({
    Name = "Numberplate Text",
    Default = "Venty",
    TextDisappear = false,
    Callback = function(txt)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then return end
        
        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("SurfaceGui") then
                local parentPart = part.Parent
                if parentPart and parentPart:IsA("BasePart") then
                    local dist = (parentPart.Position - root.Position).Magnitude
                    
                    if dist < 15 then
                        local label = part:FindFirstChildOfClass("TextLabel")
                        if label then 
                            label.Text = txt 
                        end
                    end
                end
            end
        end
    end
})

local rainbowLoop = nil
local rainbowEnabled = false

local function setCarColor(selectedColor)
    local player = game.Players.LocalPlayer
    local char = player.Character
    local seat = char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart
    
    if seat then
        local vehicle = seat:FindFirstAncestorOfClass("Model")
        if vehicle then
            for _, part in ipairs(vehicle:GetDescendants()) do
                if part:IsA("BasePart") then
                    local name = part.Name:lower()
                    if name:find("body") or name:find("paint") or name:find("color") then
                        part.Color = selectedColor
                    end
                end
            end
        end
    end
end

local function toggleRainbow(state)
    rainbowEnabled = state
    
    if rainbowEnabled then
        if rainbowLoop then task.cancel(rainbowLoop) end

        rainbowLoop = task.spawn(function()
            local hue = 0
            while rainbowEnabled do
                hue = tick() % 5 / 5
                local color = Color3.fromHSV(hue, 1, 1)
                
                setCarColor(color)
                task.wait(0.05)
            end
        end)
    else
        if rainbowLoop then
            task.cancel(rainbowLoop)
            rainbowLoop = nil
        end
    end
end

VehicleTab:AddColorpicker({
    Name = "Vehicle Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Value)
        if not rainbowEnabled then
            setCarColor(Value)
        end
    end   
})

VehicleTab:AddToggle({
    Name = "Rainbow Mode",
    Default = false,
    Callback = function(Value)
        toggleRainbow(Value)
    end
})

VehicleTab:AddSection({
    Name = "Vehicle Hack"
})

local player = game.Players.LocalPlayer

local function getMyVehicle()
    local vehiclesFolder = workspace:FindFirstChild("Vehicles")
    if not vehiclesFolder then return nil end

    for _, v in ipairs(vehiclesFolder:GetChildren()) do
        if v.Name == tostring(player.UserId) or v:FindFirstChild("Owner") and v.Owner.Value == player.Name or v.Name:find(player.Name) then
            return v
        end
        if v:GetAttribute("OwnerId") == player.UserId or v:GetAttribute("Owner") == player.Name then
            return v
        end
    end
    return nil
end

VehicleTab:AddButton({
    Name = "Enter in own Car",
    Callback = function()
        local vehicle = getMyVehicle()
        local char = player.Character
        if vehicle and char then
            local seat = vehicle:FindFirstChild("DriveSeat") or vehicle:FindFirstChildWhichIsA("VehicleSeat")
            local hum = char:FindFirstChild("Humanoid")
            if seat and hum then
                seat:Sit(hum)
                if not hum.SeatPart then
                    char:MoveTo(seat.Position)
                end
            end
        end
    end
})

VehicleTab:AddButton({
    Name = "Bring own Car",
    Callback = function()
        local vehicle = getMyVehicle()
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if vehicle and root then
            vehicle:PivotTo(root.CFrame * CFrame.new(0, 2, -10))
            task.wait(0.2)

            local seat = vehicle:FindFirstChild("DriveSeat") or vehicle:FindFirstChildWhichIsA("VehicleSeat")
            local hum = char:FindFirstChild("Humanoid")
            if seat and hum then
                seat:Sit(hum)
            end
        end
    end
})

VehicleTab:AddSection({
    Name = "Duplicate"
})

VehicleTab:AddButton({
    Name = "Duplicate Current Car",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local targetVehicle = nil

        if character and character:FindFirstChild("Humanoid") then
            local seat = character.Humanoid.SeatPart
            if seat and seat:IsA("VehicleSeat") then
                targetVehicle = seat:FindFirstAncestorOfClass("Model")
            end
        end

        if not targetVehicle then
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Model") and obj.Name == player.Name and obj ~= character then
                    if obj:FindFirstChildWhichIsA("VehicleSeat", true) then
                        targetVehicle = obj
                        break
                    end
                end
            end
        end

        if not targetVehicle then
            VentyLib:MakeNotification({
                Name = "Error",
                Content = "No Vehicle Found",
                Time = 3
            })
            return
        end

        targetVehicle.Archivable = true
        local clone = targetVehicle:Clone()
        targetVehicle.Archivable = false

        if clone then
            clone.Name = "Silent_Duplicate_" .. player.Name

            local currentPivot = targetVehicle:GetPivot()
            clone:PivotTo(currentPivot * CFrame.new(15, 0, 0))

            for _, item in pairs(clone:GetDescendants()) do
                if item:IsA("Sound") then
                    item:Stop()
                    item:Destroy()

                elseif item:IsA("LuaSourceContainer") or item:IsA("Script") or item:IsA("LocalScript") then
                    item:Destroy()

                elseif item:IsA("Seat") or item:IsA("VehicleSeat") then
                    item.Disabled = true
                
                elseif item:IsA("BasePart") then
                    item.Anchored = true
                    item.CanCollide = true
                end
            end

            clone.Parent = workspace
            
            VentyLib:MakeNotification({
                Name = "Success",
                Content = "Car duplicated",
                Time = 3
            })
        end
    end
})

WeaponTab:AddSection({
    Name = "Weapon Modifications"
})

local Players = game:GetService("Players")
local plr = Players.LocalPlayer

WeaponTab:AddToggle({
    Name = "Rapid Fire",
    Default = false,
    Callback = function(Value)
        _G.VisualFastFire = Value 

        if Value then
            task.spawn(function()
                while _G.VisualFastFire do
                    local char = plr.Character
                    local tool = char and char:FindFirstChildOfClass("Tool")
                    
                    if tool then
                        for _, obj in ipairs(tool:GetDescendants()) do
                            if obj:IsA("ParticleEmitter") then
                                obj:Emit(1)
                            end
                        end
                    end
                    task.wait(0.07) 
                end
            end)
        end
    end
})

WeaponTab:AddToggle({
    Name = "No Recoil",
    Default = false,
    Callback = function(enabled)
        if recoilConnection then
            recoilConnection:Disconnect()
            recoilConnection = nil
        end

        if enabled then
            recoilConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local character = game.Players.LocalPlayer.Character
                local tool = character and character:FindFirstChildOfClass("Tool")
                
                if tool then
                    tool:SetAttribute("Recoil", 0)
                    tool:SetAttribute("RecoilControl", 0)
                    tool:SetAttribute("Shake", 0)

                    local config = tool:FindFirstChild("Configuration") or tool:FindFirstChild("Settings")
                    if config then
                        local recoilVal = config:FindFirstChild("Recoil")
                        if recoilVal then recoilVal.Value = 0 end
                    end
                end
            end)
        end
    end
})

PlayerTab:AddSection({
    Name = "Special"
})

EMOTE_ID        = "94292601332790"
STOP_ON_MOVE    = false
ALLOW_INVISIBLE = true
FADE_IN         = 0.1
FADE_OUT        = 0.1
WEIGHT          = 1
SPEED           = 1
TIME_POSITION   = 0

cloneref = (type(cloneref) == "function") and cloneref or function(...) return ... end
InvServices = setmetatable({}, { __index = function(_, n) return cloneref(game:GetService(n)) end })

RunService = InvServices.RunService
player     = game:GetService("Players").LocalPlayer

invCharacter = player.Character or player.CharacterAdded:Wait()
invHumanoid  = invCharacter:WaitForChild("Humanoid")

local CurrentTrack
lastPosition      = invCharacter.PrimaryPart and invCharacter.PrimaryPart.Position or Vector3.new()
originalCollisions = {}
invisibleEnabled  = false

local function saveCollisions()
    originalCollisions = {}
    for _, p in ipairs(invCharacter:GetDescendants()) do
        if p:IsA("BasePart") then 
            originalCollisions[p] = p.CanCollide 
        end
    end
end

local function disableCollisions()
    for _, p in ipairs(invCharacter:GetDescendants()) do
        if p:IsA("BasePart") then 
            p.CanCollide = false 
        end
    end
end

local function restoreCollisions()
    for p, state in pairs(originalCollisions) do
        if p and p.Parent then 
            p.CanCollide = state 
        end
    end
    originalCollisions = {}
end

local function startEmote()
    if CurrentTrack then CurrentTrack:Stop(0) end
    
    local id = tonumber(EMOTE_ID) or tonumber(string.match(EMOTE_ID, "%d+"))
    if not id then return end
    
    local animId = "rbxassetid://" .. id

    pcall(function()
        local objs = game:GetObjects(animId)
        if objs and #objs > 0 and objs[1]:IsA("Animation") then
            animId = objs[1].AnimationId
        end
    end)
    
    local anim = Instance.new("Animation")
    anim.AnimationId = animId
    
    local track = invHumanoid:LoadAnimation(anim)
    track.Priority = Enum.AnimationPriority.Action4
    track:Play(FADE_IN, WEIGHT == 0 and 0.001 or WEIGHT, SPEED)
    
    CurrentTrack = track
    CurrentTrack.TimePosition = math.clamp(TIME_POSITION, 0, 1) * CurrentTrack.Length
    
    if ALLOW_INVISIBLE then 
        saveCollisions() 
        disableCollisions() 
    end
end

local function stopEmote()
    if CurrentTrack then 
        CurrentTrack:Stop(FADE_OUT) 
        CurrentTrack = nil 
    end
    restoreCollisions()
end

player.CharacterAdded:Connect(function(c)
    invCharacter = c
    invHumanoid  = c:WaitForChild("Humanoid")
end)

RunService.RenderStepped:Connect(function()
    if not invisibleEnabled then return end
    
    if STOP_ON_MOVE and CurrentTrack and CurrentTrack.IsPlaying and invCharacter.PrimaryPart then
        local currentPos = invCharacter.PrimaryPart.Position
        if (currentPos - lastPosition).Magnitude > 0.1 then
            stopEmote()
            invisibleEnabled = false
        end
        lastPosition = currentPos
    end
end)

RunService.Stepped:Connect(function()
    if invisibleEnabled and ALLOW_INVISIBLE and invCharacter and invCharacter.Parent then
        disableCollisions()
    end
end)

PlayerTab:AddToggle({
    Name = "Invisible",
    Default = false,
    Callback = function(value)
        invisibleEnabled = value
        if value then 
            startEmote() 
        else 
            stopEmote() 
        end
    end,
})

local JesusMode = false
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

local WaterFloor = Instance.new("Part")
WaterFloor.Name = "JesusPlatform"
WaterFloor.Size = Vector3.new(10, 1, 10)
WaterFloor.Transparency = 1
WaterFloor.Anchored = true
WaterFloor.CanCollide = false
WaterFloor.Parent = workspace

RunService.Heartbeat:Connect(function()
    if JesusMode and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local RootPart = Player.Character.HumanoidRootPart
        local CharacterPos = RootPart.Position
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = {Player.Character, WaterFloor}
        
        local ray = workspace:Raycast(CharacterPos, Vector3.new(0, -10, 0), raycastParams)
        
        if ray and ray.Material == Enum.Material.Water then
            WaterFloor.CanCollide = true
            WaterFloor.CFrame = CFrame.new(CharacterPos.X, ray.Position.Y, CharacterPos.Z)
        else
            WaterFloor.CanCollide = false
        end
    else
        WaterFloor.CanCollide = false
    end
end)

PlayerTab:AddToggle({
    Name = "Jesus Mode",
    Default = false,
    Callback = function(Value)
        JesusMode = Value
        if not Value then
            WaterFloor.CanCollide = false
        end
    end    
})

PlayerTab:AddSection({
    Name = "Noclip V2"
})

local EMOTE_ID        = "94292601332790"
local STOP_ON_MOVE    = false
local ALLOW_INVISIBLE = true
local FADE_IN         = 0.1
local FADE_OUT        = 0.1
local WEIGHT          = 1
local SPEED_ANIM      = 1
local TIME_POSITION   = 0

local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local CurrentTrack = nil
local originalCollisions = {}
local noclipEnabled = false
local noclipConnection = nil
local noclipSpeed = 30

local function saveCollisions(char)
    originalCollisions = {}
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then 
            originalCollisions[p] = p.CanCollide 
        end
    end
end

local function restoreCollisions()
    for p, state in pairs(originalCollisions) do
        if p and p.Parent then 
            p.CanCollide = state 
        end
    end
    originalCollisions = {}
end

local function startEmote(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if CurrentTrack then CurrentTrack:Stop(0) end
    
    local id = tonumber(EMOTE_ID) or tonumber(string.match(EMOTE_ID, "%d+"))
    if not id then return end
    
    local animId = "rbxassetid://" .. id
    pcall(function()
        local objs = game:GetObjects(animId)
        if objs and #objs > 0 and objs[1]:IsA("Animation") then
            animId = objs[1].AnimationId
        end
    end)
    
    local anim = Instance.new("Animation")
    anim.AnimationId = animId
    
    CurrentTrack = hum:LoadAnimation(anim)
    CurrentTrack.Priority = Enum.AnimationPriority.Action4
    CurrentTrack:Play(FADE_IN, WEIGHT == 0 and 0.001 or WEIGHT, SPEED_ANIM)
    CurrentTrack.TimePosition = math.clamp(TIME_POSITION, 0, 1) * CurrentTrack.Length
    
    if ALLOW_INVISIBLE then 
        saveCollisions(char) 
    end
end

local function stopEmote()
    if CurrentTrack then 
        CurrentTrack:Stop(FADE_OUT) 
        CurrentTrack = nil 
    end
    restoreCollisions()
end

local function setCharTransparency(char, transparency)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            if v.Name ~= "HumanoidRootPart" then
                v.Transparency = transparency
            end
        end
    end
end

local function getCharacter()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
        return player.Character
    end
    return nil
end

local function toggleNoclip(state)
    noclipEnabled = state
    local char = getCharacter()
    
    if noclipConnection then 
        noclipConnection:Disconnect() 
        noclipConnection = nil
    end
    
    if noclipEnabled and char then
        startEmote(char)
        setCharTransparency(char, 0)

        noclipConnection = RunService.Stepped:Connect(function()
            if not noclipEnabled then return end
            local character = getCharacter()
            if not character then return end
            
            local hum = character.Humanoid
            local root = character.HumanoidRootPart
            local camera = workspace.CurrentCamera

            for _, v in pairs(character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end

            hum:ChangeState(Enum.HumanoidStateType.FallingDown)

            local moveDir = Vector3.new(0, 0, 0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
            
            if moveDir.Magnitude > 0 then
                root.CFrame = CFrame.new(root.Position, root.Position + moveDir)
                root.CFrame = root.CFrame + (moveDir.Unit * (noclipSpeed / 60))
            end

            if UIS:IsKeyDown(Enum.KeyCode.Space) then root.CFrame = root.CFrame * CFrame.new(0, 0.6, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then root.CFrame = root.CFrame * CFrame.new(0, -0.6, 0) end

            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end)
    else
        stopEmote()
        if char then
            setCharTransparency(char, 0)
            char.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end

local NoclipToggle = PlayerTab:AddToggle({
    Name = "Noclip V2",
    Default = false,
    Callback = function(Value)
        toggleNoclip(Value)
    end
})

PlayerTab:AddBind({
    Name = "Noclip Keybind",
    Default = Enum.KeyCode.H,
    Callback = function()
        NoclipToggle:Set(not noclipEnabled)
    end    
})

PlayerTab:AddSlider({
    Name = "Noclip Speed",
    Min = 5, 
    Max = 115, 
    Default = 30, 
    Increment = 1,
    Callback = function(v) 
        noclipSpeed = v 
    end
})

PlayerTab:AddSection({
    Name = "Player Speed Hack"
})

speedHackEnabled = false
speedHackStepSize = 0.1
local speedHackConnection

PlayerTab:AddToggle({
    Name = "Speed Hack",
    Default = false,
    Callback = function(Value)
        speedHackEnabled = Value
        if Value then
            speedHackConnection = RunService.Heartbeat:Connect(function()
                if speedHackEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    local character = LocalPlayer.Character
                    local humanoid = character:FindFirstChild("Humanoid")
                    local direction = humanoid.MoveDirection
                    if direction.Magnitude > 0 then
                        character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame + direction.Unit * speedHackStepSize)
                    end
                end
            end)
        else
            if speedHackConnection then
                speedHackConnection:Disconnect()
                speedHackConnection = nil
            end
        end
    end
})

PlayerTab:AddBind({
    Name = "Speed Hack Keybind",
    Default = Enum.KeyCode.U,
    Hold = false,
    Callback = function()
        speedHackEnabled = not speedHackEnabled
        if speedHackEnabled then
            speedHackConnection = RunService.Heartbeat:Connect(function()
                if speedHackEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    local character = LocalPlayer.Character
                    local humanoid = character:FindFirstChild("Humanoid")
                    local direction = humanoid.MoveDirection
                    if direction.Magnitude > 0 then
                        character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame + direction.Unit * speedHackStepSize)
                    end
                end
            end)
        else
            if speedHackConnection then
                speedHackConnection:Disconnect()
                speedHackConnection = nil
            end
        end
    end    
})

PlayerTab:AddSlider({
    Name = "Speed Hack Speed",
    Min = 0.1,
    Max = 0.5,
    Default = 0.1,
    Increment = 0.05,
    ValueName = "Speed",
    Callback = function(Value)
        speedHackStepSize = Value
    end    
})

PlayerTab:AddSection({
    Name = "Player Fly"
})

flyingSpeed = 20
isFlying = false
local attachment, alignPosition, alignOrientation
player = game:GetService("Players").LocalPlayer

function canFly()
	return player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").SeatPart == nil
end

function enableFly()
	if not canFly() then return false end

	local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
	local humanoid = player.Character:FindFirstChild("Humanoid")

	if attachment then attachment:Destroy() end
	if alignPosition then alignPosition:Destroy() end
	if alignOrientation then alignOrientation:Destroy() end

	attachment = Instance.new("Attachment")
	attachment.Parent = humanoidRootPart

	alignPosition = Instance.new("AlignPosition")
	alignPosition.Attachment0 = attachment
	alignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
	alignPosition.MaxForce = 5000
	alignPosition.Responsiveness = 45
	alignPosition.Parent = humanoidRootPart

	alignOrientation = Instance.new("AlignOrientation")
	alignOrientation.Attachment0 = attachment
	alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	alignOrientation.MaxTorque = 5000
	alignOrientation.Responsiveness = 45
	alignOrientation.Parent = humanoidRootPart

	humanoid.PlatformStand = true
	isFlying = true

	local lastPosition = humanoidRootPart.Position
	alignPosition.Position = lastPosition

	local function flyLoop()
		while isFlying and player.Character and humanoidRootPart and humanoid do
			local moveDirection = Vector3.new()
			local camCFrame = workspace.CurrentCamera.CFrame

			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
				moveDirection += camCFrame.LookVector
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
				moveDirection -= camCFrame.LookVector
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
				moveDirection -= camCFrame.RightVector
			end
			if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
				moveDirection += camCFrame.RightVector
			end

			if moveDirection.Magnitude > 0 then
				moveDirection = moveDirection.Unit
				local newPosition = lastPosition + (moveDirection * flyingSpeed * game:GetService("RunService").Heartbeat:Wait())
				alignPosition.Position = newPosition
				lastPosition = newPosition
			end

			alignOrientation.CFrame = CFrame.new(Vector3.new(), camCFrame.LookVector)
			game:GetService("RunService").Heartbeat:Wait()
		end
	end

	spawn(flyLoop)
	return true
end

function disableFly()
	isFlying = false
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character:FindFirstChild("Humanoid").PlatformStand = false
	end
	if attachment then attachment:Destroy() end
	if alignPosition then alignPosition:Destroy() end
	if alignOrientation then alignOrientation:Destroy() end
end

local FlyToggle = PlayerTab:AddToggle({
    Name = "Player Fly",
    Default = false,
    Callback = function(Value)
        if Value then
            if not enableFly() then
                FlyToggle:Set(false)
            end
        else
            disableFly()
        end
    end    
})

PlayerTab:AddBind({
    Name = "Fly Keybind",
    Default = Enum.KeyCode.U,
    Hold = false,
    Callback = function()
        if isFlying then
            disableFly()
            FlyToggle:Set(false)
        else
            if enableFly() then
                FlyToggle:Set(true)
            else
                FlyToggle:Set(false)
            end
        end
    end    
})

PlayerTab:AddSlider({
    Name = "Fly Speed",
    Min = 5,
    Max = 100,
    Default = 20,
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        flyingSpeed = Value
    end    
})

player.CharacterAdded:Connect(function()
	if isFlying then
		task.wait(1)
		if FlyToggle.Value then
			enableFly()
		end
	end
end)

PlayerTab:AddSection({
    Name = "Other Settings"
})

local InfiniteJumpEnabled = false

game:GetService("UserInputService").JumpRequest:Connect(function()
	if InfiniteJumpEnabled then
		game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end
end)

PlayerTab:AddToggle({
	Name = "Infinite Jump",
	Default = false,
	Callback = function(Value)
		InfiniteJumpEnabled = Value
	end    
})

spinbotEnabled = false
spinbotSpeed = 25
local spinbotConnection

PlayerTab:AddToggle({
    Name = "Spinbot",
    Default = false,
    Callback = function(value)
        spinbotEnabled = value
        
        if spinbotEnabled then
            spinbotConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if spinbotEnabled then
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            local currentCFrame = humanoidRootPart.CFrame
                            local newCFrame = currentCFrame * CFrame.Angles(0, math.rad(spinbotSpeed), 0)
                            humanoidRootPart.CFrame = newCFrame
                        end
                    end
                end
            end)
        else
            if spinbotConnection then
                spinbotConnection:Disconnect()
                spinbotConnection = nil
            end
        end
    end
})

PlayerTab:AddSlider({
    Name = "Spinbot Speed",
    Min = 1,
    Max = 50,
    Default = 25,
    Increment = 1,
    Suffix = " Speed",
    Callback = function(value)
        spinbotSpeed = value
    end
})

GraphicTab:AddSection({
    Name = "World Graphics"
})

getgenv().Resolution = 100

local Camera = workspace.CurrentCamera


game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().Resolution then
        Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, getgenv().Resolution, 0, 0, 0, 1)
    end
end)

GraphicTab:AddSlider({
    Name = "Resolution Scale",
    Min = 20,
    Max = 100,
    Default = 100,
    Increment = 1,
    ValueName = "%",
    Callback = function(Value)
        getgenv().Resolution = Value / 100
    end
})

Lighting = game:GetService("Lighting")

originalSky = Lighting:FindFirstChildOfClass("Sky")

function removeSky()
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky then
        sky:Destroy()
    end
end

function restoreSky()
    if originalSky and not Lighting:FindFirstChildOfClass("Sky") then
        local newSky = originalSky:Clone()
        newSky.Parent = Lighting
    end
end

GraphicTab:AddToggle({
	Name = "Remove Atmosphere",
    Default = false,
    Callback = function(Value)
        if Value then
            removeSky()
        else
            restoreSky()
        end
    end    
})

LightingSettings = {
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	Brightness = Lighting.Brightness,
	ShadowSoftness = Lighting.ShadowSoftness,
	GlobalShadows = Lighting.GlobalShadows
}

function enableFullbright()
	Lighting.Ambient = Color3.fromRGB(255, 255, 255)
	Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
	Lighting.Brightness = 2
	Lighting.ShadowSoftness = 0
	Lighting.GlobalShadows = false
end

function disableFullbright()
	Lighting.Ambient = LightingSettings.Ambient
	Lighting.OutdoorAmbient = LightingSettings.OutdoorAmbient
	Lighting.Brightness = LightingSettings.Brightness
	Lighting.ShadowSoftness = LightingSettings.ShadowSoftness
	Lighting.GlobalShadows = LightingSettings.GlobalShadows
end

GraphicTab:AddToggle({
	Name = "Fullbright",
	Default = false,
	Callback = function(value)
		if value then
			enableFullbright()
		else
			disableFullbright()
		end
	end
})

GraphicTab:AddSection({
    Name = "Skin changer"
})

_G.ST = {} 
_G.ST.Speed = 0.5
local P = game:GetService("Players")
local L = P.LocalPlayer

function _G.ST.C(t)
    local c, tc = L.Character, t and t.Character
    if not c or not tc then return end
    for _, v in next, c:GetChildren() do
        if v:IsA("Clothing") or v:IsA("ShirtGraphic") then v:Destroy() end
    end
    for _, v in next, tc:GetChildren() do
        if v:IsA("Clothing") or v:IsA("ShirtGraphic") then v:Clone().Parent = c end
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            local p = c:FindFirstChild(v.Name)
            if p then p.BrickColor = v.BrickColor p.Material = v.Material end
        end
    end
    local h, th = c:FindFirstChild("Head"), tc:FindFirstChild("Head")
    if h and th then
        for _, d in next, h:GetChildren() do if d:IsA("Decal") then d:Destroy() end end
        local f = th:FindFirstChildOfClass("Decal")
        if f then f:Clone().Parent = h end
    end
end

function _G.ST.G()
    local t = {}
    for _, v in next, P:GetPlayers() do if v ~= L then table.insert(t, v.Name) end end
    return t
end

task.spawn(function()
    while true do
        task.wait(_G.ST.Speed) 
        
        if _G.ST.Lp then
            local pl = P:GetPlayers()
            if #pl > 1 then
                local r = pl[math.random(1, #pl)]
                if r ~= L then _G.ST.C(r) end
            end
        end
    end
end)

local d = GraphicTab:AddDropdown({
    Name = "Select Player", 
    Default = "...", 
    Options = _G.ST.G(),
    Callback = function(v) _G.ST.C(P:FindFirstChild(v)) end
})

GraphicTab:AddToggle({
    Name = "Random Loop", 
    Default = false,
    Callback = function(v)
        _G.ST.Lp = v
    end
})

GraphicTab:AddSlider({
    Name = "Loop Speed",
    Min = 0.1,
    Max = 5,
    Default = 0.5,
    Increment = 0.1,
    ValueName = "Seconds",
    Callback = function(Value)
        _G.ST.Speed = Value
    end    
})

P.PlayerAdded:Connect(function() d:Refresh(_G.ST.G(), true) end)
P.PlayerRemoving:Connect(function() d:Refresh(_G.ST.G(), true) end)

GraphicTab:AddSection({
	Name = "Trail Options"
})

local currentTrails = {}
local attachments = {}

local function createTrail(arm)
    local att0 = Instance.new("Attachment", arm)
    att0.Position = Vector3.new(0, 0, 0)
    
    local att1 = Instance.new("Attachment", arm)
    att1.Position = Vector3.new(0, -1, 0)
    
    local trail = Instance.new("Trail")
    trail.Attachment0 = att0
    trail.Attachment1 = att1
    
    trail.Color = ColorSequence.new(selectedColor)
    trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.3),
        NumberSequenceKeypoint.new(1, 1)
    })
    
    trail.Lifetime = 1.2
    trail.WidthScale = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(1, 0.2)
    })
    
    trail.LightEmission = 1
    trail.LightInfluence = 0
    trail.MinLength = 0.05
    trail.TextureMode = Enum.TextureMode.Stretch
    trail.Parent = arm
    
    return trail, att0, att1
end

GraphicTab:AddToggle({
    Name = "Player Trail",
    Default = false,
    Callback = function(Value)
        if Value then
            local char = game.Players.LocalPlayer.Character
            if char then
                if char:FindFirstChild("Left Arm") then
                    local trailLeft, att0Left, att1Left = createTrail(char["Left Arm"])
                    table.insert(currentTrails, trailLeft)
                    table.insert(attachments, att0Left)
                    table.insert(attachments, att1Left)
                elseif char:FindFirstChild("LeftUpperArm") then
                    local trailLeft, att0Left, att1Left = createTrail(char["LeftUpperArm"])
                    table.insert(currentTrails, trailLeft)
                    table.insert(attachments, att0Left)
                    table.insert(attachments, att1Left)
                end
                
                if char:FindFirstChild("Right Arm") then
                    local trailRight, att0Right, att1Right = createTrail(char["Right Arm"])
                    table.insert(currentTrails, trailRight)
                    table.insert(attachments, att0Right)
                    table.insert(attachments, att1Right)
                elseif char:FindFirstChild("RightUpperArm") then
                    local trailRight, att0Right, att1Right = createTrail(char["RightUpperArm"])
                    table.insert(currentTrails, trailRight)
                    table.insert(attachments, att0Right)
                    table.insert(attachments, att1Right)
                end
            end
        else
            for _, trail in pairs(currentTrails) do
                trail:Destroy()
            end
            for _, att in pairs(attachments) do
                att:Destroy()
            end
            currentTrails = {}
            attachments = {}
        end
    end    
})

GraphicTab:AddColorpicker({
	Name = "Trail Color",
	Default = selectedColor,
	Callback = function(Value)
        TrailColor = {Value.R * 255, Value.G * 255, Value.B * 255}
		selectedColor = Value
        for _, trail in pairs(currentTrails) do
            trail.Color = ColorSequence.new(selectedColor)
        end
	end	  
})

GraphicTab:AddSection({
	Name = "Ghost Options"
})

Players = game:GetService("Players")
RunService = game:GetService("RunService")
LocalPlayer = Players.LocalPlayer

STATE = "force" or "normal"
savedColors = {}
ghostColor = false
rainbowEnabled = false

function HSVToRGB(hue)
	return Color3.fromHSV(hue % 1, 1, 1)
end

function applyGhostColor(color)
	local character = LocalPlayer.Character
	if not character then return end

	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") and part.Transparency < 1 then
			if not savedColors[part] then
				savedColors[part] = {
					Color = part.Color,
					Material = part.Material
				}
			end
			part.Material = Enum.Material.ForceField
			part.Color = color
		end
	end
end

function restoreOriginalAppearance()
	local character = LocalPlayer.Character
	if not character then return end

	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") and savedColors[part] then
			part.Material = savedColors[part].Material
			part.Color = savedColors[part].Color
		end
	end

	savedColors = {}
end

GraphicTab:AddToggle({
	Name = "Player Ghost",
	Default = false,
	Callback = function(enabled)
		STATE = enabled and "force" or "normal"
		if enabled then
			applyGhostColor(ghostColor)
		else
			restoreOriginalAppearance()
		end
	end
})

GraphicTab:AddColorpicker({
	Name = "Ghost Color",
	Default = None,
	Callback = function(value)
		ghostColor = value
		if STATE == "force" and not rainbowEnabled then
			applyGhostColor(ghostColor)
		end
	end
})

GraphicTab:AddToggle({
	Name = "Rainbow Color",
	Default = false,
	Callback = function(enabled)
		rainbowEnabled = enabled
	end
})

RunService.RenderStepped:Connect(function()
	if STATE == "force" and rainbowEnabled then
		local hue = tick() % 5 / 5
		local rainbowColor = HSVToRGB(hue)
		applyGhostColor(rainbowColor)
	end
end)

TrollingTab:AddSection({
    Name = "Secial Trolling Features"
})

local jumpHeight = 180

TrollingTab:AddSlider({
    Name = "Backflip Jump Height",
    Min = 130,
    Max = 200,
    Default = 150,
    Increment = 10,
    ValueName = "Studs",
    Callback = function(Value)
        jumpHeight = Value
    end
})

TrollingTab:AddButton({
    Name = "Vehicle Backflip (Buggy)",
    Callback = function()
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        
        if Humanoid and Humanoid.Sit then
            local Seat = Humanoid.SeatPart
            
            if Seat and Seat:IsA("VehicleSeat") then
                local VehicleModel = Seat.Parent
                local VehicleBody = nil

                local possibleBodyParts = {"Body", "Base", "VehicleBody", "Chassis", "PrimaryPart", Seat:FindFirstChild("Body"), VehicleModel:FindFirstChild("Body")}
                
                for _, partName in ipairs(possibleBodyParts) do
                    if type(partName) == "string" then
                        VehicleBody = VehicleModel:FindFirstChild(partName)
                        if VehicleBody and VehicleBody:IsA("BasePart") then
                            break
                        end
                    elseif partName and partName:IsA("BasePart") then
                        VehicleBody = partName
                        break
                    end
                end
                
                if not VehicleBody then
                    VehicleBody = VehicleModel.PrimaryPart or Seat
                end
                
                if VehicleBody then
                    local originalVelocity = VehicleBody.AssemblyLinearVelocity

                    VehicleBody.AssemblyLinearVelocity = Vector3.new(
                        originalVelocity.X,
                        jumpHeight,
                        originalVelocity.Z
                    )
                    
                    task.wait(0.45)
                    
                    local RightVector = VehicleBody.CFrame.RightVector
                    
                    local flipMultiplier = jumpHeight / 100
                    local baseFlipForce = 45
                    local FlipForce = baseFlipForce * flipMultiplier
                    
                    VehicleBody.AssemblyAngularVelocity = RightVector * FlipForce
                    
                    task.wait(0.15)
                    if VehicleBody and VehicleBody.Parent then
                        VehicleBody.AssemblyAngularVelocity = VehicleBody.AssemblyAngularVelocity + (RightVector * (FlipForce * 0.4))
                    end
                    
                    VentyLib:Notification({
                        Title = "Backflip",
                        Content = string.format("Vehicle launched %.0f studs high!", jumpHeight),
                        Duration = 3,
                        Image = "rocket"
                    })
                end
            else
                VentyLib:Notification({
                    Title = "Error",
                    Content = "Please sit in a vehicle seat first",
                    Duration = 5,
                    Image = "triangle-alert"
                })
            end
        else
            VentyLib:Notification({
                Title = "Error",
                Content = "You need to be sitting in a vehicle",
                Duration = 5,
                Image = "triangle-alert"
            })
        end
    end
})

TrollingTab:AddSection({
    Name = "Fling"
})


local PlayerService = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = PlayerService.LocalPlayer

local WalkFlingActive = false
local WalkFlingTask = nil
local NoclipLoop = nil

local function ClaimPhysics()
    settings().Physics.AllowSleep = false
    if sethiddenproperty then
        sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
    end
end

TrollingTab:AddToggle({
    Name = "Walk Fling",
    Default = false,
    Callback = function(Value)
        WalkFlingActive = Value
        
        if Value then
            NoclipLoop = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)

            WalkFlingTask = task.spawn(function()
                while WalkFlingActive do
                    RunService.Heartbeat:Wait()
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildWhichIsA("Humanoid")
                    
                    if hrp and hum and hum.Health > 0 then
                        ClaimPhysics()
                        local oldV = hrp.Velocity
                        hrp.Velocity = oldV * 1.1 + Vector3.new(0, 5000, 0)
                        hrp.RotVelocity = Vector3.new(0, 99999, 0) 
                        RunService.RenderStepped:Wait()
                        hrp.Velocity = oldV
                        hrp.RotVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        else
            if WalkFlingTask then task.cancel(WalkFlingTask); WalkFlingTask = nil end
            if NoclipLoop then NoclipLoop:Disconnect(); NoclipLoop = nil end
            
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
            end
        end
    end
})

MiscTab:AddSection({
    Name = "Player"
})

MiscTab:AddToggle({
    Name = "Enable Field Of View",
    Default = false,
    Callback = function(isEnabled)
        _G.FOVLockEnabled = isEnabled
        
        if isEnabled then
            if not fovConnection then
                fovConnection = game:GetService("RunService").RenderStepped:Connect(function()
                    if _G.FOVLockEnabled and (_G.LockedFOV and workspace.CurrentCamera.FieldOfView ~= _G.LockedFOV) then
                        workspace.CurrentCamera.FieldOfView = _G.LockedFOV
                    end
                end)
            end
        elseif fovConnection then
            fovConnection:Disconnect()
            fovConnection = nil
        end
    end
})

MiscTab:AddSlider({
    Name = "Field Of View",
    Min = 30,
    Max = 120,
    Default = 90,
    Suffix = "FOV",
    Save = true,
    Callback = function(value)
        workspace.CurrentCamera.FieldOfView = value
        _G.LockedFOV = value
    end
})

local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain 

local UserSettingsObj = UserSettings():GetService("UserGameSettings")

IsBoostEnabled = false
OriginalSettings = {
    QualityLevel = Enum.QualityLevel.Level10, 
    LightingTechnology = Lighting.Technology,
    GlobalShadows = Lighting.GlobalShadows,
    DiffuseScale = Lighting.EnvironmentDiffuseScale,
    SpecularScale = Lighting.EnvironmentSpecularScale,
    Textures = {},
    Water = {
        Size = Terrain.WaterWaveSize,
        Speed = Terrain.WaterWaveSpeed,
        Reflectance = Terrain.WaterReflectance,
        Transparency = Terrain.WaterTransparency
    },
    Decals = {},
    Particles = {},
    Explosions = {},
    Materials = {},
    Effects = {}
}

function ToggleFPSBoost(State)
    IsBoostEnabled = State
    
    if State then
        OriginalSettings.QualityLevel = settings().Rendering.QualityLevel
        OriginalSettings.LightingTechnology = Lighting.Technology
        OriginalSettings.GlobalShadows = Lighting.GlobalShadows

        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0

        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.GlobalShadows = false
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.FogEnd = 9e9
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

        for _, Item in pairs(game:GetDescendants()) do
            if Item:IsA("BasePart") then
                OriginalSettings.Materials[Item] = {Mat = Item.Material, Ref = Item.Reflectance}
                Item.Material = Enum.Material.Plastic
                Item.Reflectance = 0
            elseif Item:IsA("Decal") then
                OriginalSettings.Decals[Item] = Item.Transparency
                Item.Transparency = 1
            elseif Item:IsA("Texture") then
                OriginalSettings.Textures[Item] = Item.Texture
                Item.Texture = ""
            elseif Item:IsA("ParticleEmitter") or Item:IsA("Trail") then
                OriginalSettings.Particles[Item] = Item.Lifetime
                Item.Lifetime = NumberRange.new(0)
            elseif Item:IsA("Explosion") then
                OriginalSettings.Explosions[Item] = {Pres = Item.BlastPressure, Rad = Item.BlastRadius}
                Item.BlastPressure = 1
                Item.BlastRadius = 1
            end
        end

        for _, Effect in pairs(Lighting:GetDescendants()) do
            if Effect:IsA("PostProcessEffect") or Effect:IsA("BlurEffect") or Effect:IsA("BloomEffect") or Effect:IsA("DepthOfFieldEffect") then
                OriginalSettings.Effects[Effect] = Effect.Enabled
                Effect.Enabled = false
            end
        end

    else
        settings().Rendering.QualityLevel = OriginalSettings.QualityLevel
        Lighting.Technology = OriginalSettings.LightingTechnology
        Lighting.GlobalShadows = OriginalSettings.GlobalShadows
        
        Terrain.WaterWaveSize = OriginalSettings.Water.Size
        Terrain.WaterWaveSpeed = OriginalSettings.Water.Speed
        Terrain.WaterReflectance = OriginalSettings.Water.Reflectance
        Terrain.WaterTransparency = OriginalSettings.Water.Transparency
        
        for Part, Data in pairs(OriginalSettings.Materials) do
            if Part and Part.Parent then
                Part.Material = Data.Mat
                Part.Reflectance = Data.Ref
            end
        end
        
        for Decal, Trans in pairs(OriginalSettings.Decals) do
            if Decal and Decal.Parent then Decal.Transparency = Trans end
        end
        
        for Text, Asset in pairs(OriginalSettings.Textures) do
            if Text and Text.Parent then Text.Texture = Asset end
        end
        
        for Effect, Enabled in pairs(OriginalSettings.Effects) do
            if Effect and Effect.Parent then Effect.Enabled = Enabled end
        end
    end
end

workspace.DescendantAdded:Connect(function(NewItem)
    if IsBoostEnabled then
        task.spawn(function()
            RunService.RenderStepped:Wait()
            if NewItem:IsA("ForceField") or NewItem:IsA("Sparkles") or NewItem:IsA("Smoke") or NewItem:IsA("Fire") then
                NewItem:Destroy()
            end
        end)
    end
end)

MiscTab:AddToggle({
    Name = "Gambo Graphic (It will lag)",
    Default = false,
    Callback = function(Value)
        ToggleFPSBoost(Value)
    end    
})

MiscTab:AddSection({
    Name = "Safety"
})

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

MiscTab:AddButton({
    Name = "Kick Out Of Seat",
    Callback = function()
        humanoid.Sit = false
    end
})

MiscTab:AddToggle({
    Name = "Anti Falldamage",
    Default = false,
    Callback = function(state)
        if state then
            if noFallConnection then noFallConnection:Disconnect() end

            noFallConnection = RunService.Heartbeat:Connect(function()
                local character = LocalPlayer.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                
                if root and root.AssemblyLinearVelocity.Y < -35 then
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterDescendantsInstances = {character}
                    raycastParams.FilterType = Enum.RaycastFilterType.Exclude

                    local ray = workspace:Raycast(root.Position, Vector3.new(0, -15, 0), raycastParams)
                    
                    if ray then 
                        root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z)
                    end
                end
            end)
        else
            if noFallConnection then
                noFallConnection:Disconnect()
                noFallConnection = nil
            end
        end
    end
})

Players = game:GetService("Players")
UserInputService = game:GetService("UserInputService")

LocalPlayer = Players.LocalPlayer
Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

MiscTab:AddButton({
    Name = "Reset Character",
    Callback = function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
    end
})

MiscTab:AddButton({
    Name = "Fake Ban",
    Callback = function()
        local Player = game:GetService("Players").LocalPlayer
        if Player then
            Player:Kick("Your Account got Banned Permanently\n Reason: No Reason given")
        else
            game:Shutdown() 
        end
    end    
})

SocialTab:AddSection({
    Name = "Social Media"
})

SocialTab:AddParagraph("TikTok", "You can Follow us on TikTok with this Name or the Button down : @froxy_eh")

SocialTab:AddButton({
    Name = "Copy TikTok Link",
    Callback = function()
        setclipboard("https://www.tiktok.com/@froxy_eh")
        VentyLib:MakeNotification({
            Name = "TikTok Link",
            Content = "Link copied to clipboard!",
            Time = 3
        })
    end
})  

SocialTab:AddSection({
    Name = "Discord"
})

SocialTab:AddParagraph("Discord", "You can Join our Discord to get the Newest Version of Venty Development")

SocialTab:AddButton({
    Name = "Join Discord Server",
    Callback = function()
        setclipboard("https://discord.gg/Jrp6mAsCn")
        VentyLib:MakeNotification({
            Name = "Discord Link",
            Content = "Link copied to clipboard!",
            Time = 3
        })
    end
})

SocialTab:AddSection({
    Name = "Rscripts"
})

SocialTab:AddParagraph("Rscripts", "You can leave a like and an Follow on our Rscripts")

SocialTab:AddButton({
    Name = "Follow us on Rscripts",
    Callback = function()
        setclipboard("https://rscripts.net/@VentyDevelopment")
        VentyLib:MakeNotification({
            Name = "Warning",
            Content = "Link Copied to clipboard",
            Time = 3
        })
    end
})

InfoTab:AddSection({
    Name = "Developer Information"
})

InfoTab:AddParagraph("Developed by","Trojaner \nBut we have also contributor like Phil from MoonHub or Eldar from EldarX")

InfoTab:AddSection({
    Name = "Information"
})

InfoTab:AddParagraph("About Venty", "Venty is an Projekt from Trojaner (the Main Developer) he decidet do make an own projekt")

VentyLib:Init()


else
    game.Players.LocalPlayer:Kick("You are not allowed to use this script. If you have Premium and have already reset your ClientID, please be patient and wait.")
    task.wait(3)
    game:Shutdown()
end