--check game ID
if game.PlaceId == 85896571713843 then
   local CurrentVersion = "v1.0"

   --call the library
   local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

   --Gradient function
   function gradient(text, startColor, endColor)
      local result = ""
      local length = #text
  
      for i = 1, length do
          local t = (i - 1) / math.max(length - 1, 1)
          local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
          local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
          local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
          local char = text:sub(i, i)
          result = result .. "<font color=\"rgb(" .. r ..", " .. g .. ", " .. b .. ")\">" .. char .. "</font>"
      end
  
      return result
  end


   --PopUp Window
   local Confirmed = false

   WindUI:Popup({
      Title = gradient("LUCKY LEAKS", Color3.fromHex("#00FF87"), Color3.fromHex("#60EFFF")),
      Icon = "star",
      Content = "Bubble Gim Simulator by " .. gradient("Lucky", Color3.fromHex("#00FF87"), Color3.fromHex("#60EFFF")),
      Buttons = {
         {
               Title = "Cancel",
               --Icon = "",
               Callback = function() end,
               Variant = "Tertiary", -- Primary, Secondary, Tertiary
         },
         {
               Title = "Open",
               Icon = "arrow-right",
               Callback = function() Confirmed = true end,
               Variant = "Primary", -- Primary, Secondary, Tertiary
         }
      }

   })
   repeat wait() until Confirmed

   --create the main window
   local Window = WindUI:CreateWindow({
      Title = gradient("LUCKY LEAKS", Color3.fromHex("#00FF87"), Color3.fromHex("#60EFFF")),
      Icon = "star",
      Author = "Lucky",
      Folder = "CloudHub",
      Size = UDim2.fromOffset(580, 460),
      Transparent = true,
      Theme = "Dark",
      UserEnabled = false,
      SideBarWidth = 200,
      --Background = "rbxassetid://13511292247", -- rbxassetid only
      HasOutline = true,

  })  


  --All Tabs
  local Tabs = {
   FarmTab = Window:Tab({ Title = "Farming", Icon = "rewind" }),
   IslandsTab = Window:Tab({ Title = "Islands", Icon = "tree-palm" }),
   PlayerTab = Window:Tab({ Title = "Player", Icon = "users" })
  }

  --All Variables
   local isBlowBubble = false
   local isSellBubble = false
   local isCollectPickup = false


  --Farm Tab
  Tabs.FarmTab:Toggle({
   Title = "Auto Blow Bubble",
   Default = false,
   Callback = function(state) 
   isBlowBubble = state
   while isBlowBubble do 
      local args = {
         [1] = "BlowBubble"
     }
     
     game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
     wait()   
   end
   
   end
   })

   Tabs.FarmTab:Toggle({
      Title = "Auto Sell Bubble",
      Default = false,
      Callback = function(state) 
      isSellBubble = state
      while isSellBubble do 
         local args = {
            [1] = "SellBubble"
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        
        wait()   
      end
      
      end
      })

      Tabs.FarmTab:Toggle({
         Title = "Auto Collect Pickups",
         Default = false,
         Callback = function(state) 
         isCollectPickup = state
         while isCollectPickup do 
            local args = {
               [1] = "308eb6af-0d62-4712-8c11-3d8a6a982e70"
           }
           
           game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup"):FireServer(unpack(args))
           
           wait()
         end
         
         end
         })
   

--Islands Tab
   --Teleport function
   function Teleport(teleportplace)
      local player = game.Players.LocalPlayer
      player.Character.HumanoidRootPart.CFrame = teleportplace
   end
   
   Tabs.IslandsTab:Button({
      Title = "Unlock All Islands",
      Callback = function() 
         Teleport(workspace.Worlds["The Overworld"].Islands["The Void"].Island.Position)
        wait(0.5)
      end
  })
  
  --Player Tab
  Tabs.PlayerTab:Slider({
   Title = "jump Strenght",
   Value = {
       Min = 70,
       Max = 1000,
       Incriment = 5,
       Default =70,
   },
   Callback = function(value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
   end
  })

end
