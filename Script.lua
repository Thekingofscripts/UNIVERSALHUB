
-- Jim's Universal Hub V10 (Modern UI & Server-Sided Physics Engine)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JimsUniversalHub"
ScreenGui.Parent = game.CoreGui or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Theme Palettes (Modern Dark)
local Theme = {
    MainBg = Color3.fromRGB(20, 20, 22),
    SubBg = Color3.fromRGB(28, 28, 32),
    Accent = Color3.fromRGB(255, 200, 40), -- Clean yellow accent
    TextMain = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(160, 160, 165),
    Button = Color3.fromRGB(36, 36, 40),
    Active = Color3.fromRGB(0, 180, 100),
    Alert = Color3.fromRGB(255, 75, 75)
}

-- Create Main Window Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Theme.MainBg
MainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 560, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Header/Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(0, 250, 0, 45)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "JIM'S UNIVERSAL HUB"
Title.TextColor3 = Theme.Accent
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Controls Panels Layout
local LeftPanel = Instance.new("Frame", MainFrame)
LeftPanel.Size = UDim2.new(0, 140, 0, 300)
LeftPanel.Position = UDim2.new(0, 10, 0, 50)
LeftPanel.BackgroundColor3 = Theme.SubBg
Instance.new("UICorner", LeftPanel).CornerRadius = UDim.new(0, 6)

local TabContainer = Instance.new("ScrollingFrame", LeftPanel)
TabContainer.Size = UDim2.new(1, -10, 1, -10)
TabContainer.Position = UDim2.new(0, 5, 0, 5)
TabContainer.BackgroundTransparency = 1
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 400)
TabContainer.ScrollBarThickness = 2
local TabLayout = Instance.new("UIListLayout", TabContainer)
TabLayout.Padding = UDim.new(0, 5)

local RightPanel = Instance.new("Frame", MainFrame)
RightPanel.Size = UDim2.new(0, 390, 0, 300)
RightPanel.Position = UDim2.new(0, 160, 0, 50)
RightPanel.BackgroundColor3 = Theme.SubBg
Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 6)

local PageContainer = Instance.new("Frame", RightPanel)
PageContainer.Size = UDim2.new(1, -10, 1, -10)
PageContainer.Position = UDim2.new(0, 5, 0, 5)
PageContainer.BackgroundTransparency = 1

local tabButtons, tabPages = {}, {}

local function CreateTab(name)
    local Btn = Instance.new("TextButton", TabContainer)
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = Theme.Button
    Btn.Text = name
    Btn.TextColor3 = Theme.TextDark
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 0, 600)
    Page.ScrollBarThickness = 4
    local PageLayout = Instance.new("UIListLayout", Page)
    PageLayout.Padding = UDim.new(0, 8)

    table.insert(tabButtons, Btn)
    table.insert(tabPages, Page)

    if #tabButtons == 1 then
        Page.Visible = true
        Btn.BackgroundColor3 = Theme.Accent
        Btn.TextColor3 = Theme.MainBg
        Btn.Font = Enum.Font.GothamBold
    end

    Btn.MouseButton1Click:Connect(function()
        for i, p in ipairs(tabPages) do
            local active = (p == Page)
            p.Visible = active
            tabButtons[i].BackgroundColor3 = active and Theme.Accent or Theme.Button
            tabButtons[i].TextColor3 = active and Theme.MainBg or Theme.TextDark
            tabButtons[i].Font = active and Enum.Font.GothamBold or Enum.Font.Gotham
        end
    end)
    return Page
end

local function AddButton(page, text, callback)
    local Btn = Instance.new("TextButton", page)
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.BackgroundColor3 = Theme.Button
    Btn.Text = text
    Btn.TextColor3 = Theme.TextMain
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function AddUncappedInput(page, text, default, callback)
    local Frame = Instance.new("Frame", page)
    Frame.Size = UDim2.new(1, -5, 0, 40)
    Frame.BackgroundColor3 = Theme.Button
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 4)

    local lbl = Instance.new("TextLabel", Frame)
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. " (No Limit):"
    lbl.TextColor3 = Theme.TextDark
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local Box = Instance.new("TextBox", Frame)
    Box.Size = UDim2.new(0.3, 0, 0.7, 0)
    Box.Position = UDim2.new(0.65, 0, 0.15, 0)
    Box.BackgroundColor3 = Theme.MainBg
    Box.Text = tostring(default)
    Box.TextColor3 = Theme.Accent
    Box.Font = Enum.Font.GothamBold
    Box.TextSize = 13
    Box.ClearTextOnFocus = false
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)

    Box.FocusLost:Connect(function()
        local n = tonumber(Box.Text)
        if n then callback(n) else Box.Text = tostring(default) end
    end)
end

