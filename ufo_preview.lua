-- Yafi Egg Hub / UFO PREVIEW (2026-11-02)
-- Non-invasive local discovery. No unknown remote events are invoked.
-- Alien biome expected 2026-11-07. Auto reward/steal requires verified event mechanics.
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")
local previous = pg:FindFirstChild("YafiUFOPreview")
if previous then previous:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name="YafiUFOPreview"; gui.ResetOnSpawn=false; gui.Parent=pg
local main=Instance.new("Frame")
main.Name="Panel"; main.Size=UDim2.fromOffset(350,350)
main.Position=UDim2.new(1,-370,.38,0)
main.BackgroundColor3=Color3.fromRGB(12,25,52)
main.Parent=gui
Instance.new("UICorner",main).CornerRadius=UDim.new(0,12)
local stroke=Instance.new("UIStroke",main)
stroke.Color=Color3.fromRGB(49,174,255); stroke.Thickness=2
local function label(text,y,height)
 local o=Instance.new("TextLabel")
 o.BackgroundTransparency=1; o.Position=UDim2.fromOffset(12,y)
 o.Size=UDim2.fromOffset(326,height or 26); o.Text=text
 o.TextColor3=Color3.fromRGB(225,240,255)
 o.Font=Enum.Font.GothamBold; o.TextSize=14
 o.TextXAlignment=Enum.TextXAlignment.Left; o.Parent=main
 return o
end
label("🛸 YAFI UFO / ALIEN TRACKER",12,28)
local state=label("PREVIEW • read-only / event not verified",44,26)
state.TextColor3=Color3.fromRGB(105,210,255)
local detail=label("Searches visible objects in this server.",77,25)
detail.Font=Enum.Font.Gotham
local list=Instance.new("ScrollingFrame",main)
list.Position=UDim2.fromOffset(12,108); list.Size=UDim2.fromOffset(326,184)
list.BackgroundColor3=Color3.fromRGB(22,42,77); list.BorderSizePixel=0
list.ScrollBarThickness=5; list.Parent=main
Instance.new("UICorner",list).CornerRadius=UDim.new(0,7)
local layout=Instance.new("UIListLayout",list)
layout.Padding=UDim.new(0,3)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
 list.CanvasSize=UDim2.fromOffset(0,layout.AbsoluteContentSize.Y+6)
end)
local notes=label("Auto Farm: LOCKED | Auto Steal: LOCKED",300,24)
notes.TextColor3=Color3.fromRGB(255,201,101)
label("Requires verified UFO rewards and egg identifiers.",324,18).TextSize=11

local keywords={"ufo","alien","extraterrestrial","spaceship","saucer"}
local function relevant(name)
 local s=name:lower()
 for _,word in ipairs(keywords) do if s:find(word,1,true) then return true end end
 return false
end
local live=true
local function scan()
 if not live then return end
 local found={}
 for _,obj in ipairs(workspace:GetDescendants()) do
  if (obj:IsA("Model") or obj:IsA("BasePart")) and relevant(obj.Name) then
   -- Only models and their named parts; reduce duplicate entries.
   if not (obj:IsA("BasePart") and obj.Parent and relevant(obj.Parent.Name)) then
    table.insert(found,obj)
   end
  end
 end
 for _,c in ipairs(list:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end
 table.sort(found,function(a,b) return a.Name<b.Name end)
 for i,obj in ipairs(found) do
  if i>25 then break end
  local l=Instance.new("TextLabel")
  l.Size=UDim2.new(1,-6,0,28)
  l.BackgroundTransparency=1
  l.TextColor3=Color3.fromRGB(165,223,255)
  l.Font=Enum.Font.Gotham; l.TextSize=12; l.TextXAlignment=Enum.TextXAlignment.Left
  l.Text="  • "..obj.Name.." ["..obj.ClassName.."]"
  l.LayoutOrder=i; l.Parent=list
 end
 state.Text="Visible UFO/Alien objects: "..#found
 if #found==0 then detail.Text="No matching objects visible in current server." end
end
task.spawn(function()
 while live and gui.Parent do
  pcall(scan)
  task.wait(5)
 end
end)
gui.Destroying:Connect(function() live=false end)
-- The panel is intentionally a separate preview, leaving V4's
-- existing scanner/steal system untouched.
