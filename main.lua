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

-- An expanded overlay preserves the V4 hub's compact navigation.
local finder=ui("Frame",gui,{Name="EggFinder",AnchorPoint=Vector2.new(.5,.5),
  Position=UDim2.fromScale(.5,.5),Size=UDim2.fromOffset(490,440),
  BackgroundColor3=P.deep,BorderSizePixel=0,Visible=false,ZIndex=15})
round(finder,17)
line(finder,P.cyan,2)
txt(finder,"EGG FINDER  /  LIVE SERVER",17,11,395,29,17,P.text,true).ZIndex=16
local finderClose=btn(finder,"X",447,12,30,29,Color3.fromRGB(85,43,76))
finderClose.ZIndex=17
local countLabel=txt(finder,"Loading...",17,46,460,22,12,P.cyan)
countLabel.ZIndex=16
local petSearch=ui("TextBox",finder,{
  Position=UDim2.fromOffset(15,75),Size=UDim2.fromOffset(268,35),
  Text="",PlaceholderText="Filter pets by name...",ClearTextOnFocus=false,
  Font=Enum.Font.GothamMedium,TextSize=13,TextColor3=P.text,
  PlaceholderColor3=P.muted,BackgroundColor3=P.panel,
  BorderSizePixel=0,ZIndex=16})
round(petSearch,9)
ui("UIPadding",petSearch,{PaddingLeft=UDim.new(0,9)})
local minIncome=ui("TextBox",finder,{
  Position=UDim2.fromOffset(289,75),Size=UDim2.fromOffset(125,35),
  Text="",PlaceholderText="Min $/s",ClearTextOnFocus=false,
  Font=Enum.Font.GothamMedium,TextSize=13,TextColor3=P.text,
  PlaceholderColor3=P.muted,BackgroundColor3=P.panel,
  BorderSizePixel=0,ZIndex=16})
round(minIncome,9)
ui("UIPadding",minIncome,{PaddingLeft=UDim.new(0,9)})
local refreshBtn=btn(finder,"↻",424,75,50,35,P.blue)
refreshBtn.ZIndex=16
local list=ui("ScrollingFrame",finder,{Position=UDim2.fromOffset(15,120),
  Size=UDim2.fromOffset(460,302),BackgroundColor3=P.navy,
  BorderSizePixel=0,ScrollBarThickness=5,CanvasSize=UDim2.fromOffset(0,0),
  ZIndex=16})
