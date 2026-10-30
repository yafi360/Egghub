-- YAFI EGG HUB • V4.0 / NEON BLUE
-- Cosmetic interface only. Roblox LocalScript.
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
if not player then return end
local parent = player:WaitForChild("PlayerGui")
local previous = parent:FindFirstChild("YafiEggHub")
if previous then previous:Destroy() end

local P = {
  deep=Color3.fromRGB(9,19,44), navy=Color3.fromRGB(16,31,65),
  panel=Color3.fromRGB(23,43,82), line=Color3.fromRGB(50,85,141),
  blue=Color3.fromRGB(36,117,252), cyan=Color3.fromRGB(61,213,255),
  text=Color3.fromRGB(240,248,255), muted=Color3.fromRGB(144,175,215),
  green=Color3.fromRGB(72,230,172)
}
local function ui(class, parent, props)
  local o=Instance.new(class)
  for k,v in pairs(props or {}) do o[k]=v end
  o.Parent=parent
  return o
end
local function round(o,r)
  ui("UICorner",o,{CornerRadius=UDim.new(0,r)})
end
local function line(o,c,t)
  ui("UIStroke",o,{Color=c or P.line,Thickness=t or 1})
end
local function grad(o,a,b,rot)
  ui("UIGradient",o,{Color=ColorSequence.new(a,b),Rotation=rot or 0})
end
local function txt(p,s,x,y,w,h,size,color,bold)
  return ui("TextLabel",p,{Text=s,Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),
    BackgroundTransparency=1,Font=bold and Enum.Font.GothamBold or Enum.Font.GothamMedium,
    TextColor3=color or P.text,TextSize=size,TextXAlignment=Enum.TextXAlignment.Left,
    TextTruncate=Enum.TextTruncate.AtEnd})
end
local function btn(p,s,x,y,w,h,bg)
  local o=ui("TextButton",p,{Text=s,Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),
    BackgroundColor3=bg or P.panel,BorderSizePixel=0,AutoButtonColor=true,
    Font=Enum.Font.GothamBold,TextSize=13,TextColor3=P.text})
  round(o,10)
  return o
end

local gui=ui("ScreenGui",parent,{Name="YafiEggHub",ResetOnSpawn=false,
  ZIndexBehavior=Enum.ZIndexBehavior.Sibling})
local shadow=ui("Frame",gui,{Size=UDim2.fromOffset(444,306),AnchorPoint=Vector2.new(.5,.5),
  Position=UDim2.new(.5,6,.5,8),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=.45,
  BorderSizePixel=0})
round(shadow,19)
local main=ui("Frame",gui,{Size=UDim2.fromOffset(444,306),AnchorPoint=Vector2.new(.5,.5),
  Position=UDim2.fromScale(.5,.5),BackgroundColor3=P.deep,BorderSizePixel=0})
round(main,18)
line(main,P.line,1.5)
local top=ui("Frame",main,{Size=UDim2.new(1,0,0,59),BackgroundColor3=P.navy,BorderSizePixel=0})
round(top,18)
local topMask=ui("Frame",top,{Position=UDim2.fromOffset(0,37),Size=UDim2.new(1,0,0,23),
  BorderSizePixel=0,BackgroundColor3=P.navy})
local dragArea=ui("Frame",top,{Size=UDim2.fromOffset(325,59),BackgroundTransparency=1,Active=true})
local orb=ui("Frame",top,{Position=UDim2.fromOffset(16,13),Size=UDim2.fromOffset(34,34),
  BackgroundColor3=P.blue,BorderSizePixel=0})
round(orb,11)
grad(orb,P.cyan,P.blue,45)
txt(orb,"Y",11,3,18,28,20,P.text,true)
txt(top,"YAFI / EGG HUB",60,9,252,27,17,P.text,true)
txt(top,"NEON BLUE    •    V4.0",61,34,240,17,10,P.cyan,true)
local minimize=btn(top,"—",363,14,29,29,P.panel)
local close=btn(top,"×",400,14,29,29,Color3.fromRGB(85,43,76))
close.TextSize=20

local sidebar=ui("Frame",main,{Position=UDim2.fromOffset(9,68),Size=UDim2.fromOffset(111,229),
  BackgroundColor3=P.navy,BorderSizePixel=0})
round(sidebar,12)
local tabButtons={}
for i,item in ipairs({{"HOME","⌂"},{"TOOLS","✦"},{"SETTINGS","⚙"},{"ABOUT","?"}}) do
  local b=btn(sidebar,item[2].."  "..item[1],8,10+(i-1)*46,95,39,P.navy)
  b.TextSize=12
  tabButtons[item[1]]=b
end
txt(sidebar,"YAFI  •  2026",14,204,90,15,9,P.muted,true)

local content=ui("Frame",main,{Position=UDim2.fromOffset(129,68),Size=UDim2.fromOffset(306,229),
  BackgroundColor3=P.navy,BorderSizePixel=0})