-- Mobile UI Toggle System
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 90, 0, 35)
OpenBtn.Position = UDim2.new(0.02, 0, 0.1, 0)
OpenBtn.Text = "Open Hub"
OpenBtn.TextColor3 = Theme.TextMain
OpenBtn.BackgroundColor3 = Theme.Button
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 13
OpenBtn.Visible = isMobile
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 6)

MainFrame.Visible = not isMobile

local function toggleHub()
    MainFrame.Visible = not MainFrame.Visible
    if isMobile then OpenBtn.Visible = not MainFrame.Visible end
end

OpenBtn.MouseButton1Click:Connect(toggleHub)

-- Desktop Keybind Trigger (1 or RightControl)
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and (input.KeyCode == Enum.KeyCode.One or input.KeyCode == Enum.KeyCode.RightControl) then
        toggleHub()
    end
end)

---------------------------------------------------------
-- FEATURES DEVELOPMENT BUILD
---------------------------------------------------------
local MainTab = CreateTab("Main")
local LocalPlayerTab = CreateTab("LocalPlayer")

-- 1. SERVER-SIDED BRING & ORBIT PARTS WINDOW BUILD
AddButton(MainTab, "Bring Unanchored Parts GUI", function()
    if ScreenGui:FindFirstChild("BringPartsGui") then return end

    local BGui = Instance.new("Frame", ScreenGui)
    BGui.Name = "BringPartsGui"
    BGui.Size = UDim2.new(0, 260, 0, 280)
    BGui.Position = UDim2.new(0.1, 0, 0.3, 0)
    BGui.BackgroundColor3 = Theme.MainBg
    BGui.Active = true
    BGui.Draggable = true
    Instance.new("UICorner", BGui).CornerRadius = UDim.new(0, 6)

    local Header = Instance.new("TextLabel", BGui)
    Header.Size = UDim2.new(1, -40, 0, 35)
    Header.Position = UDim2.new(0, 10, 0, 0)
    Header.BackgroundTransparency = 1
    Header.Text = "Server-Sided Orbit Engine"
    Header.TextColor3 = Theme.TextMain
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 13
    Header.TextXAlignment = Enum.TextXAlignment.Left

    local Close = Instance.new("TextButton", BGui)
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.Position = UDim2.new(1, -35, 0, 2)
    Close.Text = "X"
    Close.TextColor3 = Theme.Alert
    Close.BackgroundTransparency = 1
    Close.MouseButton1Click:Connect(function() BGui:Destroy() end)

    local orbitSpeed, orbitRadius = 5, 10
    local layoutPattern = "Horizontal"
    local active = false

    -- Embedded Sub UI inputs (Uncapped bounds processing layout)
    local function subInput(txt, pos, def, cb)
        local f = Instance.new("Frame", BGui)
        f.Size = UDim2.new(0.9, 0, 0, 35)
        f.Position = UDim2.new(0.05, 0, 0, pos)
        f.BackgroundTransparency = 1
        
        local l = Instance.new("TextLabel", f)
        l.Size = UDim2.new(0.5, 0, 1, 0)
        l.Text = txt .. ":"
        l.TextColor3 = Theme.TextDark
        l.Font = Enum.Font.Gotham
        l.TextSize = 12
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.BackgroundTransparency = 1

        local b = Instance.new("TextBox", f)
        b.Size = UDim2.new(0.45, 0, 0.8, 0)
        b.Position = UDim2.new(0.55, 0, 0.1, 0)
        b.BackgroundColor3 = Theme.SubBg
        b.Text = tostring(def)
        b.TextColor3 = Theme.Accent
        b.Font = Enum.Font.GothamBold
        b.TextSize = 12
        b.ClearTextOnFocus = false
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
        b.FocusLost:Connect(function()
            local v = tonumber(b.Text) or def
            cb(v)
        end)
    end

    subInput("Orbit Speed", 45, 5, function(v) orbitSpeed = v end)
    subInput("Orbit Radius", 85, 10, function(v) orbitRadius = v end)

    local LayoutBtn = Instance.new("TextButton", BGui)
    LayoutBtn.Size = UDim2.new(0.9, 0, 0, 35)
    LayoutBtn.Position = UDim2.new(0.05, 0, 0, 130)
    LayoutBtn.BackgroundColor3 = Theme.Button
    LayoutBtn.Text = "Orientation: Horizontal"
    LayoutBtn.TextColor3 = Theme.TextMain
    LayoutBtn.Font = Enum.Font.Gotham
    LayoutBtn.TextSize = 12
    Instance.new("UICorner", LayoutBtn).CornerRadius = UDim.new(0, 4)

    local patterns = {"Horizontal", "Vertical", "Square", "Circle"}
    local idx = 1
    LayoutBtn.MouseButton1Click:Connect(function()
        idx = (idx % #patterns) + 1
        layoutPattern = patterns[idx]
        LayoutBtn.Text = "Orientation: " .. layoutPattern
    end)

    local ToggleBtn = Instance.new("TextButton", BGui)
    ToggleBtn.Size = UDim2.new(0.9, 0, 0, 40)
    ToggleBtn.Position = UDim2.new(0.05, 0, 0, 185)
    ToggleBtn.BackgroundColor3 = Theme.Alert
    ToggleBtn.Text = "Bring Parts: OFF"
    ToggleBtn.TextColor3 = Theme.TextMain
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 13
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 4)

    ToggleBtn.MouseButton1Click:Connect(function()
        active = not active
        ToggleBtn.Text = active and "Bring Parts: ACTIVE" or "Bring Parts: OFF"
        ToggleBtn.BackgroundColor3 = active and Theme.Active or Theme.Alert
    end)

    -- SERVER-SIDED PHYSICS REPLICATION CORE
    task.spawn(function()
        local ang = 0
        pcall(function()
            settings().Physics.AllowSleep = false
            LocalPlayer.MaximumSimulationRadius = math.huge
            if setsimulationradius then setsimulationradius(math.huge) end
        end)

        while BGui and task.wait() do
            if active and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local root = LocalPlayer.Character.HumanoidRootPart
                ang = ang + (0.02 * orbitSpeed)

                local parts = {}
                for _, d in pairs(workspace:GetDescendants()) do
                    if d:IsA("BasePart") and not d.Anchored then
                        local isPlayer = false
                        for _, p in pairs(Players:GetPlayers()) do
                            if p.Character and d:IsDescendantOf(p.Character) then isPlayer = true break end
                        end
                        if not isPlayer then table.insert(parts, d) end
                    end
                end

                local count = #parts
                for i, part in ipairs(parts) do
                    pcall(function()
                        local offsetAngle = ang + (i * (math.pi * 2 / math.max(count, 1)))
                        local offset = Vector3.new(0,0,0)

                        if layoutPattern == "Horizontal" or layoutPattern == "Circle" then
                            offset = Vector3.new(math.cos(offsetAngle) * orbitRadius, 0, math.sin(offsetAngle) * orbitRadius)
                        elseif layoutPattern == "Vertical" then
                            offset = Vector3.new(0, math.cos(offsetAngle) * orbitRadius, math.sin(offsetAngle) * orbitRadius)
                        elseif layoutPattern == "Square" then
                            local edge = i % 4
                            if edge == 0 then offset = Vector3.new(orbitRadius, 0, (i/count)*orbitRadius)
                            elseif edge == 1 then offset = Vector3.new(-orbitRadius, 0, (i/count)*orbitRadius)
                            elseif edge == 2 then offset = Vector3.new((i/count)*orbitRadius, 0, orbitRadius)
                            else offset = Vector3.new((i/count)*orbitRadius, 0, -orbitRadius) end
                        end

                        local targetPos = root.Position + offset
                        -- Velocity overrides client-only caching structures to enforce global replication updates
                        part.AssemblyLinearVelocity = (targetPos - part.Position) * 35
                        part.CFrame = CFrame.new(targetPos)
                    end)
                end
            end
        end
    end)
end)

