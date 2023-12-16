local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local Player = Players.LocalPlayer
local ViewportSize = workspace.CurrentCamera.ViewportSize
local UIScale = ViewportSize.Y / 550

local RedzLib = {
  PlayerName = Player.Name,
  GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name,
  Icons = {},
  Elements = {},
  Configs = {
    ["Color Hub 1"] = Color3.fromRGB(10, 10, 30),
    ["Color Hub 2"] = Color3.fromRGB(15, 15, 35),
    ["Color Theme"] = Color3.fromRGB(30, 160, 255),
    ["Color Text"] = Color3.fromRGB(200, 200, 200),
    ["Color Dark Text"] = Color3.fromRGB(140, 140, 140),
    ["Color Stroke"] = Color3.fromRGB(60, 60, 60),
    ["Corner Radius"] = UDim.new(0, 4),
    ["Font"] = Enum.Font.FredokaOne
  }
}
local GitHub = "https://raw.githubusercontent.com/"
RedzLib.Icons = HttpService:JSONDecode(game:HttpGetAsync(GitHub .. "evoincorp/lucideblox/master/src/modules/util/icons.json")).icons

local ConfigsHub = RedzLib.Configs
local ElementsHub = RedzLib.Elements

local function SetProps(instance, props)
  if props and type(props) == "table" then
    table.foreach(props, function(prop, Value)
      instance[prop] = Value
    end)
  end
  return instance
end

local function Create(instance, parent, props)
  local New = Instance.new(instance, parent)
  SetProps(New, props)
  return New
end

local function CreateTween(instance, prop, value, time, tweenWait)
  local instance = instance or nil
  local prop = prop or nil
  local value = value or nil
  local time = time or 5
  local tweenWait = tweenWait or true
  
  local tween = TweenService:Create(instance,
  TweenInfo.new(time, Enum.EasingStyle.Linear),
  {[prop] = value})
  tween:Play()
  if tweenWait then
    tween.Completed:Wait()
  end
end

function RedzLib.Elements:Stroke(parent, props)
  local New = Create("UIStroke", parent, {
    Name = "Stroke",
    Color = ConfigsHub["Color Stroke"] or Color3.fromRGB(60, 60, 60),
    ApplyStrokeMode = "Border"
  })SetProps(New, props)
  return New
end

function RedzLib.Elements:Corner(parent, props)
  local New = Create("UICorner", parent, {
    Name = "Corner",
    CornerRadius = ConfigsHub["Corner Radius"] or UDim.new(0, 4)
  })SetProps(New, props)
  return New
end

function RedzLib.Elements:Button(parent, Size, props)
  local New = Create("TextButton", parent, {
    Name = "Frame",
    AutoButtonColor = false,
    Text = "",
    BackgroundColor3 = ConfigsHub["Color Hub 2"],
    Size = UDim2.new(1, 0, 0, Size)
  })SetProps(New, props)
  return New
end

function RedzLib.Elements:Text(parent, props)
  local New = Create("TextLabel", parent, {
    Name = "Text",
    Text = "",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    Font = ConfigsHub["Font"],
    TextColor3 = ConfigsHub["Color Text"]
  })SetProps(New, props)
  return New
end

local function TextSetColor(instance)
  instance.MouseEnter:Connect(function()
    CreateTween(instance, "TextColor3", ConfigsHub["Color Theme"], 0.4, false)
  end)
  instance.MouseLeave:Connect(function()
    CreateTween(instance, "TextColor3", ConfigsHub["Color Text"], 0.4, false)
  end)
end

local function GetMousePos()
  return Player:GetMouse()
end

local ScreenGui = Create("ScreenGui", CoreGui, {
  Name = "redz Library V3"
})local UIScaleI = Create("UIScale", ScreenGui, {
  Scale = UIScale
})

local ScreenFind = CoreGui:FindFirstChild(ScreenGui.Name)
if ScreenFind and ScreenFind ~= ScreenGui then
  ScreenFind:Destroy()
end

function RedzLib:GetIcon(IconName)
  return RedzLib.Icons[IconName]
end

function RedzLib:Destroy()
  ScreenGui:Destroy()
end

function RedzLib:Visible(Bool)
  ScreenGui.Enabled = Bool
end

function RedzLib:Set(val1)
  if typeof(val1) == "number" then
    UIScaleI.Scale = ViewportSize.Y / val1
  end
end

