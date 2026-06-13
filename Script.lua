-- Jim's Universal Hub V8 (Uncapped Controls, Real IY Fly & Bringing Unanchored Parts)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()

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

-- Main Window Configuration
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

local function AddNumberBox(page, text, default, callback)
    local BoxFrame = Instance.new("Frame", page)
    BoxFrame.Size = UDim2.new(1, -10, 0, 40)
    BoxFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Instance.new("UICorner", BoxFrame).CornerRadius = UDim.new(0, 4)

    local Label = Instance.new("TextLabel", BoxFrame)
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text .. " (No Limits):"
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
            num = math.floor(num)
            InputField.Text = tostring(num)
            callback(num)
        else
            InputField.Text = tostring(default)
        end
    end

    InputField.FocusLost:Connect(validateAndSubmit)
end

-- Anti-AFK Setup
task.spawn(function()
    local virtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new(0,0))
    end)
end)

---------------------------------------------------------
-- TAB 1: MAIN TAB (SELL LEMONS & BRING PARTS AUTOMATION)
---------------------------------------------------------
local MainTab = CreateTab("Main")

AddButton(MainTab, "Run Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- NEW BRING UNANCHORED PARTS SUB-GUI GENERATOR BUTTON
AddButton(MainTab, "Bring Unanchored Parts Tool", function()
    if ScreenGui:FindFirstChild("BringPartsGui") then return end

    local BGui = Instance.new("Frame", ScreenGui)
    BGui.Name = "BringPartsGui"
    BGui.Size = UDim2.new(0, 280, 0, 280)
    BGui.Position = UDim2.new(0.1, 0, 0.45, 0)
    BGui.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    BGui.Active = true
    BGui.Draggable = true
    Instance.new("UICorner", BGui).CornerRadius = UDim.new(0, 6)

    local BTitle = Instance.new("TextLabel", BGui)
    BTitle.Size = UDim2.new(1, 0, 0, 30)
    BTitle.Text = "Bring & Orbit Parts Engine"
    BTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    BTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    BTitle.Font = Enum.Font.SourceSansBold
    
    local BClose = Instance.new("TextButton", BGui)
    BClose.Size = UDim2.new(0, 30, 0, 30)
    BClose.Position = UDim2.new(1, -30, 0, 0)
    BClose.Text = "X"
    BClose.TextColor3 = Color3.fromRGB(255, 50, 50)
    BClose.BackgroundTransparency = 1
    BClose.MouseButton1Click:Connect(function() BGui:Destroy() end)

    -- Configuration Variables
    local orbitSpeed = 5
    local orbitRadius = 10
    local orientationType = "Horizontal" -- Horizontal, Vertical, Square, Circle
    local bringActive = false

    -- Speed Control Input Box
    local SpeedFrame = Instance.new("Frame", BGui)
    SpeedFrame.Size = UDim2.new(0.9, 0, 0, 35)
    SpeedFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
    SpeedFrame.BackgroundTransparency = 1

    local SpeedLabel = Instance.new("TextLabel", SpeedFrame)
    SpeedLabel.Size = UDim2.new(0.5, 0, 1, 0)
    SpeedLabel.Text = "Orbit Speed:"
    SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

    local SpeedInput = Instance.new("TextBox", SpeedFrame)
    SpeedInput.Size = UDim2.new(0.4, 0, 0.8, 0)
    SpeedInput.Position = UDim2.new(0.55, 0, 0.1, 0)
    SpeedInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    SpeedInput.Text = "5"
    SpeedInput.TextColor3 = Color3.fromRGB(60, 120, 255)
    SpeedInput.FocusLost:Connect(function()
        orbitSpeed = tonumber(SpeedInput.Text) or 5
    end)

    -- Radius Control Input Box
    local RadiusFrame = Instance.new("Frame", BGui)
    RadiusFrame.Size = UDim2.new(0.9, 0, 0, 35)
    RadiusFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
    RadiusFrame.BackgroundTransparency = 1

    local RadiusLabel = Instance.new("TextLabel", RadiusFrame)
    RadiusLabel.Size = UDim2.new(0.5, 0, 1, 0)
    RadiusLabel.Text = "Orbit Radius:"
    RadiusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    RadiusLabel.TextXAlignment = Enum.TextXAlignment.Left

    local RadiusInput = Instance.new("TextBox", RadiusFrame)
    RadiusInput.Size = UDim2.new(0.4, 0, 0.8, 0)
    RadiusInput.Position = UDim2.new(0.55, 0, 0.1, 0)
    RadiusInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    RadiusInput.Text = "10"
    RadiusInput.TextColor3 = Color3.fromRGB(60, 120, 255)
    RadiusInput.FocusLost:Connect(function()
        orbitRadius = tonumber(RadiusInput.Text) or 10
    end)

    -- Orientation Selection Selector Button
    local OrientBtn = Instance.new("TextButton", BGui)
    OrientBtn.Size = UDim2.new(0.9, 0, 0, 35)
    OrientBtn.Position = UDim2.new(0.05, 0, 0.48, 0)
    OrientBtn.Text = "Orientation: Horizontal"
    OrientBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    OrientBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", OrientBtn).CornerRadius = UDim.new(0, 4)

    local orientations = {"Horizontal", "Vertical", "Square", "Circle"}
    local currentIdx = 1
    OrientBtn.MouseButton1Click:Connect(function()
        currentIdx = currentIdx + 1
        if currentIdx > #orientations then currentIdx = 1 end
        orientationType = orientations[currentIdx]
        OrientBtn.Text = "Orientation: " .. orientationType
    end)

    -- Primary Toggle Trigger Activation Switch
    local ToggleBtn = Instance.new("TextButton", BGui)
    ToggleBtn.Size = UDim2.new(0.9, 0, 0, 40)
    ToggleBtn.Position = UDim2.new(0.05, 0, 0.72, 0)
    ToggleBtn.Text = "Bring Parts: OFF"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 4)

    ToggleBtn.MouseButton1Click:Connect(function()
        bringActive = not bringActive
        ToggleBtn.Text = bringActive and "Bring Parts: ACTIVE" or "Bring Parts: OFF"
        ToggleBtn.BackgroundColor3 = bringActive and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(255, 75, 75)
    end)

    -- Core Assembly Physics Iteration Engine
    task.spawn(function()
        local angle = 0
        while BGui and task.wait() do
            if bringActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local rootPos = LocalPlayer.Character.HumanoidRootPart.Position
                angle = angle + (0.01 * orbitSpeed)
                
                -- Gather all networkable unanchored parts in the simulation world
                local index = 0
                local allParts = {}
                for _, desc in pairs(workspace:GetDescendants()) do
                    if desc:IsA("BasePart") and not desc.Anchored and not desc:IsDescendantOf(LocalPlayer.Character) then
                        table.insert(allParts, desc)
                    end
                end

                local partCount = #allParts
                for i, part in ipairs(allParts) do
                    pcall(function()
                        -- Assert Network Ownership simulation profile parameters
                        if part:FindFirstChildOfClass("BodyPosition") or part:FindFirstChildOfClass("BodyVelocity") then
                            -- Skip parts already targeted by complex tracking variables
                        else
                            -- Calculate offsets based on chosen pattern geometry rules
                            local offset = Vector3.new(0,0,0)
                            local totalAngleOffset = angle + (i * (math.pi * 2 / math.max(partCount, 1)))

                            if orientationType == "Horizontal" or orientationType == "Circle" then
                                offset = Vector3.new(math.cos(totalAngleOffset) * orbitRadius, 0, math.sin(totalAngleOffset) * orbitRadius)
                            elseif orientationType == "Vertical" then
                                offset = Vector3.new(0, math.cos(totalAngleOffset) * orbitRadius, math.sin(totalAngleOffset) * orbitRadius)
                            elseif orientationType == "Square" then
                                local side = i % 4
                                if side == 0 then offset = Vector3.new(orbitRadius, 0, (i/partCount)*orbitRadius)
                                elseif side == 1 then offset = Vector3.new(-orbitRadius, 0, (i/partCount)*orbitRadius)
                                elseif side == 2 then offset = Vector3.new((i/partCount)*orbitRadius, 0, orbitRadius)
                                else offset = Vector3.new((i/partCount)*orbitRadius, 0, -orbitRadius) end
                            end

                            -- Instantly update physical position and strip linear velocity
                            part.AssemblyLinearVelocity = Vector3.new(0,0,0)
                            part.CFrame = CFrame.new(rootPos + offset)
                        end
                     pcall(function() settings().Physics.AllowSleep = false end)
                    end)
                end
            end
        end
    end)
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
-- TAB 2: LOCALPLAYER TAB (REAL UNALTERED IY FLY MECHANICS)
---------------------------------------------------------
local LocalPlayerTab = CreateTab("LocalPlayer")

local targetWalkSpeed = 16
local targetJumpPower = 50
local targetFlySpeed = 50
local flyEnabled = false
local wallhopEnabled = false
local camera = workspace.CurrentCamera

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

AddNumberBox(LocalPlayerTab, "WalkSpeed", 16, function(value)
    targetWalkSpeed = value
end)

AddNumberBox(LocalPlayerTab, "JumpPower", 50, function(value)
    targetJumpPower = value
end)

local IYFlyBodyVelocity
local IYFlyBodyGyro
local IYFlyConnection
local flyKeyDown, flyKeyUp

local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local SPEED = 0

local function stopFlying()
    flyEnabled = false
    if IYFlyConnection then IYFlyConnection:Disconnect() IYFlyConnection = nil end
    if flyKeyDown then flyKeyDown:Disconnect() flyKeyDown = nil end
    if flyKeyUp then flyKeyUp:Disconnect() flyKeyUp = nil end
    if IYFlyBodyVelocity then IYFlyBodyVelocity:Destroy() IYFlyBodyVelocity = nil end
    if IYFlyBodyGyro then IYFlyBodyGyro:Destroy() IYFlyBodyGyro = nil end
    
    local character = LocalPlayer.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
end

local function startFlying()
    stopFlying()
    flyEnabled = true
    
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if not root or not humanoid then return end
    humanoid.PlatformStand = true

    CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    SPEED = 0

    IYFlyBodyGyro = Instance.new("BodyGyro", root)
    IYFlyBodyGyro.P = 9e4
    IYFlyBodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    IYFlyBodyGyro.cframe = root.CFrame

    IYFlyBodyVelocity = Instance.new("BodyVelocity", root)
    IYFlyBodyVelocity.velocity = Vector3.new(0, 0.1, 0)
    IYFlyBodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

    flyKeyDown = Mouse.KeyDown:Connect(function(KEY)
        if KEY:lower() == 'w' then CONTROL.F = targetFlySpeed
        elseif KEY:lower() == 's' then CONTROL.B = -targetFlySpeed
        elseif KEY:lower() == 'a' then CONTROL.L = -targetFlySpeed
        elseif KEY:lower() == 'd' then CONTROL.R = targetFlySpeed
        elseif KEY:lower() == 'e' then CONTROL.Q = targetFlySpeed * 2
        elseif KEY:lower() == 'q' then CONTROL.E = -targetFlySpeed * 2
        end
    end)
    
    flyKeyUp = Mouse.KeyUp:Connect(function(KEY)
        if KEY:lower() == 'w' then CONTROL.F = 0
        elseif KEY:lower() == 's' then CONTROL.B = 0
        elseif KEY:lower() == 'a' then CONTROL.L = 0
        elseif KEY:lower() == 'd' then CONTROL.R = 0
        elseif KEY:lower() == 'e' then CONTROL.Q = 0
        elseif KEY:lower() == 'q' then CONTROL.E = 0
        end
    end)

    IYFlyConnection = RunService.RenderStepped:Connect(function()
        if not flyEnabled or not root or not IYFlyBodyVelocity or not IYFlyBodyGyro then
            stopFlying()
            return
        end
        
        if humanoid then humanoid.PlatformStand = true end
        
        if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
            SPEED = 50
        elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
            SPEED = 0
        end
        
        local mobileMove = humanoid and humanoid.MoveDirection or Vector3.new(0,0,0)
        
        if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 or mobileMove.Magnitude > 0 then
            local workingCamera = workspace.CurrentCamera
            local baseVector = Vector3.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + (CONTROL.Q + CONTROL.E)) * 0.2, (CONTROL.F + CONTROL.B) * 0.4)
            
            if mobileMove.Magnitude > 0 then
                local verticalDirection = 0
                if UserInputService.JumpAxis and UserInputService.JumpAxis.Y > 0 then verticalDirection = targetFlySpeed end
                IYFlyBodyVelocity.velocity = (mobileMove * targetFlySpeed) + Vector3.new(0, verticalDirection, 0)
            else
                IYFlyBodyVelocity.velocity = workingCamera.CFrame:VectorToWorldSpace(baseVector)
            end
            
            lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R, Q = CONTROL.Q, E = CONTROL.E}
        elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
            local workingCamera = workspace.CurrentCamera
            IYFlyBodyVelocity.velocity = workingCamera.CFrame:VectorToWorldSpace(Vector3.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + (lCONTROL.Q + lCONTROL.E)) * 0.2, (lCONTROL.F + lCONTROL.B) * 0.4))
        else
            IYFlyBodyVelocity.velocity = Vector3.new(0, 0, 0)
        end
        
        IYFlyBodyGyro.cframe = workspace.CurrentCamera.CFrame
    end)