-- 2. AUTOMATIC UTILITY SYSTEMS (SELL LEMONS TYCOON CORE)
AddButton(MainTab, "Sell Lemons Automator GUI", function()
    if ScreenGui:FindFirstChild("LemonTycoonGui") then return end

    local LGui = Instance.new("Frame", ScreenGui)
    LGui.Name = "LemonTycoonGui"
    LGui.Size = UDim2.new(0, 240, 0, 150)
    LGui.Position = UDim2.new(0.45, 0, 0.45, 0)
    LGui.BackgroundColor3 = Theme.MainBg
    LGui.Active = true
    LGui.Draggable = true
    Instance.new("UICorner", LGui).CornerRadius = UDim.new(0, 6)

    local LTitle = Instance.new("TextLabel", LGui)
    LTitle.Size = UDim2.new(1, -35, 0, 35)
    LTitle.Position = UDim2.new(0, 10, 0, 0)
    LTitle.Text = "Lemon Automator"
    LTitle.TextColor3 = Theme.TextMain
    LTitle.Font = Enum.Font.GothamBold
    LTitle.TextSize = 13
    LTitle.TextXAlignment = Enum.TextXAlignment.Left
    LTitle.BackgroundTransparency = 1

    local LClose = Instance.new("TextButton", LGui)
    LClose.Size = UDim2.new(0, 30, 0, 30)
    LClose.Position = UDim2.new(1, -35, 0, 2)
    LClose.Text = "X"
    LClose.TextColor3 = Theme.Alert
    LClose.BackgroundTransparency = 1
    LClose.MouseButton1Click:Connect(function() LGui:Destroy() end)

    local SellBtn = Instance.new("TextButton", LGui)
    SellBtn.Size = UDim2.new(0.9, 0, 0, 35)
    SellBtn.Position = UDim2.new(0.05, 0, 0, 45)
    SellBtn.BackgroundColor3 = Theme.Button
    SellBtn.Text = "Auto Sell: OFF"
    SellBtn.TextColor3 = Theme.TextMain
    SellBtn.Font = Enum.Font.Gotham
    Instance.new("UICorner", SellBtn).CornerRadius = UDim.new(0, 4)

    local running = false
    SellBtn.MouseButton1Click:Connect(function()
        running = not running
        SellBtn.Text = running and "Auto Sell: ON" or "Auto Sell: OFF"
        SellBtn.BackgroundColor3 = running and Theme.Active or Theme.Button

        task.spawn(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") or game:GetService("ReplicatedStorage"):FindFirstChild("Events")
            local remote = remotes and (remotes:FindFirstChild("Sell") or remotes:FindFirstChild("SellLemons"))
            while running do
                if remote and remote:IsA("RemoteEvent") then
                    remote:FireServer()
                end
                task.wait(0.5)
            end
        end)
    end)
end)