round(content,12)
line(content,P.line,1)
local pages={}
local function page(name)
  local f=ui("Frame",content,{Name=name,Size=UDim2.fromScale(1,1),
    BackgroundTransparency=1,Visible=false})
  pages[name]=f
  return f
end
local home=page("HOME")
local tools=page("TOOLS")
local settings=page("SETTINGS")
local about=page("ABOUT")

txt(home,"YOUR COMMAND DECK",17,16,272,25,16,P.text,true)
txt(home,"A little blue energy for your game.",17,44,270,20,11,P.muted,false)
local hero=ui("Frame",home,{Position=UDim2.fromOffset(15,76),Size=UDim2.fromOffset(276,91),
  BackgroundColor3=P.blue,BorderSizePixel=0})
round(hero,12)
grad(hero,Color3.fromRGB(21,115,238),Color3.fromRGB(19,57,133),0)
txt(hero,"EGG HUB",16,13,175,31,22,P.text,true)
txt(hero,"Interface online",17,49,190,22,12,Color3.fromRGB(222,244,255))
txt(hero,"✦",232,24,40,42,29,P.cyan,true)
local statusDot=ui("Frame",home,{Position=UDim2.fromOffset(18,187),Size=UDim2.fromOffset(8,8),
  BackgroundColor3=P.green,BorderSizePixel=0})
round(statusDot,5)
txt(home,"READY TO EXPLORE",34,179,245,23,12,P.green,true)

txt(tools,"TOOLBOX",17,16,265,27,17,P.text,true)
txt(tools,"A home for upcoming game tools.",17,49,268,24,12,P.muted)
local toolCard=ui("Frame",tools,{Position=UDim2.fromOffset(15,86),Size=UDim2.fromOffset(276,91),
  BackgroundColor3=P.panel,BorderSizePixel=0})
round(toolCard,12)
line(toolCard,P.line)
txt(toolCard,"✦  NEW FEATURES",16,12,250,26,15,P.cyan,true)
txt(toolCard,"This is a UI-only preview.",16,48,240,25,12,P.muted)

txt(settings,"CUSTOMIZE",17,16,270,27,17,P.text,true)
txt(settings,"Your hub, your vibe.",17,44,260,22,12,P.muted)
local glowButton=btn(settings,"GLOW ACCENT   ON",16,83,273,42,P.blue)
local glowOn=true
local function setGlow()
  orb.BackgroundColor3=glowOn and P.blue or P.panel
  glowButton.Text=glowOn and "GLOW ACCENT   ON" or "GLOW ACCENT   OFF"
  glowButton.BackgroundColor3=glowOn and P.blue or P.panel
  hero.BackgroundColor3=glowOn and P.blue or P.panel
end
glowButton.MouseButton1Click:Connect(function()
  glowOn=not glowOn
  setGlow()
end)
txt(settings,"Changes apply instantly.",17,146,265,23,11,P.muted)

txt(about,"ABOUT YAFI",17,17,272,28,17,P.text,true)
txt(about,"EGG HUB  •  VERSION 4.0",17,55,274,22,12,P.cyan,true)
txt(about,"Built as a custom Roblox interface.",17,95,273,23,12,P.muted)
txt(about,"Blue arcade style. Clean and compact.",17,125,278,23,12,P.muted)

local function selectTab(name)
  for key,p in pairs(pages) do
    p.Visible=(key==name)
    tabButtons[key].BackgroundColor3=(key==name) and P.blue or P.navy
  end
end
for name,b in pairs(tabButtons) do
  b.MouseButton1Click:Connect(function() selectTab(name) end)
end
selectTab("HOME")

local reopen=btn(gui,"Y",18,175,45,45,P.blue)
reopen.Visible=false
reopen.TextSize=22
line(reopen,P.cyan,2)
local function visible(on)
  main.Visible=on
  shadow.Visible=on
  reopen.Visible=not on
end
minimize.MouseButton1Click:Connect(function() visible(false) end)
reopen.MouseButton1Click:Connect(function() visible(true) end)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

local dragging=false
local startPointer,startPosition,dragInput
dragArea.InputBegan:Connect(function(input)
  if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
    dragging=true
    startPointer=input.Position
    startPosition=main.Position
    input.Changed:Connect(function()
      if input.UserInputState==Enum.UserInputState.End then dragging=false end
    end)
  end
end)
dragArea.InputChanged:Connect(function(input)
  if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
    dragInput=input
  end
end)
UIS.InputChanged:Connect(function(input)
  if dragging and input==dragInput then
    local d=input.Position-startPointer
    main.Position=UDim2.new(startPosition.X.Scale,startPosition.X.Offset+d.X,
      startPosition.Y.Scale,startPosition.Y.Offset+d.Y)
    shadow.Position=UDim2.new(main.Position.X.Scale,main.Position.X.Offset+6,
      main.Position.Y.Scale,main.Position.Y.Offset+8)
  end
end)
print("Yafi Egg Hub V4.0 loaded")
