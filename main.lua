-- YAFI EGG HUB V3.0
-- Blue game-inspired UI | Client-side interface
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
if not player then return end
local playerGui = player:WaitForChild("PlayerGui")
local prior = playerGui:FindFirstChild("YafiEggHub")
if prior then prior:Destroy() end

local C = {
    navy = Color3.fromRGB(12, 53, 125),
    blue = Color3.fromRGB(18, 112, 245),
    sky = Color3.fromRGB(65, 184, 255),
    light = Color3.fromRGB(211, 241, 255),
    white = Color3.fromRGB(255, 255, 255),
    ink = Color3.fromRGB(19, 69, 138),
    pale = Color3.fromRGB(233, 247, 255),
    green = Color3.fromRGB(38, 197, 129)
}
local function round(obj, r)
    local x = Instance.new("UICorner")
    x.CornerRadius = UDim.new(0, r)
    x.Parent = obj
end
local function stroke(obj, color, width)
    local x = Instance.new("UIStroke")
    x.Color = color
    x.Thickness = width or 2
    x.Parent = obj
end
local function gradient(obj, top, bottom, rotation)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(top, bottom)
    g.Rotation = rotation or 90
    g.Parent = obj
end
local function text(parent, value, pos, size, fontSize, color, bold)
    local t = Instance.new("TextLabel")
    t.BackgroundTransparency = 1
    t.Position = pos
    t.Size = size
    t.Text = value
    t.Font = bold and Enum.Font.GothamBold or Enum.Font.GothamMedium
    t.TextSize = fontSize
    t.TextColor3 = color or C.white
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = parent
    return t
end
local function button(parent, name, pos, size)
    local b = Instance.new("TextButton")
    b.Name = name
    b.Position = pos
    b.Size = size
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 15
    b.TextColor3 = C.white
    b.BackgroundColor3 = C.blue
    b.AutoButtonColor = true
    b.Parent = parent
    round(b, 13)
    stroke(b, Color3.fromRGB(137, 222, 255), 2)
    return b
end

local gui = Instance.new("ScreenGui")
gui.Name = "YafiEggHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(.5, .5)
shadow.Position = UDim2.new(.5, 7, .5, 10)
shadow.Size = UDim2.fromOffset(428, 356)
shadow.BackgroundColor3 = Color3.fromRGB(4, 27, 74)
shadow.BackgroundTransparency = .38
shadow.BorderSizePixel = 0
shadow.Parent = gui
round(shadow, 24)

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(.5, .5)
main.Position = UDim2.fromScale(.5, .5)
main.Size = UDim2.fromOffset(428, 356)
main.BackgroundColor3 = C.navy
main.BorderSizePixel = 0
main.Parent = gui
round(main, 24)
stroke(main, C.light, 3)
gradient(main, C.sky, C.blue, 90)

local header = Instance.new("Frame")
header.Name = "DragArea"
header.Size = UDim2.new(1, -12, 0, 78)
header.Position = UDim2.fromOffset(6, 5)
header.BackgroundTransparency = 1
header.Active = true
header.Parent = main
local logo = text(header, "🥚  YAFI EGG HUB", UDim2.fromOffset(16, 10), UDim2.new(1, -130, 0, 34), 22, C.white, true)
local subtitle = text(header, "BLUE EDITION  •  V3.0", UDim2.fromOffset(24, 46), UDim2.new(1, -150, 0, 18), 11, C.light, true)

local mini = button(header, "–", UDim2.new(1, -98, 0, 15), UDim2.fromOffset(39, 37))
mini.TextSize = 22
local exit = button(header, "X", UDim2.new(1, -52, 0, 15), UDim2.fromOffset(39, 37))

local panel = Instance.new("Frame")
panel.Name = "InnerPanel"
panel.Position = UDim2.fromOffset(14, 83)
panel.Size = UDim2.new(1, -28, 1, -98)
panel.BackgroundColor3 = C.pale
panel.BorderSizePixel = 0
panel.Parent = main
round(panel, 18)
stroke(panel, Color3.fromRGB(166, 226, 255), 2)

