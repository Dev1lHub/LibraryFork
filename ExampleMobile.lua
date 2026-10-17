getgenv().D3v1lHubMobileMode = true
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/D3v1lLoader.lua"))()

-- D3v1lHub Beispiel-Script für MOBILE (Handy / Tablet)
--
-- Was im Mobile-Menü anders ist:
--   * Es wird nur MobileGUILib.lua geladen (schlankes Touch-Menü).
--   * Das Menü baut sich schrittweise auf (kein Einfrieren beim Start).
--   * Keybinds werden ignoriert (AddKeybind/Keybind-Option sind nur Platzhalter).
--   * library:Notify wird ignoriert (zeigt nichts an).
--   * Es gibt keinen Settings-Tab.
--
-- Aufbau langsamer/schneller machen (VOR CreateWindow):
--   library.MobileBuildBatch = 2      -- Elemente pro Pause
--   library.MobileBuildDelay = 0.06   -- Pause in Sekunden, 0 = alles auf einmal
--
-- Tipp: Halte das Menü klein (wenige Elemente pro Tab), das ist auf dem Handy stabiler.

library:ShowLoadingScreen({
    OnAccept = function()
        local Window = library:CreateWindow({
            Name = "D3v1lHub"
        })

        local MainTab = Window:CreateTab({
            Name = "Main"
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
            Name = "Modus",
            Flag = "Farming_Mode",
            List = { "Leicht", "Mittel", "Schwer" },
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

        MiscSection:AddTextbox({
            Name = "Spielername",
            Flag = "Misc_PlayerName",
            Placeholder = "Name eingeben...",
            Callback = print
        })

        MiscSection:AddLabel({
            Name = "Labels zeigen einfach Text an."
        })

        MiscSection:AddColorpicker({
            Name = "Beispiel-Farbe",
            Flag = "Misc_ExampleColor",
            Value = Color3.fromRGB(168, 85, 247),
            Callback = print
        })

        local ESPSection = VisualTab:CreateSection({
            Name = "ESP"
        })

        ESPSection:AddToggle({
            Name = "Spieler-ESP",
            Flag = "ESP_Players",
            Callback = print
        })

        ESPSection:AddColorpicker({
            Name = "ESP-Farbe",
            Flag = "ESP_Color",
            Value = Color3.fromRGB(255, 255, 255),
            Callback = print
        })
    end,

    OnDecline = function()
        print("[D3v1lHub] Laden abgebrochen - es wurde nichts erstellt.")
    end
})
