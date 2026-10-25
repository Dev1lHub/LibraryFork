D3v1lHub - Dokumentation (Library v0.94)

DATEIEN
   D3v1lLoader.lua   Entry point. Detects the device (PC or phone/tablet), shows Yes/No + "Detected device" + HWID + loading bar
                     and loads ONLY the matching library. Returns the loaded library.
   PCGUILib.lua      Full menu for PC / laptop.
   MobileGUILib.lua  Slim touch menu for phone / tablet (far fewer GUI objects, builds itself step by step).
   Examples/ExamplePC.lua      Complete example script.
   Examples/ExampleMobile.lua Example script for phone/tablet only (Mobile menu).

START
   local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/D3v1lLoader.lua"))()
   library:ShowLoadingScreen({
       OnAccept = function() ... end,    -- after "Yes": build the menu here (CreateWindow, CreateTab, ...)
       OnDecline = function() ... end    -- after "No": nothing was created
   })

FORCE DEVICE (set before the loader)
   getgenv().D3v1lHubMobileMode = true    -- always Mobile
   getgenv().D3v1lHubMobileMode = false   -- always PC

LOADER OPTIONS (getgenv().D3v1lLoaderOptions = {...} or directly in ShowLoadingScreen({...}))
   (string | nil) TitlePart1 = "D3v1l"
   (string | nil) TitlePart2 = "Hub | PlayerName"
   (string | nil) ConfirmText = "Do you want to execute this script?"
   (string | nil) LoadingTitle / LoadingSubText / WelcomeSubText
   (boolean | nil) ShowHWID = true or false
   (string | number | boolean | nil) BackgroundAsset = "rbxassetid://..." | 123456 | false
   (number | nil) BackgroundTransparency = 0.5
   (string | nil) OpenSound / CloseSound, (number | nil) SoundVolume = 0.5
   (function) OnAccept / (function | nil) OnDecline
   (boolean | nil) MobileWarning = true or false // default: true on mobile. After "Yes" a warning (Continue / Cancel) is shown
   (string | nil) MobileWarningText // custom warning text
   (table | nil) RequiredFunctions = {"hookfunction", getconnections = "reason"} // extra executor functions your script needs
   (table | nil) KnownUnsupported = { xeno = {"hookmetamethod"} } // your own list of unsupported functions per executor name (matched by substring)
   (boolean | nil) ExecutorWarning = true or false // default true: after "Yes" a warning lists unsupported functions (Continue / Cancel)
   (table | nil) ExecutorStatusList = { wave = "supported", madium = "partial", xeno = "untested" } // overrides the built-in list (matched by substring of the executor name)
   Executor status line in the Yes/No window: green = supported, yellow = partially supported, red = not tested / unknown.
   Yellow and red also show: "Some features may not work properly because of the lack of UNC/sUNC."
   Built-in list: Wave, Volt, Real, Potassium = supported | Madium = partial | Synapse Z = not tested | everything else = not tested

EXECUTOR CHECK (after the loader returned)
   library.Executor = { Name = string, Version = string | nil, Missing = { {Name, Reason}, ... }, Supported = { "name", ... } }
   library:CheckExecutor({"firesignal", ...}) -> same table format for the given function names
   library:SetVIP(State | nil) -> State // Unlocks / locks every element created with VIP = true (nil toggles)
   library:IsVIP() -> boolean
   library:ShowTerms() // Opens the Terms Of Use / copyright window (also: Settings tab > More Info > "View Terms Of Use")
   library.CloseTerms() // Closes it again

MOBILE ONLY (set before CreateWindow)
   library.MobileBuildBatch = 2      -- elements per pause during the step-by-step build
   library.MobileBuildDelay = 0.06   -- pause in seconds; 0 = everything at once
   The menu appears first and then fills up step by step ("loading..." in the title bar).
   Debug log (Mobile only): "D3v1lHub Lib/debug_log.txt", the previous log is in "debug_log_prev.txt".
   library.DebugLog = false turns it off, = true turns it on for PC as well.
   Tooltips, watermark, keybind list, keystrokes and cursor exist on PC only. Mobile ignores all keybinds.