-- 3. LOCAL PLAYER CONTROLS (UNRESTRICTED SPEED & EXTRACTED IY FLY ALGORITHMS)
local targetSpeed, targetJump = 16, 50
local flySpeed, flyRunning = 50, false

AddUncappedInput(LocalPlayerTab, "WalkSpeed", 16, function(v) targetSpeed = v end)
AddUncappedInput(LocalPlayerTab, "JumpPower", 50, function(v) targetJump = v end)
AddUncappedInput(LocalPlayerTab, "Fly Speed", 50, function(v) flySpeed = v end)

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum.WalkSpeed ~= targetSpeed then hum.WalkSpeed = targetSpeed end
        if hum.UseJumpPower then
            if hum.JumpPower ~= targetJump then hum.JumpPower = targetJump end
        else
            if hum.JumpHeight ~= (targetJump * 0.14) then hum.JumpHeight = (targetJump * 0.14) end
        end
    end
end)

local FlyToggle = AddButton(LocalPlayerTab, "Toggle Flight Engine: OFF", function() end)

local bVel, bGyro, renderLoop, kDown, kUp
local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}

local function stopFlight()
    flyRunning = false
    FlyToggle.Text = "Toggle Flight Engine: OFF"
    FlyToggle.BackgroundColor3 = Theme.Button
    if renderLoop then renderLoop:Disconnect() renderLoop = nil end
    if kDown then kDown:Disconnect() kDown = nil end
    if kUp then kUp:Disconnect() kUp = nil end
    if bVel then bVel:Destroy() bVel = nil end
    if bGyro then bGyro:Destroy() bGyro = nil end
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false end
end

FlyToggle.MouseButton1Click:Connect(function()
    if flyRunning then stopFlight() return end
    
    flyRunning = true
    FlyToggle.Text = "Toggle Flight Engine: ACTIVE"
    FlyToggle.BackgroundColor3 = Theme.Active

    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end

    bGyro = Instance.new("BodyGyro", root)
    bGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bGyro.cframe = root.CFrame

    bVel = Instance.new("BodyVelocity", root)
    bVel.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bVel.velocity = Vector3.new(0, 0.1, 0)

    kDown = Mouse.KeyDown:Connect(function(k)
        if k:lower() == 'w' then CONTROL.F = flySpeed
        elseif k:lower() == 's' then CONTROL.B = -flySpeed
        elseif k:lower() == 'a' then CONTROL.L = -flySpeed
        elseif k:lower() == 'd' then CONTROL.R = flySpeed
        end
    end)

    kUp = Mouse.KeyUp:Connect(function(k)
        if k:lower() == 'w' then CONTROL.F = 0
        elseif k:lower() == 's' then CONTROL.B = 0
        elseif k:lower() == 'a' then CONTROL.L = 0
        elseif k:lower() == 'd' then CONTROL.R = 0
        end
    end)

    renderLoop = RunService.RenderStepped:Connect(function()
        if not flyRunning or not root or not bVel then stopFlight() return end
        hum.PlatformStand = true
        
        local cam = workspace.CurrentCamera
        local direction = Vector3.new(CONTROL.L + CONTROL.R, 0, CONTROL.F + CONTROL.B)
        
        if hum.MoveDirection.Magnitude > 0 then
            bVel.velocity = hum.MoveDirection * flySpeed
        else
            bVel.velocity = cam.CFrame:VectorToWorldSpace(direction)
        end
        bGyro.cframe = cam.CFrame
    end)
end)

-- Multi-Tab Placeholders Expansion Setup 
for i = 3, 6 do CreateTab("Extra " .. i) end
