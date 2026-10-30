-- Yafi Egg Hub v2.0 - LocalScript for Roblox Studio
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
if not player then return end
local parent = player:WaitForChild("PlayerGui")
local old = parent:FindFirstChild("YafiEggHub")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "YafiEggHub"
gui.ResetOnSpawn = false
gui.Parent = parent

local function rounded(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end
local function label(parentObj, text, pos, size, fontSize)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Position = pos
    l.Size = size
    l.Font = Enum.Font.Gotham
    l.TextSize = fontSize or 14
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextColor3 = Color3.fromRGB(238, 242, 255)
    l.Text = text
    l.Parent = parentObj
    return l
end
local main = Instance.new("Frame")
main.Name = "MainWindow"
main.AnchorPoint = Vector2.new(.5, .5)
main.Position = UDim2.fromScale(.5, .5)
main.Size = UDim2.fromOffset(390, 300)
main.BackgroundColor3 = Color3.fromRGB(24, 27, 40)
main.BorderSizePixel = 0
main.Parent = gui
rounded(main, 14)

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 58)
header.BackgroundTransparency = 1
header.Active = true
header.Parent = main
local title = label(header, "YAFI EGG HUB", UDim2.fromOffset(17, 8), UDim2.fromOffset(255, 31), 21)
title.Font = Enum.Font.GothamBold
local version = label(header, "VERSION 2.0", UDim2.fromOffset(19, 36), UDim2.fromOffset(150, 18), 11)
version.TextColor3 = Color3.fromRGB(117, 163, 255)

local function headerButton(text, offset)
    local b = Instance.new("TextButton")
    b.Position = UDim2.new(1, offset, 0, 12)
    b.Size = UDim2.fromOffset(34, 32)
    b.BackgroundColor3 = Color3.fromRGB(49, 56, 77)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 18
    b.Text = text
    b.Parent = header
    rounded(b, 7)
    return b
end
local minimize = headerButton("-", -82)
local close = headerButton("X", -43)

local bar = Instance.new("Frame")
bar.Position = UDim2.fromOffset(15, 64)
bar.Size = UDim2.new(1, -30, 0, 38)
bar.BackgroundTransparency = 1
bar.Parent = main
local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Horizontal
layout.Padding = UDim.new(0, 8)
layout.Parent = bar

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(15, 110)
content.Size = UDim2.new(1, -30, 1, -122)
content.BackgroundColor3 = Color3.fromRGB(35, 40, 58)
content.BorderSizePixel = 0
content.Parent = main
rounded(content, 10)

local pages, tabs = {}, {}
local function addTab(name)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.fromOffset(110, 34)
    tab.Text = name
    tab.Font = Enum.Font.GothamSemibold
    tab.TextSize = 14
    tab.TextColor3 = Color3.new(1, 1, 1)
    tab.BackgroundColor3 = Color3.fromRGB(48, 54, 75)
    tab.Parent = bar
    rounded(tab, 8)
    tabs[name] = tab

    local page = Instance.new("Frame")
    page.Name = name
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content
    pages[name] = page
    return page
end
local home = addTab("Home")
local settings = addTab("Settings")
local about = addTab("About")
local function selectPage(name)
    for key, page in pairs(pages) do
        local selected = (key == name)
        page.Visible = selected
        tabs[key].BackgroundColor3 = selected and Color3.fromRGB(55, 103, 215) or Color3.fromRGB(48, 54, 75)
    end
end
for name, tab in pairs(tabs) do
    tab.MouseButton1Click:Connect(function() selectPage(name) end)
end

local welcome = label(home, "Welcome to Yafi Egg Hub!", UDim2.fromOffset(16, 17), UDim2.new(1, -32, 0, 30), 18)
welcome.Font = Enum.Font.GothamBold
label(home, "Your personal Roblox interface.", UDim2.fromOffset(16, 52), UDim2.new(1, -32, 0, 25), 13)
local status = label(home, "Status: Ready", UDim2.fromOffset(16, 106), UDim2.new(1, -32, 0, 28), 14)
status.TextColor3 = Color3.fromRGB(105, 229, 160)

label(settings, "Settings", UDim2.fromOffset(16, 17), UDim2.fromOffset(220, 30), 18)
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.fromOffset(220, 36)
toggle.Position = UDim2.fromOffset(16, 64)
toggle.Text = "Status indicator: ON"
toggle.Font = Enum.Font.GothamMedium
toggle.TextSize = 13
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.BackgroundColor3 = Color3.fromRGB(55, 67, 92)
toggle.Parent = settings
rounded(toggle, 8)
local enabled = true
toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    status.Visible = enabled
    toggle.Text = enabled and "Status indicator: ON" or "Status indicator: OFF"
end)

label(about, "Yafi Egg Hub v2.0", UDim2.fromOffset(16, 18), UDim2.new(1, -32, 0, 30), 18)
label(about, "Made for learning Roblox UI scripting.", UDim2.fromOffset(16, 56), UDim2.new(1, -32, 0, 30), 13)

local collapsed = false
minimize.MouseButton1Click:Connect(function()
    collapsed = not collapsed
    bar.Visible = not collapsed
    content.Visible = not collapsed
    main.Size = collapsed and UDim2.fromOffset(390, 58) or UDim2.fromOffset(390, 300)
    minimize.Text = collapsed and "+" or "-"
end)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

local dragging, dragStart, startPos, dragInput = false, nil, nil, nil
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
selectPage("Home")
print("Yafi Egg Hub v2.0 loaded")