function RedzLib:MakeWindow(Configs)
  local HubTitle = Configs.Menu.Title or "Redz Library"
  local HubMiniText = Configs[2] or Configs.MiniText or "by : redz9999"
  
  local Animation = Configs.Animation or {}
  local AnimationTitle = Animation.Title or "redz library"
  
  local StartSize = 150
  local TabSize = 30
  
  local MainFrame = Create("Frame", ScreenGui, {
    Size = UDim2.new(),
    Position = UDim2.new(0.5, 0 -550/2, 0.5, -310/2),
    BackgroundColor3 = ConfigsHub["Color Hub 1"],
    Draggable = true,
    Active = true
  })ElementsHub:Corner(MainFrame, {CornerRadius = UDim.new(0, 8)})
  
  CreateTween(MainFrame, "Size", UDim2.new(0, 0, 0, 30), 0.1, true)
  CreateTween(MainFrame, "Size", UDim2.new(0, 550, 0, 30), 0.4, true)
  CreateTween(MainFrame, "Size", UDim2.new(0, 550, 0, 310), 0.4, true)
  
  local TopBar = Create("Frame", MainFrame, {
    Size = UDim2.new(1, 0, 0, TabSize),
    BackgroundTransparency = 1
  })Create("TextLabel", TopBar, {
    Size = UDim2.new(1, -80, 1, 0),
    Position = UDim2.new(0, 25, 0, 0),
    Text = HubTitle,
    TextXAlignment = "Left",
    TextSize = 20,
    BackgroundTransparency = 1,
    TextColor3 = ConfigsHub["Color Text"],
    ClipsDescendants = true,
    Font = ConfigsHub["Font"]
  })
  
  local Containers = Create("Frame", MainFrame, {
    Size = UDim2.new(1, -StartSize, 1, -TabSize),
    Position = UDim2.new(1, 0, 1, 0),
    AnchorPoint = Vector2.new(1, 1),
    BackgroundTransparency = 1
  })
  
  local Containers2 = Create("Frame", MainFrame, {
    Size = UDim2.new(0, StartSize, 1, -TabSize),
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 0, 1, 0),
    BackgroundTransparency = 1
  })Create("UIListLayout", Containers2)
  
  local Scroll = Create("ScrollingFrame", Containers2, {
    Size = UDim2.new(1, 0, 1, 0),
    ScrollingDirection = "Y",
    ScrollBarThickness = 2,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = "Y",
    BackgroundTransparency = 1
  })Create("UIPadding", Scroll, {
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10)
  })Create("UIListLayout", Scroll, {
    Padding = UDim.new(0, 5)
  })local ControlScrollSize = Create("Frame", MainFrame, {
    Size = UDim2.new(0, 15, 1, -TabSize),
    Position = UDim2.new(0, StartSize, 1, 0),
    AnchorPoint = Vector2.new(0, 1),
    BackgroundColor3 = Color3.fromRGB(90, 90, 90),
    BackgroundTransparency = 1,
    Draggable = true,
    Active = true
  })local ControlGuiSize = Create("Frame", MainFrame, {
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(0, 550, 0, 310),
    AnchorPoint = Vector2.new(1, 1),
    BackgroundColor3 = Color3.fromRGB(90, 90, 90),
    BackgroundTransparency = 1,
    Draggable = true,
    Active = true
  })
  
  local NotifiContainer = Create("TextButton", MainFrame, {
    Size = UDim2.new(),
    BackgroundTransparency = 0.4,
    BackgroundColor3 = ConfigsHub["Color Hub 2"],
    AutoButtonColor = false,
    Text = "",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Visible = false
  })ElementsHub:Corner(NotifiContainer, {CornerRadius = UDim.new(0, 8)})
  local NotifiFrameVisible
  NotifiContainer.MouseButton1Click:Connect(function()
    CreateTween(NotifiContainer, "Size", UDim2.new(), 0.3, true)
    NotifiContainer.Visible = false
    NotifiFrameVisible = false
  end)
  local function SetFrameNotifiVisible(Bool)
    if Bool then
      NotifiContainer.Visible = true
      NotifiFrameVisible = true
      CreateTween(NotifiContainer, "Size", UDim2.new(1, 0, 1, 0), 0.3, true)
    else
      CreateTween(NotifiContainer, "Size", UDim2.new(), 0.3, true)
      NotifiContainer.Visible = false
      NotifiFrameVisible = false
    end
  end
  
  local function ControlSize()
    ControlGuiSize.Position = UDim2.new(0, math.clamp(ControlGuiSize.Position.X.Offset, 400, 900), 0, math.clamp(ControlGuiSize.Position.Y.Offset, 200, 500))
    ControlScrollSize.Position = UDim2.new(0, math.clamp(ControlScrollSize.Position.X.Offset, 140, 275), 1, 0)
    Containers2.Size = UDim2.new(0, ControlScrollSize.Position.X.Offset, 1, -TabSize)
    MainFrame.Size = ControlGuiSize.Position
    Containers.Size = UDim2.new(1, -ControlScrollSize.Position.X.Offset, 1, -TabSize)
  end
  
  ControlGuiSize:GetPropertyChangedSignal("Position"):Connect(ControlSize)
  ControlScrollSize:GetPropertyChangedSignal("Position"):Connect(ControlSize)
  
  local MinimizeButton = Create("TextButton", TopBar, {
    Size = UDim2.new(0, 25, 0, 25),
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -30, 0.5, 0),
    Text = "-",
    Font = Enum.Font.FredokaOne,
    TextSize = 30,
    TextYAlignment = "Bottom",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1
  })
  local CloseButton = Create("TextButton", TopBar, {
    Size = UDim2.new(0, 25, 0, 25),
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -10, 0.5, 0),
    Text = "×",
    Font = Enum.Font.FredokaOne,
    TextSize = 30,
    TextYAlignment = "Bottom",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1
  })
  
  local Minimized, SaveSize, WaitPress
  MinimizeButton.MouseButton1Click:Connect(function()
    if not WaitPress then
      WaitPress = true
      MinimizeButton.Text = Minimized and "-" or "+"
      if Minimized then
        local udim = UDim2.new(0, MainFrame.Size.X.Offset, 0, SaveSize)
        CreateTween(MainFrame, "Size", udim, 0.3, true)
      else
        SaveSize = MainFrame.Size.Y.Offset local udim = UDim2.new(0, MainFrame.Size.X.Offset, 0, 30)
        CreateTween(MainFrame, "Size", udim, 0.3, true)
      end
      ControlGuiSize.Active = Minimized
      ControlGuiSize.Draggable = Minimized
      Minimized = not Minimized
      WaitPress = false
    end
  end)
  
  CloseButton.MouseButton1Click:Connect(function()
    
  end)
  
  local Window = {}
  local IsFirst = true
  
  function Window:Set(val1)
    if typeof(val1) == "number" then
      MainFrame.Transparency = val1
    elseif typeof(val1) == "Color3" then
      MainFrame.BackgroundColor3 = val1
    end
  end
  
  function Window:Destroy()
    MainFrame:Destroy()
  end
  
  function Window:Visible(Bool)
    MainFrame.Visible = Bool
  end
  
  function Window:Separator()
    local Frame1 = Create("Frame", Scroll, {
      Size = UDim2.new(1, 0, 0, 15),
      BackgroundTransparency = 1
    })
    
    local Frame2 = Create("Frame", Frame1, {
      Size = UDim2.new(1, -15, 0, 6),
      Position = UDim2.new(0.5, 0, 0.5, 0),
      AnchorPoint = Vector2.new(0.5, 0.5),
      BackgroundColor3 = ConfigsHub["Color Theme"],
      BackgroundTransparency = 0.6
    })ElementsHub:Corner(Frame2, {CornerRadius = UDim.new(0, 1e3)})
    
    local Separator = {}
    
    function Separator:Destroy()
      Frame1:Destroy()
    end
    
    function Separator:Visible(Bool)
      Frame1.Visible = Bool
    end
    
    return Separator
  end
  
  function Window:MakeTab(Configs)
    local TabName = Configs[1] or Configs.Name or "Redz Library"
    local TabImage = Configs[2] or Configs.Image or ""
    
    local TabFrame = ElementsHub:Button(Scroll, 20)
    ElementsHub:Corner(TabFrame)
    
    local ImageLabel = Create("ImageLabel", TabFrame, {
      Image = TabImage,
      Size = UDim2.new(0, 15, 1, -5),
      AnchorPoint = Vector2.new(0, 0.5),
      Position = UDim2.new(0, 5, 0.5, 0),
      BackgroundTransparency = 1,
      ImageTransparency = IsFirst and 0 or 0.4,
    })
    
    local TextLabel = ElementsHub:Text(TabFrame, {
      Text = TabName,
      TextSize = 15,
      TextXAlignment = "Left",
      Position = UDim2.new(0, 35, 0, 0),
      TextTransparency = IsFirst and 0 or 0.4,
    })
    
    local IsSelected = Create("Frame", TabFrame, {
      Size = UDim2.new(0, 5, 1, -5),
      BackgroundColor3 = ConfigsHub["Color Theme"],
      BackgroundTransparency = IsFirst and 0 or 1,
      Position = UDim2.new(0, 25, 0.5, 0),
      AnchorPoint = Vector2.new(0, 0.5)
    })ElementsHub:Corner(IsSelected)
    
    local Container = Create("ScrollingFrame", Containers, {
      Size = UDim2.new(1, 0, 1, 0),
      BackgroundTransparency = 1,
      Visible = IsFirst,
      ScrollBarThickness = 2,
      ScrollingDirection = "Y",
      AutomaticCanvasSize = "Y",
      CanvasSize = UDim2.new()
    })Create("UIPadding", Container, {
      PaddingLeft = UDim.new(0, 10),
      PaddingRight = UDim.new(0, 10),
      PaddingTop = UDim.new(0, 10),
      PaddingBottom = UDim.new(0, 10)
    })Create("UIListLayout", Container, {
      Padding = UDim.new(0, 5)
    })
    
    TabFrame.MouseButton1Down:Connect(function()
      for _,frame in pairs(Containers:GetChildren()) do
        if frame ~= Container and frame:IsA("ScrollingFrame") then
          frame.Visible = false
        elseif frame:IsA("ScrollingFrame") then
          frame.Visible = true
        end
      end
      for _,frame in pairs(Scroll:GetChildren()) do
        if frame ~= TabFrame and frame:IsA("TextButton") then
          task.spawn(function()CreateTween(frame.Frame, "BackgroundTransparency", 1, 0.3)end)
          task.spawn(function()CreateTween(frame.ImageLabel, "ImageTransparency", 0.4, 0.3)end)
          task.spawn(function()CreateTween(frame:WaitForChild("Text"), "TextTransparency", 0.4, 0.3)end)
        end
      end
      task.spawn(function()CreateTween(IsSelected, "BackgroundTransparency", 0, 0.3)end)
      task.spawn(function()CreateTween(ImageLabel, "ImageTransparency", 0, 0.3)end)
      task.spawn(function()CreateTween(TextLabel, "TextTransparency", 0, 0.3)end)
    end)
    
    local Tab = {}
    
    function Tab:Set(NewValue1, NewValue2)
      if typeof(NewValue) == "string" then
        if string.find(NewValue, "rbxassetid://") then
          ImageLabel.Image = NewValue
        else
          TextLabel.Text = NewValue
        end
        if NewValue2 and string.find(NewValue, "rbxassetid://") then
          ImageLabel.Image = NewValue
        end
      end
    end
    
    function Tab:Visible(Bool)
      Container.Visible = Bool
      TabFrame.Visible = Bool
    end
    
    function Tab:Destroy()
      Container:Destroy()
      TabFrame:Destroy()
    end
    
    function Tab:AddSection(Configs)
      local SectionName = Configs[1] or Configs.Name or "Section!!"
      
      local Frame = Create("Frame", Container, {
        Size = UDim2.new(1, 0, 0, 25),
        Name = "Frame",
        BackgroundTransparency = 1
      })ElementsHub:Corner(Frame)
      
      local TextLabel = Create("TextLabel", Frame, {
        TextSize = 14,
        TextColor3 = ConfigsHub["Color Dark Text"],
        Text = SectionName,
        Size = UDim2.new(1, 0, 0, 25),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        TextXAlignment = "Left",
        Font = ConfigsHub["Font"]
      })TextSetColor(TextLabel)
      
      local Section = {}
      
      function Section:Visible(Bool)
        Frame.Visible = Bool
      end
      
      function Section:Set(NewValue1, NewValue2)
        if NewValue2 then
          TextLabel.Text = NewValue1
          TextLabel.TextColor3 = NewValue2
        elseif typeof(NewValue1) == "string" then
          TextLabel.Text = NewValue1
        elseif typeof(NewValue1) == "Color3" then
          TextLabel.TextColor3 = NewValue1
        end
      end
      
      return Section
    end
    
    function Tab:AddLabel(Configs)
      local Type = Configs[1] or Configs.Type or "Text"
      local NameI = Configs[2] or Configs.Name or "Section!!"
      local ImageI = Configs[3] or Configs.Image or "rbxassetid://"
      
      local Frame = Create("Frame", Container, {
        Size = UDim2.new(1, 0, 0, 25),
        Name = "Frame",
        BackgroundColor3 = ConfigsHub["Color Hub 2"]
      })ElementsHub:Corner(Frame)ElementsHub:Stroke(Frame)
      
      local Bagulho1, Bagulho2
      if Type == "Image" then
        Frame.Size = UDim2.new(1, 0, 0, 160)
        Bagulho1 = Create("TextLabel", Frame, {
          TextSize = 16,
          TextColor3 = ConfigsHub["Color Text"],
          Text = NameI,
          Size = UDim2.new(1, -10, 0, 25),
          Position = UDim2.new(0, 10, 0, 0),
          BackgroundTransparency = 1,
          TextXAlignment = "Left",
          Font = ConfigsHub["Font"]
        })TextSetColor(Bagulho1)
        
        Bagulho2 = Create("ImageLabel", Frame, {
          Size = UDim2.new(0, 125, 0, 125),
          Position = UDim2.new(0, 10, 0, 25),
          BackgroundTransparency = 1,
          Image = ImageI
        })
      else
        Bagulho1 = Create("TextLabel", Frame, {
          TextSize = 16,
          TextColor3 = ConfigsHub["Color Text"],
          Text = NameI,
          Size = UDim2.new(1, -10, 1, 0),
          Position = UDim2.new(0, 10, 0, 0),
          BackgroundTransparency = 1,
          TextXAlignment = "Left",
          Font = ConfigsHub["Font"]
        })TextSetColor(Bagulho1)
      end
      
      local Label = {}
      
      function Label:Visible(Bool)
        Frame.Visible = Bool
      end
      
      function Label:Set(NewValue1, NewValue2)
        if Type == "Image" then
          if typeof(NewValue1) == "string" then
            if string.find(NewValue1, "rbxassetid://") then
              Bagulho2.Image = NewValue1
            else
              Bagulho1.Text = NewValue1
            end
            if NewValue2 and string.find(NewValue2, "rbxassetid://") then
              Bagulho2.Image = NewValue2
            end
          elseif typeof(NewValue1) == "Color3" then
            Bagulho1.TextColor3 = NewValue1
          end
        else
          if typeof(NewValue1) == "string" then
            Bagulho1.Text = NewValue1
          elseif typeof(NewValue1) == "Color3" then
            Bagulho1.TextColor3 = NewValue1
          end
        end
      end
      
      return Label
    end
    
    function Tab:AddParagraph(Configs)
      local ParagraphName1 = Configs[1] or Configs.Name or "Paragraph!!"
      local ParagraphName2 = Configs[2] or Configs.Text or "Paragraph!!"
      
      local Frame = Create("Frame", Container, {
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundColor3 = ConfigsHub["Color Hub 2"],
        AutomaticSize = "Y"
      })ElementsHub:Corner(Frame)ElementsHub:Stroke(Frame)
      Create("UIListLayout", Frame)Create("UIPadding", Frame, {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5)})
      
      local TextLabel1 = Create("TextLabel", Frame, {
        TextSize = 15,
        TextColor3 = ConfigsHub["Color Text"],
        Text = ParagraphName1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = "Y",
        BackgroundTransparency = 1,
        TextXAlignment = "Left",
        TextYAlignment = "Top",
        Font = ConfigsHub["Font"],
        TextWrapped = true
      })TextSetColor(TextLabel1)
      
      local TextLabel2 = Create("TextLabel", Frame, {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        AutomaticSize = "Y",
        TextXAlignment = "Left",
        TextYAlignment = "Top",
        TextColor3 = ConfigsHub["Color Dark Text"],
        TextSize = 13,
        Text = ParagraphName2,
        Font = ConfigsHub["Font"],
        TextWrapped = true
      })
      
      local Paragraph = {}
      
      function Paragraph:Set(val1, val2)
        if not val2 then
          TextLabel2.Text = val1
        else
          TextLabel1.Text = val1
          TextLabel2.Text = val2
        end
      end
      
      function Paragraph:Visible(Bool)
        Frame.Visible = Bool
      end
      
      function Paragraph:Destroy()
        Frame:Destroy()
      end
      
      return Paragraph
    end
    
    function Tab:AddButton(Configs)
      local BtnName = Configs[1] or Configs.Name or "Button!"
      local Callback = Configs[2] or Configs.Callback or function()end
      
      local ButtonF = ElementsHub:Button(Container, 25, {
        Name = "Frame"
      })ElementsHub:Corner(ButtonF)ElementsHub:Stroke(ButtonF)
      
      local TextLabel1 = Create("TextLabel", ButtonF, {
        TextSize = 15,
        TextColor3 = ConfigsHub["Color Text"],
        Text = BtnName,
        Size = UDim2.new(1, -45, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        TextXAlignment = "Left",
        Font = ConfigsHub["Font"],
        TextWrapped = true
      })
      
      local Cursor = Create("ImageLabel", ButtonF, {
        Image = Configs[3] or Configs.Cursor or "rbxassetid://15626116789",
        Size = UDim2.new(0, 20, 0, 20),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        BackgroundTransparency = 1,
        ImageColor3 = ConfigsHub["Color Stroke"],
        Rotation = -20
      })
      
      local SaveColor, IsPress
      ButtonF.MouseButton1Click:Connect(function()
        if not IsPress then
          IsPress = true
          task.spawn(function()CreateTween(Cursor, "ImageColor3", ConfigsHub["Color Theme"], 0.5, true)end)
          CreateTween(TextLabel1, "TextColor3", ConfigsHub["Color Theme"], 0.5, true)
          task.spawn(function()CreateTween(Cursor, "ImageColor3", ConfigsHub["Color Stroke"], 0.5, true)end)
          CreateTween(TextLabel1, "TextColor3", ConfigsHub["Color Text"], 0.5, true)
          IsPress = false
        end
        Callback("Click")
      end)
      
      TextLabel1.MouseEnter:Connect(function()
        if not IsPress then
          CreateTween(TextLabel1, "TextColor3", ConfigsHub["Color Theme"], 0.4, false)
        end
      end)
      TextLabel1.MouseLeave:Connect(function()
        if not IsPress then
          CreateTween(TextLabel1, "TextColor3", ConfigsHub["Color Text"], 0.4, false)
        end
      end)
      
      local Button = {}
      
      function Button:Set(val1, val2, val3)
        if typeof(val1) == "function" then Callback = val1
        elseif typeof(val1) == "Color3" then TextLabel1.TextColor3 = val1
        elseif typeof(val1) == "string" then TextLabel1.Text = val1 end
      end
      
      function Button:Visible(Boll)
        ButtonF.Visible = Boll
      end
      
      function Button:Destroy()
        ButtonF:Destroy()
      end
      
      return Button
    end
    
    function Tab:AddToggle(Configs)
      local TName = Configs[1] or Configs.Name or "Toggle!!"
      local Default = Configs[2] or Configs.Default or false
      local Callback = Configs[3] or Configs.Callback or function()end
      
      local ButtonF = ElementsHub:Button(Container, 25, {
        Name = "Frame"
      })ElementsHub:Corner(ButtonF)ElementsHub:Stroke(ButtonF)
      
      local TextLabel1 = Create("TextLabel", ButtonF, {
        TextSize = 15,
        TextColor3 = ConfigsHub["Color Text"],
        Text = TName,
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        TextXAlignment = "Left",
        Font = ConfigsHub["Font"],
        TextWrapped = true
      })
      
      local T1 = Create("Frame", ButtonF, {
        Size = UDim2.new(0, 30, 1, -8),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        BackgroundTransparency = 1
      })ElementsHub:Corner(T1, {CornerRadius = UDim.new(0, 1e3)})
      local Stroke = ElementsHub:Stroke(T1, {Thickness = 2})
      
      local T2 = Create("Frame", T1, {
        Size = UDim2.new(0, 16, 1, -2),
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 1.8, 0.5, 0),
        BackgroundColor3 = ConfigsHub["Color Stroke"]
      })ElementsHub:Corner(T2, {CornerRadius = UDim.new(0, 1e3)})
      
      if Default then
        task.spawn(function()CreateTween(T2, "AnchorPoint", Vector2.new(1, 0.5), 0.3, false)end)
        task.spawn(function()CreateTween(T2, "Position", UDim2.new(1, -1.8, 0.5, 0), 0.3, false)end)
        Callback(true)
      else
        Callback(false)
      end
  
      local ToggleVal = Default
      local function Set(Val)
        Callback(Val)ToggleVal = Val
        if not Val then
          task.spawn(function()CreateTween(T2, "AnchorPoint", Vector2.new(0, 0.5), 0.2, false)end)
          task.spawn(function()CreateTween(T2, "Position", UDim2.new(0, 1.8, 0.5, 0), 0.2, false)end)
          task.spawn(function()CreateTween(T2, "BackgroundColor3", ConfigsHub["Color Stroke"], 0.2, false)end)
          task.spawn(function()CreateTween(Stroke, "Color", ConfigsHub["Color Stroke"], 0.2, false)end)
          task.spawn(function()CreateTween(TextLabel1, "TextColor3", ConfigsHub["Color Text"], 0.2, false)end)
        else
          task.spawn(function()CreateTween(T2, "AnchorPoint", Vector2.new(1, 0.5), 0.2, false)end)
          task.spawn(function()CreateTween(T2, "Position", UDim2.new(1, -1.8, 0.5, 0), 0.2, false)end)
          task.spawn(function()CreateTween(T2, "BackgroundColor3", ConfigsHub["Color Theme"], 0.2, false)end)
          task.spawn(function()CreateTween(Stroke, "Color", ConfigsHub["Color Theme"], 0.2, false)end)
          task.spawn(function()CreateTween(TextLabel1, "TextColor3", ConfigsHub["Color Theme"], 0.2, false)end)
        end
      end
      
      TextLabel1.MouseEnter:Connect(function()
        if not ToggleVal then
          CreateTween(TextLabel1, "TextColor3", ConfigsHub["Color Theme"], 0.4, false)
        end
      end)
      TextLabel1.MouseLeave:Connect(function()
        if not ToggleVal then
          CreateTween(TextLabel1, "TextColor3", ConfigsHub["Color Text"], 0.4, false)
        end
      end)
      
      ButtonF.MouseButton1Click:Connect(function()
        ToggleVal = not ToggleVal
        Set(ToggleVal)
      end)
      
      Toggle = {}
      
      function Toggle:Set(val1)
        if typeof(val1) == "function" then Callback = val1
        elseif typeof(val1) == "Color3" then TextLabel1.TextColor3 = val1
        elseif typeof(val1) == "boolean" then Set(val1)
        elseif typeof(val1) == "string" then TextLabel1.Text = val1 end
      end
      
      function Toggle:Destroy()
        ButtonF:Destroy()
      end
      
      function Toggle:Visible(Bool)
        ButtonF.Visible = Bool
      end
        
      return Toggle
    end
    
    function Tab:AddSlider(Configs)
      local SName = Configs[1] or Configs.Name or "Slider!!"
      local Increase = Configs[5] or Configs.Increase or 1
      local Min = Configs[2] and Configs[2] / Increase or Configs.MinValue and Configs.MinValue / Increase or 10 / Increase
      local Max = Configs[3] and Configs[3] / Increase or Configs.MaxValue and Configs.MaxValue / Increase or 100 / Increase
      local Default = Configs[4] or Configs.Default or 25
      local Callback = Configs[6] or Configs.Callback or function()end
      
      local Frame = Create("Frame", Container, {
        BackgroundColor3 = ConfigsHub["Color Hub 2"],
        Size = UDim2.new(1, 0, 0, 25)
      })ElementsHub:Corner(Frame)ElementsHub:Stroke(Frame)
      
      local TextLabel1 = Create("TextLabel", Frame, {
        TextSize = 15,
        TextColor3 = ConfigsHub["Color Text"],
        Text = SName,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        TextXAlignment = "Left",
        Font = ConfigsHub["Font"],
        TextWrapped = true
      })TextSetColor(TextLabel1)
      
      local MouseDetect = Create("TextButton", Frame, {
        Size = UDim2.new(0.45, 0, 1, 0),
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1
      })
      
      local SliderBar = Create("Frame", MouseDetect, {
        Size = UDim2.new(1, -20, 0, 8),
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 10, 0.5, 0),
        BackgroundColor3 = ConfigsHub["Color Stroke"]
      })ElementsHub:Corner(SliderBar)
      
      local BaseMousePos = Create("Frame", SliderBar, {
        Size = UDim2.new(0, 0, 1, 0),
        Visible = false
      })
      
      local Indicator = Create("Frame", SliderBar, {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = ConfigsHub["Color Theme"]
      })ElementsHub:Corner(Indicator)
      
      local SliderIcon = Create("Frame", SliderBar, {
        Size = UDim2.new(0, 8, 0, 15),
        BackgroundColor3 = Color3.fromRGB(200, 200, 200),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0)
      })ElementsHub:Corner(SliderIcon)
      
      local TextLabel2 = Create("TextLabel", MouseDetect, {
        Text = "...",
        TextScaled = true,
        Font = ConfigsHub["Font"],
        Size = UDim2.new(0, 25, 0, 25),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        TextColor3 = ConfigsHub["Color Text"]
      })
      
      local MouseOn, AtualValue
      
      local function Set(NewVal)
        if typeof(NewVal) == "number" then
          
        end
      end
      
      local function UpdateLabel(NewValue)
        local Number = tostring(NewValue * Increase)
        
        if string.find(Number, ".") then
          Number = string.sub(Number, 1, 5)
        end
        TextLabel2.Text = Number
        Callback(tonumber(Number))
      end
      
      local function ControlPos()
        while MouseOn do task.wait()
          local MousePos = GetMousePos()
          local APos = MousePos.X - BaseMousePos.AbsolutePosition.X
          local ConfigureDpiPos = APos / SliderBar.AbsoluteSize.X
          
          SliderIcon.Position = UDim2.new(math.clamp(ConfigureDpiPos, 0, 1), 0, 0.5, 0)
        end
      end
      
      MouseDetect.MouseLeave:Connect(function()
        MouseOn = false
      end)
      
      MouseDetect.MouseButton1Down:Connect(function()
        MouseOn = true
        ControlPos()
      end)
      
      SliderIcon.Changed:Connect(function()
        Indicator.Size = UDim2.new(SliderIcon.Position.X.Scale, 0, 1, 0)
        local SliderPos = SliderIcon.Position.X.Scale
        local NewValue = math.floor(((SliderPos * Max) / Max) * (Max - Min) + Min)
        UpdateLabel(NewValue)
      end)
      
      local Slider = {}
      
      function Slider:Set(val1)
        if typeof(val1) == "function" then Callback = val1
        elseif typeof(val1) == "Color3" then TextLabel1.TextColor3 = val1
        elseif typeof(val1) == "string" then TextLabel1.Text = val1
        elseif typeof(val1) == "number" then Set(val1) end
      end
      
      function Slider:Visible(Bool)
        Frame.Visible = Bool
      end
      
      function Slider:Destroy()
        Frame:Destroy()
      end
      
      return Slider
    end
    
    function Tab:AddDiscordInvite(Configs)
      local DiscordLink = Configs[1] or Configs.DiscordLink or "https://discord.gg/"
      local DiscordIcon = Configs[2] or Configs.DiscordIcon or "rbxassetid://"
      local DiscordTitle = Configs[3] or Configs.DiscordTitle or ""
      
      local Frame1 = Create("Frame", Container, {
        Size = UDim2.new(1, 0, 0, 110),
        BackgroundTransparency = 1
      })
      
      local Frame2 = Create("Frame", Frame1, {
        Size = UDim2.new(1, 0, 0, 110 - 25),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Position = UDim2.new(0, 0, 0, 25),
        BackgroundColor3 = ConfigsHub["Color Hub 2"]
      })ElementsHub:Corner(Frame2)
      
      local LinkLabel = Create("TextLabel", Frame1, {
        Size = UDim2.new(1, 0, 0, 25),
        Text = DiscordLink,
        TextXAlignment = "Left",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        TextColor3 = Color3.fromRGB(30, 160, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 14
      })
      
      local TitleLabel = Create("TextLabel", Frame2, {
        Size = UDim2.new(1, 0, 0, 20),
        Text = DiscordTitle,
        TextXAlignment = "Left",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 60, 0, 5),
        TextColor3 = ConfigsHub["Color Text"],
        Font = Enum.Font.GothamBold,
        TextSize = 14
      })
      
      local IconLabel = Create("ImageLabel", Frame2, {
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(0, 12, 0, 5),
        Image = DiscordIcon
      })ElementsHub:Corner(IconLabel, {CornerRadius = UDim.new(0, 8)})
      
      local JoinButton = Create("TextButton", Frame2, {
        Size = UDim2.new(1, -24, 0, 25),
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -8),
        Text = "Join",
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = Color3.fromRGB(220, 220, 220),
        BackgroundColor3 = Color3.fromRGB(50, 150, 50)
      })ElementsHub:Corner(JoinButton)
      
      local time = tick()
      local JoinClick
      JoinButton.MouseButton1Click:Connect(function()
        setclipboard(DiscordLink)
        if not JoinClick then
          JoinClick = true
          JoinButton.Text = "Copied to Clipboard"
          JoinButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
          JoinButton.TextColor3 = Color3.fromRGB(150, 150, 150)
          task.wait(5)
          JoinButton.Text = "Join"
          JoinButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
          JoinButton.TextColor3 = Color3.fromRGB(220, 220, 220)
          JoinClick = false
        end
      end)
    end
    
    function Tab:AddTextBox(Configs)
      local TName = Configs[1] or Configs.Name or "Text Box!!"
      local Default = Configs[2] or Configs.Default or ""
      local PHText = Configs[3] or Configs.PlaceholderText or "< input >"
      local ClearOnFocus = Configs[4] or Configs.ClearText or false
      local Callback = Configs[5] or Configs.Callback or function()end
      
      local Frame = Create("Frame", Container, {
        BackgroundColor3 = ConfigsHub["Color Hub 2"],
        Size = UDim2.new(1, 0, 0, 25)
      })ElementsHub:Corner(Frame)ElementsHub:Stroke(Frame)
      
      local TextLabel1 = Create("TextLabel", Frame, {
        TextSize = 15,
        TextColor3 = ConfigsHub["Color Text"],
        Text = TName,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        TextXAlignment = "Left",
        Font = ConfigsHub["Font"],
        TextWrapped = true
      })TextSetColor(TextLabel1)
      
      local TextBox = Create("TextBox", Frame, {
        Size = UDim2.new(0.45, -18, 0, 20),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        BackgroundTransparency = 0.8,
        TextColor3 = ConfigsHub["Color Text"],
        Font = ConfigsHub["Font"],
        TextScaled = true,
        ClearTextOnFocus = ClearOnFocus,
        PlaceholderText = PHText,
        Text = ""
      })ElementsHub:Corner(TextBox)
      
      local Pencil = Create("ImageLabel", TextBox, {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, -5, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        Image = "rbxassetid://15637081879",
        BackgroundTransparency = 1,
        ImageColor3 = ConfigsHub["Color Stroke"]
      })
      
      local function SetBox(NewText)
        TextBox.Text = NewText
        Callback(NewText)
      end
      
      TextBox.MouseEnter:Connect(function()
        CreateTween(Pencil, "ImageColor3", ConfigsHub["Color Theme"], 0.5, true)
        CreateTween(Pencil, "ImageColor3", ConfigsHub["Color Stroke"], 0.5, true)
      end)
      
      TextBox.FocusLost:Connect(function()
        Callback(TextBox.Text)
        CreateTween(Pencil, "ImageColor3", ConfigsHub["Color Theme"], 0.5, true)
        CreateTween(Pencil, "ImageColor3", ConfigsHub["Color Stroke"], 0.5, true)
      end)
      TextBox.Text = Default
      
      local TextBoxF = {}
      
      function TextBoxF:Set()
        if typeof(val1) == "function" then Callback = val1
        elseif typeof(val1) == "Color3" then TextLabel1.TextColor3 = val1
        elseif typeof(val1) == "string" then SetBox(val1) end
      end
      
      function TextBoxF:Destroy()
        Frame:Destroy()
      end
      
      function TextBoxF:Visible(Bool)
        Frame.Visible = Value
      end
      
      return TextBoxF
    end
    
    function Tab:AddDropdown(Configs)
      local DName = Configs[1] or Configs.Name or "Dropdown!!"
      local Options = Configs[2] or Configs.Options or {"1", "2", "3"}
      local Default = Configs[3] or Configs.Default or "2"
      local MultSelect = Configs[4] or Configs.MultSelect or false
      local Callback = Configs[5] or Configs.Callback or function()end
      
      local Frame = Create("TextButton", Container, {
        BackgroundColor3 = ConfigsHub["Color Hub 2"],
        Size = UDim2.new(1, 0, 0, 25),
        Text = "",
        AutoButtonColor = false,
        Name = "Frame"
      })ElementsHub:Corner(Frame)ElementsHub:Stroke(Frame)
      
      local MainContainer = Create("Frame", Frame, {
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundTransparency = 1
      })
      
      local TextLabel1 = Create("TextLabel", MainContainer, {
        TextSize = 15,
        TextColor3 = ConfigsHub["Color Text"],
        Text = DName,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        TextXAlignment = "Left",
        Font = ConfigsHub["Font"],
        TextWrapped = true
      })TextSetColor(TextLabel1)
      
      local TextLabel2 = Create("TextLabel", MainContainer, {
        Size = UDim2.new(0.45, -18, 0, 20),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        BackgroundTransparency = 0.8,
        TextColor3 = ConfigsHub["Color Text"],
        Font = ConfigsHub["Font"],
        TextScaled = true,
        Text = "..."
      })ElementsHub:Corner(TextLabel2)
      
      local Arrow = Create("ImageLabel", TextLabel2, {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, -5, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        Image = "rbxassetid://15637313297",
        BackgroundTransparency = 1,
        Rotation = 180,
        ImageColor3 = ConfigsHub["Color Stroke"]
      })
      
      local ContainerList = Create("ScrollingFrame", Frame, {
        Size = UDim2.new(1, 0, 1, -25),
        Position = UDim2.new(0, 0, 0, 25),
        ScrollBarThickness = 2,
        ScrollingDirection = "Y",
        AutomaticCanvasSize = "Y",
        CanvasSize = UDim2.new(),
        BackgroundTransparency = 1
      })Create("UIPadding", ContainerList, {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10)
      })Create("UIListLayout", ContainerList, {
        Padding = UDim.new(0, 5)
      })
      
      local OptionsC, SelectedOption = {}, "", {}
      local function Void()
        table.foreach(ContainerList:GetChildren(), function(a, b)
          if b:IsA("TextButton") then
            b:Destroy()
          end
        end)
        TextLabel2.Text = "..."
        OptionsC = {}
      end
      
      local function RemoveOption(name)
        local Option = ContainerList:FindFirstChild(name)
        if Option then
          Option:Destroy()
          table.remove(OptionsC, name)
        end
      end
      
      local function AddOption(val, void)
        local function CreateButton(name)
          table.insert(OptionsC, name)
          local Frame = Create("TextButton", ContainerList, {
            Size = UDim2.new(1, 0, 0, 15),
            Text = "",
            BackgroundTransparency = 1
          })ElementsHub:Corner(Frame)
          
          local TextLabel = Create("TextLabel", Frame, {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 20, 0, 0),
            Text = name,
            TextColor3 = ConfigsHub["Color Dark Text"],
            Font = ConfigsHub["Font"],
            TextSize = 14,
            BackgroundTransparency = 1,
            TextXAlignment = "Left"
          })
          
          local Selected = Create("Frame", Frame, {
            Size = UDim2.new(0, 5, 0, 10),
            Position = UDim2.new(0, 10, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            BackgroundColor3 = ConfigsHub["Color Theme"]
          })ElementsHub:Corner(Selected)
          
          if name == Default or name == SelectedOption then
            task.spawn(function()CreateTween(Selected, "BackgroundTransparency", 0, 0.2, true)end)
            task.spawn(function()CreateTween(TextLabel, "TextColor3", ConfigsHub["Color Text"], 0.2, true)end)
            task.spawn(function()CreateTween(Frame, "BackgroundTransparency", 0.7, 0.2, true)end)
            SelectedOption = name
            TextLabel2.Text = name
            Callback(name)
          end
          
          Frame.MouseButton1Click:Connect(function()
            for _,option in pairs(ContainerList:GetChildren()) do
              if option ~= Frame and option:IsA("TextButton") then
                task.spawn(function()CreateTween(option.Frame, "BackgroundTransparency", 1, 0.2, true)end)
                task.spawn(function()CreateTween(option.TextLabel, "TextColor3", ConfigsHub["Color Dark Text"], 0.2, true)end)
                task.spawn(function()CreateTween(option, "BackgroundTransparency", 1, 0.2, true)end)
              end
            end
            task.spawn(function()CreateTween(Selected, "BackgroundTransparency", 0, 0.2, true)end)
            task.spawn(function()CreateTween(TextLabel, "TextColor3", ConfigsHub["Color Text"], 0.2, true)end)
            task.spawn(function()CreateTween(Frame, "BackgroundTransparency", 0.7, 0.2, true)end)
            SelectedOption = name
            TextLabel2.Text = name
            Callback(name)
          end)
        end
        
        local function CreateToggle(name)
          table.insert(OptionsC, name)
          local Frame = Create("TextButton", ContainerList, {
            Size = UDim2.new(1, 0, 0, 15),
            Text = "",
            BackgroundTransparency = 1
          })ElementsHub:Corner(Frame)
          
          local TextLabel = Create("TextLabel", Frame, {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 20, 0, 0),
            Text = name,
            TextColor3 = ConfigsHub["Color Dark Text"],
            Font = ConfigsHub["Font"],
            TextSize = 14,
            BackgroundTransparency = 1,
            TextXAlignment = "Left"
          })
          
          local Selected = Create("Frame", Frame, {
            Size = UDim2.new(0, 5, 0, 10),
            Position = UDim2.new(0, 10, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            BackgroundColor3 = ConfigsHub["Color Theme"]
          })ElementsHub:Corner(Selected)
          
          if name == Default or table.find(SelectedOptionT, name) then
            task.spawn(function()CreateTween(Selected, "BackgroundTransparency", 0, 0.2, true)end)
            task.spawn(function()CreateTween(TextLabel, "TextColor3", ConfigsHub["Color Text"], 0.2, true)end)
            task.spawn(function()CreateTween(Frame, "BackgroundTransparency", 0.7, 0.2, true)end)
            SetLabelToggle()
          end
          
          Frame.MouseButton1Click:Connect(function()
            task.spawn(function()CreateTween(Selected, "BackgroundTransparency", 0, 0.2, true)end)
            task.spawn(function()CreateTween(TextLabel, "TextColor3", ConfigsHub["Color Text"], 0.2, true)end)
            task.spawn(function()CreateTween(Frame, "BackgroundTransparency", 0.7, 0.2, true)end)
            SelectedOption = name
            TextLabel2.Text = name
            Callback(name)
          end)
        end
        
        if typeof(val) == "table" then
          if void then
            Void()
          end
          
          table.foreach(val, function(a, b)
            if not table.find(OptionsC, b) then
              if MultSelect then
              else
                CreateButton(b)
              end
            end
          end)
        else
        end
      end;AddOption(Options, true)
      
      local function GetNumber()
        local counter = 0
        for _,v in pairs(ContainerList:GetChildren()) do
          if v:IsA("TextButton") then
            counter = counter + 1
          end
        end
        return counter
      end
      
      local Minimized, WaitPress
      Frame.MouseButton1Click:Connect(function()
        if not WaitPress then
          local SizeY
          if GetNumber() >= 1 then
            SizeY = (35 + math.clamp(GetNumber(), 1, 4) * 20)
          else
            SizeY = 25
          end
          
          WaitPress = true
          if not Minimized then
            task.spawn(function()CreateTween(Arrow, "Rotation", 0, 0.3, false)end)
            task.spawn(function()CreateTween(Arrow, "ImageColor3", ConfigsHub["Color Theme"], 0.3, false)end)
            CreateTween(Frame, "Size", UDim2.new(1, 0, 0, SizeY), 0.3, true)
          else
            task.spawn(function()CreateTween(Arrow, "Rotation", 180, 0.3, false)end)
            task.spawn(function()CreateTween(Arrow, "ImageColor3", ConfigsHub["Color Stroke"], 0.3, false)end)
            CreateTween(Frame, "Size", UDim2.new(1, 0, 0, 25), 0.3, true)
          end
          Minimized = not Minimized
          WaitPress = false
        end
      end)
      
      local DropdownF = {}
      
      function DropdownF:Void()
        Void()
      end
      
      function DropdownF:Set(val1, val2)
        if val1 and typeof(val1) == "string" then TextLabel1.Text = val1
        elseif val1 and typeof(val1) == "function" then Callback = val1
        elseif val1 and val2 and typeof(val1) == "table" then AddOption(val1, val2) end
      end
      
      function DropdownF:Visible(Bool)
        Frame.Visible = Bool
      end
      
      function DropdownF:Destroy()
        Frame:Destroy()
      end
      
      return DropdownF
    end
    
    function Tab:AddColorpicker(Configs)
      local CName = Configs[1] or Configs.Name or "Colorpicker"
      local DefaultColor = Configs[2] or Configs.Default or Color3.fromRGB(0, 120, 50)
      local Callback = Configs[3] or Configs.Callback or function()end
      
      local DColorHSV = Color3.toHSV(DefaultColor)
      local ColorH, ColorS, ColorV = select(1, DColorHSV), select(2, DColorHSV), select(3, DColorHSV)
      
      local Frame = Create("TextButton", Container, {
        BackgroundColor3 = ConfigsHub["Color Hub 2"],
        Size = UDim2.new(1, 0, 0, 25),
        Text = "",
        AutoButtonColor = false,
        Name = "Frame"
      })ElementsHub:Corner(Frame)ElementsHub:Stroke(Frame)
      
      local MainContainer = Create("Frame", Frame, {
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundTransparency = 1
      })
      
      local TextLabel1 = Create("TextLabel", MainContainer, {
        TextSize = 15,
        TextColor3 = ConfigsHub["Color Text"],
        Text = CName,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        TextXAlignment = "Left",
        Font = ConfigsHub["Font"],
        TextWrapped = true
      })TextSetColor(TextLabel1)
      
      local ColorSelected = Create("Frame", MainContainer, {
        Size = UDim2.new(0, 60, 1, -5),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0)
      })ElementsHub:Corner(ColorSelected)
      
      local ColorpickerC = Create("Frame", Frame, {
        Size = UDim2.new(1, 0, 1, -25),
        Position = UDim2.new(0, 0, 0, 25),
        BackgroundTransparency = 1,
        ClipsDescendants = true
      })
      
      local Select1 = Create("ImageButton", ColorpickerC, {
        Size = UDim2.new(0, 180, 1, -20),
        Position = UDim2.new(0, 10, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        AutoButtonColor = false,
        Image = "rbxassetid://6333902413"
      })ElementsHub:Corner(Select1)local BaseMousePos1 = Create("Frame", Select1, {
        Visible = false
      })
      
      local Select2 = Create("ImageButton", Select1, {
        Size = UDim2.new(0, 25, 1, -20),
        Position = UDim2.new(1, 10, 0, 0),
        AutoButtonColor = false
      })ElementsHub:Corner(Select2)local BaseMousePos2 = Create("Frame", Select2, {
        Visible = false
      })Create("UIGradient", Select2, {
        Rotation = 90,
        Color = ColorSequence.new({
          ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
          ColorSequenceKeypoint.new(1.00, Color3.fromRGB()),
        })
      })
      
      local Mouse1 = Create("Frame", Select1, {
        Size = UDim2.new(0, 15, 0, 15),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(ColorS, 0, ColorH, 0),
        BackgroundTransparency = 1
      })ElementsHub:Corner(Mouse1, {CornerRadius = UDim.new(0, 1e4)})Create("UIStroke", Mouse1, {
        Thickness = 1.2,
        Color = Color3.fromRGB(255, 255, 255)
      })
      
      local Mouse2 = Create("Frame", Select2, {
        Size = UDim2.new(1, 0, 0, 10),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, ColorV, 0),
        BackgroundTransparency = 1
      })ElementsHub:Corner(Mouse2, {CornerRadius = UDim.new(0, 1e4)})Create("UIStroke", Mouse2, {
        Thickness = 1.2,
        Color = Color3.fromRGB(255, 255, 255)
      })
      
      local function ConfigureColor()
        
      end
      
      local Mouse1On, Mouse2On
      local function ControlMouse1()
        while Mouse1On do task.wait()
          local MousePos = GetMousePos()
          local APosX = MousePos.X - BaseMousePos1.AbsolutePosition.X
          local APosY = MousePos.Y - BaseMousePos1.AbsolutePosition.Y
          local BPosX = APosX / Select1.AbsoluteSize.X
          local BPosY = APosY / Select1.AbsoluteSize.Y
          
          Mouse1.Position = UDim2.new(math.clamp(BPosX, 0, 1), 0, math.clamp(BPosY, 0, 1), 0)
        end
      end
      
      local function ControlMouse2()
        while Mouse2On do task.wait()
          local MousePos = GetMousePos()
          local APosY = MousePos.Y - BaseMousePos2.AbsolutePosition.Y
          local BPosY = APosY / Select2.AbsoluteSize.Y
          
          Mouse2.Position = UDim2.new(0.5, 0, math.clamp(BPosY, 0, 1), 0)
          ColorH = math.clamp(BPosY, 0, 1)
          ConfigureColor()
        end
      end
      
      Select1.MouseLeave:Connect(function()
        Mouse1On = false
      end)
      
      Select1.MouseButton1Down:Connect(function()
        Mouse1On = true
        ControlMouse1()
      end)
      
      Select2.MouseLeave:Connect(function()
        Mouse2On = false
      end)
      
      Select2.MouseButton1Down:Connect(function()
        Mouse2On = true
        ControlMouse2()
      end)
      
      local Minimized, WaitClick
      Frame.MouseButton1Click:Connect(function()
        if not WaitClick then
          WaitClick = true
          if not Minimized then
            CreateTween(Frame, "Size", UDim2.new(1, 0, 0, 135), 0.3, true)
          else
            CreateTween(Frame, "Size", UDim2.new(1, 0, 0, 25), 0.3, true)
          end
          WaitClick = false
          Minimized = not Minimized
        end
      end)
      
      local Colorpicker = {}
      
      function Colorpicker:Destroy()
        
      end
      
      function Colorpicker:Visible(Bool)
        
      end
      
      return Colorpicker
    end
    
    IsFirst = false
    return Tab
  end
  
  return Window
