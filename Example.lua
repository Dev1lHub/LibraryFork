local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/Library.lua"))()
local Wait = library.subs.Wait

-- ✅ Loading-Screen davor: Yes/No-Prompt + Ladebildschirm. Erst wenn der Nutzer
-- auf "Yes" klickt und die Lade-Animation fertig ist, wird hier drin alles ganz
-- normal aufgebaut (CreateWindow, Tabs, Sections, usw.) - exakt wie vorher, nur
-- eben hinter dem Loader. Bei "No" wird NICHTS davon ausgeführt: kein Window,
-- keine Tabs, keine Sections, keine Toggles usw. werden überhaupt erst erstellt -
-- es gibt dadurch nichts, was man noch extra "unloaden" müsste.
library:ShowLoadingScreen({
    OnAccept = function()
        local PepsisWorld = library:CreateWindow({
            Name = "D3v1lHub",
            Themeable = {
                Info = "Discord Server: CODE"
            }
        })

        -- Beispiel für die smoothe Notify-Funktion (fährt sanft rein/raus, wie bei Linoria)
        library:Notify({
            Text = "D3v1lHub wurde geladen!",
            Time = 5
        })

        local MainTab = PepsisWorld:CreateTab({
            Name = "Main"
        })

        local ESPTab = PepsisWorld:CreateTab({
            Name = "ESP"
        })

        local WorldTab = PepsisWorld:CreateTab({
            Name = "World"
        })

        -- Settings-Tab kommt automatisch (durch "Themeable" oben) und wird immer als letzter Tab angehängt.

        local FarmingSection = MainTab:CreateSection({
            Name = "Farming"
        })

        local EXPGrinderToggle = FarmingSection:AddToggle({
            Name = "EXP Grinder",
            Flag = "FarmingSection_EXPGrinder",
            Tooltip = "Grindet automatisch EXP, solange aktiviert.",
            DisabledTooltip = "Aktuell gesperrt."
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
            Tooltip = "Wie oft automatisch Tricks ausgeführt werden."
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
            Tooltip = "Repariert das Board sofort.",
            Callback = function()
                print("Fixed")
                library:Notify({
                    Title = "Repair",
                    Text = "Board wurde repariert!",
                    Time = 4
                })
            end
        })

        MiscSection:AddKeybind({
            Name = "Test Key",
            Tooltip = "Beispiel-Keybind zum Testen.",
            Callback = print
        })

        -- Beispiel für dauerhaft deaktivierte (ausgegraute) Elemente via "Disabled"
        MiscSection:AddToggle({
            Name = "Premium-Feature (bald verfügbar)",
            Flag = "MiscSection_PremiumFeature",
            Disabled = true,
            Tooltip = "Automatisiert Premium-Funktionen.",
            DisabledTooltip = "Noch nicht freigeschaltet - kommt in einem späteren Update."
        })

        MiscSection:AddButton({
            Name = "Premium kaufen",
            Disabled = true,
            Tooltip = "Öffnet den Premium-Shop.",
            DisabledTooltip = "Aktuell deaktiviert, solange kein Premium-Zugang besteht.",
            Callback = function()
                print("Premium-Shop geöffnet")
            end
        })

        -- Beispiel für SetDisabled: dieser Button sperrt/entsperrt den "EXP Grinder"-Toggle oben
        MiscSection:AddButton({
            Name = "EXP Grinder sperren/entsperren",
            Tooltip = "Schaltet die Sperre des EXP Grinders (siehe Farming-Sektion) um.",
            Callback = function()
                EXPGrinderToggle:SetDisabled()
            end
        })

        MiscSection:AddToggle({
            Name = "Test Toggle/Key",
            Keybind = {
                Mode = "Dynamic"
            },
            Callback = print
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

        -- Beispiel für ein ganz normales Dropdown
        DropdownSection:AddDropdown({
            Name = "Einfaches Dropdown",
            Flag = "DropdownSection_Simple",
            List = { "Erster Wert", "Zweiter Wert", "Dritter Wert" },
            Tooltip = "Wähle einen der drei Werte aus.",
            Callback = print
        })

        -- Beispiel für ein durchsuchbares Dropdown (Searchable) - praktisch bei langen Listen
        DropdownSection:AddDropdown({
            Name = "Durchsuchbares Dropdown",
            Flag = "DropdownSection_Searchable",
            List = { "Apfel", "Banane", "Kirsche", "Dattel", "Erdbeere", "Feige", "Guave" },
            Searchable = true,
            Callback = print
        })

        -- Beispiel für FormatDisplayValue - der gespeicherte Wert bleibt roh, nur die Anzeige ändert sich
        DropdownSection:AddDropdown({
            Name = "Formatiertes Dropdown",
            Flag = "DropdownSection_Formatted",
            List = { "ez", "med", "hard" },
            FormatDisplayValue = function(Value)
                if Value == "ez" then
                    return "Einfach"
                elseif Value == "med" then
                    return "Mittel"
                elseif Value == "hard" then
                    return "Schwer"
                end
                return Value
            end,
            Callback = print
        })

        -- Beispiel für DisabledValues - einzelne Optionen sind sichtbar, aber nicht anklickbar
        DropdownSection:AddDropdown({
            Name = "Dropdown mit gesperrten Werten",
            Flag = "DropdownSection_DisabledValues",
            List = { "Verfügbar 1", "Gesperrt", "Verfügbar 2", "Ebenfalls Gesperrt" },
            DisabledValues = { "Gesperrt", "Ebenfalls Gesperrt" },
            Callback = print
        })

        -- Beispiel für MaxVisibleDropdownItems - viele Werte, die geöffnete Liste scrollt statt endlos zu wachsen
        do
            local ManyValues = {}
            for i = 1, 30 do
                ManyValues[i] = "Eintrag " .. tostring(i)
            end

            DropdownSection:AddDropdown({
                Name = "Dropdown mit vielen Einträgen",
                Flag = "DropdownSection_ManyItems",
                List = ManyValues,
                MaxVisibleDropdownItems = 12,
                Callback = print
            })
        end

        -- Beispiel für SpecialType "Player" - füllt sich automatisch mit den Spielern im Server
        DropdownSection:AddDropdown({
            Name = "Spieler-Dropdown",
            Flag = "DropdownSection_Players",
            List = {},
            SpecialType = "Player",
            ExcludeLocalPlayer = true,
            Callback = print
        })

        -- Beispiel für SpecialType "Team" - füllt sich automatisch mit den Teams des Spiels
        DropdownSection:AddDropdown({
            Name = "Team-Dropdown",
            Flag = "DropdownSection_Teams",
            List = {},
            SpecialType = "Team",
            Callback = print
        })

        -- ESP-Tab (noch ohne Beispiel-Elemente, wie gewünscht bleibt alles Beispielhafte nur in "Main")
        local ESPSection = ESPTab:CreateSection({
            Name = "ESP"
        })

        ESPSection:AddLabel({
            Name = "Kommt bald..."
        })

        -- World-Tab (noch ohne Beispiel-Elemente, wie gewünscht bleibt alles Beispielhafte nur in "Main")
        local WorldSection = WorldTab:CreateSection({
            Name = "World"
        })

        WorldSection:AddLabel({
            Name = "Kommt bald..."
        })
    end,

    -- ✅ Bei "No" wird nichts davon oben ausgeführt (OnAccept läuft dann einfach nie),
    -- es existiert also kein Window/keine Tabs/Sections/Toggles usw. - nichts zum Aufräumen.
    -- Falls der Executor hier zusätzlich das komplette Script beenden soll, kann das hier passieren:
    OnDecline = function()
        print("[D3v1lHub] Laden abgebrochen - es wurde nichts erstellt.")
        -- Optional, falls gewünscht: das ganze Script danach hart beenden
        -- script:Destroy()
    end
})
