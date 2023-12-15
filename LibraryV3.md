# Redz Library V3
:)

## loadstring Source
Library Source
```lua
local redzlib = loadstring(game:HttpGet("https://pastebin.com/raw/ShJvpAGG"))()
```
Source Functions
```lua
--[[
  redzlib:Destroy() - Void
  
  redzlib:Set(550) - number
  
  redzlib:Visible() - bool
]]
```

## Make Window
Create the Home Window
```lua
local Window = redzlib:MakeWindow({
  Menu = {
    Title = "REDz HUB teste",
  },
  LoadAnim = {
    Active = true,
    Title = "by : redz9999",
    WaitTime = 0.5
  }
})
```
Window Finctions
```
--[[
  Window:Destroy() - Void
  
  Window:Visible(false) - bool
  
  Window:Set(0) - number or Color3
]]
```

## Make Tab
Add a Scroll Tab
```lua
local Tab = Window:MakeTab({
  Name = "Main",
  Image = "rbxassetid://13687780725"
})
```
Tab Functions
```lua
--[[
  Tab:Set("New Name") - Name or Image
  
  Tab:Destroy() - void
   
  Tab:Visible(false) - bool
]]
```

## Add Tab Separator
Add a Scroll Separator
```lua
local Separator = Window:Separator() - Void
```
Separator Functions
```lua
--[[
  Separator:Destroy() - Void
  
  Separator:Visible(false) - bool
]]
```

## Make Notification
Create a notification

