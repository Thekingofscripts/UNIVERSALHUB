-- Jim's Universal Hub V4 (Modern Vector Fly & Precise TextBox Controls)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local RightPanel = Instance.new("Frame")
local TabContainer = Instance.new("ScrollingFrame")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "JimsUniversalHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 90, 0, 35)
OpenBtn.Position = UDim2.new(0.02, 0, 0.1, 0)
OpenBtn.Text = "Open Hub"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.TextSize = 14
OpenBtn.Visible = false

local OpenCorner = Instance.new("UICorner", OpenBtn)
OpenCorner.CornerRadius = UDim.new(0, 6)

local function setHubVisible(visible)
    MainFrame.Visible = visible
    if isMobile then
        OpenBtn.Visible = not visible
    else
        OpenBtn.Visible = false
    end
end

-- Main Window
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 10)
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Text = "Jim's Universal Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.SourceSansBold

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 10)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 16

local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 10)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.TextSize = 16

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function() setHubVisible(false) end)
OpenBtn.MouseButton1Click:Connect(function() setHubVisible(true) end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    LeftPanel.Visible = not minimized
    RightPanel.Visible = not minimized
    MainFrame.Size = minimized and UDim2.new(0, 550, 0, 50) or UDim2.new(0, 550, 0, 350)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and (input.KeyCode == Enum.KeyCode.KeypadOne or input.KeyCode == Enum.KeyCode.One or input.KeyCode == Enum.KeyCode.RightControl) then
        setHubVisible(not MainFrame.Visible)
    end
end)

LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
LeftPanel.Position = UDim2.new(0, 10, 0, 50)
LeftPanel.Size = UDim2.new(0, 130, 0, 285)

TabContainer.Name = "TabContainer"
TabContainer.Parent = LeftPanel
TabContainer.BackgroundTransparency = 1
TabContainer.Size = UDim2.new(1, 0, 1, 0)
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 450)
TabContainer.ScrollBarThickness = 2

local TabLayout = Instance.new("UIListLayout", TabContainer)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)

RightPanel.Name = "RightPanel"
RightPanel.Parent = MainFrame
RightPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
RightPanel.Position = UDim2.new(0, 150, 0, 50)
RightPanel.Size = UDim2.new(0, 390, 0, 285)

local PageContainer = Instance.new("Frame", RightPanel)
PageContainer.Size = UDim2.new(1, 0, 1, 0)
PageContainer.BackgroundTransparency = 1

local tabButtons = {}
local tabPages = {}

local function CreateTab(tabName)
    local TabButton = Instance.new("TextButton", TabContainer)
    TabButton.Size = UDim2.new(1, -10, 0, 30)
    TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.SourceSans
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 4)

    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, -10, 1, -10)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 0, 650)
    Page.ScrollBarThickness = 4
    Page.Position = UDim2.new(0, 5, 0, 5)
    
    local ContentLayout = Instance.new("UIListLayout", Page)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 8)

    table.insert(tabButtons, TabButton)
    table.insert(tabPages, Page)

    if #tabButtons == 1 then
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    TabButton.MouseButton1Click:Connect(function()
        for i, p in ipairs(tabPages) do
            p.Visible = (p == Page)
            tabButtons[i].BackgroundColor3 = (p == Page) and Color3.fromRGB(60, 120, 255) or Color3.fromRGB(35, 35, 40)
            tabButtons[i].TextColor3 = (p == Page) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        end
    end)

    return Page
end

local function AddButton(page, text, callback)
    local Button = Instance.new("TextButton", page)
    Button.Size = UDim2.new(1, -10, 0, 32)
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSans
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 4)
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- NEW REPLACEMENT FOR SLIDERS: Safe Input Numbers Box Component
local function AddNumberBox(page, text, min, max, default, callback)
    local BoxFrame = Instance.new("Frame", page)
    BoxFrame.Size = UDim2.new(1, -10, 0, 40)
    BoxFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Instance.new("UICorner", BoxFrame).CornerRadius = UDim.new(0, 4)

    local Label = Instance.new("TextLabel", BoxFrame)
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text .. " (" .. min .. "-" .. max .. "):"
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 14
    Label.Font = Enum.Font.SourceSans
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local InputField = Instance.new("TextBox", BoxFrame)
    InputField.Size = UDim2.new(0.3, 0, 0.7, 0)
    InputField.Position = UDim2.new(0.65, 0, 0.15, 0)
    InputField.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    InputField.Text = tostring(default)
    InputField.TextColor3 = Color3.fromRGB(60, 120, 255)
    InputField.TextSize = 14
    InputField.Font = Enum.Font.SourceSansBold
    InputField.PlaceholderText = "..."
    InputField.ClearTextOnFocus = false
    Instance.new("UICorner", InputField).CornerRadius = UDim.new(0, 4)

    local function validateAndSubmit()
        local num = tonumber(InputField.Text)
        if num then
            num = math.clamp(math.floor(num), min, max)
            InputField.Text = tostring(num)
            callback(num)
        else
            InputField.Text = tostring(default)
        end
    end

    InputField.FocusLost:Connect(validateAndSubmit)
