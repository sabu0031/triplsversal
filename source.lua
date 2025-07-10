-- Modern Sleek UI Library for Roblox
-- Create Variables for Roblox Services
local coreGui = game:GetService("CoreGui")
local httpService = game:GetService("HttpService")
local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local guiService = game:GetService("GuiService")
local statsService = game:GetService("Stats")
local starterGui = game:GetService("StarterGui")
local teleportService = game:GetService("TeleportService")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService('UserInputService')
local gameSettings = UserSettings():GetService("UserGameSettings")

-- Variables
local camera = workspace.CurrentCamera
local getMessage = replicatedStorage:WaitForChild("DefaultChatSystemChatEvents", 1) and replicatedStorage.DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering", 1)
local localPlayer = players.LocalPlayer
local notifications = {}
local friendsCooldown = 0
local mouse = localPlayer:GetMouse()
local promptedDisconnected = false
local smartBarOpen = false
local debounce = false
local searchingForPlayer = false
local musicQueue = {}
local currentAudio
local lowerName = localPlayer.Name:lower()
local lowerDisplayName = localPlayer.DisplayName:lower()
local placeId = game.PlaceId
local jobId = game.JobId
local checkingForKey = false
local originalTextValues = {}
local creatorId = game.CreatorId
local noclipDefaults = {}
local movers = {}
local creatorType = game.CreatorType
local espContainer = Instance.new("Folder", gethui and gethui() or coreGui)
local oldVolume = gameSettings.MasterVolume
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Library = {}
Library.__index = Library

-- Theme settings
local Theme = {
    Background = Color3.fromRGB(25, 25, 35),
    Accent = Color3.fromRGB(0, 170, 255),
    Text = Color3.fromRGB(240, 240, 240),
    Outline = Color3.fromRGB(50, 50, 60),
    Font = Enum.Font.Gotham,
}

-- Tween utility
local function tween(obj, props, duration)
    TweenService:Create(obj, TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

-- Create a new window
function Library:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SleekUILib"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 500, 0, 350)
    main.Position = UDim2.new(0.5, -250, 0.5, -175)
    main.BackgroundColor3 = Theme.Background
    main.BorderSizePixel = 0
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.Parent = screenGui

    local uicorner = Instance.new("UICorner", main)
    uicorner.CornerRadius = UDim.new(0, 10)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "UI Library"
    titleLabel.TextColor3 = Theme.Text
    titleLabel.Font = Theme.Font
    titleLabel.TextSize = 20
    titleLabel.Parent = main

    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, -20, 1, -60)
    tabContainer.Position = UDim2.new(0, 10, 0, 50)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Name = "TabContainer"
    tabContainer.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = tabContainer

    local Window = {}

    function Window:CreateButton(text, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 40)
        button.BackgroundColor3 = Theme.Outline
        button.Text = text
        button.TextColor3 = Theme.Text
        button.Font = Theme.Font
        button.TextSize = 16
        button.AutoButtonColor = false
        button.Parent = tabContainer

        local corner = Instance.new("UICorner", button)
        corner.CornerRadius = UDim.new(0, 6)

        button.MouseEnter:Connect(function()
            tween(button, {BackgroundColor3 = Theme.Accent})
        end)
        button.MouseLeave:Connect(function()
            tween(button, {BackgroundColor3 = Theme.Outline})
        end)

        button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
    end

    function Window:CreateToggle(text, default, callback)
        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.new(1, 0, 0, 40)
        toggle.BackgroundColor3 = Theme.Outline
        toggle.Text = ""
        toggle.AutoButtonColor = false
        toggle.Parent = tabContainer

        local corner = Instance.new("UICorner", toggle)
        corner.CornerRadius = UDim.new(0, 6)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -40, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Theme.Text
        label.Font = Theme.Font
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = toggle

        local state = default or false
        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 20, 0, 20)
        indicator.Position = UDim2.new(1, -30, 0.5, -10)
        indicator.BackgroundColor3 = state and Theme.Accent or Theme.Background
        indicator.Parent = toggle

        local indCorner = Instance.new("UICorner", indicator)
        indCorner.CornerRadius = UDim.new(1, 0)

        toggle.MouseButton1Click:Connect(function()
            state = not state
            tween(indicator, {BackgroundColor3 = state and Theme.Accent or Theme.Background})
            if callback then callback(state) end
        end)
    end

    function Window:CreateLabel(text)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 30)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Theme.Text
        label.Font = Theme.Font
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = tabContainer
    end

    return Window
end

return Library