GEMEINSAME ELEMENT-OPTIONEN (Toggle, Slider, Button, Label, Textbox, Dropdown, Colorpicker, ...)
   (string | nil) Tooltip = "Hilfetext beim Hovern"            -- nur PC
   (string | nil) DisabledTooltip = "Text, wenn gesperrt"        -- nur PC
   (boolean | nil) Disabled/Locked = true or false
   (string | table | function | nil) DependsOn = "FlagName" | {"FlagName", Wert} | {{"FlagA", true}, {"FlagB", false}} | function(flags) return bool end
       -- Element is only visible while the condition holds (Dependency Box). An element object instead of a flag name is also allowed.
   Elements with SetLocked/Lock/Unlock additionally have SetDisabled/Disable/Enable (same function).

Library v0.94 [
   CreateWindow: Function (
       (table | nil) Options [
           (string | nil) Name = "Window Name"
           (JSON | nil) DefaultTheme/Theme = "[...]"
           (boolean | nil) Themeable/DefaultTheme/Theme = true or false | Options [
               (string | number | nil) Image = "rbxassetid://7483871523" | 7483871523
               (boolean | nil) Credit = true or false // You're removing my credits? Kinda hurts.
               (string | table | nil) Info = "Extra info displayed in designer" | Lines ["line 1", "line 2", "line 3", "and so on..."]
(string | number | table | nil) Background/Backdrop/Grahpic = "rbxassetid://13337" | 13337 | Options [
(string | number | nil) 1/Asset = "rbxassetid://13337" | 13337
(number | nil) 2/Transparency = 0.5 | 50 // Both examples will make the backdrop half visible (PC: the menu shows the decal by default, darkened by a 55% black layer so buttons stay readable)
(boolean | number | nil) 3/Visible = true or false | 1 or 0 // 1: true, 0: false
]
           ]
       ]
   ) -> Window [
       CreateTab: Function (
           (table | nil) Options [
               (string | nil) Name = "Tab Name"
               (string | number | nil) Image = "rbxassetid://133337" | 133337
               (string | nil) Badge = "NEW" // Small label on the tab
               (Color3 | nil) BadgeColor = Color3.fromRGB(128, 0, 255)
           ]
       ) -> Tab [
           SetBadge: Function (Text, Color) // nil or "" removes the badge
           ClearBadge: Function
           GetBadge: Function -> Text | nil
           CreateSection: Function (
               (table) Options [
                   (string | nil) Name = "Section Name"
                   (string | nil) Side = "Left" or "Right"
               ]
           ) -> Section [
               AddLabel: Function (
                   (table) Options [
                       (string | nil) Text/Value/Name = "Label Text"
                       (string | nil) Flag = "FlagName"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                   ]
               ) -> Label [
                   Options: Table
                   Name: String
                   Type: String
                   Default: String
                   Parent: Section
                   Instance: Instance
                   Set: Function (NewText) -> NewText
RawSet: Function (NewText) -> NewText // Same function as Set. For backwards compatibility.
                   Reset: Function -> DefaultText
                   Get: Function -> CurrentText
Update: Function -> CurrentText // Same function as Get, exists for compat.
               ]
               AddToggle: Function (
                   (table) Options [
                       (string) Name = "Toggle Name"
                       (boolean | nil) Value/Enabled = true or false
                       (function | nil) Callback = Function (NewValue, OldValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (boolean | nil) Locked = true or false
                       (boolean | string | nil) VIP = true | "Badge text" // Shows a gold badge and stays locked until library:SetVIP(true)
                       (function | nil) VIPCheck = Function -> boolean // Alternative unlock check, VIP is unlocked if library.VIP or this returns true
                       (table | boolean | EnumItem | nil) Keybind/Key/KeyBind = Keybind [
                           (string | nil) Mode/KeybindMode = "Dynamic" | "Hold" | "Toggle" // Click the small D/H/T letter next to the key to change it
                           (function | nil) ModeCallback = Function (NewMode)
                           (string | nil) Flag = "ToggleKeybindFlag"
                           (EnumItem | nil) Value = Enum.KeyCode.F
                           (function | nil) Callback = Function (NewValue, OldValue)
                           (function | nil) Pressed = Function
                           (string | nil) Mode = "Dynamic" or "Hold" or "Toggle"
                           (number | nil) DynamicTime = 0.65
                           (table | nil) Location = Table
                           (string | nil) LocationFlag = "LocationFlag"
                           (table | nil) KeyNames = Table
                       ]
                       (function | nil) Condition = Function (NewValue, LastValue) // Will only allow the toggle state to be changed, if this function returns true
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> ToggleInfo [
                   Options: Table
                   Type: String
                   Name: String
                   Default: Boolean
                   Parent: Section
                   Instance: Instance
                   IsVIP: boolean
                   VIPLocked: Function -> boolean
                   SetLocked: Function (LockedState) -> LockState
                   Unlock: function
                   Lock: Function
                   Update: Function -> CurrentValue
                   Set: Function (NewValue) -> NewValue
                   RawSet: Function (NewValue, Condition) -> NewValue // Sets the flag without firing the callback
                   Reset: Function -> DefaultText
                   Get: Function -> CurrentValue
                   SetCondition: Function (NewCondition) -> NewCondition
               ]
               AddTextbox: Function (
                   (table) Options [
                       (string) Name = "Textbox Name"
                       (string | number) Value = "String" or 1337
                       (function | nil) Callback = Function (NewValue, OldValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (string | nil) Placeholder = "Text to display by default"
                       (string | nil) Type = "number"
                       (number | nil) Min = 0
                       (number | nil) Max = 100
                       (number | nil) Decimals/Precision/Precise = 2
                       (boolean | nil) Hex = true or false
                       (boolean | nil) Binary = true or false
                       (number | nil) Base = 10
                       (boolean | nil) Rich/RichText/RichTextBox = true or false
                       (boolean | nil) Lines/MultiLine = true or false
                       (boolean | nil) Scaled/TextScaled = true or false
                       (EnumItem | nil) Font/TextFont = Enum.Font.Code
                       (function | nil) PreFormat = Function (Value)
                       (function | nil) PostFormat = Function (Value)
                       (table | nil) CustomProperties = Properties [
                        TextTruncate = Enum.TextTruncate.None
                       ]
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Textbox [
                   Options: Table
                   Name: String
                   Type: String
                   Default: String/Number
                   Parent: Section
                   Instance: Textbox
                   Update: Function -> CurrentValue
                   Set: Function (NewValue) -> NewValue
RawSet: Function (NewValue) -> NewValue // Sets the flag without firing the callback
                   Reset: Function -> DefaultText
                   Get: Function -> CurrentValue
               ]
               AddSlider: Function (
                   (table) Options [
                       (string) Name = "Slider Name"
                       (number | nil) Value = 0
                       (function | nil) Callback = Function (Value, OldValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (number) Min = 0
                       (number) Max = 100
                       (number | nil) Decimals/Precision/Precise = 2
                       (string | function | nil) Format = "Value %s" | Function (Value, LastValue)
                       (boolean | nil) IllegalInput = true or false // Allow textbox to break min & max limits
                       (boolean | table | nil) Textbox/InputBox/CustomInput = true | Options [
                           (boolean | nil) Hex = true or false
                           (boolean | nil) Binary = true or false
                           (number | nil) Base = 10
                           (function | nil) PreFormat = Function (Value)
                           (function | nil) PostFormat = Function (Value)
                           (boolean | nil) IllegalInput = true or false // Allow textbox to break min & max limits
                       ]
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Slider [
                   Options: Table
                   Name: String
                   Type: String
                   Default: Number
                   Parent: Section
                   Instance: Instance
                   Update: Function (FromValue) -> CurrentValue
                   Set: Function (NewValue) -> NewValue
                RawSet: Function (NewValue) -> NewValue // Changes value without firing callback
                   Reset: Function -> DefaultText
                   Get: Function -> CurrentValue
                   SetConstraints: Function (NewMin, NewMax)
                   SetMin: Function (NewMin)
                   SetMax: Function (NewMax)
               ]
               AddButton: Function (
                   (table) Options [
                       (string) Name = "Button Name"
                       (function | nil) Callback = Function (NumPresses)
(boolean | nil) Locked = true or false
(function | nil) Condition = Function (NumPresses) // Will only allow the button to be pressed, if this function returns true
(boolean | string | nil) Confirm = true | "Confirm text" // First click asks, second click within 3 seconds runs the callback
(number | nil) Cooldown = 10 // Seconds the button is blocked after a press, shows a countdown
(boolean | string | nil) VIP = true | "Badge text" // Gold badge, locked until library:SetVIP(true)
(function | nil) VIPCheck = Function -> boolean
                   ]
                   (table | nil) Options ...
               ) -> Buttons [
                   Options: Table
                   Name: String
                   Type: String
                   Parent: Section
                   Instance: Instance
                   Update: Function -> ButtonName
                   Press: Function (...)
                   IsVIP: boolean
                   VIPLocked: Function -> boolean
                   SetLocked: Function (LockedState) -> LockState
                   Unlock: function
                   Lock: Function
SetCondition: Function(NewCondition) -> NewCondition
RawPress: Function (...) // Does not update press count
                   Get: Function -> Callback, NumPresses
SetText: Function (NewText) -> NewText
SetCallback: Function (NewCallback) -> NewCallback
               ]
               AddKeybind: Function (
                   (table) Options [
                       (string) Name = "Keybind Name"
                       (EnumItem | nil) Value = Enum.KeyCode.F
                       (function | nil) Callback = Function (NewValue, OldValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (function | nil) Pressed = Function (InputObject, GameProcessed)
                       (table | nil) KeyNames = Table
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Keybind [
                   Options: Table
                   Name: String
                   Type: String
                   Parent: Section
                   Instance: Instance
                   Update: Function
                   Set: Function (NewValue) -> NewValue
                   Reset: Function -> DefaultText
                   Get: Function -> CurrentValue
               ]
               AddDropdown: Function (
                   (table) Options [
                       (string) Name = "Dropdown Name"
                       (any) Value = Value
                       (function | nil) Callback = Function (NewValue, LastValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (table | Instance | Enum) List = Table | workspace | Enum.Font
                       (string | function | table | nil) Filter = "StringToMatch" | Function (ValueToCheck) | Table [
                           (boolean | nil) [0] = InverseBool
                           (any) [1] ... = "StringToMatch" | Enum.Font.Code/ValuesToMatch
                       ]
                       (string | function | table | nil) Method = "GetDescendants" | workspace.GetDescendants | Parameters [
                        (string | function) [1/Method] = "GetFriendsOnline" | Player.GetFriendsOnline
                        (any) [1/2/Args/Arguments] ... = 50
                       ]
                       (string | nil) BlankValue/NoValueString/Nothing = "No Selection"
                       (boolean | function | nil) Sort = true or false | Function
                       (boolean | string | nil) Multi/Multiple/MultiSelect = true or false | "Text to display"
                       (boolean | nil) SelectButtons = false // Hides the "Select All" / "Clear" buttons of multiselect lists (shown by default)
                       (function | nil) ItemAdded/AddedCallback = Function (Item, AllItems)
                       (function | nil) ItemRemoved/RemovedCallback = Function (Item, AllItems)
                       (function | nil) ItemChanged/ChangedCallback = Function (Item, SelectedState, Items)
                       (function | nil) ItemsCleared/ClearedCallback = Function (Items, PreviousItems)
(EnumItem/Keycode | nil) ScrollUpButton = Enum.KeyCode.Up // Default is Enum.KeyCode.Up
(EnumItem/Keycode | nil) ScrollDownButton = Enum.KeyCode.Down // Default is Enum.KeyCode.Down
(number | nil) ScrollButtonRate / ScrollRate = 5 // How fast the scroller goes by pressing the scroll buttons
(bool | nil) DisablePrecisionScrolling = true or false // Dissallows use of keys to control pan
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                       (boolean | nil) Searchable = true or false // search box in the opened list
                       (table | nil) DisabledValues = {"Value", ...} // visible but not selectable
                       (function | nil) FormatDisplayValue = Function (Value) -> DisplayText // only the display changes, the value stays raw
                       (number | nil) MaxVisibleDropdownItems = 12 // the opened list scrolls from this count
                       (string | nil) SpecialType = "Player" or "Team" // fills the list automatically (players in the server / teams)
                       (boolean | nil) ExcludeLocalPlayer = true or false // only with SpecialType = "Player"
                   ]
               ) -> Dropdown [
                   Options: Table
                   Name: String
                   Type: String
                   Default: Value
                   Parent: Section
                   Instance: Instance
                   Update: Function
                   Set: Function (NewValue) -> NewValue
RawSet: Function (NewValue) -> NewValue // Sets value without firing callback
                   Reset: Function -> DefaultValue
                   Get: Function -> CurrentValue
                   UpdateList: Function (
                    (table | Instance | Enum) List = Table | workspace | Enum.Font
                    (boolean | nil) ValidateValues = true or false | nil // When set to true, will call Validate() on it
                   ) -> NewList
                   Validate: Function (
                    (any | nil) InvalidValue = "Optional value to be set, if the list's current value is no longer in list"
                   ) -> IsValidBool
               ]
               AddSearchBox: Function (
                   (table) Options [
                       (string) Name = "SearchBox Name"
                       (any) Value = Value
                       (function | nil) Callback = Function (NewValue, LastValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (table | Instance | Enum) List = Table | workspace | Enum.Font
                       (string | function | table | nil) Filter = "StringToMatch" | Function (ValueToCheck) | Table [
                           (boolean | nil) [0] = InverseBool
                           (string | any | nil) [1] ... = "StringToMatch" | Enum.Font.Code
                       ]
                       (string | function | table | nil) Method = "GetDescendants" | workspace.GetDescendants | Parameters [
                        (string | function) [1/Method] = "GetFriendsOnline" | Player.GetFriendsOnline
                        (any) [1/2/Args/Arguments] ... = 50
                       ]
                       (boolean | function | nil) Sort = true or false | Function
                       (string | nil) BlankValue/NoValueString/Nothing = "No Selection"
                       (boolean | string | nil) Multi/Multiple/MultiSelect = true or false | "Text to display"
                       (boolean | nil) SelectButtons = false // Hides the "Select All" / "Clear" buttons of multiselect lists (shown by default)
                       (function | nil) ItemAdded/AddedCallback = Function (Item, AllItems)
                       (function | nil) ItemRemoved/RemovedCallback = Function (Item, AllItems)
                       (function | nil) ItemChanged/ChangedCallback = Function (Item, SelectedState, Items)
                       (function | nil) ItemsCleared/ClearedCallback = Function (Items, PreviousItems)
(EnumItem/Keycode | nil) ScrollUpButton = Enum.KeyCode.Up // Default is Enum.KeyCode.Up
(EnumItem/Keycode | nil) ScrollDownButton = Enum.KeyCode.Down // Default is Enum.KeyCode.Down
(number | nil) ScrollButtonRate / ScrollRate = 5 // How fast the scroller goes by pressing the scroll buttons
(bool | nil) DisablePrecisionScrolling = true or false // Dissallows use of keys to control pan
(boolean | nil) RegEx = true or false // Enables use of %d and %w, etc (False by default)
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> SearchBox [
                   Options: Table
                   Name: String
                   Type: String
                   Default: Value
                   Parent: Section
                   Instance: Instance
                   Update: Function
                   Set: Function (NewValue) -> NewValue
RawSet: Function (NewValue) -> NewValue // Sets value without firing callback
                   Reset: Function -> DefaultValue
                   Get: Function -> CurrentValue
                   UpdateList: Function (
                    (table | Instance | Enum) List = Table | workspace | Enum.Font
                    (boolean | nil) ValidateValues = true or false | nil // When set to true, will call Validate() on it
                   ) -> NewList
                   Validate: Function (
                    (any | nil) InvalidValue = "Optional value to be set, if the list's current value is no longer in list"
                   ) -> IsValidBool
               ]
               AddColorpicker: Function (
                   (table) Options [
                       (string) Name = "Colorpicker Name"
                       (string | Color3 | nil) Value = "rainbow" or "random" | Color3.new()
                       (function | nil) Callback = Function (NewValue, LastValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (boolean | nil) Rainbow = true or false
                       (boolean | nil) Random = true or false
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Colorpicker [
                   Options: Table
                   Name: String
                   Type: String
                   Default: Color3
                   Parent: Section
                   Instance: Instance
                   Update: Function
                   Set: Function (NewValue) -> NewValue
RawSet: Function (NewValue) -> NewValue // Sets value without firing callback
                   Reset: Function -> DefaultColor
                   Get: Function -> CurrentValue
                   SetRainbow: Function (
                       (boolean | nil) RainbowMode = true or false
                   )
               ]
               AddPersistence: Function (
                   (table) Options [
                       (string) Name = "Persistence Name"
                       (string | nil) Value = "FileName"
                       (function | nil) Callback = Function (NewValue, LastValue)
                       (string | nil) Flag = "FlagName"
                       (table | nil) Location = Table
                       (string | nil) LocationFlag = "LocationFlag"
                       (any) UnloadValue = UnloadValue
                       (function | nil) UnloadFunc = Function
                       (string | nil) Workspace = "FolderName"
                       (boolean | string | number | table | nil) Persistive/Flags = true | "all" | 1 (Window) or 2 (Tab) or 3 (Section) | FlagNames [...]
                       (string | nil) Suffix = "Mods"
                       (function | nil) LoadCallback = Function (FilePath, FileName) // 'PreLoad'
                       (function | nil) SaveCallback = Function (FilePath, FileName)
                       (function | nil) PostLoadCallback = Function (FilePath, FileName)
                       (function | nil) PostSaveCallback = Function (FilePath, FileName)
(EnumItem/Keycode | nil) ScrollUpButton = Enum.KeyCode.Up // Default is Enum.KeyCode.Up
(EnumItem/Keycode | nil) ScrollDownButton = Enum.KeyCode.Down // Default is Enum.KeyCode.Down
(number | nil) ScrollButtonRate / ScrollRate = 5 // How fast the scroller goes by pressing the scroll buttons
(bool | nil) DisablePrecisionScrolling = true or false // Dissallows use of keys to control pan
(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
                   ]
               ) -> Persistence [
                   Options: Table
                   Name: String
                   Type: String
                   Default: Value
                   Parent: Section
                   Instance: Instance
                   Update: Function
                   Set: Function (NewValue) -> NewValue
RawSet: Function (NewValue) -> NewValue // Sets value without firing callback
                   Reset: Function -> DefaultFile
                   Get: Function -> CurrentValue
SaveFile: Function (FileName) // Mimics the Save Button with optional file input
LoadFile: Function (FileName) // Mimics the Load Button with optional file input
LoadJSON: Function (JSON) // Mimics the Load Button with specific json
LoadFileRaw: Function (FileName) // Mimics the Load Button with optional file input using Obj:RawSet
LoadJSONRaw: Function (JSON) // Mimics the Load Button with specific json using Obj:RawSet
GetJSON: Function (Func) // Gets the json, and passes it as the first argument of Func. Set to true to use setclipboard
               ]
           ]
           Flags: Table
       ]
       CreateDesigner: Function (
           (table) Options [
(string | number | table | nil) Background/Backdrop/Grahpic = "rbxassetid://13337" | 13337 | Options [
(string | number | nil) 1/Asset = "rbxassetid://13337" | 13337
(number | nil) 2/Transparency = 0.5 | 50 // Both examples will make the backdrop half visible
(boolean | number | nil) 3/Visible = true or false | 1 or 0 // 1: true, 0: false
]
               (string | number | nil) Image = "rbxassetid://7483871523" | 7483871523
               (string | table | nil) Info = "Extra info displayed in designer" | Lines ["line 1", "line 2", "line 3", "and so on..."]
               (boolean | nil) Credit = true
           ]
       ) -> Designer [
           Options: Table
           Parent: Window
           Name: String
           Type: String
           Instance: Instance,
           SetBackground: Function (
            (string | boolean | number | nil) AssetString = "rbxassetid://7483871523" | true or false (as Visible arg) | 7483871523 or transparency (0-100 or 0-1) | nil (Toggle visibility)
            (number | boolean | nil) Transparency = 0.7 or 70 | true or false (as Visible arg)
            (number | boolean | nil) Visible = true/1 or false/0 | nil (Dont change)
           )
       ]
       MoveTabSlider: Function (
           (Instance) tabObject = tabVar
       )
       GoHome: Function
       Flags: Table
   ]
   Designer: Designer
   LP: LocalPlayer
   Players: game.Players
   Mouse: LP:GetMouse()
   Unload: Function
   Notify: Function (
       (table) Options [
           (string) Text/Message/String/Value = "Nachricht"
           (number | nil) Time = 6 // seconds
           (string | nil) Type = "success", "error" or "warning" // colors the accent bar and progress line (Mobile)
       ]
   ) -> Notification [ Text, Active, SetText: Function (NewText), Destroy: Function ]
   Prompt: Function (
       (table) Options [
           (string | nil) Name = "Titel"
           (string | nil) Description/Text/Message = "Beschreibung"
           (table) Options/Buttons/Choices = { Ja = Function, Nein = Function } | { {Name = "OK", Callback = Function} } | {"OK"}
           (number | nil) Timeout = seconds until it closes automatically
           (boolean | nil) KeepOpen = true or false // Fenster bleibt nach einem Klick offen
       ]
   ) -> Prompt [ Active, Close: Function, OnSelect: Event ]
   ShowLoadingScreen: Function ({OnAccept = Function, OnDecline = Function | nil}) // Beim Loader bereits angezeigt: ruft direkt OnAccept auf
   IsMobile: boolean // true if the Mobile library was loaded
   LoadedVersion: "PC" or "Mobile"
ResetAll: Function // Resets all elements to their default value
SaveFile: Function (FileName) // Only if designer is present; this would save all non-deisgner elements
LoadFile: Function (FileName)
LoadJSON: Function (JSON)
LoadFileRaw: Function (FileName)
LoadJSONRaw: Function (JSON)
GetJSON: Function (Func)
signals: Table // All :connection()'s go in that table, and are disconnected upon unloading the gui. Feel free to add yours here, too
   (function | nil) UnloadCallback = Function
(EnumItem/Keycode | nil) scrollupbutton = Enum.KeyCode.Up // Default is Enum.KeyCode.Up
(EnumItem/Keycode | nil) scrolldownbutton = Enum.KeyCode.Down // Default is Enum.KeyCode.Down
   Subs: Shared Functions [
updatecolors: Function // Re-Applys all colors from designer
Wait: Function (Time) // Only waits & returns true if the library has not been unloaded
removeSpaces: Function (String)
Color3ToHex: Function (Color3)
Color3FromHex: Function (String/Hex)
textToSize: Function (String)
Instance_new: Function (Class, Parent) // Automatically protects instances with syn.protect_gui, and adds the instance to library.objects (all objects destroyed when unloading)
   ]
]
