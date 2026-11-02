-- YAFI EGG HUB • V4.0 / NEON BLUE
-- Cosmetic interface only. Roblox LocalScript.
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local PathfindingService = game:GetService("PathfindingService")
local player = Players.LocalPlayer
if not player then return end
local parent = player:WaitForChild("PlayerGui")
local previous = parent:FindFirstChild("YafiEggHub")
if previous then previous:Destroy() end
-- Reset stale state from a previous execution.
_G.YafiPickupBusy=false
_G.YafiTripToken=(_G.YafiTripToken or 0)+1
_G.YafiSavedSpeed=nil

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
  ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=10000})
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

-- EGG FINDER: restored from EggFinder_V6.lua (current-server snapshot)
local RS=game:GetService("ReplicatedStorage")

local assets,mutationModule
pcall(function() assets=require(RS.Data.Assets).Directory end)
pcall(function() mutationModule=require(RS.Shared.Modules.Mutations) end)
local function iconId(v)
 if type(v)=="table" then v=v.Image or v.ImageId or v.AssetId or v.Id end
 if type(v)=="number" then return "rbxassetid://"..v end
 if type(v)=="string" then
  if v:match("^%d+$") then return "rbxassetid://"..v end
  if v:match("^rbxassetid://") or v:match("^rbxasset://") then return v end
 end
 return ""
end
local function earned(e,base)
 if not base or not mutationModule or type(mutationModule.EarningsFor)~="function" then return nil end
 local names={}
 if e.BaseMutation and e.BaseMutation~="None" then table.insert(names,tostring(e.BaseMutation)) end
 if type(e.Mutations)=="table" then
  for _,m in pairs(e.Mutations) do if type(m)=="string" then table.insert(names,m) end end
 end
 local ok,m=pcall(mutationModule.EarningsFor,names)
 if ok and type(m)=="number" and m>0 then
  return base*math.max(tonumber(e.AssetScale) or 1,0)^1.85*m
 end
end
local rarityColors={
 common="#BFC9D9", uncommon="#74E88E", rare="#52B9FF",
 epic="#B98AFF", legendary="#FFD45D", mythic="#FF6FAE",
 mythical="#FF6FAE", divine="#FFDB66", secret="#FF555F",
 celestial="#82F8FF", exclusive="#FFB477",
 cosmic="#54E8FF", eternal="#FF8A3D", brainrot="#FF82D6",
 monster="#A4F45C", event="#FFCB60"
}
local function rarityHex(rarity)
 if typeof(rarity)=="Color3" then
  return string.format("#%02X%02X%02X",math.floor(rarity.R*255+.5),math.floor(rarity.G*255+.5),math.floor(rarity.B*255+.5))
 end
 local key=tostring(rarity or ""):lower():gsub("<[^>]*>",""):gsub("[^%a]","")
 -- Prefer exact tier; avoid matching "rare" inside a longer word.
 if rarityColors[key] then return rarityColors[key] end
 for word,color in pairs(rarityColors) do
  if key:find(word,1,true) then return color end
 end
 return "#F0F8FF"
end
local function richSafe(s)
 return tostring(s or ""):gsub("&","&amp;"):gsub("<","&lt;"):gsub(">","&gt;")
end

local database,dbCount={},0
local databaseRarity={}
local function normalize(s)
  return tostring(s or ""):lower():gsub("[^%w]","")
end
local function incomeNum(s)
  s=tostring(s or ""):gsub(",","")
  local v,unit=s:match("%$?%s*([%d%.]+)%s*([KkMmBbTt]?)%s*/?s?")
  if not v then return nil end
  return tonumber(v)*(({K=1e3,M=1e6,B=1e9,T=1e12})[unit:upper()] or 1)
end
local function money(n)
  if not n then return "Unknown base" end
  if n>=1e12 then return string.format("$%.1fT/s",n/1e12) end
  if n>=1e9 then return string.format("$%.1fB/s",n/1e9) end
  if n>=1e6 then return string.format("$%.1fM/s",n/1e6) end
  if n>=1e3 then return string.format("$%.1fK/s",n/1e3) end
  return string.format("$%.0f/s",n)
end
local function clean(s)
  return tostring(s or ""):gsub("<[^>]*>",""):gsub("&amp;","&")
    :gsub("&nbsp;"," "):gsub("^%s+",""):gsub("%s+$","")
end
local function fetchDatabase()
  local ok,html=pcall(function() return game:HttpGet("https://stealaneggindex.com/") end)
  if not ok or type(html)~="string" then return end
  for tr in html:gmatch("<tr[^>]*>(.-)</tr>") do
    local cells={}
    for td in tr:gmatch("<td[^>]*>(.-)</td>") do
      cells[#cells+1]=clean(td)
    end
    if #cells>=4 then
      local key=normalize(cells[2])
      local value=incomeNum(cells[4])
      if key~="" and value and cells[4]:find("%$") and not database[key] then
        database[key]=value
        databaseRarity[key]=clean(cells[3] or "")
        dbCount=dbCount+1
      end
    end
  end
end

txt(tools,"LIVE EGG FINDER",17,11,270,25,17,P.text,true)
txt(tools,"Current server • ranked by base $/s",17,40,270,20,11,P.muted)
local finderButton=btn(tools,"OPEN EGG FINDER",16,81,274,42,P.blue)
txt(tools,"Refreshes every 5 seconds when open.",17,137,274,22,11,P.muted)

-- Compact launcher above the game's egg menu (right-side HUD).
-- Transparent touch target; the Pokeball itself is a true circular frame.
local eggLauncher=btn(gui,"",0,0,56,56,P.blue)
eggLauncher.Name="EggFinderLauncher"
eggLauncher.AnchorPoint=Vector2.new(1,0.5)
eggLauncher.Position=UDim2.new(1,-48,0.325,0)
eggLauncher.Size=UDim2.fromOffset(56,56)
eggLauncher.BackgroundTransparency=0
line(eggLauncher,P.cyan,2)
eggLauncher.ZIndex=30

local ball=ui("Frame",eggLauncher,{
  AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),
  Size=UDim2.fromOffset(39,39),BackgroundColor3=Color3.new(1,1,1),
  BorderSizePixel=0,ZIndex=31})