local tabbar = Instance.new("Frame")
tabbar.Position = UDim2.fromOffset(12, 12)
tabbar.Size = UDim2.new(1, -24, 0, 46)
tabbar.BackgroundTransparency = 1
tabbar.Parent = panel
local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Horizontal
layout.Padding = UDim.new(0, 8)
layout.Parent = tabbar

local body = Instance.new("Frame")
body.Position = UDim2.fromOffset(12, 70)
body.Size = UDim2.new(1, -24, 1, -82)
body.BackgroundColor3 = C.white
body.BorderSizePixel = 0
body.Parent = panel
round(body, 15)
stroke(body, Color3.fromRGB(190, 228, 255), 1)

local pages, tabs = {}, {}
local function makeTab(name, symbol)
    local b = button(tabbar, symbol .. " " .. name, UDim2.new(), UDim2.new(1/3, -6, 0, 42))
    b.Name = name
    b.TextSize = 13
    tabs[name] = b
    local p = Instance.new("Frame")
    p.Name = name
    p.Size = UDim2.fromScale(1, 1)
    p.BackgroundTransparency = 1
    p.Visible = false
    p.Parent = body
    pages[name] = p
    return p
end
local home = makeTab("Home", "⌂")
local settings = makeTab("Settings", "⚙")
local about = makeTab("About", "★")
local function selectTab(name)
    for key, page in pairs(pages) do
        local active = (key == name)
        page.Visible = active
        tabs[key].BackgroundColor3 = active and C.blue or Color3.fromRGB(95, 179, 231)
        tabs[key].TextColor3 = C.white
    end
end
for name, b in pairs(tabs) do
    b.MouseButton1Click:Connect(function() selectTab(name) end)
end

text(home, "WELCOME, PLAYER!", UDim2.fromOffset(18, 18), UDim2.new(1, -36, 0, 32), 21, C.ink, true)
text(home, "Your very own blue egg hub.", UDim2.fromOffset(18, 55), UDim2.new(1, -36, 0, 24), 14, C.ink, false)
local status = text(home, "●  HUB READY", UDim2.fromOffset(18, 105), UDim2.new(1, -36, 0, 28), 16, C.green, true)

text(settings, "SETTINGS", UDim2.fromOffset(18, 17), UDim2.new(1, -36, 0, 30), 20, C.ink, true)
local toggle = button(settings, "STATUS INDICATOR: ON", UDim2.fromOffset(18, 65), UDim2.fromOffset(242, 42))
local statusOn = true
toggle.MouseButton1Click:Connect(function()
    statusOn = not statusOn
    status.Visible = statusOn
    toggle.Text = statusOn and "STATUS INDICATOR: ON" or "STATUS INDICATOR: OFF"
end)
text(about, "YAFI EGG HUB V3.0", UDim2.fromOffset(18, 20), UDim2.new(1, -36, 0, 30), 20, C.ink, true)
text(about, "Blue game-inspired interface.", UDim2.fromOffset(18, 65), UDim2.new(1, -36, 0, 24), 14, C.ink, false)
text(about, "UI only — gameplay tools not added yet.", UDim2.fromOffset(18, 98), UDim2.new(1, -36, 0, 24), 12, C.ink, false)

local collapsed = false
mini.MouseButton1Click:Connect(function()
    collapsed = not collapsed
    panel.Visible = not collapsed
    main.Size = collapsed and UDim2.fromOffset(428, 82) or UDim2.fromOffset(428, 356)
    shadow.Size = main.Size
    mini.Text = collapsed and "+" or "–"
end)
exit.MouseButton1Click:Connect(function() gui:Destroy() end)

local dragging, dragInput, startInput, startPosition = false, nil, nil, nil
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        startInput = input.Position
        startPosition = main.Position
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
        local d = input.Position - startInput
        main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + d.X, startPosition.Y.Scale, startPosition.Y.Offset + d.Y)
        shadow.Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset + 7, main.Position.Y.Scale, main.Position.Y.Offset + 10)
    end
end)
selectTab("Home")
print("Yafi Egg Hub v3.0 loaded!")