end

-- Anti-AFK Engine Loop
task.spawn(function()
    local virtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new(0,0))
    end)
end)

---------------------------------------------------------
-- TAB 1: MAIN TAB (SELL LEMONS AUTOMATION)
---------------------------------------------------------
local MainTab = CreateTab("Main")

AddButton(MainTab, "Run Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

AddButton(MainTab, "Sell Lemons Automator", function()
    if ScreenGui:FindFirstChild("LemonTycoonGui") then return end

    local SubGui = Instance.new("Frame", ScreenGui)
    SubGui.Name = "LemonTycoonGui"
    SubGui.Size = UDim2.new(0, 240, 0, 180)
    SubGui.Position = UDim2.new(0.45, 0, 0.45, 0)
    SubGui.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    SubGui.Active = true
    SubGui.Draggable = true
    Instance.new("UICorner", SubGui).CornerRadius = UDim.new(0, 6)

    local SubTitle = Instance.new("TextLabel", SubGui)
    SubTitle.Size = UDim2.new(1, 0, 0, 30)
    SubTitle.Text = "Sell Lemons Engine"
    SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    SubTitle.Font = Enum.Font.SourceSansBold
    
    local SubClose = Instance.new("TextButton", SubGui)
    SubClose.Size = UDim2.new(0, 30, 0, 30)
    SubClose.Position = UDim2.new(1, -30, 0, 0)
    SubClose.Text = "X"
    SubClose.TextColor3 = Color3.fromRGB(255, 50, 50)
    SubClose.BackgroundTransparency = 1
    SubClose.MouseButton1Click:Connect(function() SubGui:Destroy() end)

    local AutoSellBtn = Instance.new("TextButton", SubGui)
    AutoSellBtn.Size = UDim2.new(0.9, 0, 0, 35)
    AutoSellBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
    AutoSellBtn.Text = "Auto Sell: OFF"
    AutoSellBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    AutoSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", AutoSellBtn).CornerRadius = UDim.new(0, 4)

    local AutoUpgradeBtn = Instance.new("TextButton", SubGui)
    AutoUpgradeBtn.Size = UDim2.new(0.9, 0, 0, 35)
    AutoUpgradeBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
    AutoUpgradeBtn.Text = "Auto Upgrade: OFF"
    AutoUpgradeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    AutoUpgradeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", AutoUpgradeBtn).CornerRadius = UDim.new(0, 4)

    local function getMyTycoon()
        local searchFolders = {workspace:FindFirstChild("Tycoons"), workspace:FindFirstChild("Plots"), workspace:FindFirstChild("TycoonFolder"), workspace}
        for _, folder in pairs(searchFolders) do
            if folder then
                for _, plot in pairs(folder:GetChildren()) do
                    local owner = plot:FindFirstChild("Owner") or plot:FindFirstChild("Player") or plot:FindFirstChild("OwnerName")
                    if owner and (owner.Value == LocalPlayer or owner.Value == LocalPlayer.Name or tostring(owner.Value) == LocalPlayer.Name) then
                        return plot
                    end
                    if string.find(string.lower(plot.Name), string.lower(LocalPlayer.Name)) or plot.Name == LocalPlayer.Name then
                        return plot
                    end
                end
            end
        end
        return nil
    end

    local function interactWithButton(part)
        if not part or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
        if firetouchinterest then
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, part, 0)
            task.wait(0.01)
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, part, 1)
        else
            local root = LocalPlayer.Character.HumanoidRootPart
            local oldPos = root.CFrame
            root.CFrame = part.CFrame
            task.wait(0.04)
            root.CFrame = oldPos
        end
    end

    local selling = false
    AutoSellBtn.MouseButton1Click:Connect(function()
        selling = not selling
        AutoSellBtn.Text = selling and "Auto Sell: ON" or "Auto Sell: OFF"
        AutoSellBtn.BackgroundColor3 = selling and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(45, 45, 50)
        
        task.spawn(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") or game:GetService("ReplicatedStorage"):FindFirstChild("Events")
            local sellRemote = remotes and (remotes:FindFirstChild("Sell") or remotes:FindFirstChild("SellLemons") or remotes:FindFirstChild("ClaimCash"))
            
            while selling do
                if sellRemote and sellRemote:IsA("RemoteEvent") then
                    sellRemote:FireServer()
                else
                    local myTycoon = getMyTycoon()
                    local pad = myTycoon and (myTycoon:FindFirstChild("Sell") or myTycoon:FindFirstChild("SellPad") or myTycoon:FindFirstChild("Collector"))
                    if not pad then
                        pad = workspace:FindFirstChild("Sell") or workspace:FindFirstChild("SellPad") or workspace:FindFirstChild("LemonSell")
                    end
                    if pad then
                        interactWithButton(pad:FindFirstChild("Touch") or pad:FindFirstChild("Head") or pad)
                    end
                end
                task.wait(0.3)
            end
        end)
    end)

    local upgrading = false
    AutoUpgradeBtn.MouseButton1Click:Connect(function()
        upgrading = not upgrading
        AutoUpgradeBtn.Text = upgrading and "Auto Upgrade: ON" or "Auto Upgrade: OFF"
        AutoUpgradeBtn.BackgroundColor3 = upgrading and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(45, 45, 50)
        
        task.spawn(function()
            while upgrading do
                local myTycoon = getMyTycoon()
                if myTycoon then
                    local buttons = myTycoon:FindFirstChild("Buttons") or myTycoon:FindFirstChild("Upgrades") or myTycoon
                    for _, btn in pairs(buttons:GetDescendants()) do
                        if btn:IsA("TouchTransmitter") or btn.Name == "TouchInterest" then
                            local realPart = btn.Parent
                            if realPart and realPart:IsA("BasePart") then
                                local parentModel = realPart.Parent
                                local isLocked = parentModel:FindFirstChild("DevProduct") or parentModel:FindFirstChild("Gamepass")
                                if not isLocked then
                                    interactWithButton(realPart)
                                    task.wait(0.05)
                                end
                            end
                        end
                    end
                end
                task.wait(0.7)
            end
        end)
    end)