round(ball,24)
ui("UIGradient",ball,{Rotation=90,Color=ColorSequence.new({
  ColorSequenceKeypoint.new(0,Color3.fromRGB(236,45,52)),
  ColorSequenceKeypoint.new(.485,Color3.fromRGB(236,45,52)),
  ColorSequenceKeypoint.new(.49,Color3.fromRGB(255,255,255)),
  ColorSequenceKeypoint.new(1,Color3.fromRGB(255,255,255))
})})
line(ball,Color3.fromRGB(17,22,29),3)
local seam=ui("Frame",ball,{
  AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),
  Size=UDim2.new(1,0,0,5),BackgroundColor3=Color3.fromRGB(17,22,29),
  BorderSizePixel=0,ZIndex=32})
local center=ui("Frame",ball,{
  AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),
  Size=UDim2.fromOffset(17,17),BackgroundColor3=Color3.fromRGB(17,22,29),
  BorderSizePixel=0,ZIndex=33})
round(center,12)
local dot=ui("Frame",center,{
  AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),
  Size=UDim2.fromOffset(10,10),BackgroundColor3=Color3.fromRGB(255,255,255),
  BorderSizePixel=0,ZIndex=34})
round(dot,7)
line(dot,Color3.fromRGB(155,161,174),1)

-- UI anchoring experiment: follow an identifiable game egg shortcut, never our own GUI.
local GuiService=game:GetService("GuiService")
eggLauncher.AnchorPoint=Vector2.new(.5,.5)
local function findGameEggButton()
  local candidates={}
  for _,d in ipairs(parent:GetDescendants()) do
    if d:IsA("GuiObject") and d:IsDescendantOf(gui)==false and d.Visible then
      local name=d.Name:lower()
      if (d:IsA("ImageButton") or d:IsA("TextButton")) and
         (name=="egg" or name=="eggs" or name=="eggbutton" or name=="eggsbutton" or
          name=="eggmenu" or name=="eggicon" or name=="eggshop") then
        local p=d.AbsolutePosition
        local size=d.AbsoluteSize
        if size.X>=25 and size.X<=170 and size.Y>=25 and size.Y<=170 then
          table.insert(candidates,d)
        end
      end
    end
  end
  if #candidates==1 then return candidates[1] end
  return nil
end
task.spawn(function()
  local lastTarget=nil
  while gui.Parent do
    local target=findGameEggButton()
    if target then
      local inset=GuiService:GetGuiInset()
      local p=target.AbsolutePosition
      local z=target.AbsoluteSize
      eggLauncher.Position=UDim2.fromOffset(
        math.floor(p.X+z.X/2-inset.X+.5),
        math.floor(p.Y-eggLauncher.AbsoluteSize.Y/2-9-inset.Y+.5))
      lastTarget=target
    elseif not lastTarget then
      -- Fallback while the game button cannot be identified.
      eggLauncher.AnchorPoint=Vector2.new(1,.5)
      eggLauncher.Position=UDim2.new(1,-45,.27,0)
    end
    task.wait(.6)
  end
end)

-- An expanded overlay preserves the V4 hub's compact navigation.
local finder=ui("Frame",gui,{Name="EggFinder",AnchorPoint=Vector2.new(1,0),
  Position=UDim2.new(1,-56,0,100),Size=UDim2.fromOffset(490,510),
  BackgroundColor3=Color3.fromRGB(31,35,58),BorderSizePixel=0,Visible=false,ZIndex=15})
round(finder,17)
line(finder,Color3.fromRGB(167,170,216),3)
ui("UIScale",finder,{Scale=.76})
local titleBar=ui("Frame",finder,{Size=UDim2.new(1,0,0,42),BackgroundColor3=Color3.fromRGB(61,64,100),BorderSizePixel=0,ZIndex=16})
round(titleBar,16)
txt(titleBar,"STEAL PANEL  /  YAFI",17,6,360,29,20,P.text,true).ZIndex=17
-- Red edge arrow: open panel when collapsed, hide when expanded.
-- Child of finder: the arrow moves and scales with the panel.
local finderTab=btn(finder,"<",-37,296,46,46,Color3.fromRGB(218,34,40))
finderTab.Name="FinderEdgeTab"
finderTab.Font=Enum.Font.GothamBlack
finderTab.TextSize=29
finderTab.ZIndex=50
line(finderTab,Color3.fromRGB(43,29,35),3)
local finderClose=btn(finder,"X",447,7,30,29,Color3.fromRGB(85,43,76))
finderClose.ZIndex=17
local countLabel=txt(finder,"Loading...",17,91,455,24,15,P.cyan)
countLabel.ZIndex=16
local petSearch=ui("TextBox",finder,{
  Position=UDim2.fromOffset(15,119),Size=UDim2.fromOffset(268,35),
  Text="",PlaceholderText="Filter pets by name...",ClearTextOnFocus=false,
  Font=Enum.Font.GothamMedium,TextSize=13,TextColor3=P.text,
  PlaceholderColor3=P.muted,BackgroundColor3=P.panel,
  BorderSizePixel=0,ZIndex=16})
round(petSearch,9)
ui("UIPadding",petSearch,{PaddingLeft=UDim.new(0,9)})
local minIncome=ui("TextBox",finder,{
  Position=UDim2.fromOffset(289,119),Size=UDim2.fromOffset(125,35),
  Text="",PlaceholderText="Min $/s",ClearTextOnFocus=false,
  Font=Enum.Font.GothamMedium,TextSize=13,TextColor3=P.text,
  PlaceholderColor3=P.muted,BackgroundColor3=P.panel,
  BorderSizePixel=0,ZIndex=16})