round(list,10)
local listLayout=ui("UIListLayout",list,{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
local remote
local latest={}
local lastStatus=""
local function renderFinder()

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
        Size=UDim2.new(1,-7,0,54),BackgroundColor3=shown%2==0 and P.panel or P.deep,
        BorderSizePixel=0,LayoutOrder=shown,ZIndex=17})
      round(row,7)
      ui("ImageLabel",row,{
        Position=UDim2.fromOffset(5,4),Size=UDim2.fromOffset(46,46),
        BackgroundTransparency=1,ScaleType=Enum.ScaleType.Fit,
        Image=iconId(egg.icon),ZIndex=18})
      ui("TextLabel",row,{
        Position=UDim2.fromOffset(59,0),Size=UDim2.new(1,-156,1,0),
        BackgroundTransparency=1,TextColor3=P.text,TextWrapped=true,
        RichText=true,TextXAlignment=Enum.TextXAlignment.Left,
        Font=Enum.Font.GothamBlack,TextSize=15,ZIndex=18,
        Text=string.format("<b>%d.</b> %s | %s <b>%s</b>\n%s | Size <b>%.2fx</b>",
          shown,'<font color="'..rarityHex(egg.rarity)..'"><b>'..richSafe(egg.name)..'</b></font>',egg.income and "EST." or "BASE",
          money(value),richSafe(egg.mutation),egg.scale)
      })
      local locate=btn(row,"STEAL",362,10,84,34,P.blue)
      locate.ZIndex=20
      locate.TextSize=13
      locate.Font=Enum.Font.GothamBlack
      locate.MouseButton1Click:Connect(function()
        local raw=egg.raw or {}
        local ids={}
        local position
        local fields={}
        for key,value in pairs(raw) do
          fields[#fields+1]=tostring(key)
          local lk=tostring(key):lower()
          if type(value)=="string" or type(value)=="number" then
            if lk:find("id") or lk:find("guid") or lk:find("uid") then
              ids[tostring(value)]=true
            end
          elseif typeof(value)=="Vector3" then
            if lk:find("pos") or lk:find("location") then position=value end
          elseif typeof(value)=="CFrame" then
            if lk:find("pos") or lk:find("cframe") then position=value.Position end
          end
        end
        local realIds={}
        for id in pairs(ids) do realIds[#realIds+1]=id end
        -- Record keys may simply be array indices, so do not assume they identify a physical egg.
        local target,part,prompt
        local nearest=math.huge
        local root=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local function inspect(obj)
          local matched=false
          for k,v in pairs(obj:GetAttributes()) do
            if ids[tostring(v)] and (tostring(k):lower():find("id") or tostring(k):lower():find("guid")) then
              matched=true break
            end
          end
          if not matched then
            for _,child in ipairs(obj:GetChildren()) do
              if child:IsA("StringValue") or child:IsA("IntValue") or child:IsA("NumberValue") then
                if ids[tostring(child.Value)] and (child.Name:lower():find("id") or child.Name:lower():find("guid")) then
                  matched=true break
                end
              end
            end
          end
          if matched then
            local p=obj:IsA("BasePart") and obj or (obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true)))
            if p then
              local d=position and (p.Position-position).Magnitude or (root and (p.Position-root.Position).Magnitude or 0)
              if d<nearest then
                nearest=d target=obj part=p
                prompt=obj:FindFirstChildWhichIsA("ProximityPrompt",true) or (obj.Parent and obj.Parent:FindFirstChildWhichIsA("ProximityPrompt",true))
              end
            end
          end
        end
        if #realIds>0 then
          for _,obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") or obj:IsA("BasePart") then inspect(obj) end
          end
        end
        local old=workspace:FindFirstChild("YafiPetLocateHighlight")
        if old then old:Destroy() end
        if not target then
          table.sort(fields)
          countLabel.Text="No exact world match | fields: "..table.concat(fields,", "):sub(1,110)
          warn("[Yafi Egg Hub] Snapshot diagnostic:",egg.name,
            "recordKey:",egg.recordKey,"candidateIDs:",table.concat(realIds,", "),
            "fields:",table.concat(fields,", "))
          return
        end
        local h=Instance.new("Highlight")
        h.Name="YafiPetLocateHighlight"
        h.FillColor=P.cyan
        h.OutlineColor=P.blue
        h.Adornee=target
        h.Parent=workspace
        if not root then countLabel.Text="Egg identified; avatar not ready" return end
        local ok=pcall(function() root.CFrame=part.CFrame*CFrame.new(0,3,5) end)
        if not ok then countLabel.Text="Egg identified, but unable to approach" return end
        if prompt then
          countLabel.Text="At matching egg; use pickup prompt"
          if type(fireproximityprompt)=="function" then
            local fired=pcall(function() fireproximityprompt(prompt) end)
            if fired then countLabel.Text="Pickup interaction sent; verify egg in inventory" end
          end
        else
          countLabel.Text="Exact egg found; no pickup prompt detected"
        end
      end)
    end
  end
  list.CanvasSize=UDim2.fromOffset(0,shown*58+6)
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
  local ok,result=pcall(function() return remote:InvokeServer() end)
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
finderButton.MouseButton1Click:Connect(function()
  finder.Visible=true
  task.spawn(refreshFinder)
end)
finderClose.MouseButton1Click:Connect(function() finder.Visible=false end)
petSearch:GetPropertyChangedSignal("Text"):Connect(renderFinder)
minIncome:GetPropertyChangedSignal("Text"):Connect(renderFinder)
refreshBtn.MouseButton1Click:Connect(function() task.spawn(refreshFinder) end)
task.spawn(function()
  fetchDatabase()
  while gui.Parent do
    if finder.Visible then refreshFinder() end
    task.wait(5)
  end
end)

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
print("Yafi Egg Hub V4 with live Egg Finder loaded")
