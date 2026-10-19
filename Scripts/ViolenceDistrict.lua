-- D3v1lHub | Violence District
-- Ported from the Obsidian UI to the D3v1lHub library (LibraryFork).
-- Rules followed: color pickers are always at the bottom of each section, all created instances use random names,
-- and the layout follows Examples/ExamplePC.lua (ShowLoadingScreen -> OnAccept builds the menu).

if _G.D3v1lHubVDUnload then
    pcall(_G.D3v1lHubVDUnload)
    _G.D3v1lHubVDUnload = nil
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/D3v1lLoader.lua"))()
local Wait = library.subs.Wait

library:ShowLoadingScreen({
    OnAccept = function()
        -- // SERVICES
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local Teams = game:GetService("Teams")
        local Lighting = game:GetService("Lighting")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        local Flags = library.Flags

        -- // HELPERS
        local function GenerateRandomString(Length)
            local Chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            local Out = {}
            for i = 1, Length or 10 do
                local r = math.random(1, #Chars)
                Out[i] = string.sub(Chars, r, r)
            end
            return table.concat(Out)
        end

        local function ColorFlag(Flag, Default)
            local Value = Flags[Flag]
            if typeof(Value) == "Color3" then
                return Value
            end
            return Default
        end

        local DummyDrawing = setmetatable({}, {
            __newindex = function() end,
            __index = function()
                return function() end
            end
        })

        local function NewDrawing(Class)
            local Ok, Obj = pcall(function()
                return Drawing.new(Class)
            end)
            if Ok and Obj then
                return Obj
            end
            return DummyDrawing
        end

        local function RemoveDrawing(Obj)
            if Obj and Obj ~= DummyDrawing then
                pcall(function()
                    Obj:Remove()
                end)
            end
        end

        local Connections = {}
        local function Track(Connection)
            Connections[#Connections + 1] = Connection
            return Connection
        end

        -- // MENU
        local Window = library:CreateWindow({
            Name = "D3v1lHub",
            Themeable = {
                Image = 95816097006870,
                Info = "Violence District V1"
            }
        })

        library:Notify({
            Text = "D3v1lHub | Violence District loaded!",
            Time = 5,
            Type = "success"
        })

        local PlayerTab = Window:CreateTab({
            Name = "Player"
        })

        local ESPTab = Window:CreateTab({
            Name = "ESP"
        })

        local ChamsTab = Window:CreateTab({
            Name = "Chams"
        })

        local WorldTab = Window:CreateTab({
            Name = "World"
        })

        -- The Settings tab (configs, menu settings, unload) is added automatically by "Themeable" above.

        -- // PLAYER TAB
        local AttrSection = PlayerTab:CreateSection({
            Name = "Character Attributes"
        })

        AttrSection:AddToggle({
            Name = "Moonwalk / Wiggle",
            Flag = "Player_Moonwalk",
            Tooltip = "Custom smoothness moonwalk.",
            Keybind = {
                Mode = "Toggle"
            }
        })

        AttrSection:AddToggle({
            Name = "Enable Vaultspeed",
            Flag = "Player_Vaultspeed"
        })

        AttrSection:AddSlider({
            Name = "Vaultspeed Power",
            Flag = "Player_VaultspeedValue",
            DependsOn = "Player_Vaultspeed",
            Value = 1,
            Min = 1,
            Max = 3,
            Precise = 1
        })

        AttrSection:AddToggle({
            Name = "Enable Speedboost",
            Flag = "Player_Speedboost",
            Tooltip = "Manipulates the speedboost attribute."
        })

        AttrSection:AddSlider({
            Name = "Speedboost Power",
            Flag = "Player_SpeedboostValue",
            DependsOn = "Player_Speedboost",
            Value = 1,
            Min = 1,
            Max = 3,
            Precise = 1
        })

        local MiscSection = PlayerTab:CreateSection({
            Name = "Misc",
            Side = "Right"
        })

        MiscSection:AddToggle({
            Name = "AutoSkillCheck",
            Flag = "Player_AutoSkillCheck",
            Tooltip = "Automatically hits the sweetpoint using space simulation."
        })

        -- // ESP TAB
        local PlayerESPSection = ESPTab:CreateSection({
            Name = "Player ESP"
        })

        PlayerESPSection:AddToggle({
            Name = "Enable ESP",
            Flag = "ESP_Enable",
            Keybind = {
                Value = Enum.KeyCode.F2,
                Mode = "Toggle"
            }
        })

        PlayerESPSection:AddSlider({
            Name = "Max Distance (Player)",
            Flag = "ESP_MaxDistance",
            Value = 1000,
            Min = 0,
            Max = 5000,
            Precise = 0,
            Format = function(Value)
                return "Max Distance (Player): " .. tostring(Value) .. " studs"
            end
        })

        PlayerESPSection:AddToggle({
            Name = "Show Names",
            Flag = "ESP_Name",
            Value = true
        })

        PlayerESPSection:AddToggle({
            Name = "Show Distance",
            Flag = "ESP_Distance",
            Value = true
        })

        PlayerESPSection:AddToggle({
            Name = "Show State",
            Flag = "ESP_State",
            Value = true
        })

        PlayerESPSection:AddToggle({
            Name = "Show Team",
            Flag = "ESP_Team",
            Value = true
        })

        PlayerESPSection:AddToggle({
            Name = "Box ESP",
            Flag = "ESP_Box",
            Value = true
        })

        PlayerESPSection:AddToggle({
            Name = "Team Check",
            Flag = "ESP_TeamCheck",
            Value = true
        })

        PlayerESPSection:AddToggle({
            Name = "Show Abilities (Killer Only)",
            Flag = "ESP_Ability",
            Value = true
        })

        PlayerESPSection:AddToggle({
            Name = "Show Hook Count",
            Flag = "ESP_HookCount"
        })

        local InstanceESPSection = ESPTab:CreateSection({
            Name = "Instance ESP",
            Side = "Right"
        })

        InstanceESPSection:AddSlider({
            Name = "Max Distance (Instances)",
            Flag = "ESP_MaxDistanceInstances",
            Value = 500,
            Min = 0,
            Max = 1500,
            Precise = 0,
            Format = function(Value)
                return "Max Distance (Instances): " .. tostring(Value) .. " studs"
            end
        })

        InstanceESPSection:AddToggle({
            Name = "Show Generator",
            Flag = "ESP_Generators"
        })

        InstanceESPSection:AddToggle({
            Name = "Show Repair State",
            Flag = "ESP_RepairState"
        })

        -- // CHAMS TAB
        local PlayerChamsSection = ChamsTab:CreateSection({
            Name = "Player Chams"
        })

        PlayerChamsSection:AddToggle({
            Name = "Master Highlights",
            Flag = "Chams_Master",
            Tooltip = "Main switch for all chams (players and instances).",
            Keybind = {
                Value = Enum.KeyCode.F3,
                Mode = "Toggle"
            }
        })

        PlayerChamsSection:AddToggle({
            Name = "Highlight Players",
            Flag = "Chams_Players"
        })

        PlayerChamsSection:AddToggle({
            Name = "Team Check (Red/Blue)",
            Flag = "Chams_TeamCheck",
            Value = true
        })

        PlayerChamsSection:AddSlider({
            Name = "Fill Transparency",
            Flag = "Chams_FillTransparency",
            Value = 0.5,
            Min = 0,
            Max = 1,
            Precise = 1
        })

        PlayerChamsSection:AddSlider({
            Name = "Outline Transparency",
            Flag = "Chams_OutlineTransparency",
            Value = 0,
            Min = 0,
            Max = 1,
            Precise = 1
        })

        -- Color pickers at the very bottom
        PlayerChamsSection:AddColorpicker({
            Name = "Fill Color",
            Flag = "Chams_PlayerFill",
            Value = Color3.fromRGB(255, 255, 255)
        })

        PlayerChamsSection:AddColorpicker({
            Name = "Outline Color",
            Flag = "Chams_PlayerOutline",
            Value = Color3.fromRGB(255, 255, 255)
        })

        local InstanceChamsSection = ChamsTab:CreateSection({
            Name = "Instance Chams",
            Side = "Right"
        })

        InstanceChamsSection:AddToggle({
            Name = "Generator Chams",
            Flag = "Chams_Generators"
        })

        InstanceChamsSection:AddToggle({
            Name = "Pallet Highlights",
            Flag = "Chams_Pallets"
        })

        InstanceChamsSection:AddToggle({
            Name = "Exit Gate Chams",
            Flag = "Chams_Gates"
        })

        InstanceChamsSection:AddToggle({
            Name = "Hook Highlights",
            Flag = "Chams_Hooks"
        })

        -- Color pickers at the very bottom
        InstanceChamsSection:AddColorpicker({
            Name = "Gen Fill Color",
            Flag = "Chams_GenFill",
            Value = Color3.fromRGB(255, 0, 0)
        })

        InstanceChamsSection:AddColorpicker({
            Name = "Gen Outline Color",
            Flag = "Chams_GenOutline",
            Value = Color3.fromRGB(255, 255, 255)
        })

        InstanceChamsSection:AddColorpicker({
            Name = "Pallet Fill Color",
            Flag = "Chams_PalletFill",
            Value = Color3.fromRGB(255, 165, 0)
        })

        InstanceChamsSection:AddColorpicker({
            Name = "Pallet Outline Color",
            Flag = "Chams_PalletOutline",
            Value = Color3.fromRGB(255, 255, 255)
        })

        InstanceChamsSection:AddColorpicker({
            Name = "Gate Fill Color",
            Flag = "Chams_GateFill",
            Value = Color3.fromRGB(0, 255, 0)
        })

        InstanceChamsSection:AddColorpicker({
            Name = "Gate Outline Color",
            Flag = "Chams_GateOutline",
            Value = Color3.fromRGB(255, 255, 255)
        })

        InstanceChamsSection:AddColorpicker({
            Name = "Hook Fill Color",
            Flag = "Chams_HookFill",
            Value = Color3.fromRGB(0, 170, 255)
        })

        InstanceChamsSection:AddColorpicker({
            Name = "Hook Outline Color",
            Flag = "Chams_HookOutline",
            Value = Color3.fromRGB(255, 255, 255)
        })

        -- // WORLD TAB
        local WorldSection = WorldTab:CreateSection({
            Name = "World"
        })

        WorldSection:AddToggle({
            Name = "Fullbright",
            Flag = "World_Fullbright"
        })

        WorldSection:AddToggle({
            Name = "No Fog",
            Flag = "World_NoFog"
        })

        local WarningSection = WorldTab:CreateSection({
            Name = "Warnings"
        })

        WarningSection:AddToggle({
            Name = "Killer Distance Warning",
            Flag = "World_KillerWarn"
        })

        WarningSection:AddSlider({
            Name = "Warning Distance",
            Flag = "World_WarnDistance",
            DependsOn = "World_KillerWarn",
            Value = 50,
            Min = 10,
            Max = 250,
            Precise = 0,
            Format = function(Value)
                return "Warning Distance: " .. tostring(Value) .. " studs"
            end
        })

        WarningSection:AddToggle({
            Name = "Gen Alerts",
            Flag = "World_GenAlerts",
            Value = true,
            Tooltip = "Notifies you when a generator is fully repaired."
        })

        local CrosshairSection = WorldTab:CreateSection({
            Name = "Crosshair",
            Side = "Right"
        })

        CrosshairSection:AddToggle({
            Name = "Show Crosshair",
            Flag = "World_Crosshair"
        })

        CrosshairSection:AddSlider({
            Name = "Crosshair Size",
            Flag = "World_CrosshairSize",
            Value = 10,
            Min = 2,
            Max = 30,
            Precise = 0
        })

        CrosshairSection:AddSlider({
            Name = "Crosshair Gap",
            Flag = "World_CrosshairGap",
            Value = 4,
            Min = 0,
            Max = 20,
            Precise = 0
        })

        -- Color picker at the very bottom
        CrosshairSection:AddColorpicker({
            Name = "Crosshair Color",
            Flag = "World_CrosshairColor",
            Value = Color3.fromRGB(255, 0, 0)
        })

        -- // CACHE & DATA
        local ITEM_DATA = {
            ["Adrenaline Shot"] = "rbxassetid://135388781922226",
            ["Bandage"] = "rbxassetid://97791520639443",
            ["Flashlight"] = "rbxassetid://103299939715311",
            ["Motion Tracker"] = "rbxassetid://92303584765773",
            ["Parrying Dagger"] = "rbxassetid://76822757630703",
            ["Shadow Clone"] = "rbxassetid://134088840518889",
            ["Twist of Fate"] = "rbxassetid://98397448432071",
            ["WaxBound Candle"] = "rbxassetid://110413686590821",
            ["Gate"] = "rbxassetid://131249244284700"
        }

        local PlayerCache = {}
        local ESPObjects = {}
        local PlayerHighlights = {}
        local AbilityGuis = {}
        local InstanceHighlights = {}
        local GeneratorESP = {}
        local GeneratorAlerted = {}

        local ESP_DRAWINGS = { "Box", "Name", "State", "Team", "Dist", "Hook" }

        local function UpdateCache(Player, Character)
            if not Character then
                return
            end
            local Root = Character:WaitForChild("HumanoidRootPart", 15)
            local Hum = Character:WaitForChild("Humanoid", 15)
            if Root and Hum and Player.Character == Character then
                PlayerCache[Player] = {
                    Character = Character,
                    RootPart = Root,
                    Humanoid = Hum
                }
            end
        end

        local function DestroyPlayerVisuals(Player)
            local Highlight = PlayerHighlights[Player]
            if Highlight then
                pcall(function()
                    Highlight:Destroy()
                end)
                PlayerHighlights[Player] = nil
            end
            local Ability = AbilityGuis[Player]
            if Ability then
                pcall(function()
                    Ability.Gui:Destroy()
                end)
                AbilityGuis[Player] = nil
            end
        end

        local function CreateESP(Player)
            if ESPObjects[Player] then
                return
            end
            local Obj = {
                Box = NewDrawing("Square"),
                Name = NewDrawing("Text"),
                State = NewDrawing("Text"),
                Team = NewDrawing("Text"),
                Dist = NewDrawing("Text"),
                Hook = NewDrawing("Text"),
                Connections = {}
            }
            ESPObjects[Player] = Obj

            if Player.Character then
                task.spawn(UpdateCache, Player, Player.Character)
            end
            Obj.Connections[1] = Player.CharacterAdded:Connect(function(Character)
                task.spawn(UpdateCache, Player, Character)
            end)
            Obj.Connections[2] = Player.CharacterRemoving:Connect(function()
                PlayerCache[Player] = nil
            end)
        end

        local function RemoveESP(Player)
            PlayerCache[Player] = nil
            DestroyPlayerVisuals(Player)
            local Obj = ESPObjects[Player]
            if Obj then
                for _, Connection in ipairs(Obj.Connections) do
                    pcall(function()
                        Connection:Disconnect()
                    end)
                end
                for _, Key in ipairs(ESP_DRAWINGS) do
                    RemoveDrawing(Obj[Key])
                end
                ESPObjects[Player] = nil
            end
        end

        -- // AUTOSKILLCHECK
        local VirtualInputManager = nil
        pcall(function()
            VirtualInputManager = game:GetService("VirtualInputManager")
        end)

        local LastSkillCheckFire = 0
        local function DoAutoSkillCheck()
            if not VirtualInputManager then
                return
            end
            local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
            local SkillGui = PlayerGui and PlayerGui:FindFirstChild("SkillCheckPromptGui")
            local CheckFrame = SkillGui and SkillGui:FindFirstChild("Check")

            if CheckFrame and CheckFrame.Visible then
                local Line = CheckFrame:FindFirstChild("Line")
                local Goal = CheckFrame:FindFirstChild("Goal")

                if Line and Goal then
                    local CurrentRot = Line.Rotation
                    local TargetStart = 106 + Goal.Rotation

                    -- Trigger exactly in the sweetpoint
                    if CurrentRot >= (TargetStart + 1) and (tick() - LastSkillCheckFire) > 0.8 then
                        LastSkillCheckFire = tick()
                        -- Simulates a spacebar press
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                        task.delay(0.01, function()
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                        end)
                    end
                end
            end
        end

        -- // MOONWALK + AUTOSKILLCHECK TRIGGER
        local WiggleCounter = 0
        Track(RunService.PreRender:Connect(function(dt)
            if Flags.Player_AutoSkillCheck then
                DoAutoSkillCheck()
            end

            local Character = LocalPlayer.Character
            local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            local Hum = Character and Character:FindFirstChildOfClass("Humanoid")

            if Character and RootPart and Hum then
                if Flags.Player_Moonwalk then
                    if Character:GetAttribute("overridelookscript") ~= true then
                        Character:SetAttribute("overridelookscript", true)
                    end

                    Hum.AutoRotate = false

                    local WiggleSpeed = 20
                    local WiggleIntensity = 0.7
                    local LerpFactor = 0.4

                    WiggleCounter = WiggleCounter + (dt * WiggleSpeed)
                    local WiggleAngle = math.sin(WiggleCounter) * WiggleIntensity

                    local CamLook = Camera.CFrame.LookVector
                    local FlatLook = Vector3.new(CamLook.X, 0, CamLook.Z)
                    if FlatLook.Magnitude > 0.001 then
                        local TargetCFrame = CFrame.lookAt(RootPart.Position, RootPart.Position + FlatLook.Unit) * CFrame.Angles(0, WiggleAngle, 0)
                        RootPart.CFrame = RootPart.CFrame:Lerp(TargetCFrame, LerpFactor)
                    end
                else
                    if Character:GetAttribute("overridelookscript") == true then
                        Character:SetAttribute("overridelookscript", false)
                        Hum.AutoRotate = true
                    end
                end
            end
        end))

        -- // ATTRIBUTE MANIPULATION LOOP
        task.spawn(function()
            while Wait(0.1) do
                local Character = LocalPlayer.Character
                if Character then
                    if Flags.Player_Speedboost then
                        Character:SetAttribute("speedboost", Flags.Player_SpeedboostValue)
                    end
                    if Flags.Player_Vaultspeed then
                        Character:SetAttribute("vaultspeed", Flags.Player_VaultspeedValue)
                    end
                end
            end
        end)

        -- // INSTANCE HIGHLIGHTS (pallets, gates, hooks, generators)
        local function AddInstanceHighlight(Obj, ToggleFlag, FillFlag, OutlineFlag, FillTransparency, Custom)
            if InstanceHighlights[Obj] then
                return
            end
            local Highlight = Instance.new("Highlight")
            Highlight.Name = GenerateRandomString(10)
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            Highlight.FillTransparency = FillTransparency
            Highlight.OutlineTransparency = 0
            Highlight.Enabled = false
            Highlight.Adornee = Obj
            Highlight.Parent = Obj
            InstanceHighlights[Obj] = {
                Highlight = Highlight,
                Toggle = ToggleFlag,
                Fill = FillFlag,
                Outline = OutlineFlag,
                Custom = Custom
            }
        end

        local function UpdateInstanceHighlights()
            local Master = Flags.Chams_Master
            for Obj, Entry in pairs(InstanceHighlights) do
                if not Obj.Parent then
                    pcall(function()
                        Entry.Highlight:Destroy()
                    end)
                    InstanceHighlights[Obj] = nil
                else
                    local Enabled = (Master and Flags[Entry.Toggle]) and true or false
                    Entry.Highlight.Enabled = Enabled
                    if Enabled then
                        local Fill = ColorFlag(Entry.Fill, Color3.new(1, 1, 1))
                        local Outline = ColorFlag(Entry.Outline, Color3.new(1, 1, 1))
                        if Entry.Custom then
                            Fill, Outline = Entry.Custom(Obj, Fill, Outline)
                        end
                        Entry.Highlight.FillColor = Fill
                        Entry.Highlight.OutlineColor = Outline
                    end
                end
            end
        end

        local function GeneratorColors(Obj, Fill, Outline)
            local Progress = Obj:GetAttribute("RepairProgress") or 0
            if Progress >= 100 then
                return Color3.fromRGB(0, 255, 0), Color3.new(1, 1, 1)
            end
            return Fill, Outline
        end

        local function CountGenerators()
            local Total, Repaired = 0, 0
            for Obj in pairs(GeneratorESP) do
                Total = Total + 1
                if (Obj:GetAttribute("RepairProgress") or 0) >= 100 then
                    Repaired = Repaired + 1
                end
            end
            return Repaired, Total
        end

        local function AddGenerator(Obj)
            if GeneratorESP[Obj] then
                return
            end
            GeneratorESP[Obj] = {
                Tag = NewDrawing("Text"),
                RepairTag = NewDrawing("Text")
            }
            AddInstanceHighlight(Obj, "Chams_Generators", "Chams_GenFill", "Chams_GenOutline", 0.5, GeneratorColors)

            Track(Obj:GetAttributeChangedSignal("RepairProgress"):Connect(function()
                local Progress = Obj:GetAttribute("RepairProgress") or 0
                if Progress >= 100 and not GeneratorAlerted[Obj] then
                    GeneratorAlerted[Obj] = true
                    if Flags.World_GenAlerts then
                        local Repaired, Total = CountGenerators()
                        library:Notify({
                            Text = "Generator repaired (" .. tostring(Repaired) .. "/" .. tostring(Total) .. ")",
                            Time = 4,
                            Type = "success"
                        })
                    end
                end
            end))
        end

        -- // MAP SCANNING
        local function HandleDescendant(Desc)
            if not Desc:IsA("PVInstance") then
                return
            end
            local Name = Desc.Name
            if Name == "Palletwrong" then
                AddInstanceHighlight(Desc, "Chams_Pallets", "Chams_PalletFill", "Chams_PalletOutline", 0.4)
            elseif Name == "Generator" then
                AddGenerator(Desc)
            elseif Name == "ExitLever" then
                AddInstanceHighlight(Desc, "Chams_Gates", "Chams_GateFill", "Chams_GateOutline", 0.4)
            elseif Name == "Hook" then
                AddInstanceHighlight(Desc, "Chams_Hooks", "Chams_HookFill", "Chams_HookOutline", 0.4)
            end
        end

        local HookedMap = nil
        local function ScanMap()
            local Map = workspace:FindFirstChild("Map")
            if not Map then
                return
            end
            if HookedMap ~= Map then
                HookedMap = Map
                Track(Map.DescendantAdded:Connect(HandleDescendant))
            end
            for _, Desc in ipairs(Map:GetDescendants()) do
                HandleDescendant(Desc)
            end
        end

        task.spawn(function()
            -- Safety rescan every 10 seconds (also picks up a new Map object between rounds)
            repeat
                ScanMap()
            until not Wait(10)
        end)

        task.spawn(function()
            while Wait(1) do
                UpdateInstanceHighlights()
            end
        end)

        -- // PLAYER CHAMS
        task.spawn(function()
            while Wait(0.5) do
                local Master = Flags.Chams_Master and Flags.Chams_Players
                local TeamKiller = Teams:FindFirstChild("Killer")
                local TeamSpectator = Teams:FindFirstChild("Spectator")

                for Player, Data in pairs(PlayerCache) do
                    local Character = Data.Character
                    local Highlight = PlayerHighlights[Player]

                    if Master and Character and Character.Parent and Player ~= LocalPlayer and not (TeamSpectator and Player.Team == TeamSpectator) then
                        if not Highlight or Highlight.Parent ~= Character then
                            if Highlight then
                                pcall(function()
                                    Highlight:Destroy()
                                end)
                            end
                            Highlight = Instance.new("Highlight")
                            Highlight.Name = GenerateRandomString(10)
                            Highlight.Parent = Character
                            PlayerHighlights[Player] = Highlight
                        end

                        local FinalFill, FinalOutline
                        if Flags.Chams_TeamCheck then
                            FinalFill = (TeamKiller and Player.Team == TeamKiller) and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(45, 120, 200)
                            FinalOutline = Color3.new(1, 1, 1)
                        else
                            FinalFill = ColorFlag("Chams_PlayerFill", Color3.new(1, 1, 1))
                            FinalOutline = ColorFlag("Chams_PlayerOutline", Color3.new(1, 1, 1))
                        end

                        Highlight.FillColor = FinalFill
                        Highlight.OutlineColor = FinalOutline
                        Highlight.FillTransparency = Flags.Chams_FillTransparency or 0.5
                        Highlight.OutlineTransparency = Flags.Chams_OutlineTransparency or 0
                        Highlight.Enabled = true
                    elseif Highlight then
                        Highlight.Enabled = false
                    end
                end
            end
        end)

        -- // ABILITY ICONS (Killer sees survivor items)
        task.spawn(function()
            while Wait(1.5) do
                local TeamSurvivors = Teams:FindFirstChild("Survivors")
                local TeamKiller = Teams:FindFirstChild("Killer")
                local Show = Flags.ESP_Ability and TeamSurvivors and TeamKiller and LocalPlayer.Team == TeamKiller

                for Player, Data in pairs(PlayerCache) do
                    local Ability = AbilityGuis[Player]

                    if Show and Player.Team == TeamSurvivors and Data.RootPart and Data.RootPart.Parent then
                        local FoundItem = nil
                        for _, Value in pairs(Player:GetAttributes()) do
                            if ITEM_DATA[tostring(Value)] then
                                FoundItem = tostring(Value)
                                break
                            end
                        end
                        if not FoundItem then
                            local Backpack = Player:FindFirstChild("Backpack")
                            if Backpack then
                                for _, Item in pairs(Backpack:GetChildren()) do
                                    if ITEM_DATA[Item.Name] then
                                        FoundItem = Item.Name
                                        break
                                    end
                                end
                            end
                        end

                        if FoundItem then
                            if not Ability or not Ability.Gui.Parent then
                                local Gui = Instance.new("BillboardGui")
                                Gui.Name = GenerateRandomString(10)
                                Gui.Size = UDim2.new(2.5, 0, 2.5, 0)
                                Gui.StudsOffset = Vector3.new(0, -5.5, 0)
                                Gui.AlwaysOnTop = true

                                local Icon = Instance.new("ImageLabel")
                                Icon.Name = GenerateRandomString(10)
                                Icon.Size = UDim2.new(1, 0, 1, 0)
                                Icon.BackgroundTransparency = 1
                                Icon.Parent = Gui

                                Gui.Parent = Data.RootPart
                                Ability = {
                                    Gui = Gui,
                                    Icon = Icon
                                }
                                AbilityGuis[Player] = Ability
                            elseif Ability.Gui.Parent ~= Data.RootPart then
                                Ability.Gui.Parent = Data.RootPart
                            end
                            Ability.Icon.Image = ITEM_DATA[FoundItem]
                            Ability.Gui.Enabled = true
                        elseif Ability then
                            Ability.Gui.Enabled = false
                        end
                    elseif Ability then
                        Ability.Gui.Enabled = false
                    end
                end
            end
        end)

        -- // ESP RENDERING
        local CrosshairLines = {
            Left = NewDrawing("Line"),
            Right = NewDrawing("Line"),
            Top = NewDrawing("Line"),
            Bottom = NewDrawing("Line")
        }
        for _, Line in pairs(CrosshairLines) do
            Line.Thickness = 1.5
            Line.Transparency = 1
            Line.Visible = false
        end

        local function HidePlayerESP(Obj)
            Obj.Box.Visible = false
            Obj.Name.Visible = false
            Obj.State.Visible = false
            Obj.Team.Visible = false
            Obj.Dist.Visible = false
            Obj.Hook.Visible = false
        end

        local function UpdatePlayerESP(Player, Obj, Ctx)
            local Data = PlayerCache[Player]
            if not Ctx.Enabled or not Player.Parent or Player == LocalPlayer or (Ctx.Spectator and Player.Team == Ctx.Spectator) or not Data or not Data.RootPart.Parent then
                HidePlayerESP(Obj)
                return
            end

            local Character, RootPart, Humanoid = Data.Character, Data.RootPart, Data.Humanoid
            local Pos, OnScreen = Camera:WorldToViewportPoint(RootPart.Position)
            local Distance = Ctx.LocalRoot and (RootPart.Position - Ctx.LocalRoot.Position).Magnitude or 0

            if not (OnScreen and Distance <= (Flags.ESP_MaxDistance or 1000)) then
                HidePlayerESP(Obj)
                return
            end

            local HeadPos = Camera:WorldToViewportPoint(RootPart.Position + Vector3.new(0, 2.5, 0))
            local LegPos = Camera:WorldToViewportPoint(RootPart.Position + Vector3.new(0, -3.5, 0))
            local Height = math.abs(HeadPos.Y - LegPos.Y)
            local Width = Height / 1.6
            local BoxPos = Vector2.new(Pos.X - Width / 2, Pos.Y - Height / 2)
            local DynamicFontSize = math.clamp(Height / 6.5, 8, 13)
            local IsSurvivor = (Ctx.Survivors ~= nil and Player.Team == Ctx.Survivors)
            local IsKiller = (Ctx.Killer ~= nil and Player.Team == Ctx.Killer)
            local ESPColor = Color3.new(1, 1, 1)
            if Flags.ESP_TeamCheck then
                ESPColor = IsKiller and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(45, 120, 200)
            end

            Obj.Box.Visible = Flags.ESP_Box and true or false
            Obj.Box.Size = Vector2.new(Width, Height)
            Obj.Box.Position = BoxPos
            Obj.Box.Color = ESPColor
            Obj.Box.Thickness = 1

            local Dist = Obj.Dist
            Dist.Visible = Flags.ESP_Distance and true or false
            Dist.Text = "[" .. math.floor(Distance) .. "m]"
            Dist.Size = math.max(DynamicFontSize - 1, 7)
            Dist.Position = Vector2.new(BoxPos.X + Width / 2, BoxPos.Y + Height + 2)
            Dist.Color = ESPColor
            Dist.Outline = true
            Dist.Center = true
            Dist.Font = 3

            local SideX = BoxPos.X + Width + 4
            local CurrentY = HeadPos.Y - (DynamicFontSize / 2)
            local LineHeight = DynamicFontSize + 2
            local HookCount = Character:GetAttribute("HookCount") or 0

            local Hook = Obj.Hook
            if Flags.ESP_HookCount and IsSurvivor and HookCount > 0 and HookCount < 3 then
                Hook.Visible = true
                Hook.Size = math.max(DynamicFontSize + 2, 10)
                Hook.Position = Vector2.new(BoxPos.X - 15, BoxPos.Y + 2)
                Hook.Text = (HookCount == 1 and "I" or "II")
                Hook.Color = (HookCount == 1 and Color3.new(1, 1, 1) or Color3.fromRGB(255, 255, 0))
                Hook.Outline = true
                Hook.Font = 3
            else
                Hook.Visible = false
            end

            local NameTag = Obj.Name
            if Flags.ESP_Name then
                NameTag.Visible = true
                NameTag.Text = Player.DisplayName
                NameTag.Size = DynamicFontSize
                NameTag.Position = Vector2.new(SideX, CurrentY)
                NameTag.Color = ESPColor
                NameTag.Outline = true
                NameTag.Font = 3
                CurrentY = CurrentY + LineHeight
            else
                NameTag.Visible = false
            end

            local StateTag = Obj.State
            if Flags.ESP_State and IsSurvivor then
                local function GetState(Name)
                    local Attr = Character:GetAttribute(Name)
                    if Attr ~= nil then
                        return Attr
                    end
                    local Val = Character:FindFirstChild(Name) or Player:FindFirstChild(Name)
                    return Val and Val.Value or false
                end

                local Text, Col = "[ Healthy ]", Color3.new(0, 1, 0)
                if HookCount >= 3 then
                    Text, Col = "[ DEAD ]", Color3.fromRGB(255, 0, 0)
                elseif GetState("IsHooked") then
                    Text, Col = "[ Hooked ]", Color3.new(1, 1, 1)
                elseif GetState("Knocked") then
                    Text, Col = "[ Downed ]", Color3.new(1, 0.5, 0)
                elseif GetState("Iframes") then
                    Text, Col = "[ IFRAME ]", Color3.fromRGB(255, 255, 255)
                elseif GetState("IsBeingHealed") then
                    Text, Col = "[ Healing ]", Color3.new(0, 1, 1)
                elseif Humanoid.Health <= 60 then
                    Text, Col = "[ Injured ]", Color3.new(1, 0, 0)
                end

                StateTag.Visible = true
                StateTag.Text = Text
                StateTag.Color = Col
                StateTag.Size = math.max(DynamicFontSize - 1, 7)
                StateTag.Position = Vector2.new(SideX, CurrentY)
                StateTag.Outline = true
                StateTag.Font = 3
                CurrentY = CurrentY + LineHeight
            else
                StateTag.Visible = false
            end

            local TeamTag = Obj.Team
            if Flags.ESP_Team then
                TeamTag.Visible = true
                TeamTag.Text = "[ " .. tostring(Player.Team) .. " ]"
                TeamTag.Color = ESPColor
                TeamTag.Size = math.max(DynamicFontSize - 1, 7)
                TeamTag.Position = Vector2.new(SideX, CurrentY)
                TeamTag.Outline = true
                TeamTag.Font = 3
            else
                TeamTag.Visible = false
            end
        end

        local function UpdateGeneratorESP(Obj, G, Ctx)
            if not Obj.Parent then
                RemoveDrawing(G.Tag)
                RemoveDrawing(G.RepairTag)
                GeneratorESP[Obj] = nil
                GeneratorAlerted[Obj] = nil
                return
            end

            if not (Ctx.Enabled and Flags.ESP_Generators) then
                G.Tag.Visible = false
                G.RepairTag.Visible = false
                return
            end

            local RootPos = Obj:GetPivot().Position + Vector3.new(0, 5, 0)
            local Pos, OnScreen = Camera:WorldToViewportPoint(RootPos)
            local Distance = Ctx.LocalRoot and (RootPos - Ctx.LocalRoot.Position).Magnitude or 0

            if not (OnScreen and Distance <= (Flags.ESP_MaxDistanceInstances or 500)) then
                G.Tag.Visible = false
                G.RepairTag.Visible = false
                return
            end

            local Tag = G.Tag
            Tag.Visible = true
            Tag.Text = "[Generator]"
            Tag.Size = 13
            Tag.Center = true
            Tag.Outline = true
            Tag.Font = 3
            Tag.Color = Color3.new(1, 1, 1)
            Tag.Position = Vector2.new(Pos.X, Pos.Y)

            local RepairTag = G.RepairTag
            if Flags.ESP_RepairState then
                local Progress = Obj:GetAttribute("RepairProgress") or 0
                RepairTag.Visible = true
                RepairTag.Size = 12
                RepairTag.Center = true
                RepairTag.Outline = true
                RepairTag.Font = 3
                RepairTag.Position = Vector2.new(Pos.X, Pos.Y + 14)

                local Color = Color3.new(1, 1, 1)
                if Progress >= 100 then
                    RepairTag.Text = "[REPAIRED]"
                    Color = Color3.new(0, 1, 0)
                elseif Progress >= 65 then
                    local Ratio = (Progress - 65) / 35
                    Color = Color3.new(1 - Ratio, 1, 1 - Ratio)
                    RepairTag.Text = string.format("[%d%%]", math.floor(Progress))
                else
                    RepairTag.Text = string.format("[%d%%]", math.floor(Progress))
                end
                RepairTag.Color = Color
            else
                RepairTag.Visible = false
            end
        end

        local function UpdateCrosshair()
            if Flags.World_Crosshair then
                local Center = Camera.ViewportSize / 2
                local Color = ColorFlag("World_CrosshairColor", Color3.fromRGB(255, 0, 0))
                local Size = Flags.World_CrosshairSize or 10
                local Gap = Flags.World_CrosshairGap or 4

                CrosshairLines.Left.From = Center - Vector2.new(Gap, 0)
                CrosshairLines.Left.To = Center - Vector2.new(Gap + Size, 0)
                CrosshairLines.Right.From = Center + Vector2.new(Gap, 0)
                CrosshairLines.Right.To = Center + Vector2.new(Gap + Size, 0)
                CrosshairLines.Top.From = Center - Vector2.new(0, Gap)
                CrosshairLines.Top.To = Center - Vector2.new(0, Gap + Size)
                CrosshairLines.Bottom.From = Center + Vector2.new(0, Gap)
                CrosshairLines.Bottom.To = Center + Vector2.new(0, Gap + Size)
                for _, Line in pairs(CrosshairLines) do
                    Line.Color = Color
                    Line.Visible = true
                end
            else
                for _, Line in pairs(CrosshairLines) do
                    Line.Visible = false
                end
            end
        end

        -- One single render connection for everything that is drawn
        Track(RunService.RenderStepped:Connect(function()
            Camera = workspace.CurrentCamera or Camera

            local LocalCharacter = LocalPlayer.Character
            local Ctx = {
                Enabled = Flags.ESP_Enable and true or false,
                LocalRoot = LocalCharacter and LocalCharacter:FindFirstChild("HumanoidRootPart"),
                Killer = Teams:FindFirstChild("Killer"),
                Survivors = Teams:FindFirstChild("Survivors"),
                Spectator = Teams:FindFirstChild("Spectator")
            }

            for Player, Obj in pairs(ESPObjects) do
                UpdatePlayerESP(Player, Obj, Ctx)
            end

            for Obj, G in pairs(GeneratorESP) do
                UpdateGeneratorESP(Obj, G, Ctx)
            end

            UpdateCrosshair()
        end))

        -- // WORLD MODS (Fullbright / No Fog) - original values are saved when switched on and restored when switched off
        local SavedLighting = {}
        local FullbrightActive = false
        local NoFogActive = false

        task.spawn(function()
            while Wait(0.5) do
                if Flags.World_Fullbright then
                    if not FullbrightActive then
                        SavedLighting.Brightness = Lighting.Brightness
                        SavedLighting.ClockTime = Lighting.ClockTime
                        SavedLighting.GlobalShadows = Lighting.GlobalShadows
                        FullbrightActive = true
                    end
                    Lighting.Brightness = 2
                    Lighting.ClockTime = 14
                    Lighting.GlobalShadows = false
                elseif FullbrightActive then
                    Lighting.Brightness = SavedLighting.Brightness
                    Lighting.ClockTime = SavedLighting.ClockTime
                    Lighting.GlobalShadows = SavedLighting.GlobalShadows
                    FullbrightActive = false
                end

                if Flags.World_NoFog then
                    if not NoFogActive then
                        SavedLighting.FogStart = Lighting.FogStart
                        SavedLighting.FogEnd = Lighting.FogEnd
                        NoFogActive = true
                    end
                    Lighting.FogStart = 1e5
                    Lighting.FogEnd = 1e5
                elseif NoFogActive then
                    Lighting.FogStart = SavedLighting.FogStart
                    Lighting.FogEnd = SavedLighting.FogEnd
                    NoFogActive = false
                end
            end
        end)

        -- // KILLER WARNING
        local LastKillerWarn = 0
        task.spawn(function()
            while Wait(0.5) do
                local TeamKiller = Teams:FindFirstChild("Killer")
                local LocalRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                if Flags.World_KillerWarn and TeamKiller and LocalPlayer.Team ~= TeamKiller and LocalRoot and (os.clock() - LastKillerWarn) >= 2.5 then
                    local Closest = nil
                    for _, Player in pairs(Players:GetPlayers()) do
                        if Player.Team == TeamKiller and Player.Character then
                            local Root = Player.Character:FindFirstChild("HumanoidRootPart")
                            if Root then
                                local Dist = (Root.Position - LocalRoot.Position).Magnitude
                                if Dist <= (Flags.World_WarnDistance or 50) and (not Closest or Dist < Closest) then
                                    Closest = Dist
                                end
                            end
                        end
                    end
                    if Closest then
                        LastKillerWarn = os.clock()
                        library:Notify({
                            Text = "KILLER NEARBY: " .. math.floor(Closest) .. " studs!",
                            Time = 2,
                            Type = "error"
                        })
                    end
                end
            end
        end)

        -- // PLAYER HOOKS
        for _, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer then
                CreateESP(Player)
            end
        end

        Track(Players.PlayerAdded:Connect(function(Player)
            if Player ~= LocalPlayer then
                CreateESP(Player)
            end
        end))

        Track(Players.PlayerRemoving:Connect(function(Player)
            RemoveESP(Player)
        end))

        -- // UNLOAD / CLEANUP (runs when the library is unloaded, e.g. via the Settings tab)
        local function Cleanup()
            for _, Connection in ipairs(Connections) do
                pcall(function()
                    Connection:Disconnect()
                end)
            end
            table.clear(Connections)

            for Player in pairs(ESPObjects) do
                RemoveESP(Player)
            end

            for Obj, Entry in pairs(InstanceHighlights) do
                pcall(function()
                    Entry.Highlight:Destroy()
                end)
                InstanceHighlights[Obj] = nil
            end

            for Obj, G in pairs(GeneratorESP) do
                RemoveDrawing(G.Tag)
                RemoveDrawing(G.RepairTag)
                GeneratorESP[Obj] = nil
            end

            for _, Line in pairs(CrosshairLines) do
                RemoveDrawing(Line)
            end

            if FullbrightActive then
                Lighting.Brightness = SavedLighting.Brightness
                Lighting.ClockTime = SavedLighting.ClockTime
                Lighting.GlobalShadows = SavedLighting.GlobalShadows
                FullbrightActive = false
            end
            if NoFogActive then
                Lighting.FogStart = SavedLighting.FogStart
                Lighting.FogEnd = SavedLighting.FogEnd
                NoFogActive = false
            end

            local Character = LocalPlayer.Character
            if Character then
                if Character:GetAttribute("overridelookscript") == true then
                    Character:SetAttribute("overridelookscript", false)
                end
                local Hum = Character:FindFirstChildOfClass("Humanoid")
                if Hum then
                    Hum.AutoRotate = true
                end
            end

            _G.D3v1lHubVDUnload = nil
        end

        library.UnloadCallback = Cleanup
        _G.D3v1lHubVDUnload = function()
            library.Unload()
        end
    end,

    -- On "No" OnAccept never runs: no window, tab or element is created.
    OnDecline = function()
        print("[D3v1lHub] Loading cancelled - nothing was created.")
    end
})