round(minIncome,9)
ui("UIPadding",minIncome,{PaddingLeft=UDim.new(0,9)})
local refreshBtn=btn(finder,"↻",424,119,50,35,P.blue)
refreshBtn.ZIndex=16
local list=ui("ScrollingFrame",finder,{Position=UDim2.fromOffset(15,164),
  Size=UDim2.fromOffset(460,328),BackgroundColor3=Color3.fromRGB(33,36,61),
  BorderSizePixel=0,ScrollBarThickness=5,CanvasSize=UDim2.fromOffset(0,0),
  ZIndex=16})
round(list,10)
local listLayout=ui("UIListLayout",list,{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
-- SERVER HUNTER: public server browser. Other servers' egg contents are unknown
-- until a player actually joins and reads that server's snapshot.
local serverHunter=ui("Frame",finder,{Name="ServerHunter",Position=UDim2.fromOffset(15,164),
  Size=UDim2.fromOffset(460,328),BackgroundColor3=P.navy,BorderSizePixel=0,
  Visible=false,ZIndex=22})
round(serverHunter,10)
local hunterTitle=txt(serverHunter,"SERVER HUNTER",12,8,434,25,16,P.cyan,true)
hunterTitle.ZIndex=23
local hunterNote=txt(serverHunter,"Other servers: egg contents unknown until joined.",12,80,434,24,13,P.muted,false)
hunterNote.ZIndex=23
local hunterRefresh=btn(serverHunter,"FIND SERVERS",12,112,210,38,P.blue)
hunterRefresh.ZIndex=24
local hunterBack=btn(serverHunter,"BACK TO EGGS",235,112,210,38,P.panel)
hunterBack.ZIndex=24
local hunterList=ui("ScrollingFrame",serverHunter,{
  Position=UDim2.fromOffset(10,162),Size=UDim2.fromOffset(438,156),
  BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=4,
  CanvasSize=UDim2.fromOffset(0,0),ZIndex=23})
local hunterLayout=ui("UIListLayout",hunterList,{Padding=UDim.new(0,5),SortOrder=Enum.SortOrder.LayoutOrder})
local hunterButton=btn(finder,"SERVERS",259,49,97,36,P.blue)
hunterButton.TextSize=13
hunterButton.ZIndex=20
local HttpService=game:GetService("HttpService")
local TeleportService=game:GetService("TeleportService")
local hunterBusy=false
local function showHunter(on)
  serverHunter.Visible=on
  list.Visible=not on
  petSearch.Visible=not on
  minIncome.Visible=not on
  refreshBtn.Visible=not on
  hunterButton.Visible=true
  hunterButton.Text="SERVERS"
end
-- Server tab binding set below the server panels
hunterBack.MouseButton1Click:Connect(function() showHunter(false) end)
local function fetchServers()
  if hunterBusy then return end
  hunterBusy=true
  hunterNote.Text="Finding joinable public servers..."
  for _,c in ipairs(hunterList:GetChildren()) do
    if c:IsA("Frame") then c:Destroy() end
  end
  task.spawn(function()
    local url="https://games.roblox.com/v1/games/"..tostring(game.PlaceId).."/servers/Public?sortOrder=Asc&limit=100"
    local ok,data=pcall(function()
      return HttpService:JSONDecode(game:HttpGet(url))
    end)
    if not gui.Parent then hunterBusy=false return end
    if not ok or type(data)~="table" or type(data.data)~="table" then
      hunterNote.Text="Server directory unavailable in this client."
      hunterBusy=false
      return
    end
    local servers={}
    for _,sv in ipairs(data.data) do
      if type(sv)=="table" and type(sv.id)=="string"
        and sv.id~=game.JobId and (tonumber(sv.playing) or 999)<(tonumber(sv.maxPlayers) or 0) then
        servers[#servers+1]=sv
      end
    end
    table.sort(servers,function(a,b) return (a.playing or 999)<(b.playing or 999) end)
    for index,sv in ipairs(servers) do
      if index>25 then break end
      local row=ui("Frame",hunterList,{Size=UDim2.new(1,-8,0,43),
        BackgroundColor3=index%2==0 and P.panel or P.deep,BorderSizePixel=0,
        LayoutOrder=index,ZIndex=24})
      round(row,7)
      local label=txt(row,tostring(sv.playing).."/"..tostring(sv.maxPlayers).." players | Eggs: unknown",9,6,310,31,12,P.text,true)
      label.ZIndex=25
      local hop=btn(row,"HOP",345,4,80,35,Color3.fromRGB(31,165,82))
      hop.ZIndex=26
      hop.MouseButton1Click:Connect(function()
        if _G.YafiPickupBusy then
          hunterNote.Text="Finish carrying your egg before hopping."
          return
        end
        hunterNote.Text="Joining selected server (egg contents unknown)..."
        local success,err=pcall(function()
          TeleportService:TeleportToPlaceInstance(game.PlaceId,sv.id,player)
        end)
        if not success then hunterNote.Text="Hop rejected: "..tostring(err):sub(1,65) end
      end)
    end
    hunterList.CanvasSize=UDim2.fromOffset(0,math.min(#servers,25)*48)
    hunterNote.Text=tostring(#servers).." joinable servers found on first page; eggs unknown."
    hunterBusy=false
  end)
end
hunterRefresh.MouseButton1Click:Connect(fetchServers)

-- PRIVATE HUNTER: local-only, previously observed egg snapshots.
-- File persistence requires executor file APIs; never represents live remote egg data.
local privateFile="yafi_private_hunter.json"
local reports={}
local function loadReports()
  if type(readfile)~="function" then return end
  pcall(function()
    if type(isfile)=="function" and not isfile(privateFile) then return end
    local data=HttpService:JSONDecode(readfile(privateFile))
    if type(data)=="table" then reports=data end
  end)
end
local function saveReports()
  if type(writefile)~="function" then return end
  pcall(function() writefile(privateFile,HttpService:JSONEncode(reports)) end)
end
loadReports()
local privateTab=btn(serverHunter,"MY SCANS",12,40,210,32,P.blue)
privateTab.ZIndex=28
local publicTab=btn(serverHunter,"PUBLIC SERVERS",235,40,210,32,P.panel)
publicTab.ZIndex=28
local privateView=ui("Frame",serverHunter,{Size=UDim2.fromScale(1,1),BackgroundColor3=P.navy,
  BorderSizePixel=0,Visible=false,ZIndex=29})
round(privateView,10)
local privateHeading=txt(privateView,"PRIVATE HUNTER  /  SAVED SIGHTINGS",12,8,430,27,16,P.cyan,true)
privateHeading.ZIndex=30
local privateInfo=txt(privateView,"Only servers you personally scanned. Old eggs may be gone.",12,36,440,25,13,P.muted)
privateInfo.ZIndex=30
local scanHere=btn(privateView,"SCAN THIS SERVER",12,65,211,36,P.blue)
scanHere.ZIndex=31
local showPublic=btn(privateView,"PUBLIC SERVERS",235,65,210,36,P.panel)
showPublic.ZIndex=31
local reportList=ui("ScrollingFrame",privateView,{Position=UDim2.fromOffset(10,110),
  Size=UDim2.fromOffset(438,182),BackgroundTransparency=1,BorderSizePixel=0,
  ScrollBarThickness=4,CanvasSize=UDim2.fromOffset(0,0),ZIndex=31})
ui("UIListLayout",reportList,{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local function renderReports()
  for _,c in ipairs(reportList:GetChildren()) do
    if c:IsA("Frame") then c:Destroy() end
  end
  local sorted={}
  for serverId,r in pairs(reports) do
    if type(r)=="table" and type(r.epoch)=="number" then
      table.insert(sorted,{id=serverId,report=r})
    end
  end
  table.sort(sorted,function(a,b) return (a.report.bestRate or 0)>(b.report.bestRate or 0) end)
  for i,entry in ipairs(sorted) do
    if i>30 then break end
    local r=entry.report
    local elapsed=math.max(0,os.time()-r.epoch)
    local age=elapsed<60 and (elapsed.."s") or (math.floor(elapsed/60).."m")
    local row=ui("Frame",reportList,{Size=UDim2.new(1,-7,0,59),BackgroundColor3=P.deep,
      BorderSizePixel=0,LayoutOrder=i,ZIndex=32})
    round(row,7)
    local label=txt(row,tostring(r.bestName or "No eggs").." | "..money(r.bestRate).." /s",8,5,315,24,15,P.text,true)
    label.ZIndex=33
    local sub=txt(row,"Observed "..age.." ago  |  "..tostring(r.count or 0).." eggs",8,30,315,21,13,P.muted)
    sub.ZIndex=33
    local hop=btn(row,"HOP",345,11,77,36,P.green)
    hop.ZIndex=33
    hop.MouseButton1Click:Connect(function()
      if _G.YafiPickupBusy then privateInfo.Text="Finish current STEAL trip before hopping" return end
      privateInfo.Text="Hopping to previously observed server; eggs not guaranteed..."
      local success,err=pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId,entry.id,player)
      end)
      if not success then privateInfo.Text="Hop failed: "..tostring(err):sub(1,75) end
    end)
  end
  reportList.CanvasSize=UDim2.fromOffset(0,math.min(#sorted,30)*63)
  if #sorted==0 then privateInfo.Text="No scans yet. Press SCAN THIS SERVER first." end
end
local function scanCurrent()
  privateInfo.Text="Scanning current server..."
  task.spawn(function()
    local remote=RS:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot",true)
    local ok,result=false,nil
    if remote and remote:IsA("RemoteFunction") then
      ok,result=pcall(function() return remote:InvokeServer() end)
    end
    if not gui.Parent then return end
    if not ok or type(result)~="table" or type(result.Records)~="table" then
      privateInfo.Text="Snapshot unavailable; nothing saved"
      return
    end
    local bestName,bestRate,count="None",0,0
    for _,rec in pairs(result.Records) do
      if type(rec)=="table" and (rec.State==nil or rec.State=="Slot") then
        count=count+1
        local name=tostring(rec.AssetCategory or "Unknown")
        local def=type(assets)=="table" and assets[name] or nil
        local base=type(def)=="table" and tonumber(def.EarningRate) or nil
        local estimated=earned(rec,base) or base or 0
        if estimated>bestRate then bestName,bestRate=name,estimated end
      end
    end
    reports[game.JobId]={epoch=os.time(),bestName=bestName,bestRate=bestRate,count=count}
    saveReports()
    renderReports()
    privateInfo.Text="Saved "..count.." egg observations for this server."
  end)
end
scanHere.MouseButton1Click:Connect(scanCurrent)
privateTab.MouseButton1Click:Connect(function() privateView.Visible=true renderReports() end)
publicTab.MouseButton1Click:Connect(function() privateView.Visible=false end)
showPublic.MouseButton1Click:Connect(function() privateView.Visible=false end)
-- Rejoin needs a fresh load unless the user's client supports autorun on teleport.
-- We do not automatically hop to unknown servers or assume reports stay live.

local alertsView
hunterButton.MouseButton1Click:Connect(function()
 local nextState=not serverHunter.Visible
 alertsView.Visible=false
 showHunter(nextState)
end)
-- Community live sightings: third-party reports only, never verified server inventories.
alertsView=ui("Frame",finder,{Name="LiveEggAlerts",
 Position=UDim2.fromOffset(15,164),Size=UDim2.fromOffset(460,328),
 BackgroundColor3=Color3.fromRGB(35,40,65),BorderSizePixel=0,Visible=false,ZIndex=40})
round(alertsView,10)
local alertsHeading=txt(alertsView,"LIVE EGG ALERTS  /  COMMUNITY REPORTS",10,8,440,25,15,P.cyan,true)
alertsHeading.ZIndex=41
local alertsNote=txt(alertsView,"No server IDs. Sightings are NOT guaranteed available.",10,34,437,32,12,Color3.fromRGB(255,200,112))
alertsNote.ZIndex=41
alertsNote.TextWrapped=true
local alertRefresh=btn(alertsView,"REFRESH REPORTS",10,67,210,32,P.blue)
alertRefresh.ZIndex=42
local alertBack=btn(alertsView,"BACK TO EGGS",228,67,220,32,P.panel)
alertBack.ZIndex=42
local alertList=ui("ScrollingFrame",alertsView,{Position=UDim2.fromOffset(10,107),
 Size=UDim2.fromOffset(438,208),BackgroundTransparency=1,
 BorderSizePixel=0,ScrollBarThickness=6,CanvasSize=UDim2.fromOffset(0,0),ZIndex=41})
ui("UIListLayout",alertList,{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local alertsBusy=false
local function fetchCommunityAlerts()
 if alertsBusy then return end
 alertsBusy=true
 alertsNote.Text="Loading community reports (not server inventories)..."
 task.spawn(function()
  local ok,html=pcall(function()
   return game:HttpGet("https://www.stealegg.com/api/live-history.php?lang=en")
  end)
  if not alertsView.Parent then alertsBusy=false return end
  for _,child in ipairs(alertList:GetChildren()) do
   if child:IsA("Frame") then child:Destroy() end
  end
  local count=0
  if ok and type(html)=="string" then
   for tr in html:gmatch("<tr[^>]*>(.-)</tr>") do
    local cells={}
    for td in tr:gmatch("<t[dh][^>]*>(.-)</t[dh]>") do
     cells[#cells+1]=td
    end
    if #cells>=3 then
     local name=cells[1]:match("</a>%s*([^<]*)") or cells[1]:match(">([^<>]+)</a>") or ""
     local rarity=cells[1]:match("<small[^>]*>(.-)</small>") or ""
     local location=cells[2]:gsub("<[^>]*>",""):gsub("&amp;","&")
     local reported=cells[3]:match("datetime=\"([^\"]+)\"") or cells[3]:gsub("<[^>]*>","")
     local freshness="time unknown"
     local timeOK,epoch=pcall(function()
      local stamp=DateTime.fromIsoDate(reported)
      return stamp and stamp.UnixTimestamp
     end)
     if timeOK and type(epoch)=="number" then
      local age=math.max(0,os.time()-epoch)
      if age<60 then freshness="under 1m ago"
      elseif age<3600 then freshness=tostring(math.floor(age/60)).."m ago"
      elseif age<86400 then freshness=tostring(math.floor(age/3600)).."h ago"
      else freshness=tostring(math.floor(age/86400)).."d ago" end
     end
     name=name:gsub("<[^>]*>",""):gsub("^%s+",""):gsub("%s+$","")
     if name~="" then
      count=count+1
      local item=ui("Frame",alertList,{Size=UDim2.new(1,-7,0,58),
       BackgroundColor3= count%2==0 and Color3.fromRGB(64,70,103) or Color3.fromRGB(52,58,89),
       BorderSizePixel=0,LayoutOrder=count,ZIndex=42})
      round(item,6)
      local title=txt(item,name.."  ["..rarity.."]",9,5,413,23,15,Color3.fromRGB(106,255,121),true)
      title.ZIndex=43
      local details=txt(item,location.."  |  "..freshness.."  |  community report",9,31,418,22,12,P.text)
      details.ZIndex=43
      if count>=45 then break end
     end
    end
   end
  end
  alertList.CanvasSize=UDim2.fromOffset(0,count*62)
  alertsNote.Text= count>0 and ("Showing "..count.." reports from StealEgg.com • server IDs unavailable")
      or (ok and "No readable reports in public feed." or "Unable to load public feed from this executor.")
  alertsBusy=false
 end)
end
local alertsButton=btn(finder,"ALERTS",361,49,113,36,Color3.fromRGB(139,77,204))
alertsButton.TextSize=13
alertsButton.ZIndex=21
local function showAlerts(on)
 alertsView.Visible=on
 if on then
  serverHunter.Visible=false
  list.Visible=false
  petSearch.Visible=false
  minIncome.Visible=false
  refreshBtn.Visible=false
  fetchCommunityAlerts()
 else
  list.Visible=true
  petSearch.Visible=true
  minIncome.Visible=true
  refreshBtn.Visible=true
 end
end
alertsButton.MouseButton1Click:Connect(function() showAlerts(not alertsView.Visible) end)
alertRefresh.MouseButton1Click:Connect(fetchCommunityAlerts)
alertBack.MouseButton1Click:Connect(function() showAlerts(false) end)

local liveEggsTab=btn(finder,"LIVE EGGS",15,49,102,36,P.blue)
liveEggsTab.TextSize=13
liveEggsTab.ZIndex=21
liveEggsTab.MouseButton1Click:Connect(function()
 alertsView.Visible=false
 showHunter(false)
end)

-- Carry state is authoritative when this game version publishes the event.
local carryObserved=false
local carryingNow=nil
local carryUpdatedAt=0
local carryEvent=RS:FindFirstChild("Eggs: AreaEggCarryState",true)
  or RS:FindFirstChild("RE/EggWorld/FieldEggCarryState",true)
if carryEvent and carryEvent:IsA("RemoteEvent") then
  carryEvent.OnClientEvent:Connect(function(state)
    carryObserved=true
    carryingNow=type(state)=="table" and state.IsCarrying==true
    carryUpdatedAt=os.clock()
  end)
end
-- Manual movement immediately takes control back from the STEAL trip.
local tripSerial=0
local activeTripHumanoid=nil
local function cancelTrip()
 if not _G.YafiPickupBusy then return end
 tripSerial=tripSerial+1
 _G.YafiPickupBusy=false
 local hum=activeTripHumanoid
 activeTripHumanoid=nil
 if hum and hum.Parent then
  pcall(function() hum:MoveTo(hum.Parent.HumanoidRootPart.Position) end)
 end
 countLabel.Text="STEAL cancelled — manual movement restored"
end
UIS.InputBegan:Connect(function(input,processed)
 if UIS:GetFocusedTextBox() then return end
 local key=input.KeyCode
 if key==Enum.KeyCode.W or key==Enum.KeyCode.A or key==Enum.KeyCode.S
  or key==Enum.KeyCode.D or key==Enum.KeyCode.Up or key==Enum.KeyCode.Down
  or key==Enum.KeyCode.Left or key==Enum.KeyCode.Right or key==Enum.KeyCode.Space then
  cancelTrip()
 end
end)
local remote
latest={}
local lastStatus=""
local function renderFinder()
  for key in pairs(stealActions) do stealActions[key]=nil end

  for _,v in ipairs(list:GetChildren()) do
    if v:IsA("Frame") then v:Destroy() end
  end
  local query=normalize(petSearch.Text)
  local minimum=incomeNum(minIncome.Text) or tonumber(minIncome.Text) or 0
  local shown=0
  for _,egg in ipairs(latest) do
    local value=egg.income or egg.base
    if (query=="" or normalize(egg.name):find(query,1,true))
      and (minimum==0 or (value and value>=minimum)) then
      shown=shown+1
      local row=ui("Frame",list,{
        Size=UDim2.new(1,-8,0,78),
        BackgroundColor3=shown%2==0 and Color3.fromRGB(72,75,100) or Color3.fromRGB(63,67,94),
        BorderSizePixel=0,LayoutOrder=shown,ZIndex=17})
      round(row,7)
      line(row,Color3.fromRGB(173,177,208),1.7)
      local iconBack=ui("Frame",row,{Position=UDim2.fromOffset(4,5),
        Size=UDim2.fromOffset(67,67),BackgroundColor3=Color3.fromRGB(123,127,164),
        BorderSizePixel=0,ZIndex=18})
      round(iconBack,6)
      grad(iconBack,Color3.fromRGB(209,210,235),Color3.fromRGB(72,79,124),45)
      ui("ImageLabel",iconBack,{
        Position=UDim2.fromOffset(4,4),Size=UDim2.fromOffset(59,59),
        BackgroundTransparency=1,ScaleType=Enum.ScaleType.Fit,
        Image=iconId(egg.icon),ZIndex=19})
      local label=txt(row,egg.name,78,6,245,26,18,
        Color3.fromRGB(255,100,88),true)
      label.ZIndex=19
      label.Font=Enum.Font.GothamBlack
      local earnings=txt(row,(egg.income and "EST. " or "BASE ")..money(value).."/s",
        78,30,245,23,18,Color3.fromRGB(85,255,84),true)
      earnings.Font=Enum.Font.GothamBlack
      earnings.ZIndex=19
      local info=txt(row,string.format("x%.2f  •  %s",egg.scale,tostring(egg.mutation)),
        78,54,240,19,13,
        Color3.fromRGB(91,199,255),true)
      info.ZIndex=19
      local locate=btn(row,"STEAL",333,15,109,46,Color3.fromRGB(46,233,20))
      locate.ZIndex=20
      line(locate,Color3.fromRGB(19,112,30),2)
      if egg.raw and egg.raw.State and egg.raw.State~="Slot" then
        locate.Text=tostring(egg.raw.State):upper()
        locate.BackgroundColor3=Color3.fromRGB(97,101,127)
      end
      locate.TextSize=18
      locate.Font=Enum.Font.GothamBlack
      local function triggerSteal()
        if _G.YafiPickupBusy then
          countLabel.Text="A pickup test is already running"
          return
        end
        local raw=egg.raw or {}
        local uid=raw.Uid or raw.UID or raw.uid
        local cf=raw.BottomCFrame
        if uid==nil or typeof(cf)~="CFrame" then
          countLabel.Text="No Uid or BottomCFrame for "..egg.name
          return
        end
        -- Dropped eggs may be recoverable; let the server decide via carry remote.
        if raw.State and raw.State~="Slot" then
          countLabel.Text="Egg state: "..tostring(raw.State).." (cannot pick up)"
          return
        end
        _G.YafiPickupBusy=true
        tripSerial=tripSerial+1
        local thisTrip=tripSerial
        task.spawn(function()
          local ok,err=pcall(function()
            local character=player.Character
            local humanoid=character and character:FindFirstChildWhichIsA("Humanoid")
            local root=character and character:FindFirstChild("HumanoidRootPart")
            if not humanoid or not root then
              countLabel.Text="Character not ready"
              return
            end
            activeTripHumanoid=humanoid
            if thisTrip~=tripSerial then return end
            local carryRemote=RS:FindFirstChild("RF/EggWorld/AskFieldEggCarry",true)
            local snapshotRemote=RS:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot",true)
            if not carryRemote or not carryRemote:IsA("RemoteFunction") then
              countLabel.Text="Pickup remote unavailable"
              return
            end
            -- Restore the straightforward movement that previously walked toward eggs.
            -- Keep cancellation, carry-drop checks, and a bounded no-progress timeout.
            local function walkTo(pos,radius,deadline,label,watchCarry,carryStart,confirmedCarry)
              local lastPosition=root.Position
              local lastProgress=os.clock()
              while gui.Parent and os.clock()<deadline do
                if thisTrip~=tripSerial or not _G.YafiPickupBusy then return false,"cancelled by movement key" end
                if not humanoid.Parent or humanoid.Health<=0 or not root.Parent then return false,"character unavailable" end
                if watchCarry and confirmedCarry and carryObserved and carryingNow==false and carryUpdatedAt>carryStart then return false,"dropped" end
                if (root.Position-pos).Magnitude<=radius then return true end
                if (root.Position-lastPosition).Magnitude>=2 then
                  lastPosition=root.Position
                  lastProgress=os.clock()
                elseif os.clock()-lastProgress>9 then
                  return false,"movement blocked"
                end
                humanoid:MoveTo(pos)
                task.wait(.3)
              end
              return false,"destination unreachable"
            end
            -- The game's CarryAreaEgg prompt uses the currently bound egg.
            -- Fallback only when a single prompt clearly matches the selected position.
            local function pickupViaPrompt(position)
              local selected,near,second
              for _,obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") and obj.Name=="CarryAreaEgg"
                  and obj.Enabled and obj.Parent and obj.Parent:IsA("BasePart") then
                  local d=(obj.Parent.Position-position).Magnitude
                  if not near or d<near then
                    second=near
                    selected,near=obj,d
                  elseif not second or d<second then second=d end
                end
              end
              if not selected or near>5 or (second and second-near<2) then
                return false,"no unique nearby egg prompt"
              end
              local playerDistance=(root.Position-selected.Parent.Position).Magnitude
              if playerDistance>selected.MaxActivationDistance+1 then
                return false,"outside pickup prompt range"
              end
              local fired=false
              if type(fireproximityprompt)=="function" then
                fired=pcall(function() fireproximityprompt(selected,1) end)
              else
                fired=pcall(function()
                  selected:InputHoldBegin()
                  task.wait(math.max(.15,selected.HoldDuration))
                  selected:InputHoldEnd()
                end)
              end
              return fired,fired and "prompt activated" or "prompt unavailable"
            end
            local function findDropped()
              if not snapshotRemote or not snapshotRemote:IsA("RemoteFunction") then return nil end
              local success,snapshot=pcall(function() return snapshotRemote:InvokeServer() end)
              if success and type(snapshot)=="table" and type(snapshot.Records)=="table" then
                for _,rec in pairs(snapshot.Records) do
                  if type(rec)=="table" and tostring(rec.Uid)==tostring(uid)
                     and typeof(rec.BottomCFrame)=="CFrame" then
                    return rec.BottomCFrame.Position
                  end
                end
              end
              return nil
            end
            local plots=workspace:FindFirstChild("Plots")
            local ownPlot
            local stateRemote=RS:FindFirstChild("RF/Homestead/AskState",true)
            if plots and stateRemote and stateRemote:IsA("RemoteFunction") then
              local stateOK,state=pcall(function() return stateRemote:InvokeServer() end)
              if stateOK and type(state)=="table" and type(state.OwnersBySlot)=="table" then
                for slot,owner in pairs(state.OwnersBySlot) do
                  if tonumber(owner)==player.UserId then ownPlot=plots:FindFirstChild(tostring(slot)) break end
                end
              end
            end
            if plots and not ownPlot then
              for _,plot in ipairs(plots:GetChildren()) do
                local sign=plot:FindFirstChild("PlotSign")
                if sign then
                  for _,label in ipairs(sign:GetDescendants()) do
                    if label:IsA("TextLabel") and label.Text==player.Name then ownPlot=plot break end
                  end
                end
                if ownPlot then break end
              end
            end
            local area=ownPlot and ownPlot:FindFirstChild("ToUpdate")
            area=area and area:FindFirstChild("PetArea")
            if not area or not area:IsA("BasePart") then
              countLabel.Text="Your base could not be identified"
              return
            end
            local eggPos=cf.Position
            -- Recheck the selected UID, because a displayed egg can move or be dropped.
            if snapshotRemote and snapshotRemote:IsA("RemoteFunction") then
              local freshOK,fresh=pcall(function() return snapshotRemote:InvokeServer() end)
              if freshOK and type(fresh)=="table" and type(fresh.Records)=="table" then
                local found=false
                for _,rec in pairs(fresh.Records) do
                  if type(rec)=="table" and tostring(rec.Uid)==tostring(uid) then
                    found=true
                    if typeof(rec.BottomCFrame)=="CFrame" then eggPos=rec.BottomCFrame.Position end
                    if rec.State and rec.State~="Slot" then
                      countLabel.Text="Egg now unavailable: "..tostring(rec.State)
                      return
                    end
                    break
                  end
                end
                if not found then
                  countLabel.Text="Egg disappeared; refresh the list"
                  return
                end
              end
            end
            local recoveries=0
            while gui.Parent and recoveries<=2 do
              countLabel.Text=(recoveries==0 and "Approaching " or "Recovering ")..egg.name
              local approached,why=walkTo(eggPos,7,os.clock()+50,"egg",false)
              if not approached then countLabel.Text="Could not reach egg: "..why return end
              if thisTrip~=tripSerial then return end
              countLabel.Text="Near "..egg.name.." - closing pickup distance..."
              local closeDeadline=os.clock()+2.5
              while gui.Parent and os.clock()<closeDeadline and (root.Position-eggPos).Magnitude>4 do
                if thisTrip~=tripSerial or not _G.YafiPickupBusy then return end
                humanoid:MoveTo(eggPos)
                task.wait(.18)
              end
              if thisTrip~=tripSerial then return end
              if (root.Position-eggPos).Magnitude>8 then
                countLabel.Text="Pickup position blocked; stopped"
                return
              end
              -- A selected egg may despawn or change state during the walk.
              -- Do not submit an outdated UID to the carry endpoint.
              if snapshotRemote and snapshotRemote:IsA("RemoteFunction") then
                local latestOK,current=pcall(function() return snapshotRemote:InvokeServer() end)
                if not latestOK or type(current)~="table" or type(current.Records)~="table" then
                  countLabel.Text="Cannot verify egg before pickup; stopped"
                  return
                end
                local validNow=false
                for _,item in pairs(current.Records) do
                  if type(item)=="table" and tostring(item.Uid)==tostring(uid) then
                    validNow=(item.State==nil or item.State=="Slot")
                    break
                  end
                end
                if not validNow then
                  countLabel.Text="Egg moved/disappeared or was dropped; refresh list"
                  return
                end
              end
              local carryStart=os.clock()
              carryingNow=nil -- Ignore carry state left over from a previous trip.
              local success,accepted,reason=pcall(function() return carryRemote:InvokeServer({Uid=uid}) end)
              if thisTrip~=tripSerial then return end
              if not success or not accepted then
                local serverReason=tostring(reason or accepted):sub(1,55)
                -- On stale-UID errors, try the game's real egg prompt once.
                if serverReason:lower():find("not found",1,true) then
                  countLabel.Text="UID rejected; trying nearby egg prompt..."
                  local promptOK,promptWhy=pickupViaPrompt(eggPos)
                  if not promptOK then
                    countLabel.Text="Pickup rejected: "..serverReason.." | "..promptWhy
                    return
                  end
                  local deadline=os.clock()+2
                  while thisTrip==tripSerial and os.clock()<deadline
                    and not (carryObserved and carryingNow==true and carryUpdatedAt>=carryStart) do
                    task.wait(.1)
                  end
                  if not (carryObserved and carryingNow==true and carryUpdatedAt>=carryStart) then
                    countLabel.Text="Prompt attempted; pickup unconfirmed. Stopped."
                    return
                  end
                else
                  countLabel.Text="Pickup rejected: "..serverReason
                  return
                end
              end
              local confirmedCarry=carryObserved and carryingNow==true and carryUpdatedAt>=carryStart
              countLabel.Text="Carrying "..egg.name.." home..."
              -- Server events, when present, tell us whether the carry was dropped.
              -- Never assume the original egg position is where it landed.
              countLabel.Text="Carrying egg — returning to assigned base..."
              local reached,why=walkTo(area.Position,5,os.clock()+90,"base",true,carryStart,confirmedCarry)
              if reached then
                countLabel.Text="Reached base with "..egg.name.." — verify claim"
                return
              end
              if why~="dropped" then
                countLabel.Text="Return stopped: "..why
                return
              end
              if recoveries>=2 then
                countLabel.Text="Egg dropped repeatedly; stopped safely"
                return
              end
              countLabel.Text="Egg dropped — checking its new position..."
              eggPos=findDropped()
              if not eggPos then
                countLabel.Text="Egg dropped; current position unavailable"
                return
              end
              recoveries=recoveries+1
            end
          end)
          if thisTrip==tripSerial and not ok and gui.Parent then
            countLabel.Text="Test error: "..tostring(err):sub(1,75)
          end
          if thisTrip==tripSerial then
            _G.YafiPickupBusy=false
            activeTripHumanoid=nil
          end
        end)
      end
      stealActions[egg.name]=triggerSteal
      locate.MouseButton1Click:Connect(triggerSteal)
    end
  end
  list.CanvasSize=UDim2.fromOffset(0,shown*82+6)
  countLabel.Text=lastStatus.." | Showing "..shown
end
local running=false
local function refreshFinder()
  if running then return end
  running=true
  if not remote or not remote.Parent then
    remote=RS:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot",true)
  end
  if not remote or not remote:IsA("RemoteFunction") then
    lastStatus="Egg snapshot unavailable"
    latest={}
    renderFinder()
    running=false
    return
  end
  countLabel.Text="Reading current server eggs..."
  local done=false
  local ok,result=false,nil
  task.spawn(function()
    ok,result=pcall(function() return remote:InvokeServer() end)
    done=true
  end)
  local started=os.clock()
  while not done and os.clock()-started<8 and gui.Parent do task.wait(.1) end
  if not done then
    lastStatus="Snapshot timed out (8s) - retry or rejoin server"
    countLabel.Text=lastStatus
    running=false
    return
  end
  if not ok or type(result)~="table" or type(result.Records)~="table" then
    lastStatus="Unable to read server eggs"
    latest={}
    renderFinder()
    running=false
    return
  end
  local eggs={}
  for recordKey,egg in pairs(result.Records) do
    if type(egg)=="table" then
      local name=tostring(egg.AssetCategory or "Unknown")
      local def=type(assets)=="table" and assets[name] or nil
      local gameBase=type(def)=="table" and tonumber(def.EarningRate) or nil
      local recordId=egg.Id or egg.ID or egg.EggId or egg.EggID or egg.Guid or egg.GUID or recordKey
      table.insert(eggs,{raw=egg,recordKey=tostring(recordKey),recordId=tostring(recordId),name=name,mutation=tostring(egg.BaseMutation or "None"),
        scale=tonumber(egg.AssetScale) or 1,base=gameBase or database[normalize(name)],
        income=earned(egg,gameBase),icon=type(def)=="table" and def.Icon or nil,
        rarity=(type(def)=="table" and (def.Rarity or def.Tier or def.RarityName)) or databaseRarity[normalize(name)] or egg.Rarity or egg.Tier})
    end
  end
  table.sort(eggs,function(a,b)
    if (a.income or a.base or -1)~=(b.income or b.base or -1) then
      return (a.income or a.base or -1)>(b.income or b.base or -1)
    end
    if a.scale~=b.scale then return a.scale>b.scale end
    return a.name<b.name
  end)
  latest=eggs
  lastStatus=string.format("%d eggs | estimates where available",#eggs)
  renderFinder()
  running=false
end
-- Keep the arrow physically connected to the scaled finder's left edge.
-- One toggle: visible blue Pokeball when closed, attached arrow when open.
local function setFinderOpen(on)
  finder.Visible=on
  eggLauncher.Visible=not on
  if on then task.spawn(refreshFinder) end
end
finder.Visible=false
eggLauncher.Visible=true
local function openFinder() setFinderOpen(true) end
finderButton.MouseButton1Click:Connect(openFinder)
eggLauncher.MouseButton1Click:Connect(openFinder)
finderTab.MouseButton1Click:Connect(function() setFinderOpen(false) end)
finderClose.MouseButton1Click:Connect(function() setFinderOpen(false) end)
petSearch:GetPropertyChangedSignal("Text"):Connect(renderFinder)
minIncome:GetPropertyChangedSignal("Text"):Connect(renderFinder)
refreshBtn.MouseButton1Click:Connect(function() task.spawn(refreshFinder) end)
-- Start the live snapshot scanner independently of the optional website.
task.spawn(function()
  while gui.Parent do
    if finder.Visible then
      local ok,err=pcall(refreshFinder)
      if not ok then
        running=false
        lastStatus="Scanner error: "..tostring(err):sub(1,90)
        countLabel.Text=lastStatus
        warn("[Yafi Egg Hub]",err)
      end
    end
    task.wait(5)
  end
end)
-- External index is optional and must never block live egg scanning.
task.spawn(function()
  local ok,err=pcall(fetchDatabase)
  if not ok then warn("[Yafi Egg Hub] Optional index:",err) end
end)

_G.YafiTeleportMode=false
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
local speedToggle=btn(settings,"MOVEMENT: NORMAL WALK",16,137,274,37,P.panel)
speedToggle.TextSize=12
txt(settings,"Stable pickup and return restored.",17,183,274,20,10,P.muted)

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
print("Yafi Egg Hub V4 with live Egg Finder loaded")
