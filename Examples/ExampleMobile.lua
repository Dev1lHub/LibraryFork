getgenv().D3v1lHubMobileMode = true
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/D3v1lLoader.lua"))()

-- D3v1lHub example script for MOBILE (phone / tablet)
--
-- What is different in the Mobile menu:
--   * Only MobileGUILib.lua is loaded (slim touch menu).
--   * The menu builds itself step by step (no freezing on start).
--   * Keybinds are ignored (AddKeybind / Keybind option / keybind modes are only placeholders).
--   * VIP elements, tab badges, button Confirm / Cooldown and multiselect Select All / Clear work like on PC.
--   * Notify is active (compact messages, max. 4 at once).
--   * The Settings tab (config only: name, configs, Save/Load/Delete/Autoload) is added by "Themeable".
--
-- Make the build slower/faster (BEFORE CreateWindow):
--   library.MobileBuildBatch = 2      -- elements per pause
--   library.MobileBuildDelay = 0.06   -- pause in seconds, 0 = everything at once
--
-- Executor check (the loader does this automatically):
--   After "Yes" a warning lists functions your executor does not support
--   (the ones the library needs plus your own RequiredFunctions), with Continue / Cancel.
--   getgenv().D3v1lLoaderOptions = {
--       RequiredFunctions = { "hookfunction", getconnections = "used by my auto farm" },
--       KnownUnsupported = { xeno = { "hookmetamethod" } },   -- your own list per executor name
--       ExecutorWarning = false                                -- turn the warning off
--   }
--   After loading: library.Executor.Name / .Missing / .Supported, library:CheckExecutor({"firesignal"})
--
-- Tip: keep the menu small (few elements per tab), it is more stable on phones.

library:ShowLoadingScreen({
    OnAccept = function()
        local Window = library:CreateWindow({
            Name = "D3v1lHub",
            Themeable = {}
        })

        local MainTab = Window:CreateTab({
            Name = "Main",
            Badge = "NEW"
        })

        local VisualTab = Window:CreateTab({
            Name = "Visuals"
        })

        local FarmingSection = MainTab:CreateSection({
            Name = "Farming"
        })

        FarmingSection:AddToggle({
            Name = "EXP Grinder",
            Flag = "Farming_EXPGrinder",
            Callback = print
        })

        FarmingSection:AddSlider({
            Name = "Trick Rate",
            Flag = "Farming_TrickRate",
            Value = 0.15,
            Precise = 2,
            Min = 0,
            Max = 1,
            Callback = print
        })

        FarmingSection:AddDropdown({
            Name = "Mode",
            Flag = "Farming_Mode",
            List = { "Easy", "Medium", "Hard" },
            Callback = print
        })

        -- Multiselect: the list has Select All / Clear / Done buttons (SelectButtons = false hides them)
        FarmingSection:AddDropdown({
            Name = "Targets",
            Flag = "Farming_Targets",
            List = { "Zombies", "Bosses", "Chests", "Players" },
            MultiSelect = true,
            Callback = print
        })

        local MiscSection = MainTab:CreateSection({
            Name = "Misc"
        })

        MiscSection:AddToggle({
            Name = "Auto Compete",
            Flag = "Misc_AutoCompete",
            Callback = print
        })

        MiscSection:AddButton({
            Name = "Repair Board",
            Callback = function()
                print("Fixed")
            end
        })

        MiscSection:AddButton({
            Name = "Reset everything",
            Confirm = true,
            Callback = function()
                print("Reset")
            end
        })

        MiscSection:AddButton({
            Name = "Collect reward",
            Cooldown = 10,
            Callback = function()
                print("Collected")
            end
        })

        MiscSection:AddToggle({
            Name = "Auto Farm Pro",
            Flag = "Misc_AutoFarmPro",
            VIP = true,
            Callback = print
        })

        MiscSection:AddToggle({
            Name = "Unlock VIP (test)",
            Flag = "Misc_UnlockVIP",
            Callback = function(State)
                library:SetVIP(State)
            end
        })

        MiscSection:AddTextbox({
            Name = "Player name",
            Flag = "Misc_PlayerName",
            Placeholder = "Enter name...",
            Callback = print
        })

        MiscSection:AddLabel({
            Name = "Labels simply display text."
        })
        local ESPSection = VisualTab:CreateSection({
            Name = "ESP"
        })

        ESPSection:AddToggle({
            Name = "Player ESP",
            Flag = "ESP_Players",
            Callback = print
        })

        ESPSection:AddColorpicker({
            Name = "ESP color",
            Flag = "ESP_Color",
            Value = Color3.fromRGB(255, 255, 255),
            Callback = print
        })
    end,

    OnDecline = function()
        print("[D3v1lHub] Loading cancelled - nothing was created.")
    end
})