end

local FlyToggleBtn = AddButton(LocalPlayerTab, "Fly: OFF", function() end)
FlyToggleBtn.MouseButton1Click:Connect(function()
    if flyEnabled then
        stopFlying()
        FlyToggleBtn.Text = "Fly: OFF"
        FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    else
        startFlying()
        FlyToggleBtn.Text = "Fly: ON"
        FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
    end
end)

AddNumberBox(LocalPlayerTab, "Fly Speed", 50, function(value)
    targetFlySpeed = value
end)

local WhToggleBtn = AddButton(LocalPlayerTab, "Wallhop Engine: OFF", function() end)
WhToggleBtn.MouseButton1Click:Connect(function()
    wallhopEnabled = not wallhopEnabled
    WhToggleBtn.Text = wallhopEnabled and "Wallhop Engine: ON" or "Wallhop Engine: OFF"
    WhToggleBtn.BackgroundColor3 = wallhopEnabled and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(45, 45, 50)
end)

UserInputService.JumpRequest:Connect(function()
    if not wallhopEnabled or flyEnabled then return end
    
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChildOfClass("Humanoid") then
        local root = character.HumanoidRootPart
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = {character}
        
        local direction = root.CFrame.LookVector * 2.5
        local result = workspace:Raycast(root.Position, direction, raycastParams)
        
        if result and result.Instance and result.Instance.CanCollide then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            
            local currentCFrame = camera.CFrame
            local x, y, z = currentCFrame:ToEulerAnglesYXZ()
            camera.CFrame = CFrame.new(currentCFrame.Position) * CFrame.Angles(0, y + 0.785, 0) * CFrame.Angles(x, 0, z)
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    camera = workspace.CurrentCamera
    task.wait(0.5)
    if flyEnabled then startFlying() end
end)

---------------------------------------------------------
-- PLACEHOLDER SECTIONS
---------------------------------------------------------
for tabIndex = 3, 10 do
    local ExtraTab = CreateTab("Tab " .. tabIndex)
    for btnIndex = 1, 20 do
        AddButton(ExtraTab, "Coming Soon", function() end)
    end
end
