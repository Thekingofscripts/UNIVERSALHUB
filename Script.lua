-- Jim's Universal Hub (Educational UI Demo)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local RightPanel = Instance.new("Frame")
local TabContainer = Instance.new("ScrollingFrame")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "JimsUniversalHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Main Window Styling
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

-- Title
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

-- Navigation Sidebar
LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
LeftPanel.Position = UDim2.new(0, 10, 0, 50)
LeftPanel.Size = UDim2.new(0, 130, 0, 285)

TabContainer.Name = "TabContainer"
TabContainer.Parent = LeftPanel
TabContainer.BackgroundTransparency = 1
TabContainer.Size = UDim2.new(1, 0, 1, 0)
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 400)
TabContainer.ScrollBarThickness = 2

local TabLayout = Instance.new("UIListLayout", TabContainer)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)

-- Content Area
RightPanel.Name = "RightPanel"
RightPanel.Parent = MainFrame
RightPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
RightPanel.Position = UDim2.new(0, 150, 0, 50)
RightPanel.Size = UDim2.new(0, 390, 0, 285)

local PageContainer = Instance.new("Frame", RightPanel)
PageContainer.Size = UDim2.new(1, 0, 1, 0)
PageContainer.BackgroundTransparency = 1

local PageLayout = Instance.new("UIListLayout", PageContainer)
PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
PageLayout.Padding = UDim.new(0, 6)

---------------------------------------------------------
-- HELPER FUNCTIONS FOR CREATING TABS & BUTTONS
---------------------------------------------------------
local pages = {}
local firstPage = nil

local function CreateTab(tabName)
    local TabButton = Instance.new("TextButton", TabContainer)
    TabButton.Size = UDim2.new(1, -10, 0, 30)
    TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.SourceSans

    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, -10, 1, -10)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 0, 600)
    Page.ScrollBarThickness = 4
    
    local ContentLayout = Instance.new("UIListLayout", Page)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 6)

    if not firstPage then
        firstPage = Page
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    TabButton.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        Page.Visible = true
    end)

    table.insert(pages, Page)
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
    
    Button.MouseButton1Click:Connect(callback)
    return Button
end

---------------------------------------------------------
-- GENERATING THE 10 TABS AND BUTTONS
---------------------------------------------------------

-- Tab 1: Main
local MainTab = CreateTab("Main")

-- Tab 1 - Button 1: Run IY
AddButton(MainTab, "Run IY", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- Tab 1 - Button 2: Wallhop Script
AddButton(MainTab, "Wallhop Script", function()
    -- Physics hack for multi-part climbing mechanics
    game:GetService("UserInputService").JumpRequest:Connect(function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local ray = Ray.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.CFrame.LookVector * 2)
            local part = workspace:FindPartOnRay(ray, character)
            if part then
                character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end)

-- Tab 1 - Button 3: Sell Elmons
AddButton(MainTab, "Sell Elmons", function()
    -- Creates a separate individual sub-GUI interface popup
    local SubGui = Instance.new("Frame", ScreenGui)
    SubGui.Size = UDim2.new(0, 220, 0, 160)
    SubGui.Position = UDim2.new(0.4, 0, 0.4, 0)
    SubGui.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    SubGui.Active = true
    SubGui.Draggable = true

    local SubTitle = Instance.new("TextLabel", SubGui)
    SubTitle.Size = UDim2.new(1, 0, 0, 30)
    SubTitle.Text = "Lemon Tycoon Helper"
    SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    
    local CloseBtn = Instance.new("TextButton", SubGui)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -30, 0, 0)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.MouseButton1Click:Connect(function() SubGui:Destroy() end)

    local AutoSellBtn = Instance.new("TextButton", SubGui)
    AutoSellBtn.Size = UDim2.new(0.9, 0, 0, 35)
    AutoSellBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
    AutoSellBtn.Text = "Toggle Auto Sell"
    AutoSellBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    AutoSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

    local AutoUpgradeBtn = Instance.new("TextButton", SubGui)
    AutoUpgradeBtn.Size = UDim2.new(0.9, 0, 0, 35)
    AutoUpgradeBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
    AutoUpgradeBtn.Text = "Toggle Auto Upgrade"
    AutoUpgradeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    AutoUpgradeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Game loop logic simulations based on Lemon game design systems
    local selling = false
    AutoSellBtn.MouseButton1Click:Connect(function()
        selling = not selling
        AutoSellBtn.BackgroundColor3 = selling and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(40, 40, 45)
        task.spawn(function()
            while selling do
                -- Simulates contacting standard game environment sell points
                local sellPart = workspace:FindFirstChild("Sell") or workspace:FindFirstChild("SellPart")
                if sellPart and game.Players.LocalPlayer.Character then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, sellPart, 0)
                    task.wait(0.1)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, sellPart, 1)
                end
                task.wait(1)
            end
        end)
    end)

    local upgrading = false
    AutoUpgradeBtn.MouseButton1Click:Connect(function()
        upgrading = not upgrading
        AutoUpgradeBtn.BackgroundColor3 = upgrading and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(40, 40, 45)
        task.spawn(function()
            while upgrading do
                -- Standard loop remote event fires for tycoon upgrades
                local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                if remotes then
                    local upgradeRemote = remotes:FindFirstChild("Upgrade") or remotes:FindFirstChild("BuyUpgrade")
                    if upgradeRemote then
                        upgradeRemote:FireServer()
                    end
                end
                task.wait(2)
            end
        end)
    end)
end)

-- Complete filling remaining 17 actions for Main page
for i = 4, 20 do
    AddButton(MainTab, "Coming Soon (" .. i .. ")", function() print("Coming soon!") end)
end

-- Create Remaining 9 Empty System Tabs, each loaded with 20 dummy indicators
for tabIndex = 2, 10 do
    local ExtraTab = CreateTab("Tab " .. tabIndex)
    for btnIndex = 1, 20 do
        AddButton(ExtraTab, "Coming Soon", function() end)
    end
end
