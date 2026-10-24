local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/D3v1lLoader.lua"))()
local Wait = library.subs.Wait

-- D3v1lHub example script
--
-- Flow:
--   1. D3v1lLoader.lua detects the device and loads ONLY the matching library:
--        PC / Laptop    -> PCGUILib.lua     (full menu)
--        Handy / Tablet -> MobileGUILib.lua (slim touch menu, builds itself step by step)
--   2. The loader shows Yes/No, "Detected device", HWID and the loading bar. On mobile, "Yes" first shows a warning (Continue / Cancel).
--   3. On "Yes" OnAccept runs: build the menu here. On "No" nothing is created (OnDecline).
--
-- Force the device (set BEFORE loading the loader):
--   getgenv().D3v1lHubMobileMode = true   -- always Mobile
--   getgenv().D3v1lHubMobileMode = false  -- always PC
--
-- Mobile only: make the build faster/slower (BEFORE CreateWindow):
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
-- Customize loader texts (BEFORE loading the loader):
--   getgenv().D3v1lLoaderOptions = { TitlePart1 = "D3v1l", ConfirmText = "Execute?", ShowHWID = false }

library:ShowLoadingScreen({
    OnAccept = function()
        local PepsisWorld = library:CreateWindow({
            Name = "D3v1lHub",
            Themeable = {
                Info = "Discord Server: CODE"
            }
        })

        -- Notify: Text, Time (seconds), Type = "success" / "error" (optional, colors the border)
        library:Notify({
            Text = "D3v1lHub loaded!",
            Time = 5,
            Type = "success"
        })

        -- Tab badges: small label on the tab (Badge / BadgeColor), change later with tab:SetBadge("text") / tab:ClearBadge()
        local MainTab = PepsisWorld:CreateTab({
            Name = "Main",
            Badge = "NEW"
        })

        local ESPTab = PepsisWorld:CreateTab({
            Name = "ESP",
            Badge = "SOON",
            BadgeColor = Color3.fromRGB(128, 0, 255)
        })

        local WorldTab = PepsisWorld:CreateTab({
            Name = "World"
        })

        -- The Settings tab (configs, menu settings) is added automatically by "Themeable" above and is always the last tab.

        local FarmingSection = MainTab:CreateSection({
            Name = "Farming"
        })

        local EXPGrinderToggle = FarmingSection:AddToggle({
            Name = "EXP Grinder",
            Flag = "FarmingSection_EXPGrinder",
            Tooltip = "Grinds EXP automatically while enabled.",
            DisabledTooltip = "Currently locked."
        })

        FarmingSection:AddToggle({
            Name = "Trick Spammer",
            Flag = "FarmingSection_TrickSpammer",
            Keybind = 1,
            Callback = print
        })

        FarmingSection:AddSlider({
            Name = "Trick Rate",
            Flag = "FarmingSection_TrickRate",
            Value = 0.15,
            Precise = 2,
            Min = 0,
            Max = 1,
            Tooltip = "How often tricks are performed automatically."
        })

        FarmingSection:AddToggle({
            Name = "TP To Coins",
            Flag = "FarmingSection_TPCoins"
        })

        FarmingSection:AddToggle({
            Name = "Collect Coins",
            Flag = "FarmingSection_CollectCoins",
            Callback = print
        })

        FarmingSection:AddSlider({
            Name = "Coin Distance",
            Flag = "FarmingSection_CoinDistance",
            -- Dependency Box: nur sichtbar, solange "Collect Coins" an ist
            DependsOn = "FarmingSection_CollectCoins",
            Value = 175,
            Min = 0,
            Max = 200,
            Format = function(Value)
                if Value == 0 then
                    return "Collection Distance: Infinite"
                else
                    return "Collection Distance: " .. tostring(Value)
                end
            end
        })

        local BoardControlSection = MainTab:CreateSection({
            Name = "Board Control"
        })

        BoardControlSection:AddToggle({
            Name = "Anti Trip/Ragdoll",
            Flag = "BoardControlSection_AntiTripRagdoll",
            Callback = print
        })

        BoardControlSection:AddToggle({
            Name = "No Wear & Tear",
            Flag = "BoardControlSection_NoWearTear"
        })

        BoardControlSection:AddToggle({
            Name = "No Trick Cooldown",
            Flag = "BoardControlSection_NoTrickCooldown",
            Callback = print
        })

        BoardControlSection:AddToggle({
            Name = "Extend Combo Timout",
            Flag = "BoardControlSection_ExtendComboTimeout"
        })

        BoardControlSection:AddSlider({
            Name = "Timeout Extension",
            Flag = "BoardControlSection_TimeoutExtension",
            -- Dependency Box: nur sichtbar, solange "Extend Combo Timout" an ist
            DependsOn = "BoardControlSection_ExtendComboTimeout",
            Value = 3,
            Min = 0,
            Max = 20,
            Format = function(Value)
                if Value == 0 then
                    return "Combo Timeout: Never"
                else
                    return "Combo Timeout: " .. tostring(Value) .. "s"
                end
            end
        })

        local MiscSection = MainTab:CreateSection({
            Name = "Misc",
            Side = "Right"
        })

        MiscSection:AddToggle({
            Name = "Unlock Gamepasses",
            Flag = "MiscSection_UnlockGamepasses",
            Callback = print
        })

        MiscSection:AddToggle({
            Name = "Auto Compete",
            Flag = "MiscSection_AutoCompete",
            Callback = print
        })

        MiscSection:AddButton({
            Name = "Repair Board",
            Tooltip = "Repairs the board immediately.",
            Callback = function()
                print("Fixed")
                library:Notify({
                    Title = "Repair",
                    Text = "Board repaired!",
                    Time = 4
                })
            end
        })

        MiscSection:AddKeybind({
            Name = "Test Key",
            Tooltip = "Example keybind for testing.",
            Callback = print
        })

        -- Example of permanently disabled (greyed out) elements via "Disabled"
        MiscSection:AddToggle({
            Name = "Premium feature (coming soon)",
            Flag = "MiscSection_PremiumFeature",
            Disabled = true,
            Tooltip = "Automates premium functions.",
            DisabledTooltip = "Not unlocked yet - coming in a later update."
        })

        MiscSection:AddButton({
            Name = "Buy premium",
            Disabled = true,
            Tooltip = "Opens the premium shop.",
            DisabledTooltip = "Currently disabled while there is no premium access.",
            Callback = function()
                print("Premium shop opened")
            end
        })

        -- Example of SetDisabled: this button locks/unlocks the "EXP Grinder" toggle above
        MiscSection:AddButton({
            Name = "Lock/unlock EXP Grinder",
            Tooltip = "Toggles the lock of the EXP Grinder (see Farming section).",
            Callback = function()
                EXPGrinderToggle:SetDisabled()
            end
        })

        -- Keybind modes: "Dynamic", "Hold" or "Toggle". Click the small D/H/T letter next to the key to cycle modes.
        MiscSection:AddToggle({
            Name = "Test Toggle/Key",
            Keybind = {
                Mode = "Dynamic"
            },
            Callback = print
        })

        MiscSection:AddToggle({
            Name = "Hold to sprint",
            Flag = "MiscSection_HoldSprint",
            Keybind = {
                Value = Enum.KeyCode.LeftShift,
                Mode = "Hold"
            },
            Callback = print
        })

        -- Confirm: first click asks "Confirm?", second click within 3 seconds runs the callback
        MiscSection:AddButton({
            Name = "Reset everything",
            Confirm = "Really reset?",
            Callback = function()
                library:Notify({Text = "Everything was reset.", Time = 3, Type = "success"})
            end
        })

        -- Cooldown: after a press the button is blocked for N seconds and shows the countdown
        MiscSection:AddButton({
            Name = "Collect reward",
            Cooldown = 10,
            Callback = function()
                library:Notify({Text = "Reward collected!", Time = 3, Type = "success"})
            end
        })

        -- VIP elements: gold badge, locked until library:SetVIP(true) or until VIPCheck returns true
        MiscSection:AddToggle({
            Name = "Auto Farm Pro",
            Flag = "MiscSection_AutoFarmPro",
            VIP = true,
            Callback = print
        })

        MiscSection:AddButton({
            Name = "Teleport to boss",
            VIP = "PREMIUM",
            Callback = function()
                print("Teleported")
            end
        })

        -- Replace this with your own key / whitelist check
        MiscSection:AddToggle({
            Name = "Unlock VIP (test)",
            Flag = "MiscSection_UnlockVIP",
            Callback = function(State)
                library:SetVIP(State)
            end
        })

        MiscSection:AddTextbox({
            Name = "Player name",
            Flag = "MiscSection_PlayerName",
            Placeholder = "Enter name...",
            Callback = print
        })

        MiscSection:AddLabel({
            Name = "Labels simply display text."
        })

        -- Prompt: small choice window with buttons (Options: Name = function)
        MiscSection:AddButton({
            Name = "Open prompt",
            Callback = function()
                library:Prompt({
                    Name = "Are you sure?",
                    Description = "This is an example of library:Prompt.",
                    Options = {
                        Ja = function()
                            library:Notify({Text = "You chose Yes.", Time = 3, Type = "success"})
                        end,
                        Nein = function()
                            library:Notify({Text = "You chose No.", Time = 3, Type = "error"})
                        end
                    }
                })
            end
        })

        local FunSection = MainTab:CreateSection({
            Name = "Fun Cosmetics"
        })

        FunSection:AddToggle({
            Name = "Ragdoll Assumes Flight",
            Flag = "FunSection_AssumesFlight"
        })

        FunSection:AddToggle({
            Name = "Ragdoll On Player Collision",
            Flag = "FunSection_RagdollOnPlayerCollision"
        })

        FunSection:AddToggle({
            Name = "Un-Ragdoll When Motionless",
            Flag = "FunSection_UnRagdollWhenMotionless"
        })

        FunSection:AddToggle({
            Name = "Extend Ragdoll Duration",
            Flag = "FunSection_ExtendRagdollDuration"
        })

        FunSection:AddSlider({
            Name = "Ragdoll Extension",
            Flag = "FunSection_RagdollExtension",
            -- Dependency Box: nur sichtbar, solange "Extend Ragdoll Duration" an ist
            DependsOn = "FunSection_ExtendRagdollDuration",
            Value = 4,
            Min = 0,
            Max = 60,
            Textbox = true,
            Format = function(Value)
                if Value == 0 then
                    return "Ragdoll Extension: Indefinite"
                else
                    return "Ragdoll Extension: " .. tostring(Value) .. "s"
                end
            end
        })

        local DropdownSection = MainTab:CreateSection({
            Name = "Dropdowns",
            Side = "Right"
        })

        -- Example of a normal dropdown
        DropdownSection:AddDropdown({
            Name = "Simple dropdown",
            Flag = "DropdownSection_Simple",
            List = { "First value", "Second value", "Third value" },
            Tooltip = "Select one of the three values.",
            Callback = print
        })

        -- Example of a multiselect dropdown - the open list has "Select All" and "Clear" (SelectButtons = false hides them)
        local MultiDropdown = DropdownSection:AddDropdown({
            Name = "Multiselect dropdown",
            Flag = "DropdownSection_Multi",
            List = { "Red", "Green", "Blue", "Yellow" },
            MultiSelect = true,
            Callback = print
        })
        -- MultiDropdown:SelectAll() / MultiDropdown:Clear() also work from code

        -- Example of a searchable dropdown (Searchable) - handy for long lists
        DropdownSection:AddDropdown({
            Name = "Searchable dropdown",
            Flag = "DropdownSection_Searchable",
            List = { "Apple", "Banana", "Cherry", "Date", "Strawberry", "Fig", "Guava" },
            Searchable = true,
            Callback = print
        })

        -- Example of FormatDisplayValue - the stored value stays raw, only the display changes
        DropdownSection:AddDropdown({
            Name = "Formatted dropdown",
            Flag = "DropdownSection_Formatted",
            List = { "ez", "med", "hard" },
            FormatDisplayValue = function(Value)
                if Value == "ez" then
                    return "Easy"
                elseif Value == "med" then
                    return "Medium"
                elseif Value == "hard" then
                    return "Hard"
                end
                return Value
            end,
            Callback = print
        })

        -- Example of DisabledValues - some options are visible but not clickable
        DropdownSection:AddDropdown({
            Name = "Dropdown with disabled values",
            Flag = "DropdownSection_DisabledValues",
            List = { "Available 1", "Disabled", "Available 2", "Also disabled" },
            DisabledValues = { "Disabled", "Also disabled" },
            Callback = print
        })

        -- Example of MaxVisibleDropdownItems - many values, the opened list scrolls instead of growing endlessly
        do
            local ManyValues = {}
            for i = 1, 30 do
                ManyValues[i] = "Entry " .. tostring(i)
            end

            DropdownSection:AddDropdown({
                Name = "Dropdown with many entries",
                Flag = "DropdownSection_ManyItems",
                List = ManyValues,
                MaxVisibleDropdownItems = 12,
                Callback = print
            })
        end

        -- Example of SpecialType "Player" - fills automatically with the players in the server
        DropdownSection:AddDropdown({
            Name = "Player dropdown",
            Flag = "DropdownSection_Players",
            List = {},
            SpecialType = "Player",
            ExcludeLocalPlayer = true,
            Callback = print
        })

        -- Example of SpecialType "Team" - fills automatically with the game's teams
        DropdownSection:AddDropdown({
            Name = "Team dropdown",
            Flag = "DropdownSection_Teams",
            List = {},
            SpecialType = "Team",
            Callback = print
        })

        local ESPSection = ESPTab:CreateSection({
            Name = "ESP"
        })

        ESPSection:AddLabel({
            Name = "Coming soon..."
        })

        local WorldSection = WorldTab:CreateSection({
            Name = "World"
        })

        WorldSection:AddLabel({
            Name = "Coming soon..."
        })
    end,

    -- On "No" OnAccept never runs: no window, tab or element is created.
    OnDecline = function()
        print("[D3v1lHub] Loading cancelled - nothing was created.")
        -- Optional: hard-stop the whole script afterwards
        -- script:Destroy()
    end
})