end

local Window = RedzLib:MakeWindow({
  Menu = {
    Title = "REDz HUB teste"
  },
  Animation = {
    Title = "by : redz9999"
  }
})

-- Criar Tab
local Tab1 = Window:MakeTab({"Main", "rbxassetid://13687632207"})
local Tab2 = Window:MakeTab({"Player", "rbxassetid://13687632207"})
Window:Separator()
local Tab3 = Window:MakeTab({"Misc", "rbxassetid://13687780725"})
-- Tab4:Destroy()
Tab1:Set("Bom Dia", "rbxassetid://13687698628")
Tab2:AddSection({"Zé da manga"})
Tab2:AddLabel({"Text", "Bom Dia Caralho!!"})
Tab2:AddLabel({"Image", "Um Carro", "rbxassetid://13687698628"})
Tab2:AddParagraph({Name = "Name", Text = "Text"})

local Button = Tab1:AddButton({})
local Toggle = Tab1:AddToggle({"Toggle Teste", false, function(Value)
  Button:Set(tostring(Value))
end})
Toggle:Set("Atualizar Label")
Toggle:Set(true)
Toggle:Set(Color3.fromRGB(255, 0, 0))

local Slider = Tab1:AddSlider({
  Name = "Slider Teste",
  MinValue = 30,
  MaxValue = 1000,
  Default = 0,
  Increase = 1,
  Callback = function(Value)
    Player.Character.Humanoid.WalkSpeed = Value
  end
})Slider:Set(100)

Tab3:AddDiscordInvite({DiscordIcon = "rbxassetid://15298567397",DiscordTitle = "REDz Hub | Community",DiscordLink = "https://discord.gg/7aR7kNVt4g"})
local Slider = Tab3:AddSlider({
  Name = "Background Color",
  MinValue = 0,
  MaxValue = 1,
  Default = 0,
  Increase = 0.1,
  Callback = function(Value)
    Window:Set(Value)
  end
})

local a = Tab1:AddTextBox({})
Tab1:AddDropdown({
  Name = "Numeros",
  Options = {"Melee", "Sword", "Blox Fruit"},
  Default = "Melee",
  MultSelect = false,
  Callback = function(Value)
    Button:Set(Value)
  end
})

Tab1:AddColorpicker({})