end)

---------------------------------------------------------
-- TAB 2: LOCALPLAYER TAB (STABLE FRAME-POSITION ENGINES)
---------------------------------------------------------
local LocalPlayerTab = CreateTab("LocalPlayer")

local targetWalkSpeed = 16
local targetJumpPower = 50
local targetFlySpeed = 50
local flyEnabled = false

-- State Engine Synchronization (Humanoid Modifiers)
RunService.RenderStepped:Connect(function()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if humanoid.WalkSpeed ~= targetWalkSpeed then humanoid.WalkSpeed = targetWalkSpeed end
            if humanoid.UseJumpPower then
                if humanoid.JumpPower ~= targetJumpPower then humanoid.JumpPower = targetJumpPower end
            else
                if humanoid.JumpHeight ~= (targetJumpPower * 0.14) then humanoid.JumpHeight = (targetJumpPower * 0.14) end
            end
        end
    end
end)

-- TextBox Numeric Modifiers instead of sliders
AddNumberBox(LocalPlayerTab, "WalkSpeed", 1, 1000, 16, function(value)
    targetWalkSpeed = value
end)

AddNumberBox(LocalPlayerTab, "JumpPower", 1, 1000, 50, function(value)
    targetJumpPower = value
end)

-- REWRITTEN FLY ENGINE: Frame-based Vector Positional Updates (No Physics Freezing)
local flyConnection
local function stopFlying()
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    local character = LocalPlayer.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        humanoid.PlatformStand = false
        -- Clear any residual velocity states
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then root.AssemblyLinearVelocity = Vector3.new(0,0,0) end
    end
end

local function startFlying()
    stopFlying()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if not root or not humanoid then return end
    
    flyConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not flyEnabled or not root or not character:IsDescendantOf(workspace) then 
            stopFlying() 
            return 
        end
        
        humanoid.PlatformStand = true
        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0) -- Freezes gravity drops safely without freezing motion

        local camera = workspace.CurrentCamera
        local moveDirection = Vector3.new(0, 0, 0)
        
        -- Input Evaluation Loops
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end
        
        -- Native Mobile Thumbstick & Jump Tracking compatibility
        if humanoid.MoveDirection.Magnitude > 0 then
            moveDirection = moveDirection + humanoid.MoveDirection
        end
        if UserInputService.JumpAxis and UserInputService.JumpAxis.Y > 0 then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end

        if moveDirection.Magnitude > 0 then
            root.CFrame = root.CFrame + (moveDirection.Unit * targetFlySpeed * deltaTime)
        end
    end)
end

-- Fly Activation Buttons
local FlyToggleBtn = AddButton(LocalPlayerTab, "Fly: OFF", function() end)
FlyToggleBtn.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyToggleBtn.Text = flyEnabled and "Fly: ON" or "Fly: OFF"
    FlyToggleBtn.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(45, 45, 50)
    if flyEnabled then startFlying() else stopFlying() end
end)

AddNumberBox(LocalPlayerTab, "Fly Speed", 1, 1000, 50, function(value)
    targetFlySpeed = value
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if flyEnabled then startFlying() end
end)

---------------------------------------------------------
-- SEED CODES FOR REMAINING TABS
---------------------------------------------------------
for tabIndex = 3, 10 do
    local ExtraTab = CreateTab("Tab " .. tabIndex)
    for btnIndex = 1, 20 do
        AddButton(ExtraTab, "Coming Soon", function() end)
    end
end
