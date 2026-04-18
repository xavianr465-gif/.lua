-- // 1. Global Settings Initialization
getgenv().autogenSettings = {
    PUZZLES_BEFORE_REJOIN = 15,
    PLAYERS_BEFORE_START = 3,
    MAXIMUM_TIMER_SECONDS = 120,
    MINIMUM_TIMER_SECONDS = 3,
    RECENT_SERVER_BLOCKLIST_LENGTH = 5,
    PLAYER_TIMER_CHECK = 1,
    SWAP_ON_MS4 = true,
    SKIP_LAST_PUZZLE = false,
    DISABLE_RENDERING = false,
    AUTO_HIDE_ABILITY = true,
    RUN_ONLY_WHEN_COOLKIDD = false,
    WEBHOOK = "",
}

-- // 2. Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // 3. Create Main Window
local Window = Rayfield:CreateWindow({
   Name = "Autogen Interface",
   LoadingTitle = "Autogen Suite",
   LoadingSubtitle = "Mobile Stable",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "AutogenConfig",
      FileName = "Settings"
   },
   KeySystem = false,
})

-- // 4. Auto Puzzle Tab
local MainTab = Window:CreateTab("Auto Puzzle", 4483362458)

MainTab:CreateButton({
   Name = "EXECUTE AUTO-PUZZLE",
   Callback = function()
      -- FIXED: Points to the raw Lua file, NOT the .gitignore or the repo home
      local scriptUrl = "https://raw.githubusercontent.com/xavianr465-gif/.lua/main/script.lua"
      
      local success, result = pcall(function()
          return game:HttpGet(scriptUrl)
      end)
      
      if success and result and not result:find("404") then
          local run, err = loadstring(result)
          if run then
              run()
              Rayfield:Notify({Title = "Success", Content = "Autogen Running", Duration = 5})
          else
              -- This happens if the code has a syntax error
              Rayfield:Notify({Title = "Script Error", Content = "The script code is invalid.", Duration = 5})
          end
      else
          -- This happens if the link is wrong or GitHub is down
          Rayfield:Notify({Title = "Fetch Failed", Content = "Check if the file is named 'script.lua' in the repo.", Duration = 5})
      end
   end,
})

Rayfield:Notify({Title = "Ready", Content = "Interface Loaded Successfully", Duration = 3})

