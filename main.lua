
-- Yafi Egg Hub
-- Version 1.0

local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("Yafi Egg Hub loaded!")

local gui = Instance.new("ScreenGui")
gui.Name = "YafiEggHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(300, 180)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "YAFI EGG HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Parent = frame
