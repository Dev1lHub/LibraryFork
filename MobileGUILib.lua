-- D3v1lHub Library - MOBILE-Version (MobileGUILib.lua)
-- Wird vom Loader (D3v1lLoader.lua) automatisch auf Handys/Tablets geladen.
-- Enthält: alten Loader (Yes/No + Ladebildschirm) + leichtes Mobile-GUI.
--[[ Pepsi's UI Library
Better and updated web-based docs are planned in distant future.
Library v0.36 [
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
					(number | nil) 2/Transparency = 0.5 | 50 // Both examples will make the backdrop half visible
					(boolean | number | nil) 3/Visible = true or false | 1 or 0 // 1: true, 0: false
				]
            ]
        ]
    ) -> Window [
        CreateTab: Function (
            (table | nil) Options [
                (string | nil) Name = "Tab Name"
                (string | number | nil) Image = "rbxassetid://133337" | 133337
            ]
        ) -> Tab [
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
                        (table | boolean | EnumItem | nil) Keybind/Key/KeyBind = Keybind [
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
                        (table | Instance | Enum | function) List = Table | workspace | Enum.Font | Function () -> New List
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
                        (function | nil) ItemAdded/AddedCallback = Function (Item, AllItems)
                        (function | nil) ItemRemoved/RemovedCallback = Function (Item, AllItems)
                        (function | nil) ItemChanged/ChangedCallback = Function (Item, SelectedState, Items)
                        (function | nil) ItemsCleared/ClearedCallback = Function (Items, PreviousItems)
						(EnumItem/Keycode | nil) ScrollUpButton = Enum.KeyCode.Up // Default is Enum.KeyCode.Up
						(EnumItem/Keycode | nil) ScrollDownButton = Enum.KeyCode.Down // Default is Enum.KeyCode.Down
						(number | nil) ScrollButtonRate / ScrollRate = 5 // How fast the scroller goes by pressing the scroll buttons
						(bool | nil) DisablePrecisionScrolling = true or false // Dissallows use of keys to control pan
						(boolean | nil) AllowDuplicateCalls = true or false // Allow the callback to be fired with same value set()
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
                    	(table | Instance | Enum | function) List = Table | workspace | Enum.Font | Function () -> New List
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
                        (table | Instance | Enum | function) List = Table | workspace | Enum.Font | Function () -> New List
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
                    	(table | Instance | Enum | function) List = Table | workspace | Enum.Font | Function () -> New List
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
]]
-- ============================================================
-- SHARED HELPERS (zufällige 10-Zeichen-Namen zur Verschleierung)
-- ============================================================
math.randomseed(tick())
local function generateRandomName()
	local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	local name = ""
	for i = 1, 10 do
		local randIndex = math.random(1, #chars)
		name = name .. string.sub(chars, randIndex, randIndex)
	end
	return name
end

-- Versucht ein ScreenGui bestmöglich zu schützen/zu verstecken (protect_gui -> gethui -> normaler Parent)
-- gibt true zurück, wenn es geschützt geparented wurde, sonst false (dann muss der Aufrufer selbst .Parent setzen)
local function protectAndParentGui(gui, fallbackParent)
	local CoreGui = game:GetService("CoreGui")
	local syn = (typeof(getgenv) == "function" and getgenv().syn) or nil
	local gethui = (typeof(gethui) == "function" and gethui) or nil
	
	if syn and syn.protect_gui then
		local ok = pcall(function()
			syn.protect_gui(gui)
			gui.Parent = CoreGui
		end)
		if ok then
			return true
		end
	end
	
	if gethui then
		local ok = pcall(function()
			gui.Parent = gethui()
		end)
		if ok then
			return true
		end
	end
	
	local ok = pcall(function()
		gui.Parent = CoreGui
	end)
	if ok then
		return true
	end
	
	if fallbackParent then
		pcall(function()
			gui.Parent = fallbackParent
		end)
	end
	return false
end

-- Fügt einer Instanz abgerundete ("smoothe") Ecken hinzu
local function addCorner(instance, radius)
	local ok, corner = pcall(function()
		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, radius or 4)
		c.Parent = instance
		return c
	end)
	if ok then
		return corner
	end
	return nil
end

local library = {
	Version = "0.66 Mobile",
	WorkspaceName = "D3v1lHub Lib",
	flags = {},
	signals = {},
	objects = {},
	elements = {},
	globals = {},
	subs = {},
	colored = {},
	configuration = {
		hideKeybind = Enum.KeyCode.LeftControl,
		smoothDragging = false,
		easingStyle = Enum.EasingStyle.Quart,
		easingDirection = Enum.EasingDirection.Out
	},
colors = {
        main = Color3.fromRGB(168, 85, 247),          -- Kräftiges Anime-Neon-Lila (Akzente)
        background = Color3.fromRGB(18, 16, 24),        -- Sehr dunkles, leicht violettes Schwarz (Hintergrund)
        outerBorder = Color3.fromRGB(10, 8, 15),        -- Tiefer, dunkler äußerer Rahmen
        innerBorder = Color3.fromRGB(59, 43, 76),       -- Dezenter lila-grauer innerer Rahmen
        topGradient = Color3.fromRGB(28, 24, 38),       -- Oberer Farbverlauf (dunkles Lila-Grau)
        bottomGradient = Color3.fromRGB(20, 17, 27),    -- Unterer Farbverlauf
        sectionBackground = Color3.fromRGB(24, 21, 33), -- Sektions-Hintergrund
        section = Color3.fromRGB(216, 180, 254),        -- Helles Lavendel für Sektions-Titel
        otherElementText = Color3.fromRGB(156, 145, 175),-- Gedimmter Text
        elementText = Color3.fromRGB(230, 220, 245),    -- Haupttext (klar und gut lesbar)
        elementBorder = Color3.fromRGB(12, 10, 18),     -- Element-Rahmen
        selectedOption = Color3.fromRGB(50, 38, 70),    -- Ausgewählte Option (sattes Lila)
        unselectedOption = Color3.fromRGB(24, 21, 33),  -- Nicht ausgewählte Option
        hoveredOptionTop = Color3.fromRGB(70, 52, 98),  -- Hover-Effekt (helleres Lila, oben)
        unhoveredOptionTop = Color3.fromRGB(38, 32, 52),-- Standard oben
        hoveredOptionBottom = Color3.fromRGB(55, 40, 78),-- Hover-Effekt (unten)
        unhoveredOptionBottom = Color3.fromRGB(28, 23, 38),-- Standard unten
        tabText = Color3.fromRGB(200, 190, 220)       -- Tab-Textfarbe
    },
	gui_parent = (function()
		local x, c = pcall(function()
			return game:GetService("CoreGui")
		end)
		if x and c then
			return c
		end
		x, c = pcall(function()
			return (game:IsLoaded() or (game.Loaded:Wait() or 1)) and game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		end)
		if x and c then
			return c
		end
		x, c = pcall(function()
			return game:GetService("StarterGui")
		end)
		if x and c then
			return c
		end
		return error("Seriously bad engine. Can't find a place to store the GUI. Robust code can't help this much incompetence.")
	end)(),
	colorpicker = false,
	colorpickerconflicts = {},
	rainbowflags = {},
	rainbows = 0,
	rainbowsg = 0
}
library.Subs = library.subs
local library_flags = library.flags
library.Flags = library_flags
local destroyrainbows, destroyrainbowsg = nil
function darkenColor(clr, intensity)
	if not intensity or (intensity == 1) then
		return clr
	end
	if clr and ((typeof(clr) == "Color3") or (type(clr) == "table")) then
		return Color3.new(clr.R / intensity, clr.G / intensity, clr.B / intensity)
	end
end
library.subs.darkenColor = darkenColor
local __runscript = true
local function wait_check(...)
	if __runscript then
		return wait(...)
	else
		wait()
		return false
	end
end
library.subs.Wait, library.subs.wait, library.Wait = wait_check, wait_check, wait_check
function library.IsGuiValid()
	return __runscript
end
local lasthidebing = 0
local temp = game:FindService("MarketplaceService") or game:GetService("MarketplaceService")
local Marketplace = (temp and (cloneref and cloneref(temp))) or temp
local resolvevararg, temp = nil
do
	local lwr = string.lower
	function library.defaultSort(a, b)
		return lwr(tostring(b)) > lwr(tostring(a))
	end
end
do
	local varargresolve = {
		Window = {"Name", "Theme"},
		Tab = {"Name", "Image"},
		Section = {"Name", "Side"},
		Label = {"Text", "Flag", "UnloadValue", "UnloadFunc", "Tooltip", "DisabledTooltip"},
		Toggle = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Locked", "Disabled", "Keybind", "Condition", "AllowDuplicateCalls", "Tooltip", "DisabledTooltip"},
		Textbox = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Placeholder", "Type", "Min", "Max", "Decimals", "Hex", "Binary", "Base", "RichTextBox", "MultiLine", "TextScaled", "TextFont", "PreFormat", "PostFormat", "CustomProperties", "AllowDuplicateCalls", "Tooltip", "DisabledTooltip"},
		Slider = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Min", "Max", "Decimals", "Format", "IllegalInput", "Textbox", "AllowDuplicateCalls", "Tooltip", "DisabledTooltip"},
		Button = {"Name", "Callback", "Locked", "Disabled", "Condition", "Tooltip", "DisabledTooltip"},
		Keybind = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Pressed", "KeyNames", "AllowDuplicateCalls", "Tooltip", "DisabledTooltip"},
		Dropdown = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "List", "Filter", "Method", "Nothing", "Sort", "MultiSelect", "ItemAdded", "ItemRemoved", "ItemChanged", "ItemsCleared", "ScrollUpButton", "ScrollDownButton", "ScrollButtonRate", "DisablePrecisionScrolling", "AllowDuplicateCalls", "Searchable", "DisabledValues", "FormatDisplayValue", "MaxVisibleDropdownItems", "SpecialType", "ExcludeLocalPlayer", "Tooltip", "DisabledTooltip"},
		SearchBox = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "List", "Filter", "Method", "Nothing", "Sort", "MultiSelect", "ItemAdded", "ItemRemoved", "ItemChanged", "ItemsCleared", "ScrollUpButton", "ScrollDownButton", "ScrollButtonRate", "DisablePrecisionScrolling", "RegEx", "AllowDuplicateCalls"},
		Colorpicker = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Rainbow", "Random", "AllowDuplicateCalls", "Tooltip", "DisabledTooltip"},
		Persistence = {"Name", "Value", "Callback", "Flag", "Location", "LocationFlag", "UnloadValue", "UnloadFunc", "Workspace", "Persistive", "Suffix", "LoadCallback", "SaveCallback", "PostLoadCallback", "PostSaveCallback", "ScrollUpButton", "ScrollDownButton", "ScrollButtonRate", "DisablePrecisionScrolling", "AllowDuplicateCalls"},
		Designer = {"Backdrop", "Image", "Info", "Credit"}
	}
	function resolvevararg(objtype, ...)
		local data = varargresolve[objtype]
		local t = {}
		if data then
			for index, value in next, {...} do
				t[data[index]] = value
			end
		end
		return t
	end
end
local resolvercache = {}
library.resolvercache = resolvercache
local function resolveid(image, flag)
	if image then
		if type(image) == "string" then
			if (#image > 14 and string.sub(image, 1, 13) == "rbxassetid://") or (#image > 12 and string.sub(image, 1, 11) == "rbxasset://") or (#image > 12 and string.sub(image, 1, 11) ~= "rbxthumb://") then
				if flag then
					local thing = library.elements[flag] or library.designerelements[flag]
					if thing and thing.Set then
						task.spawn(thing.Set, thing, image)
					end
				end
				return image
			end
		end
		local orig = image
		if resolvercache[orig] then
			if flag then
				local thing = library.elements[flag] or library.designerelements[flag]
				if thing and thing.Set then
					task.spawn(thing.Set, thing, resolvercache[orig])
				end
			end
			return resolvercache[orig]
		end
		image = tonumber(image) or image
		local succezz = pcall(function()
			local typ = type(image)
			if typ == "string" then
				if getsynasset then
					if #image > 11 and (string.sub(image, 1, 11) == "synasset://") then
						return getsynasset(string.sub(image, 12))
					elseif (#image > 14) and (string.sub(image, 1, 14) == "synasseturl://") then
						local x, e = pcall(function()
							local codename, fixes = string.gsub(image, ".", function(c)
								if c:lower() == c:upper() and not tonumber(c) then
									return ""
								end
							end)
							codename = string.sub(codename, 1, 24) .. tostring(fixes)
							local fold = isfolder("D3v1lHub Lib")
							if fold then
							else
								makefolder("D3v1lHub Lib")
							end
							fold = isfolder("D3v1lHub Lib/Themes")
							if fold then
							else
								makefolder("D3v1lHub Lib/Themes")
							end
							fold = isfolder("D3v1lHub Lib/Themes/SynapseAssetsCache")
							if fold then
							else
								makefolder("D3v1lHub Lib/Themes/SynapseAssetsCache")
							end
							if not fold or not isfile("D3v1lHub Lib/Themes/SynapseAssetsCache/" .. codename .. ".dat") then
								local res = game:HttpGet(string.sub(image, 15))
								if res ~= nil then
									writefile("D3v1lHub Lib/Themes/SynapseAssetsCache/" .. codename .. ".dat", res)
								end
							end
							return getsynasset(readfile("D3v1lHub Lib/Themes/SynapseAssetsCache/" .. codename .. ".dat"))
						end)
						if x and e ~= nil then
							return e
						end
					end
				end
				if (#image < 11) or ((string.sub(image, 1, 13) ~= "rbxassetid://") and (string.sub(image, 1, 11) ~= "rbxasset://") and string.sub(image, 1, 11) ~= "rbxthumb://") then
					image = tonumber(image:gsub("%D", ""), 10) or image
					typ = type(image)
				end
			end
			if (typ == "number") and (image > 0) then
				pcall(function()
					local nfo = Marketplace and Marketplace:GetProductInfo(image)
					image = tostring(image)
					if nfo and nfo.AssetTypeId == 1 then
						image = "rbxassetid://" .. image
					elseif nfo and nfo.AssetTypeId == 13 then
						-- Decal-ID -> Bild über rbxthumb anzeigen. Vorher wurde dafür game:GetObjects
						-- benutzt: das gibt es bei vielen (v.a. mobilen) Executors nicht oder es
						-- bringt Roblox dort zum Absturz.
						image = "rbxthumb://type=Asset&id=" .. image .. "&w=420&h=420"
					end
				end)
			else
				image = nil
			end
		end)
		if succezz and image then
			if orig then
				resolvercache[orig] = image
			end
			resolvercache[image] = image
			if flag then
				local thing = library.elements[flag] or library.designerelements[flag]
				if thing and thing.Set then
					task.spawn(thing.Set, thing, image)
				end
			end
		end
	end
	return image
end
library.subs.ResolveID = resolveid
library.resolvercache = resolvercache
local colored, colors = library.colored, library.colors
local tweenService = game:GetService("TweenService")
local updatecolors, MainScreenGui = nil
do
	local MayGC = 0
	spawn(function()
		local IsDescendantOf = game.IsDescendantOf
		local RemoveTable = table.remove
		while wait_check() do
			while shared.NO_LIB_GC do
				wait(20)
				if wait_check() then
				else
					return
				end
			end
			wait(10)
			local Breathe = 30
			for DataIndex = #colored, 1, -1 do
				if MayGC > 0 then
					break
				end
				Breathe -= 1
				if Breathe <= 0 then
					Breathe = 30
					if wait_check() then
						if MayGC > 0 then
							break
						end
					else
						return
					end
				end
				if MayGC > 0 then
					break
				end
				local data = colored[DataIndex]
				data = data and data[1]
				if data and (typeof(data) == "Instance") and IsDescendantOf(data, game) then
					-- Instanz existiert noch irgendwo im Spiel (Hauptmenü, Watermark, Keybinds-Liste, Notify usw.) -> behalten
				elseif data and typeof(data) ~= "Instance" then
					-- Kein Roblox-Instance (z. B. ein internes Modul-Table wie KeybindsListModule.MainColor) -> nie automatisch entfernen
				elseif MayGC <= 0 then
					RemoveTable(colored, DataIndex)
				else
					break
				end
			end
			local sigs = library.signals
			local len = sigs and #sigs
			if len then
				local Dyn = math.round(len / 10)
				Dyn = ((Dyn < 1) and 1) or Dyn
				for DataIndex = len, 1, -1 do
					Breathe -= 1
					if Breathe <= 0 then
						Breathe = Dyn
						if wait_check() then
						else
							return
						end
					end
					local data = sigs[DataIndex]
					if data and (typeof(data) == "RBXScriptConnection") and data.Connected then
					else
						RemoveTable(sigs, DataIndex)
					end
				end
			end
		end
	end)
	local function colortwee(data, tweenit)
		local cclr = colors[data[3]]
		local darkness = data[4]
		tweenService:Create(data[1], TweenInfo.new(tweenit, library.configuration.easingStyle, library.configuration.easingDirection), {
			[data[2]] = (darkness and darkness ~= 1 and darkenColor(cclr, darkness)) or cclr
		}):Play()
	end
	local function colordarktwee(data)
		local cclr = colors[data[3]]
		local darkness = data[4]
		data[1][data[2]] = (darkness and darkness ~= 1 and darkenColor(cclr, darkness)) or cclr
	end
	function updatecolors(tweenit)
		MayGC += 1
		if library.objects and (#library.objects > 0 or next(library.objects)) then
			for _, data in next, colored do
				local x, e
				if tweenit then
					x, e = pcall(colortwee, data, tweenit)
				end
				if x then
				else
					local x, e = pcall(colordarktwee, data)
					if e and not x then
						warn(debug.traceback(e))
					end
				end
			end
			pcall(function()
				if library.Backdrop then
					library.Backdrop.Visible = library_flags["__Designer.Background.UseBackgroundImage"] and true
					library.Backdrop.Image = resolveid(library_flags["__Designer.Background.ImageAssetID"], "__Designer.Background.ImageAssetID") or ""
					library.Backdrop.ImageColor3 = library_flags["__Designer.Background.ImageColor"] or Color3.new(1, 1, 1)
					library.Backdrop.ImageTransparency = (library_flags["__Designer.Background.ImageTransparency"] or 50) / 100
				end
			end)
		end
		MayGC -= 1
	end
end
local function updatecolorsnotween()
	updatecolors()
end
library.subs.updatecolors = updatecolors
library.colors = setmetatable({}, {
	__index = colors,
	__newindex = function(_, k, v)
		if colors[k] ~= v then
			colors[k] = v
			spawn(updatecolorsnotween)
		end
	end
})
local elements = library.elements
library.__AllSections = library.__AllSections or {}

-- ============================================================
-- SEARCH (filtert Toggles/Slider/Buttons/usw. live nach Namen und blendet
-- alles andere aus; leere Groupboxen werden dabei ebenfalls versteckt)
-- ============================================================
-- Gemeinsames Sichtbarkeits-System für Suche UND Dependency Boxes:
-- ein Element ist sichtbar, wenn (a) seine DependsOn-Bedingung erfüllt ist und
-- (b) keine Suche läuft oder sein Name zur Suche passt. Sections ohne sichtbaren
-- Inhalt werden ausgeblendet. Vorher hat Update() leere Sections bei der Suche
-- sofort wieder eingeblendet.
library.__SearchQuery = ""
local function sectionHasVisibleChild(holder)
	for _, child in next, holder:GetChildren() do
		if child:IsA("GuiObject") and child.Visible then
			return true
		end
	end
	return false
end
local function updateSectionVisibility()
	for _, entry in next, library.__AllSections do
		local frame, holder, functions = entry.Frame, entry.Holder, entry.Functions
		if frame and holder and frame.Parent and functions then
			if sectionHasVisibleChild(holder) then
				-- Update() blendet die Section ein und berechnet Größe + Scrollbereich neu
				pcall(functions.Update, functions)
			elseif frame.Visible then
				frame.Visible = false
			end
		end
	end
end
local visibilityRefreshRunning = false
local visibilityRefreshAgain = false
local function refreshElementVisibility()
	local query = library.__SearchQuery or ""
	local searching = query ~= ""
	-- Erst alle Element-Container verstecken: mehrere Elemente können sich einen
	-- Container teilen (z.B. mehrere Buttons in einer Reihe) ...
	for _, obj in next, elements do
		if type(obj) == "table" and obj.Container and obj.Container.Visible then
			obj.Container.Visible = false
		end
	end
	-- ... und dann jeden Container zeigen, in dem mindestens ein Element sichtbar sein soll
	for _, obj in next, elements do
		if type(obj) == "table" and obj.Container and not obj.__DepHidden then
			local show = true
			if searching then
				local name = tostring(obj.DisplayName or (obj.Options and obj.Options.Name) or obj.Name or "")
				show = string.find(string.lower(name), query, 1, true) ~= nil
			end
			if show then
				obj.Container.Visible = true
			end
		end
	end
	-- Layout-Größen aktualisiert Roblox erst im nächsten Frame -> Sections danach anpassen.
	-- Mehrere Aufrufe kurz hintereinander werden zu einem Durchlauf zusammengefasst.
	if visibilityRefreshRunning then
		visibilityRefreshAgain = true
		return
	end
	visibilityRefreshRunning = true
	task.spawn(function()
		repeat
			visibilityRefreshAgain = false
			task.wait()
			pcall(updateSectionVisibility)
			-- zweiter Durchlauf: Scrollbereich der Spalten passt erst, wenn die Sections ihre neue Größe haben
			task.wait()
			pcall(updateSectionVisibility)
		until not visibilityRefreshAgain
		visibilityRefreshRunning = false
	end)
end
library.RefreshVisibility = refreshElementVisibility
local function applySearch(query)
	query = string.lower(tostring(query or ""))
	query = (string.gsub(query, "^%s+", ""))
	query = (string.gsub(query, "%s+$", ""))
	library.__SearchQuery = query
	refreshElementVisibility()
end
-- ============================================================
-- DEPENDENCY BOXES (wie bei Linoria): jedes Element kann per Option
--   DependsOn = "Flag"                          -> sichtbar, wenn der Flag-Wert truthy ist (z.B. Toggle an)
--   DependsOn = {"Flag", Wert}                  -> sichtbar, wenn Flag == Wert (z.B. {"Modus", "Legit"})
--   DependsOn = {{"FlagA", true}, {"FlagB", false}} -> alle Bedingungen müssen stimmen
--   ACHTUNG: {"FlagA", "FlagB"} bedeutet "FlagA hat den Wert 'FlagB'" - mehrere Flags
--   immer verschachtelt angeben: {{"FlagA"}, {"FlagB"}}
--   DependsOn = function(flags) return ... end  -> eigene Bedingung
-- automatisch ein-/ausgeblendet werden. Statt eines Flag-Namens kann auch das
-- zurückgegebene Element-Objekt selbst angegeben werden (z.B. DependsOn = MeinToggle).
-- Die Bedingung kann zur Laufzeit geändert werden: obj.Options.DependsOn = ...
-- ============================================================
local function resolveDependencyFlag(ref)
	if type(ref) == "table" and ref.Flag ~= nil then
		return ref.Flag
	end
	return ref
end
local warnedDependencyFns = setmetatable({}, {__mode = "k"})
local evaluateDependency
function evaluateDependency(dep, depth)
	depth = (depth or 0) + 1
	if dep == nil or depth > 16 then
		return true
	end
	local t = type(dep)
	if t == "function" then
		local ok, res = pcall(dep, library_flags)
		if not ok then
			-- nur einmal pro Bedingung warnen, sonst 20x pro Sekunde
			if not warnedDependencyFns[dep] then
				warnedDependencyFns[dep] = true
				warn("[DependsOn] Fehler in der Bedingung:", res)
			end
			return true
		end
		return res and true or false
	elseif t == "string" then
		return library_flags[dep] and true or false
	elseif t == "table" then
		-- Ein Element-Objekt oder {Flag = "...", Value = ...}
		if dep.Flag ~= nil then
			if dep.Value ~= nil then
				return library_flags[dep.Flag] == dep.Value
			end
			return library_flags[dep.Flag] and true or false
		end
		local first = dep[1]
		-- {"Flag", Wert} bzw. {Element, Wert}
		if type(first) == "string" or (type(first) == "table" and first.Flag ~= nil and type(first[1]) == "nil" and dep[2] ~= nil and type(dep[2]) ~= "table") then
			local flag = resolveDependencyFlag(first)
			if dep[2] == nil then
				return library_flags[flag] and true or false
			end
			return library_flags[flag] == dep[2]
		end
		-- Liste von Bedingungen: alle müssen erfüllt sein
		for _, sub in ipairs(dep) do
			if not evaluateDependency(sub, depth) then
				return false
			end
		end
		return true
	end
	return true
end
library.subs.EvaluateDependency = evaluateDependency
local function scanDependencies()
	local changed = false
	for _, obj in next, elements do
		if type(obj) == "table" and obj.Container then
			local opts = obj.Options
			local dep = (type(opts) == "table") and (opts.DependsOn or opts.Depends) or nil
			if dep ~= nil or obj.__DepHidden then
				local hidden = not evaluateDependency(dep)
				if (obj.__DepHidden and true or false) ~= hidden then
					obj.__DepHidden = hidden
					changed = true
				end
			end
		end
	end
	if changed then
		refreshElementVisibility()
	end
end
task.spawn(function()
	local warnedLoopError = false
	while wait_check(0.05) do
		-- abgesichert: ein Fehler (z.B. weil sich die Element-Liste während des Durchlaufs
		-- geändert hat) beendet die Schleife nicht mehr, DependsOn läuft einfach weiter
		local ok, err = pcall(scanDependencies)
		if not ok and not warnedLoopError then
			warnedLoopError = true
			warn("[DependsOn] Fehler beim Prüfen der Abhängigkeiten:", err)
		end
	end
end)
library.__ApplySearch = applySearch

shared.libraries = shared.libraries or {}
local colorpickerconflicts = library.colorpickerconflicts
local keyHandler = {
	notAllowedKeys = {
		[Enum.KeyCode.Return] = true,
		[Enum.KeyCode.Space] = true,
		[Enum.KeyCode.Tab] = true,
		[Enum.KeyCode.Unknown] = true,
		[Enum.KeyCode.Backspace] = true
	},
	notAllowedMouseInputs = {
		[Enum.UserInputType.MouseMovement] = true,
		[Enum.UserInputType.MouseWheel] = true,
		[Enum.UserInputType.MouseButton1] = true,
		[Enum.UserInputType.MouseButton2] = true,
		[Enum.UserInputType.MouseButton3] = true
	},
	allowedKeys = {
		[Enum.KeyCode.LeftShift] = "LShift",
		[Enum.KeyCode.RightShift] = "RShift",
		[Enum.KeyCode.LeftControl] = "LCtrl",
		[Enum.KeyCode.RightControl] = "RCtrl",
		[Enum.KeyCode.LeftAlt] = "LAlt",
		[Enum.KeyCode.RightAlt] = "RAlt",
		[Enum.KeyCode.CapsLock] = "CAPS",
		[Enum.KeyCode.One] = "1",
		[Enum.KeyCode.Two] = "2",
		[Enum.KeyCode.Three] = "3",
		[Enum.KeyCode.Four] = "4",
		[Enum.KeyCode.Five] = "5",
		[Enum.KeyCode.Six] = "6",
		[Enum.KeyCode.Seven] = "7",
		[Enum.KeyCode.Eight] = "8",
		[Enum.KeyCode.Nine] = "9",
		[Enum.KeyCode.Zero] = "0",
		[Enum.KeyCode.KeypadOne] = "Num-1",
		[Enum.KeyCode.KeypadTwo] = "Num-2",
		[Enum.KeyCode.KeypadThree] = "Num-3",
		[Enum.KeyCode.KeypadFour] = "Num-4",
		[Enum.KeyCode.KeypadFive] = "Num-5",
		[Enum.KeyCode.KeypadSix] = "Num-6",
		[Enum.KeyCode.KeypadSeven] = "Num-7",
		[Enum.KeyCode.KeypadEight] = "Num-8",
		[Enum.KeyCode.KeypadNine] = "Num-9",
		[Enum.KeyCode.KeypadZero] = "Num-0",
		[Enum.KeyCode.Minus] = "-",
		[Enum.KeyCode.Equals] = "=",
		[Enum.KeyCode.Tilde] = "~",
		[Enum.KeyCode.LeftBracket] = "[",
		[Enum.KeyCode.RightBracket] = "]",
		[Enum.KeyCode.RightParenthesis] = ")",
		[Enum.KeyCode.LeftParenthesis] = "(",
		[Enum.KeyCode.Semicolon] = ";",
		[Enum.KeyCode.Quote] = "'",
		[Enum.KeyCode.BackSlash] = "\\",
		[Enum.KeyCode.Comma] = ",",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Slash] = "/",
		[Enum.KeyCode.Asterisk] = "*",
		[Enum.KeyCode.Plus] = "+",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Backquote] = "`"
	}
}
local SeverAllConnections = nil
function SeverAllConnections(t, cache)
	cache = cache or {}
	for k, v in next, t do
		t[k] = nil
		if v ~= nil then
			if cache[v] then
				continue
			end
			local te = v and typeof(v)
			if te then
				if te == "RBXScriptConnection" then
					v:Disconnect()
				elseif te == "Instance" then
					v:Destroy()
				elseif te == "table" then
					cache[v] = true
					SeverAllConnections(v, cache)
				end
			end
		end
	end
end
library.Subs.SeverAllConnections = SeverAllConnections
local function hardunload(library)
	if library.UnloadCallback and (type(library.UnloadCallback) == "function") then
		local x, e = pcall(library.UnloadCallback)
		if not x and e then
			task.spawn(error, e, 2)
		end
	end
	for cflag, data in next, elements do
		if data.Type ~= "Persistence" then
			if data.Set and data.Options.UnloadValue ~= nil then
				data.Set(data.Options.UnloadValue)
			end
			if data.Options.UnloadFunc then
				local y, u = pcall(data.Options.UnloadFunc)
				if not y and u then
					warn(debug.traceback("Error unloading '" .. tostring(cflag) .. "'\n" .. u))
				end
			end
		end
	end
	local hardcache = {}
	SeverAllConnections(library.signals, hardcache)
	SeverAllConnections(library.objects, hardcache)
	hardcache = (table.clear(hardcache) and nil) or nil
	library.signals = nil
	library.objects = nil
end
library.Subs.UnloadArg = hardunload
local function unloadall()
	if shared.libraries then
		local b = 50
		while #shared.libraries > 0 do
			b = b - 1
			if b < 0 then
				b = 50
				wait(warn("Looped 50 times while unloading....?"))
			end
			local v = shared.libraries[1]
			if v and v.unload and (type(v.unload) == "function") then
				if not pcall(v.unload) then
					pcall(hardunload, v)
					for k in next, v do
						v[k] = nil
					end
				end
				if shared.libraries then
					pcall(function()
						table.remove(shared.libraries, 1)
					end)
				else
					return pcall(hardunload, library)
				end
			end
		end
	end
	shared.libraries = nil
end
shared.unloadall = unloadall
library.unloadall = unloadall
shared.libraries[1 + #shared.libraries] = library
function library.unload()
	__runscript = nil
	hardunload(library)
	if shared.libraries then
		for k, v in next, shared.libraries or {} do
			if v == library then
				for k in next, table.remove(shared.libraries or {}, k) do
					v[k] = nil
				end
				break
			end
		end
		if shared.libraries and (#shared.libraries == 0) then
			shared.libraries = nil
		end
	end
	warn("Unloaded")
end
library.Unload = library.unload
local Instance_new = (syn and syn.protect_gui and function(...)
	local x = {Instance.new(...)}
	if x[1] then
		library.objects[1 + #library.objects] = x[1]
		pcall(syn.protect_gui, x[1])
	end
	return unpack(x)
end) or function(...)
	local x = {Instance.new(...)}
	if x[1] then
		library.objects[1 + #library.objects] = x[1]
	end
	return unpack(x)
end
library.subs.Instance_new = Instance_new
-- Laufschrift/Marquee: wenn ein Text-Label breiter ist als der ihm zugewiesene Platz,
-- wird der Text stattdessen in einer geclippten Box hin und her animiert statt zu überlappen/umzubrechen.
local function makeMarquee(headline)
	local originalPosition = headline.Position
	local originalSize = headline.Size
	local wrapper = Instance_new("Frame")
	wrapper.Name = generateRandomName()
	wrapper.BackgroundTransparency = 1
	wrapper.ClipsDescendants = true
	-- Y um 8px vergrößern (und mittig ausgleichen), damit Unterlängen wie g/y/p nicht abgeschnitten werden
	wrapper.Position = UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset, originalPosition.Y.Scale, originalPosition.Y.Offset - 4)
	wrapper.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, originalSize.Y.Scale, originalSize.Y.Offset + 8)
	wrapper.AnchorPoint = headline.AnchorPoint
	wrapper.ZIndex = headline.ZIndex
	wrapper.LayoutOrder = headline.LayoutOrder -- wichtig, falls der Parent (z.B. titleBar) eine UIListLayout benutzt
	wrapper.Parent = headline.Parent
	headline.Parent = wrapper
	headline.AnchorPoint = Vector2.new(0, 0.5)
	headline.Position = UDim2.new(0, 0, 0.5, 0)
	headline.Size = UDim2.new(0, 0, 1, 0)
	headline.AutomaticSize = Enum.AutomaticSize.X
	headline.TextXAlignment = Enum.TextXAlignment.Left
	local activeTween = nil
	local generation = 0
	local function refresh()
		generation = generation + 1
		local myGeneration = generation
		if activeTween then
			activeTween:Cancel()
			activeTween = nil
		end
		headline.Position = UDim2.new(0, 0, 0.5, 0)
		task.defer(function()
			if generation ~= myGeneration then
				return
			end
			-- +2px: das rechte Ende des Texts verschwindet schon 2px bevor es den echten Rand erreicht, nur auf der rechten Seite
			local overflow = (headline.AbsoluteSize.X - wrapper.AbsoluteSize.X) + 2
			-- Mobile mit verkleinertem Menü (UIScale): Absolute-Werte sind dann skaliert -> zurückrechnen
			local menuScale = library.__MenuScale
			if type(menuScale) == "number" and menuScale > 0 then
				overflow = overflow / menuScale
			end
			if overflow ~= overflow then
				return
			end
			if overflow > 2 then
				local duration = math.clamp(overflow / 30, 1.5, 8)
				-- Ablauf: 2 Sek. warten -> hin scrollen -> 2 Sek. warten -> zurück scrollen -> wiederholen
				task.spawn(function()
					while generation == myGeneration do
						task.wait(2)
						if generation ~= myGeneration then
							break
						end
						activeTween = tweenService:Create(headline, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Position = UDim2.new(0, -overflow, 0.5, 0)
						})
						activeTween:Play()
						activeTween.Completed:Wait()
						if generation ~= myGeneration then
							break
						end
						task.wait(2)
						if generation ~= myGeneration then
							break
						end
						activeTween = tweenService:Create(headline, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Position = UDim2.new(0, 0, 0.5, 0)
						})
						activeTween:Play()
						activeTween.Completed:Wait()
					end
				end)
			end
		end)
	end
	refresh()
	return refresh
end
local playersservice = game:GetService("Players")
local function getresolver(listt, filter, method, _)
	local huo, args = type(filter), {}
	local hou = typeof(listt)
	return ((hou == "function") and function(...)
		return listt(...)
	end) or ((hou == "table") and function()
		return listt
	end) or function()
		local hardtype = nil
		local g = listt
		for _ = 1, 5 do
			hardtype = typeof(g)
			if hardtype == "function" then
				local x, e = pcall(listt)
				if x and e then
					g = e
				end
				hardtype = typeof(g)
			end
			if hardtype == "Instance" then
				local lastg = g
				if method == nil and listt == playersservice then
					g = listt:GetPlayers()
				end
				if method then
					local metype = type(method)
					if metype == "table" then
						method = method.Method or method[1]
						args = method.Args or method.Arguments or unpack(method, (method.Method ~= nil and 1) or 2)
						metype = type(method)
					end
					local y, u = nil, nil
					if metype == "function" then
						y, u = pcall(method, listt, unpack(args))
					elseif metype == "string" then
						local y, u = pcall(function()
							return listt[method](listt, unpack(args))
						end)
					else
						warn("Idk how to handle method type of", metype, debug.traceback(""))
					end
					if u then
						if y then
							g = u
						else
							warn("Error trying method", method, "on", listt, debug.traceback(u))
						end
					end
				end
				if g == lastg then
					g = listt:GetChildren()
				end
			end
			if hardtype == "Enum" then
				g = listt:GetEnumItems()
			end
			hardtype = typeof(g)
			if hardtype == "table" then
				break
			end
		end
		hardtype = typeof(g)
		if hardtype ~= "table" then
			warn("Could not resolve " .. hou .. " type to a list.")
			return {}
		end
		if filter then
			if huo == "function" then
				local accept = {}
				for _, v in next, g do
					local x, e = pcall(filter, v)
					if x and e then
						accept[1 + #accept] = (e == true and v) or e
					end
				end
				g = accept
			elseif huo == "string" then
				local accept = {}
				for _, v in next, g do
					if tostring(v):lower():find(huo) then
						accept[1 + #accept] = v
					end
				end
				g = accept
			elseif huo == "table" then
				local accept = {}
				if type(filter[1]) == "string" then
					for _, v in next, g do
						if tostring(v):lower():find(huo) then
							accept[1 + #accept] = v
						elseif filter[0] then
							accept[1 + #accept] = v
						end
					end
				else
					for _, v in next, g do
						if not table.find(filter, v) and not table.find(filter, tostring(v)) then
							accept[1 + #accept] = v
						elseif not filter[0] then
							accept[1 + #accept] = v
						end
					end
				end
				g = accept
			end
		end
		return g
	end
end
library.subs.GetResolver = getresolver
local function resetall()
	destroyrainbowsg = true
	pcall(function()
		for k, v in next, elements do
			if v and k and v.Set and (v.Default ~= nil) and (library_flags[k] ~= v.Default) and (string.sub(k, 1, 11) ~= "__Designer.") then
				v:Set(v.Default)
			end
		end
	end)
end
library.ResetAll = resetall
local textService = game:GetService("TextService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local LP = playersservice.LocalPlayer
library.LP = LP
library.Players = playersservice
library.UserInputService = userInputService
library.RunService = runService
local mouse = LP and LP:GetMouse()
if not mouse and PluginManager and runService:IsStudio() then
	shared.library_plugin = shared.library_plugin or print("Creating Studio Test-Plugin...") or PluginManager():CreatePlugin()
	mouse = shared.library_plugin:GetMouse()
	library.plugin = shared.library_plugin
end
library.Mouse = mouse
local textToSize = nil
do
	local textService = game:GetService("TextService")
	-- große, aber ENDLICHE Grenze statt math.huge (unendliche Werte sind auf manchen Geräten heikel)
	local bigv2 = Vector2.new(100000, 100000)
	function textToSize(object)
		local ok, size = pcall(textService.GetTextSize, textService, object.Text, object.TextSize, object.Font, bigv2)
		if ok and typeof(size) == "Vector2" then
			return size
		end
		return Vector2.new(#tostring(object.Text) * (object.TextSize or 14) * 0.6, object.TextSize or 14)
	end
end
library.subs.textToSize = textToSize
-- Rechnet Bildschirm-Pixel (AbsoluteSize, AbsoluteContentSize ...) in "Menü-Pixel" zurück.
-- Auf Mobile wird das Menü per UIScale verkleinert, falls es sonst nicht in die Breite passt.
-- Roblox meldet Absolute-Werte dann bereits verkleinert -> ohne Rückrechnung würden Größen,
-- die daraus berechnet werden (Sections, Scrollbereiche ...), doppelt schrumpfen.
local function toLogical(v)
	local s = library.__MenuScale
	if type(s) ~= "number" or s <= 0 then
		return v
	end
	return v / s
end
library.subs.ToLogical = toLogical
-- Füllstand eines Sliders (0..1) ohne NaN/Unendlich: Min == Max oder ungültige Werte ergaben
-- vorher 0/0 = NaN als GUI-Größe - so etwas kann den Roblox-Client (v.a. auf Handys) abstürzen lassen
local function safeFillRatio(value, minV, maxV)
	value, minV, maxV = tonumber(value), tonumber(minV), tonumber(maxV)
	if not value or not minV or not maxV then
		return 0
	end
	local range = maxV - minV
	if range == 0 or range ~= range then
		return 0
	end
	local r = (value - minV) / range
	if r ~= r then
		return 0
	end
	return math.clamp(r, 0, 1)
end
library.subs.SafeFillRatio = safeFillRatio
-- ============================================================
-- Geräte-Erkennung (Mobile / PC)
-- Manuell erzwingen: library.MobileMode = true / false (vor ShowLoadingScreen/CreateWindow setzen)
-- ============================================================
local function DetectMobile()
	-- Manuelle Überschreibung hat Vorrang
	if library.MobileMode ~= nil then
		return library.MobileMode == true
	end
	-- Eigenschaften sicher lesen (manche Executor-Umgebungen werfen hier Fehler)
	local function readInput(prop)
		local ok, value = pcall(function()
			return userInputService[prop]
		end)
		return ok and value == true
	end
	local touchEnabled = readInput("TouchEnabled")
	local mouseEnabled = readInput("MouseEnabled")
	local keyboardEnabled = readInput("KeyboardEnabled")
	-- 1) Plattform direkt abfragen (funktioniert auch im Emulator)
	local okPlat, platform = pcall(function()
		return userInputService:GetPlatform()
	end)
	if okPlat and platform then
		if platform == Enum.Platform.Android or platform == Enum.Platform.IOS then
			return true
		end
		if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX
			or platform == Enum.Platform.Linux or platform == Enum.Platform.UWP then
			-- Desktop: nur Mobile, wenn Touch ohne Maus
			return touchEnabled and not mouseEnabled
		end
	end
	-- 2) Fallback: Touch vorhanden und keine echte Tastatur
	if touchEnabled and not keyboardEnabled then
		return true
	end
	return touchEnabled and not mouseEnabled
end
library.DetectMobile = DetectMobile
-- Mobile-GUI (wird weiter unten vor CreateWindow gebaut; hier nur vorab bekannt gemacht,
-- damit ShowLoadingScreen es schon benutzen kann)
local MobileUI = nil
-- ============================================================
-- DIAGNOSE-LOG (standardmäßig nur auf Handys aktiv)
-- Schreibt mit, wie weit die Library gekommen ist, Fehler/Warnungen aus der Konsole und
-- alle 5 Sek. Speicher/FPS/Objektanzahl in "D3v1lHub Lib/debug_log.txt".
-- Stürzt Roblox ab, steht in der letzten Zeile, wobei es passiert ist. Beim nächsten
-- Ausführen wird das alte Log nach "debug_log_prev.txt" kopiert (= Log des Absturzes).
-- library.DebugLog = true -> auch am PC an; = false -> komplett aus.
-- ============================================================
local DebugLog = {
	Started = false,
	Lines = {},
	MaxLines = 400,
	Folder = "D3v1lHub Lib",
	File = "D3v1lHub Lib/debug_log.txt",
	PrevFile = "D3v1lHub Lib/debug_log_prev.txt",
	FlushQueued = false,
	LastError = nil,
	LastErrorCount = 0,
	ErrorLines = 0
}
library.__DebugLog = DebugLog
local debugLogMobileCache = nil
function DebugLog:IsEnabled()
	if library.DebugLog == false then
		return false
	end
	if library.DebugLog == true then
		return true
	end
	if debugLogMobileCache == nil then
		local ok, res = pcall(DetectMobile)
		debugLogMobileCache = (ok and res == true) and true or false
	end
	return debugLogMobileCache
end
function DebugLog:Flush()
	if not self.Started then
		return
	end
	pcall(function()
		writefile(self.File, table.concat(self.Lines, "\n") .. "\n")
	end)
end
function DebugLog:QueueFlush()
	-- Fehler können sehr schnell hintereinander kommen -> höchstens einmal pro Sekunde schreiben
	if self.FlushQueued then
		return
	end
	self.FlushQueued = true
	task.delay(1, function()
		self.FlushQueued = false
		self:Flush()
	end)
end
function DebugLog:Add(text)
	local stamp = string.format("[%7.2f] ", os.clock() - (self.StartClock or os.clock()))
	self.Lines[1 + #self.Lines] = stamp .. tostring(text)
	while #self.Lines > self.MaxLines do
		table.remove(self.Lines, 2) -- Zeile 1 (Kopf mit Gerät/Executor) bleibt immer erhalten
	end
end
function DebugLog:Start()
	if self.Started then
		return true
	end
	if not self:IsEnabled() then
		return false
	end
	if type(writefile) ~= "function" then
		return false
	end
	self.Started = true
	self.StartClock = os.clock()
	pcall(function()
		if isfolder and makefolder and not isfolder(self.Folder) then
			makefolder(self.Folder)
		end
	end)
	-- Log des letzten Durchlaufs (z.B. des Absturzes) sichern, bevor es überschrieben wird
	pcall(function()
		if isfile and readfile and isfile(self.File) then
			writefile(self.PrevFile, readfile(self.File))
		end
	end)
	local executorName = "?"
	pcall(function()
		if typeof(identifyexecutor) == "function" then
			executorName = table.concat({identifyexecutor()}, " ")
		end
	end)
	local platformName = "?"
	pcall(function()
		platformName = tostring(userInputService:GetPlatform())
	end)
	local viewport = "?"
	pcall(function()
		viewport = tostring(workspace.CurrentCamera.ViewportSize)
	end)
	local dateText = "?"
	pcall(function()
		dateText = os.date("%Y-%m-%d %H:%M:%S")
	end)
	self.Lines = {}
	self.Lines[1] = string.format("D3v1lHub Debug-Log | %s | Executor: %s | Plattform: %s | Mobile: %s | Viewport: %s", dateText, executorName, platformName, tostring(debugLogMobileCache), viewport)
	-- Fehler und Warnungen aus der Konsole mitschreiben (gleiche direkt hintereinander werden zusammengefasst)
	pcall(function()
		local logService = game:GetService("LogService")
		library.signals[1 + #library.signals] = logService.MessageOut:Connect(function(message, messageType)
			if messageType ~= Enum.MessageType.MessageError and messageType ~= Enum.MessageType.MessageWarning then
				return
			end
			local kind = (messageType == Enum.MessageType.MessageError) and "FEHLER" or "WARNUNG"
			local text = kind .. ": " .. string.sub(tostring(message), 1, 300)
			if text == self.LastError then
				self.LastErrorCount = self.LastErrorCount + 1
				self.Lines[#self.Lines] = string.format("[%7.2f] ", os.clock() - self.StartClock) .. text .. " (x" .. self.LastErrorCount .. ")"
			else
				if self.ErrorLines >= 150 then
					return -- nicht endlos Fehler sammeln
				end
				self.ErrorLines = self.ErrorLines + 1
				self.LastError, self.LastErrorCount = text, 1
				self:Add(text)
				-- die ersten Fehler sofort speichern: stürzt Roblox direkt danach ab, wären sie sonst weg
				if self.ErrorLines <= 30 then
					self:Flush()
					return
				end
			end
			self:QueueFlush()
		end)
	end)
	-- alle 5 Sekunden: Speicher, Lua-Speicher, FPS, Anzahl GUI-Objekte/Verbindungen
	task.spawn(function()
		local statsService = game:GetService("Stats")
		local renderStepped = game:GetService("RunService").RenderStepped
		while library.IsGuiValid and library.IsGuiValid() do
			task.wait(5)
			if not (library.IsGuiValid and library.IsGuiValid()) then
				break
			end
			local mem, lua, fps, objects, signals = "?", "?", "?", "?", "?"
			pcall(function()
				mem = string.format("%.0fMB", statsService:GetTotalMemoryUsageMb())
			end)
			pcall(function()
				lua = string.format("%.1fMB", gcinfo() / 1024)
			end)
			pcall(function()
				fps = tostring(math.floor(1 / renderStepped:Wait()))
			end)
			pcall(function()
				if library.MainScreenGui then
					objects = tostring(#library.MainScreenGui:GetDescendants())
				end
			end)
			pcall(function()
				signals = tostring(#library.signals)
			end)
			self.LastError = nil -- Statuszeile trennt Fehler-Gruppen
			self:Add(string.format("Status: Speicher %s | Lua %s | FPS %s | GUI-Objekte %s | Verbindungen %s", mem, lua, fps, objects, signals))
			self:Flush()
		end
	end)
	return true
end
-- Meilenstein eintragen und SOFORT speichern (damit nach einem Absturz klar ist, wie weit es kam)
function DebugLog:Mark(text)
	if not self.Started and not self:Start() then
		return
	end
	self.LastError = nil
	self:Add(">> " .. tostring(text))
	self:Flush()
end
library.DebugMark = function(text)
	pcall(DebugLog.Mark, DebugLog, text)
end
-- ============================================================
-- Loading-Screen / Execute-Prompt (Linoria-Style-Port vom Nutzer)
-- Zeigt zuerst ein Yes/No-Prompt, dann (bei Yes) einen Ladebildschirm
-- mit Avatar/HWID/Progressbar, und ruft danach options.OnAccept() auf,
-- damit genau an der Stelle ganz normal wie vorher weitergemacht wird
-- (z.B. library:CreateWindow(...) usw.), statt wie im Original ein
-- rbxassetid-fremdes loadstring(HttpGet(...))() nachzuladen.
-- Läuft komplett über protectAndParentGui/generateRandomName der Lib,
-- macht also KEINE eigenen, ungesicherten GUI-Parentings.
-- ============================================================
function library:ShowLoadingScreen(options)
	options = options or {}
	pcall(DebugLog.Mark, DebugLog, "Loader: Yes/No-Fenster wird angezeigt")
	local onAccept = options.OnAccept or options.Callback
	local onDecline = options.OnDecline
	local soundService = game:GetService("SoundService")
	-- Gleiche Transparenz wie das Hintergrundbild im Hauptmenü (Slider "Image Transparency",
	-- Standard 50%). Vorher 0.3 -> Bild zu hell, HWID-Text schlecht lesbar
	local backgroundTransparency = tonumber(options.BackgroundTransparency)
	if not backgroundTransparency then
		local menuValue = tonumber(library_flags["__Designer.Background.ImageTransparency"])
		backgroundTransparency = (menuValue and math.clamp(menuValue / 100, 0, 1)) or 0.5
	end
	-- Hintergrundbild (gleiches Bild wie im Menü). Eigenes Bild per BackgroundAsset = "rbxassetid://...",
	-- ausschalten per BackgroundAsset = false
	local backgroundAsset = options.BackgroundAsset
	if backgroundAsset == nil then
		backgroundAsset = "rbxassetid://133158046147209"
	elseif type(backgroundAsset) == "number" then
		backgroundAsset = "rbxassetid://" .. tostring(backgroundAsset)
	end
	local openSoundId = options.OpenSound or "91896029011112"
	local closeSoundId = options.CloseSound or "6698737249"
	local soundVolume = options.SoundVolume or 0.5
	local titlePart1 = options.TitlePart1 or "D3v1l"
	local titlePart2 = options.TitlePart2 or ("Hub | " .. LP.Name)
	local confirmText = options.ConfirmText or "Do you want to execute this script?"
	local loadingTitle = options.LoadingTitle or ("D3v1lHub | " .. LP.Name)
	local loadingSubText = options.LoadingSubText or "Loading scripts and assets..."
	local welcomeSubText = options.WelcomeSubText or "D3v1lHub successfully loaded."
	local showHWID = (options.ShowHWID ~= false)

	local MainColor = library.colors.main
	local TopGradColor = library.colors.topGradient
	local BottomGradColor = library.colors.bottomGradient

	local function playSound(soundId)
		pcall(function()
			local sound = Instance.new("Sound")
			sound.SoundId = (not string.find(soundId, "rbxassetid://") and ("rbxassetid://" .. soundId)) or soundId
			sound.Volume = soundVolume
			sound.Parent = soundService
			sound:Play()
			sound.Ended:Connect(function()
				sound:Destroy()
			end)
		end)
	end

	local function getHWID()
		local hwid = ""
		pcall(function()
			if typeof(gethwid) == "function" then
				hwid = gethwid()
			elseif typeof(syn) == "table" and syn.get_hwid then
				hwid = syn.get_hwid()
			else
				hwid = "Executor does not support getHWID"
			end
		end)
		return hwid
	end

	local function addTextStroke(textLabel, thickness)
		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Thickness = thickness or 1.5
		stroke.Parent = textLabel
	end

	local function applyBackground(parentFrame)
		if type(backgroundAsset) == "string" and backgroundAsset ~= "" then
			local BgAsset = Instance.new("ImageLabel")
			BgAsset.Name = generateRandomName()
			BgAsset.BackgroundTransparency = 1
			BgAsset.ImageTransparency = backgroundTransparency
			BgAsset.Image = backgroundAsset
			BgAsset.Size = UDim2.new(1, 0, 1, 0)
			BgAsset.ScaleType = Enum.ScaleType.Crop
			BgAsset.ZIndex = 302
			BgAsset.Parent = parentFrame
		end
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = generateRandomName()
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false
	if not protectAndParentGui(ScreenGui, library.gui_parent) then
		ScreenGui.Parent = library.gui_parent
	end

	local Outer = Instance.new("Frame")
	Outer.Name = generateRandomName()
	Outer.BackgroundColor3 = Color3.new(0, 0, 0)
	Outer.BorderColor3 = Color3.new(0, 0, 0)
	Outer.BorderSizePixel = 1
	Outer.AnchorPoint = Vector2.new(0.5, 0.5)
	Outer.Position = UDim2.new(0.5, 0, 0.5, 0)
	Outer.Size = UDim2.new(0, 0, 0, 0)
	Outer.BackgroundTransparency = 1
	Outer.ClipsDescendants = true
	Outer.ZIndex = 300
	Outer.Parent = ScreenGui

	local Inner = Instance.new("Frame")
	Inner.Name = generateRandomName()
	Inner.BackgroundColor3 = MainColor
	Inner.BorderColor3 = Color3.new(0, 0, 0)
	Inner.BorderSizePixel = 1
	Inner.BorderMode = Enum.BorderMode.Inset
	Inner.Size = UDim2.new(1, 0, 1, 0)
	Inner.ClipsDescendants = true
	Inner.ZIndex = 301
	Inner.Parent = Outer

	local InnerFrame = Instance.new("Frame")
	InnerFrame.Name = generateRandomName()
	InnerFrame.BackgroundColor3 = Color3.new(1, 1, 1)
	InnerFrame.BorderSizePixel = 0
	InnerFrame.Position = UDim2.new(0, 1, 0, 1)
	InnerFrame.Size = UDim2.new(1, -2, 1, -2)
	InnerFrame.ClipsDescendants = true
	InnerFrame.ZIndex = 302
	InnerFrame.Parent = Inner

	applyBackground(InnerFrame)

	local Gradient = Instance.new("UIGradient")
	Gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, TopGradColor),
		ColorSequenceKeypoint.new(1, BottomGradColor)
	})
	Gradient.Rotation = 90
	Gradient.Parent = InnerFrame

	local TitleContainer = Instance.new("Frame")
	TitleContainer.Name = generateRandomName()
	TitleContainer.BackgroundTransparency = 1
	TitleContainer.AnchorPoint = Vector2.new(0.5, 0)
	TitleContainer.Position = UDim2.new(0.5, 0, 0, 55)
	TitleContainer.Size = UDim2.new(0, 0, 0, 25)
	TitleContainer.ZIndex = 303
	TitleContainer.Parent = InnerFrame

	local TitleLayout = Instance.new("UIListLayout")
	TitleLayout.FillDirection = Enum.FillDirection.Horizontal
	TitleLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TitleLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TitleLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	TitleLayout.Parent = TitleContainer

	local TitlePart1Label = Instance.new("TextLabel")
	TitlePart1Label.Name = generateRandomName()
	TitlePart1Label.BackgroundTransparency = 1
	TitlePart1Label.Size = UDim2.new(0, 0, 1, 0)
	TitlePart1Label.AutomaticSize = Enum.AutomaticSize.X
	TitlePart1Label.Font = Enum.Font.Code
	TitlePart1Label.TextColor3 = Color3.new(1, 1, 1)
	TitlePart1Label.TextSize = 15
	TitlePart1Label.ZIndex = 303
	TitlePart1Label.Text = titlePart1
	TitlePart1Label.LayoutOrder = 1
	TitlePart1Label.Parent = TitleContainer
	addTextStroke(TitlePart1Label)

	local TitlePart2Label = Instance.new("TextLabel")
	TitlePart2Label.Name = generateRandomName()
	TitlePart2Label.BackgroundTransparency = 1
	TitlePart2Label.Size = UDim2.new(0, 0, 1, 0)
	TitlePart2Label.AutomaticSize = Enum.AutomaticSize.X
	TitlePart2Label.Font = Enum.Font.Code
	TitlePart2Label.TextColor3 = MainColor
	TitlePart2Label.TextSize = 15
	TitlePart2Label.ZIndex = 303
	TitlePart2Label.Text = titlePart2
	TitlePart2Label.LayoutOrder = 2
	TitlePart2Label.Parent = TitleContainer
	addTextStroke(TitlePart2Label)

	local SubLabel = Instance.new("TextLabel")
	SubLabel.Name = generateRandomName()
	SubLabel.BackgroundTransparency = 1
	SubLabel.Position = UDim2.new(0, 20, 0, 85)
	SubLabel.Size = UDim2.new(1, -40, 0, 25)
	SubLabel.Font = Enum.Font.Code
	SubLabel.TextColor3 = Color3.fromRGB(200, 190, 220)
	SubLabel.TextSize = 14
	SubLabel.TextXAlignment = Enum.TextXAlignment.Center
	SubLabel.ZIndex = 303
	SubLabel.Text = confirmText
	SubLabel.Parent = InnerFrame
	addTextStroke(SubLabel)

	local function createButton(text, posX)
		local btnOuter = Instance.new("TextButton")
		btnOuter.Name = generateRandomName()
		btnOuter.AutoButtonColor = false
		btnOuter.BackgroundColor3 = MainColor
		btnOuter.BorderColor3 = Color3.new(0, 0, 0)
		btnOuter.BorderSizePixel = 1
		btnOuter.BorderMode = Enum.BorderMode.Inset
		btnOuter.Position = UDim2.new(0, posX, 0, 265)
		btnOuter.Size = UDim2.new(0, 153, 0, 34)
		btnOuter.Text = ""
		btnOuter.ClipsDescendants = true
		btnOuter.ZIndex = 303
		btnOuter.Parent = InnerFrame

		local btnInner = Instance.new("Frame")
		btnInner.Name = generateRandomName()
		btnInner.BackgroundColor3 = library.colors.topGradient
		btnInner.BorderSizePixel = 0
		btnInner.Position = UDim2.new(0, 1, 0, 1)
		btnInner.Size = UDim2.new(1, -2, 1, -2)
		btnInner.ZIndex = 304
		btnInner.Parent = btnOuter

		local btnGrad = Instance.new("UIGradient")
		btnGrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, TopGradColor),
			ColorSequenceKeypoint.new(1, library.colors.bottomGradient)
		})
		btnGrad.Rotation = 90
		btnGrad.Parent = btnInner

		local btnText = Instance.new("TextLabel")
		btnText.Name = generateRandomName()
		btnText.BackgroundTransparency = 1
		btnText.Size = UDim2.new(1, 0, 1, 0)
		btnText.Font = Enum.Font.Code
		btnText.TextColor3 = Color3.fromRGB(200, 190, 220)
		btnText.TextSize = 14
		btnText.Text = text
		btnText.ZIndex = 305
		btnText.Parent = btnInner
		addTextStroke(btnText)

		return btnOuter
	end

	local YesBtn = createButton("Yes", 20)
	local NoBtn = createButton("No", 187)

	task.spawn(function()
		playSound(openSoundId)
		tweenService:Create(Outer, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 360, 0, 360)}):Play()
	end)

	local function startLoadingSequence()
		local closeTween = tweenService:Create(Outer, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
		closeTween:Play()
		closeTween.Completed:Wait()
		ScreenGui:Destroy()

		local LoadGui = Instance.new("ScreenGui")
		LoadGui.Name = generateRandomName()
		LoadGui.IgnoreGuiInset = true
		LoadGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		LoadGui.ResetOnSpawn = false
		if not protectAndParentGui(LoadGui, library.gui_parent) then
			LoadGui.Parent = library.gui_parent
		end

		local LoadOuter = Instance.new("Frame")
		LoadOuter.Name = generateRandomName()
		LoadOuter.BackgroundColor3 = Color3.new(0, 0, 0)
		LoadOuter.BorderColor3 = Color3.new(0, 0, 0)
		LoadOuter.BorderSizePixel = 1
		LoadOuter.AnchorPoint = Vector2.new(0.5, 0.5)
		LoadOuter.Position = UDim2.new(0.5, 0, 0.5, 0)
		LoadOuter.Size = UDim2.new(0, 0, 0, 0)
		LoadOuter.BackgroundTransparency = 1
		LoadOuter.ClipsDescendants = true
		LoadOuter.ZIndex = 300
		LoadOuter.Parent = LoadGui

		local LoadInner = Instance.new("Frame")
		LoadInner.Name = generateRandomName()
		LoadInner.BackgroundColor3 = MainColor
		LoadInner.BorderColor3 = Color3.new(0, 0, 0)
		LoadInner.BorderSizePixel = 1
		LoadInner.BorderMode = Enum.BorderMode.Inset
		LoadInner.Size = UDim2.new(1, 0, 1, 0)
		LoadInner.ClipsDescendants = true
		LoadInner.ZIndex = 301
		LoadInner.Parent = LoadOuter

		local LoadInnerFrame = Instance.new("Frame")
		LoadInnerFrame.Name = generateRandomName()
		LoadInnerFrame.BackgroundColor3 = Color3.new(1, 1, 1)
		LoadInnerFrame.BorderSizePixel = 0
		LoadInnerFrame.Position = UDim2.new(0, 1, 0, 1)
		LoadInnerFrame.Size = UDim2.new(1, -2, 1, -2)
		LoadInnerFrame.ClipsDescendants = true
		LoadInnerFrame.ZIndex = 302
		LoadInnerFrame.Parent = LoadInner

		local LoadGrad = Instance.new("UIGradient")
		LoadGrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, TopGradColor),
			ColorSequenceKeypoint.new(1, BottomGradColor)
		})
		LoadGrad.Rotation = 90
		LoadGrad.Parent = LoadInnerFrame
		applyBackground(LoadInnerFrame)

		local AvatarImage = Instance.new("ImageLabel")
		AvatarImage.Name = generateRandomName()
		AvatarImage.BackgroundTransparency = 1
		AvatarImage.ImageTransparency = 1
		AvatarImage.Position = UDim2.new(0, -50, 0, 15)
		AvatarImage.Size = UDim2.new(0, 48, 0, 48)
		AvatarImage.ZIndex = 303
		AvatarImage.Parent = LoadInnerFrame

		local LoadTitle = Instance.new("TextLabel")
		LoadTitle.Name = generateRandomName()
		LoadTitle.BackgroundTransparency = 1
		LoadTitle.Position = UDim2.new(0, 15, 0, 16)
		LoadTitle.Size = UDim2.new(1, -30, 0, 20)
		LoadTitle.Font = Enum.Font.Code
		LoadTitle.TextColor3 = MainColor
		LoadTitle.TextSize = 14
		LoadTitle.TextXAlignment = Enum.TextXAlignment.Left
		LoadTitle.ZIndex = 303
		LoadTitle.Text = loadingTitle
		LoadTitle.Parent = LoadInnerFrame
		addTextStroke(LoadTitle)

		local LoadSub = Instance.new("TextLabel")
		LoadSub.Name = generateRandomName()
		LoadSub.BackgroundTransparency = 1
		LoadSub.Position = UDim2.new(0, 15, 0, 42)
		LoadSub.Size = UDim2.new(1, -30, 0, 20)
		LoadSub.Font = Enum.Font.Code
		LoadSub.TextColor3 = Color3.fromRGB(200, 190, 220)
		LoadSub.TextSize = 13
		LoadSub.TextXAlignment = Enum.TextXAlignment.Left
		LoadSub.ZIndex = 303
		LoadSub.Text = loadingSubText
		LoadSub.Parent = LoadInnerFrame
		addTextStroke(LoadSub)

		local HwidContainer, HwidValueLabel
		if showHWID then
			local HwidStaticLabel = Instance.new("TextLabel")
			HwidStaticLabel.Name = generateRandomName()
			HwidStaticLabel.BackgroundTransparency = 1
			HwidStaticLabel.Position = UDim2.new(0, 75, 0, 64)
			HwidStaticLabel.Size = UDim2.new(0, 85, 0, 20)
			HwidStaticLabel.Font = Enum.Font.Code
			HwidStaticLabel.TextColor3 = Color3.fromRGB(150, 140, 170)
			HwidStaticLabel.TextSize = 12
			HwidStaticLabel.TextXAlignment = Enum.TextXAlignment.Left
			HwidStaticLabel.ZIndex = 303
			HwidStaticLabel.Text = "Your HWID: "
			HwidStaticLabel.Parent = LoadInnerFrame
			addTextStroke(HwidStaticLabel, 1) -- dünne schwarze Umrandung, damit der Text auf dem Bild lesbar bleibt

			HwidContainer = Instance.new("Frame")
			HwidContainer.Name = generateRandomName()
			HwidContainer.BackgroundTransparency = 1
			HwidContainer.Position = UDim2.new(0, 160, 0, 64)
			HwidContainer.Size = UDim2.new(1, -175, 0, 20)
			HwidContainer.ClipsDescendants = true
			HwidContainer.ZIndex = 303
			HwidContainer.Parent = LoadInnerFrame

			HwidValueLabel = Instance.new("TextLabel")
			HwidValueLabel.Name = generateRandomName()
			HwidValueLabel.BackgroundTransparency = 1
			HwidValueLabel.Size = UDim2.new(2, 0, 1, 0)
			HwidValueLabel.Font = Enum.Font.Code
			HwidValueLabel.TextColor3 = Color3.fromRGB(200, 180, 240)
			HwidValueLabel.TextSize = 12
			HwidValueLabel.TextXAlignment = Enum.TextXAlignment.Left
			HwidValueLabel.ZIndex = 303
			HwidValueLabel.Text = getHWID()
			HwidValueLabel.Parent = HwidContainer
			addTextStroke(HwidValueLabel, 1)

			local HwidNoteLabel = Instance.new("TextLabel")
			HwidNoteLabel.Name = generateRandomName()
			HwidNoteLabel.BackgroundTransparency = 1
			HwidNoteLabel.Position = UDim2.new(0, 75, 0, 82)
			HwidNoteLabel.Size = UDim2.new(1, -90, 0, 14)
			HwidNoteLabel.Font = Enum.Font.Code
			HwidNoteLabel.TextColor3 = Color3.fromRGB(110, 100, 130)
			HwidNoteLabel.TextSize = 9
			HwidNoteLabel.TextXAlignment = Enum.TextXAlignment.Left
			HwidNoteLabel.ZIndex = 303
			HwidNoteLabel.Text = "HWID is used to identify the Owner."
			HwidNoteLabel.Parent = LoadInnerFrame
			addTextStroke(HwidNoteLabel, 1)
		end

		local BarBg = Instance.new("Frame")
		BarBg.Name = generateRandomName()
		BarBg.BackgroundColor3 = Color3.fromRGB(10, 8, 15)
		BarBg.BorderColor3 = Color3.new(0, 0, 0)
		BarBg.BorderSizePixel = 1
		BarBg.BorderMode = Enum.BorderMode.Inset
		BarBg.Position = UDim2.new(0, 15, 0, 102)
		BarBg.Size = UDim2.new(1, -30, 0, 8)
		BarBg.ClipsDescendants = true
		BarBg.ZIndex = 303
		BarBg.Parent = LoadInnerFrame

		local BarFill = Instance.new("Frame")
		BarFill.Name = generateRandomName()
		BarFill.BackgroundColor3 = Color3.new(1, 1, 1)
		BarFill.BorderSizePixel = 0
		BarFill.Size = UDim2.new(0, 0, 1, 0)
		BarFill.ZIndex = 304
		BarFill.Parent = BarBg

		local BarGrad = Instance.new("UIGradient")
		BarGrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(210, 130, 255)),
			ColorSequenceKeypoint.new(1, MainColor)
		})
		BarGrad.Rotation = 90
		BarGrad.Parent = BarFill

		task.spawn(function()
			local openLoad = tweenService:Create(LoadOuter, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 380, 0, 138)})
			openLoad:Play()
			openLoad.Completed:Wait()

			local success, thumbUrl = pcall(function()
				return playersservice:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)

			local loadTween = tweenService:Create(BarFill, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(1, 0, 1, 0)})
			loadTween:Play()
			loadTween.Completed:Wait()

			if success and thumbUrl then
				AvatarImage.Image = thumbUrl
				tweenService:Create(AvatarImage, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 15, 0, 15), ImageTransparency = 0}):Play()
				tweenService:Create(LoadTitle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 75, 0, 14)}):Play()
				tweenService:Create(LoadSub, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 75, 0, 38)}):Play()
				tweenService:Create(BarBg, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 75, 0, 102), Size = UDim2.new(1, -90, 0, 8)}):Play()
			end

			LoadTitle.Text = "Welcome, " .. LP.Name .. "!"
			LoadSub.Text = welcomeSubText

			local barHideTween = tweenService:Create(BarBg, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -90, 0, 0)})
			barHideTween:Play()
			barHideTween.Completed:Wait()
			BarBg.Visible = false

			if showHWID and HwidValueLabel then
				task.wait(0.4)
				local scrollTween = tweenService:Create(HwidValueLabel, TweenInfo.new(2.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(-0.7, 0, 0, 0)})
				scrollTween:Play()
				scrollTween.Completed:Wait()
			end

			task.wait(1.2)

			playSound(closeSoundId)
			local closeLoad = tweenService:Create(LoadOuter, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
			closeLoad:Play()
			closeLoad.Completed:Wait()
			LoadGui:Destroy()

			-- ✅ Statt eines fremden loadstring(HttpGet(...))() geht's hier einfach ganz normal weiter,
			-- wie es vorher (ohne Loader) direkt der Fall war - z.B. CreateWindow(...) usw.
			pcall(DebugLog.Mark, DebugLog, "Loader fertig -> OnAccept (Menü wird aufgebaut)")
			if onAccept then
				task.spawn(onAccept)
			end
		end)
	end

	-- Nur EINE Entscheidung zählen: ein Doppeltipp (auf Handys sehr häufig) hat vorher alles
	-- zweimal gestartet -> zwei Fenster gleichzeitig -> Script abgestürzt.
	local promptDecided = false
	YesBtn.MouseButton1Click:Connect(function()
		if promptDecided then
			return
		end
		promptDecided = true
		pcall(DebugLog.Mark, DebugLog, "Loader: Yes gedrückt")
		startLoadingSequence()
	end)

	NoBtn.MouseButton1Click:Connect(function()
		if promptDecided then
			return
		end
		promptDecided = true
		pcall(DebugLog.Mark, DebugLog, "Loader: No gedrückt")
		playSound(closeSoundId)
		local closeTween = tweenService:Create(Outer, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
		closeTween:Play()
		closeTween.Completed:Wait()
		ScreenGui:Destroy()
		if onDecline then
			task.spawn(onDecline)
		end
	end)

	return ScreenGui
end
library.subs.ShowLoadingScreen = library.ShowLoadingScreen
local function removeSpaces(str)
	if str then
		local newStr = str:gsub(" ", "")
		return newStr
	end
end
library.subs.removeSpaces = removeSpaces
-- Gibt bei ungültigem Input nil zurück statt zu crashen (akzeptiert "A855F7", "#a855f7", "0xA855F7", "F0A")
local function Color3FromHex(hex)
	if typeof(hex) == "Color3" then
		return hex
	end
	if type(hex) ~= "string" then
		return nil
	end
	hex = (string.gsub(hex, "%s", ""))
	hex = (string.gsub(hex, "^#", ""))
	hex = (string.gsub(hex, "^0[xX]", ""))
	if #hex == 3 then
		hex = string.rep(string.sub(hex, 1, 1), 2) .. string.rep(string.sub(hex, 2, 2), 2) .. string.rep(string.sub(hex, 3, 3), 2)
	end
	if #hex ~= 6 or string.find(hex, "[^%x]") then
		return nil
	end
	return Color3.fromRGB(tonumber(string.sub(hex, 1, 2), 16), tonumber(string.sub(hex, 3, 4), 16), tonumber(string.sub(hex, 5, 6), 16))
end
library.subs.Color3FromHex = Color3FromHex
local floor = math.floor
-- Runden statt Abschneiden: vorher wurde z.B. 167.9999 zu 167 -> Farben wurden bei
-- jedem Save/Load-Durchlauf minimal dunkler
local function Color3ToHex(color)
	local function channel(v)
		if type(v) ~= "number" or v ~= v then
			return 0 -- NaN -> schwarz statt Fehler
		end
		return math.clamp(floor(v * 255 + 0.5), 0, 255)
	end
	return string.format("%02X%02X%02X", channel(color.R), channel(color.G), channel(color.B))
end
if Color3.ToHex and not shared.overridecolortohex then
	local x, e = pcall(Color3.ToHex, Color3.new())
	if x and type(e) == "string" and #e == 6 then
		Color3ToHex = Color3.ToHex
	end
end
library.subs.Color3ToHex = Color3ToHex
local isDraggingSomething = false
local function makeDraggable(topBarObject, object)
	local dragging = nil
	local dragInput = nil
	local dragStart = nil
	local startPosition = nil
	library.signals[1 + #library.signals] = topBarObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	library.signals[1 + #library.signals] = topBarObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	library.signals[1 + #library.signals] = userInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			if not isDraggingSomething and library.configuration.smoothDragging then
				tweenService:Create(object, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
					Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
				}):Play()
			elseif not isDraggingSomething and not library.configuration.smoothDragging then
				object.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
			end
		end
	end)
end
library.subs.makeDraggable = makeDraggable
local JSONEncode, JSONDecode = nil, nil
do
	local temp_http = game:FindService("HttpService") or game:GetService("HttpService")
	local httpservice = temp_http
	if cloneref and (type(cloneref) == "function") then
		httpservice, temp_http = cloneref(httpservice), nil
	end
	library.Http = httpservice
	local JSONEncodeFunc = httpservice.JSONEncode
	function JSONEncode(...)
		return pcall(JSONEncodeFunc, httpservice, ...)
	end
	library.JSONEncode = JSONEncode
	local JSONDecodeFunc = httpservice.JSONDecode
	function JSONDecode(...)
		return pcall(JSONDecodeFunc, httpservice, ...)
	end
	library.JSONDecode = JSONDecode
end
local convertfilename
do
	local string_gsub = string.gsub
	function convertfilename(str, default, replace)
		replace = replace or "_"
		local corrections = 0
		local predname = string_gsub(str, "%W", function(c)
			local byt = c:byte()
			-- byt >= 128 = Teil einer UTF-8-Mehrbyte-Sequenz (Umlaute wie ä/ö/ü/ß, Akzente usw.) -> unverändert durchlassen,
			-- sonst wurden einzelne Bytes dieser Buchstaben rausgefiltert/entfernt und der Config-Name kam beim Save/Load kaputt an
			if ((byt == 0) or (byt == 32) or (byt == 33) or (byt == 59) or (byt == 61) or ((byt >= 35) and (byt <= 41)) or ((byt >= 43) and (byt <= 57)) or ((byt >= 64) and (byt <= 123)) or ((byt >= 125) and (byt <= 127)) or (byt >= 128)) then
			else
				corrections = 1 + corrections
				return replace
			end
		end)
		return (default and corrections == #predname and tostring(default)) or predname
	end
	library.subs.ConvertFilename = convertfilename
end
-- ============================================================
-- CONFIG-SYSTEM HELPERS (gemeinsam für Save, Load, Delete, Liste, Copy Theme)
-- ============================================================
-- Ein einziger Namens-Filter für ALLES (Speichern, Laden, Löschen, Ordner).
-- Vorher hat Save alle Nicht-Buchstaben (Leerzeichen, _, -, Umlaute) gelöscht,
-- Load aber nicht -> "My Config" wurde als "MyConfig.txt" gespeichert und beim
-- Laden als "My Config.txt" gesucht -> nicht gefunden.
local sanitizeConfigName
do
	local reservedNames = {CON = true, PRN = true, AUX = true, NUL = true}
	for i = 1, 9 do
		reservedNames["COM" .. i] = true
		reservedNames["LPT" .. i] = true
	end
	function sanitizeConfigName(str)
		if type(str) == "number" then
			str = tostring(str)
		end
		if type(str) ~= "string" then
			return ""
		end
		str = (string.gsub(str, "%c", ""))
		str = (string.gsub(str, '[\\/:%*%?"<>|]', ""))
		str = (string.gsub(str, "^%s+", ""))
		str = (string.gsub(str, "[%s%.]+$", ""))
		if #str > 64 then
			local ok, cut = pcall(utf8.offset, str, 65)
			if ok and cut then
				str = string.sub(str, 1, cut - 1)
			elseif #str > 64 then
				str = string.sub(str, 1, 64)
			end
			str = (string.gsub(str, "[%s%.]+$", ""))
		end
		if reservedNames[string.upper(str)] then
			str = str .. "_"
		end
		return str
	end
	library.subs.SanitizeConfigName = sanitizeConfigName
end
-- Holt aus einem listfiles()-Eintrag nur den reinen Config-Namen, egal ob der
-- Executor "./Ordner/x.txt", "Ordner\x.txt" oder einen absoluten Pfad liefert.
-- Vorher wurde stur eine feste Zeichenanzahl abgeschnitten -> bei manchen
-- Executoren fehlten dadurch vorne Buchstaben im Config-Namen.
local function extractConfigName(path)
	if type(path) ~= "string" then
		return nil
	end
	local name = string.match(path, "([^/\\]+)$") or path
	return string.match(name, "^(.+)%.[Tt][Xx][Tt]$")
end
library.subs.ExtractConfigName = extractConfigName
-- Diese Flags werden nie in Configs/Themes gespeichert bzw. daraus geladen:
-- der Workspace-Name bestimmt den Ordner selbst - ein Theme/Config hätte sonst
-- beim Laden still den Ordner gewechselt und deine Configs "verschwanden".
local configIgnoredFlags = {
	["__Designer.Files.WorkspaceFile"] = true
}
library.subs.ConfigIgnoredFlags = configIgnoredFlags
-- Wandelt einen Flag-Wert in etwas JSON-taugliches um.
-- Gibt (true, wert) zurück, oder false, wenn der Wert nicht gespeichert werden soll.
local function serializeFlagValue(cflag, value, elementType)
	if value == nil then
		-- Keybinds auf NONE müssen mitgespeichert werden, sonst bleibt beim Laden die alte Taste drin
		if elementType == "Keybind" then
			return true, "NONE"
		end
		return false
	end
	local typ = typeof(value)
	if typ == "boolean" or typ == "string" then
		return true, value
	elseif typ == "number" then
		if value ~= value or value == math.huge or value == -math.huge then
			return false
		end
		return true, value
	elseif typ == "Color3" then
		return true, ((cflag and library.rainbowflags[cflag]) and "rainbow") or Color3ToHex(value)
	elseif typ == "EnumItem" then
		return true, tostring(value)
	elseif typ == "Instance" then
		return true, value.Name
	elseif typ == "table" then
		local arr = {}
		for _, v in ipairs(value) do
			local ok, sv = serializeFlagValue(nil, v)
			if ok and sv ~= nil and type(sv) ~= "table" then
				arr[1 + #arr] = sv
			end
		end
		return true, arr
	end
	local good, jval = JSONEncode(value)
	if good and jval and jval ~= "null" then
		return true, value
	end
	return true, tostring(value)
end
library.subs.SerializeFlagValue = serializeFlagValue
-- Wandelt einen geladenen JSON-Wert passend zum Element zurück.
-- Gibt (wert, true) zurück, oder (nil, false), wenn der Wert nicht passt.
local function deserializeFlagValue(val, data)
	if val == nil then
		return nil, false
	end
	if type(val) == "string" and #val > 7 and #val < 64 and string.sub(val, 1, 5) == "Enum." then
		local e = string.find(val, ".", 6, true)
		if e then
			local ok, en = pcall(function()
				local enumType = Enum[string.sub(val, 6, e - 1)]
				return enumType and enumType[string.sub(val, e + 1)]
			end)
			if ok and en then
				val = en
			else
				warn("[Config] Konnte '" .. val .. "' nicht in ein EnumItem umwandeln - wird übersprungen")
				return nil, false
			end
		end
	end
	local etype = data and data.Type
	local opts = (data and type(data.Options) == "table" and data.Options) or {}
	if etype == "Toggle" then
		if type(val) ~= "boolean" then
			if val == "true" or val == 1 then
				val = true
			elseif val == "false" or val == 0 then
				val = false
			else
				return nil, false
			end
		end
	elseif etype == "Slider" then
		if type(val) == "string" then
			val = tonumber(val)
		end
		if type(val) ~= "number" or val ~= val then
			return nil, false
		end
		-- Werte außerhalb von Min/Max (z.B. weil das Script die Grenzen geändert hat)
		-- wurden vorher stillschweigend ignoriert -> jetzt sauber auf den Bereich begrenzen
		if type(opts.Min) == "number" and type(opts.Max) == "number" and not opts.IllegalInput then
			val = math.clamp(val, math.min(opts.Min, opts.Max), math.max(opts.Min, opts.Max))
		end
	elseif etype == "Dropdown" or etype == "SearchBox" then
		local isMulti = opts.MultiSelect or opts.Multi or opts.Multiple
		if isMulti then
			if type(val) ~= "table" then
				val = {val}
			end
		elseif type(val) == "table" then
			val = val[1]
			if val == nil then
				return nil, false
			end
		end
	elseif etype == "Colorpicker" then
		if type(val) ~= "string" and typeof(val) ~= "Color3" then
			return nil, false
		end
	end
	return val, true
end
library.subs.DeserializeFlagValue = deserializeFlagValue
do
	do
		local function NewOption(TextStr, Order, Parent)
			local Option = Instance_new("Frame")
			local BBorder = Instance_new("Frame")
			local Inner_2 = Instance_new("Frame")
			local Border_2 = Instance_new("Frame")
			local Text = Instance_new("TextLabel")
			local Button = Instance_new("TextButton")
			Option.AnchorPoint = Vector2.new(0, 0.5)
			Option.BackgroundColor3 = library.colors.background
			colored[1 + #colored] = {Option, "BackgroundColor3", "background"}
			Option.BorderColor3 = Color3.fromRGB(27, 27, 27)
			Option.LayoutOrder = Order or #Parent:GetChildren()
			Option.Name = generateRandomName()
			Option.Position = UDim2.new(0, 5, 0.5, 0)
			Option.Size = UDim2.new(0, 35, 0, 25)
			BBorder.AnchorPoint = Vector2.new(0.5, 0.5)
			BBorder.BackgroundColor3 = library.colors.background
			colored[1 + #colored] = {BBorder, "BackgroundColor3", "background"}
			BBorder.BorderColor3 = Color3.fromRGB(50, 43, 50)
			BBorder.BorderMode = Enum.BorderMode.Inset
			BBorder.Name = generateRandomName()
			BBorder.Parent = Option
			BBorder.Position = UDim2.new(0.5, 0, 0.5, 0)
			BBorder.Size = UDim2.new(1, 0, 1, 0)
			Inner_2.AnchorPoint = Vector2.new(0.5, 0.5)
			Inner_2.BackgroundColor3 = library.colors.background
			colored[1 + #colored] = {Inner_2, "BackgroundColor3", "background"}
			Inner_2.BorderColor3 = Color3.fromRGB(27, 27, 27)
			Inner_2.Name = generateRandomName()
			Inner_2.Parent = Option
			Inner_2.Position = UDim2.new(0.5, 0, 0.5, 0)
			Inner_2.Size = UDim2.new(1, -6, 1, -6)
			Border_2.AnchorPoint = Vector2.new(0.5, 0.5)
			Border_2.BackgroundColor3 = library.colors.background
			colored[1 + #colored] = {Border_2, "BackgroundColor3", "background"}
			Border_2.BorderColor3 = Color3.fromRGB(50, 43, 50)
			Border_2.BorderMode = Enum.BorderMode.Inset
			Border_2.Name = generateRandomName()
			Border_2.Parent = Inner_2
			Border_2.Position = UDim2.new(0.5, 0, 0.5, 0)
			Border_2.Size = UDim2.new(1, 0, 1, 0)
			Text.AnchorPoint = Vector2.new(0.5, 0.5)
			Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Text.BackgroundTransparency = 1
			Text.Font = Enum.Font.Code
			Text.FontSize = Enum.FontSize.Size14
			Text.Name = generateRandomName()
			Text.Parent = Border_2
			Text.Position = UDim2.new(0.5, 0, 0.5, 0)
			Text.Size = UDim2.new(1, 0, 1, 0)
			Text.TextColor3 = library.colors.elementText
			colored[1 + #colored] = {Text, "TextColor3", "elementText"}
			Text.TextSize = 14
			Text.TextStrokeTransparency = 0.75
			Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button.BackgroundTransparency = 1
			Button.BorderSizePixel = 0
			Button.Font = Enum.Font.SourceSans
			Button.FontSize = Enum.FontSize.Size14
			Button.Name = generateRandomName()
			Button.Parent = Option
			Button.Size = UDim2.new(1, 0, 1, 0)
			Button.Text = ""
			Button.TextColor3 = Color3.fromRGB(0, 0, 0)
			Button.TextSize = 14
			Button.TextTransparency = 1
			Text.Text = TextStr
			local siz = textToSize(Text)
			Option.Size = UDim2.new(0, math.max(siz.X, 28) + 12, 0, 25)
			Option.Parent = Parent
			return Option, Button, Text
		end
		local function AddOption(OptionData, Key, OptionCount, Parent, Close, PromptEvent, KeepOpen)
			local Enabled = OptionData.Enabled
			if OptionData.Disabled then
				Enabled = false
			else
				Enabled = Enabled or (Enabled == nil)
			end
			local OptionText = OptionData.Text or OptionData.String or OptionData.Message or OptionData.Value or OptionData.Name or Key
			local Callback = OptionData.Callback or OptionData.OnPressed or OptionData.Function or nil
			local Order = tonumber(OptionData.Slot or OptionData.Order or OptionData.LayoutOrder or OptionData.Index or OptionCount)
			local OptionIns, OptionButton, OptionTxt = NewOption(tostring(OptionText), Order, Parent)
			local OptionObj = {
				Text = OptionText,
				Callback = Callback,
				ButtonObject = OptionIns,
				Pressed = OptionButton.MouseButton1Click,
				PressedRight = OptionButton.MouseButton2Click,
				Activated = OptionButton.Activated,
				TextButton = OptionButton,
				Order = Order,
				Enabled = Enabled
			}
			function OptionObj.Remove()
				do
					local Btn = OptionObj.ButtonObject
					if Btn then
						Btn:Destroy()
					end
				end
				for k in next, OptionObj do
					rawset(OptionObj, k, nil)
				end
				return true
			end
			local Proxy = nil
			local function Clicked(f)
				return function(...)
					if f then
						task.spawn(f, ...)
					end
					PromptEvent:Fire(Key, OptionButton.Text, ...)
					if KeepOpen then
					else
						Close()
					end
				end
			end
			function OptionObj.Press(...)
				OptionObj.Update()
				Proxy = Proxy or Clicked(Callback)
				Proxy(...)
			end
			function OptionObj.Lock()
				OptionObj.Enabled = false
				OptionObj.Update()
			end
			function OptionObj.Unlock()
				OptionObj.Enabled = true
				OptionObj.Update()
			end
			function OptionObj.SetLocked(self, state)
				if type(self) == "boolean" then
					state = self
				end
				OptionObj.Enabled = state
				OptionObj.Update()
			end
			function OptionObj.SetCondition(self, Condition)
				if type(self) ~= "table" then
					Condition = self
				end
				OptionObj.Condition = Condition
				OptionObj.Update()
			end
			function OptionObj.Update()
				do
					local OptionText = OptionObj.Text or OptionData.Text or OptionData.String or OptionData.Message or OptionData.Value or OptionData.Name or OptionButton.Text or Key
					OptionButton.Text = tostring(OptionText)
				end
				OptionIns.LayoutOrder = tonumber(OptionObj.Order or OptionData.Slot or OptionData.Order or OptionData.LayoutOrder or OptionData.Index or OptionIns.LayoutOrder or OptionCount)
				do
					local Enabled = OptionData.Enabled
					local Cond = OptionObj.Condition
					if Cond then
						local x, e = pcall(Cond, OptionObj)
						if x then
							Enabled = e and true
						else
							warn(debug.traceback(string.format("Error in prompt-option %s's Condition function: %s", OptionButton.Text, e), 2))
						end
					else
						if OptionData.Disabled then
							Enabled = false
						else
							Enabled = (Enabled and true) or (Enabled == nil)
						end
					end
					local Proxy = nil
					do
						local nCallback = (Enabled and (OptionData.Callback or OptionData.OnPressed or OptionData.Function)) or nil
						if not Proxy or Callback ~= nCallback then
							Callback = nCallback
							Proxy = Clicked(Callback)
							OptionObj.PressedConnection = (OptionObj.PressedConnection and OptionObj.PressedConnection:Disconnect() and nil) or (Callback and OptionObj.Pressed:Connect(Proxy)) or nil
						end
						local PC = OptionObj.PressedConnection
						if Enabled then
							if PC then
								if Callback then
								else
									OptionObj.PressedConnection = (PC:Disconnect() and nil) or nil
								end
							elseif Callback then
								Proxy = Proxy or Clicked(Callback)
								OptionObj.PressedConnection = OptionObj.Pressed:Connect(Proxy)
							end
						elseif PC then
							OptionObj.PressedConnection = (PC:Disconnect() and nil) or nil
						end
					end
					OptionObj.Enabled = Enabled
					OptionTxt.TextTransparency = (Enabled and 0) or 0.5
				end
				return OptionObj
			end
			OptionObj.Update()
			return OptionObj
		end
		local function SortByLayoutOrder(a, b)
			return a.Order < b.Order
		end
		local DefaultSelections = {
			Ok = true
		}
		function library.Prompt(self, PromptData, ...)
			if rawequal(self, library) then
			else
				PromptData, self = self, library
			end
			local PromptEvent = Instance_new("BindableEvent")
			local PromptObj = {
				OnSelect = PromptEvent.Event,
				Active = true,
				SelectedEvent = PromptEvent
			}
			local ChoicePopup = Instance_new("Frame")
			local Buttons = Instance_new("ScrollingFrame")
			local Title = Instance_new("TextLabel")
			local Description = Instance_new("TextLabel")
			local DoClose = PromptData.CloseButton
			DoClose = (DoClose == nil) or (DoClose == true) or DoClose or nil
			local Close = DoClose and Instance_new("ImageButton")
			do
				local Border = Instance_new("Frame")
				local Inner = Instance_new("Frame")
				local InnerBorder = Instance_new("Frame")
				local Bar = Instance_new("Frame")
				local Splitter = Instance_new("Frame")
				local ButtonBar = Instance_new("Frame")
				local UIListLayout = Instance_new("UIListLayout")
				ChoicePopup.AnchorPoint = Vector2.new(0.5, 0.5)
				ChoicePopup.BackgroundColor3 = library.colors.background
				colored[1 + #colored] = {ChoicePopup, "BackgroundColor3", "background"}
				ChoicePopup.BorderColor3 = library.colors.outerBorder
				colored[1 + #colored] = {ChoicePopup, "BorderColor3", "outerBorder"}
				ChoicePopup.Name = generateRandomName()
				ChoicePopup.Position = UDim2.new(0.5, 0, 0.5, 0)
				ChoicePopup.Size = UDim2.new(0, 325, 0, 100)
				Border.AnchorPoint = Vector2.new(0.5, 0.5)
				Border.BackgroundColor3 = library.colors.background
				colored[1 + #colored] = {Border, "BackgroundColor3", "background"}
				Border.BorderColor3 = library.colors.innerBorder
				colored[1 + #colored] = {Border, "BorderColor3", "innerBorder"}
				Border.BorderMode = Enum.BorderMode.Inset
				Border.Name = generateRandomName()
				Border.Parent = ChoicePopup
				Border.Position = UDim2.new(0.5, 0, 0.5, 0)
				Border.Size = UDim2.new(1, 0, 1, 0)
				Inner.AnchorPoint = Vector2.new(0.5, 0.5)
				Inner.BackgroundColor3 = library.colors.background
				colored[1 + #colored] = {Inner, "BackgroundColor3", "background"}
				Inner.BorderColor3 = library.colors.outerBorder
				colored[1 + #colored] = {Inner, "BorderColor3", "outerBorder"}
				Inner.Name = generateRandomName()
				Inner.Parent = ChoicePopup
				Inner.Position = UDim2.new(0.5, 0, 0.5, 0)
				Inner.Size = UDim2.new(1, -8, 1, -8)
				InnerBorder.AnchorPoint = Vector2.new(0.5, 0.5)
				InnerBorder.BackgroundColor3 = library.colors.background
				colored[1 + #colored] = {InnerBorder, "BackgroundColor3", "background"}
				InnerBorder.BorderColor3 = library.colors.innerBorder
				colored[1 + #colored] = {InnerBorder, "BorderColor3", "innerBorder"}
				InnerBorder.BorderMode = Enum.BorderMode.Inset
				InnerBorder.Name = generateRandomName()
				InnerBorder.Parent = Inner
				InnerBorder.Position = UDim2.new(0.5, 0, 0.5, 0)
				InnerBorder.Size = UDim2.new(1, 0, 1, 0)
				Bar.BackgroundColor3 = library.colors.main
				colored[1 + #colored] = {Bar, "BackgroundColor3", "main"}
				Bar.BorderSizePixel = 0
				Bar.Name = generateRandomName()
				Bar.Parent = InnerBorder
				Bar.Size = UDim2.new(1, 0, 0, 3)
				Splitter.AnchorPoint = Vector2.new(0, 1)
				Splitter.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
				Splitter.BorderSizePixel = 0
				Splitter.Name = generateRandomName()
				Splitter.Parent = InnerBorder
				Splitter.Position = UDim2.new(0, 0, 1, -35)
				Splitter.Size = UDim2.new(1, 0, 0, 1)
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1
				Title.Font = Enum.Font.Code
				Title.FontSize = Enum.FontSize.Size18
				Title.Parent = InnerBorder
				Title.Position = UDim2.new(0, 6, 0, 4)
				Title.Size = UDim2.new(0, 300, 0, 25)
				Title.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {Title, "TextColor3", "elementText"}
				Title.TextSize = 15
				Title.TextStrokeTransparency = 0.50
				Title.TextXAlignment = Enum.TextXAlignment.Left
				Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Description.BackgroundTransparency = 1
				Description.Font = Enum.Font.Code
				Description.FontSize = Enum.FontSize.Size14
				Description.Name = generateRandomName()
				Description.Parent = InnerBorder
				Description.Position = UDim2.new(0, 6, 0, 25)
				Description.Size = UDim2.new(0, 300, 0, 25)
				Description.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {Description, "TextColor3", "elementText"}
				Description.TextSize = 14
				Description.TextStrokeTransparency = 0.50
				Description.TextTruncate = Enum.TextTruncate.AtEnd
				Description.TextWrap = true
				Description.TextWrapped = true
				Description.TextXAlignment = Enum.TextXAlignment.Left
				if Close then
					Close.AnchorPoint = Vector2.new(1)
					Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Close.BackgroundTransparency = 1
					Close.Image = "http://www.roblox.com/asset/?id=9064270627"
					Close.ImageColor3 = library.colors.section
					colored[1 + #colored] = {Close, "ImageColor3", "section"}
					Close.Name = generateRandomName()
					Close.Parent = InnerBorder
					Close.Position = UDim2.new(1, -9, 0, 11)
					Close.ScaleType = Enum.ScaleType.Fit
					Close.Size = UDim2.new(0, 10, 0, 10)
				end
				ButtonBar.AnchorPoint = Vector2.new(0, 1)
				ButtonBar.BackgroundColor3 = library.colors.sectionBackground
				colored[1 + #colored] = {ButtonBar, "BackgroundColor3", "sectionBackground"}
				ButtonBar.BorderSizePixel = 0
				ButtonBar.Name = generateRandomName()
				ButtonBar.Parent = InnerBorder
				ButtonBar.Position = UDim2.new(0, 0, 1, 0)
				ButtonBar.Size = UDim2.new(1, 0, 0, 35)
				Buttons.AutomaticCanvasSize = Enum.AutomaticSize.X
				Buttons.BackgroundColor3 = library.colors.sectionBackground
				colored[1 + #colored] = {Buttons, "BackgroundColor3", "sectionBackground"}
				Buttons.BorderColor3 = library.colors.background
				colored[1 + #colored] = {Buttons, "BorderColor3", "background"}
				Buttons.BorderSizePixel = 0
				Buttons.BottomImage = ""
				Buttons.CanvasSize = UDim2.new(0, 0, 0, 0)
				Buttons.MidImage = ""
				Buttons.Name = generateRandomName()
				Buttons.Parent = ButtonBar
				Buttons.Position = UDim2.new(0, 6, 0, 0)
				Buttons.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
				Buttons.ScrollBarImageTransparency = 1
				Buttons.ScrollBarThickness = 0
				Buttons.ScrollingDirection = Enum.ScrollingDirection.X
				Buttons.Selectable = false
				Buttons.Size = UDim2.new(1, -12, 1, 0)
				Buttons.TopImage = ""
				UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout.Padding = UDim.new(0, 10)
				UIListLayout.Parent = Buttons
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			end
			PromptObj.FrameInstance = ChoicePopup
			PromptObj.Closed = ChoicePopup.Destroying
			local function ClosePrompt(method)
				PromptObj.Active = (ChoicePopup and ChoicePopup:Destroy() and nil) or (PromptEvent:Fire("Close", method and (method == "timeout_")) and nil) or nil
			end
			PromptObj.Close = ClosePrompt
			if Close then
				Close.MouseButton1Click:Connect(((DoClose ~= true) and DoClose) or ClosePrompt)
			end
			do
				local NameTxt = PromptData.Name
				Title.Text = ((NameTxt ~= nil) and tostring(NameTxt)) or "Untitled Prompt"
			end
			do
				local DescriptionTxt = PromptData.Description
				if DescriptionTxt == nil then
					DescriptionTxt = PromptData.Text
					if DescriptionTxt == nil then
						DescriptionTxt = PromptData.String
						if DescriptionTxt == nil then
							DescriptionTxt = PromptData.Message
							if DescriptionTxt == nil then
								DescriptionTxt = PromptData.Value
							end
						end
					end
				end
				Description.Text = ((DescriptionTxt ~= nil) and tostring(DescriptionTxt)) or ""
			end
			do
				local Selections = PromptData.Options or PromptData.Buttons or PromptData.Choices
				if Selections then
					if type(Selections) ~= "table" then
						Selections = {
							OK = Selections
						}
					end
				else
					Selections = DefaultSelections
				end
				local OptionCount = 0
				local ButtonsProxy = {}
				PromptObj.Buttons = ButtonsProxy
				function PromptObj.ReOrder(self, SortFunc)
					if self ~= ButtonsProxy then
						SortFunc, self = self, nil
					end
					if SortFunc and (type(SortFunc) ~= "function") then
						SortFunc = SortByLayoutOrder
					end
					local BtnOrder = {}
					for _, Data in next, ButtonsProxy do
						BtnOrder[1 + #BtnOrder] = Data
					end
					table.sort(BtnOrder, SortFunc or SortByLayoutOrder)
					for Order, Data in next, BtnOrder do
						Data.Order = Order or Data.Order
						local UpdateFunc = Data.Update
						if UpdateFunc then
							spawn(UpdateFunc)
						else
							local Frame = Data.ButtonObject
							if Frame then
								Frame.LayoutOrder = Order
							end
						end
					end
					return ButtonsProxy
				end
				function PromptObj.PressAll(self, ...)
					local isSelf = nil
					if self and rawequal(self, PromptObj) then
						isSelf = true
					end
					for _, Data in next, ButtonsProxy do
						local f = Data.Callback
						if f then
							if isSelf then
								f(...)
							else
								f(self, ...)
							end
						end
					end
				end
				local KeepOpen = PromptData.KeepOpen
				for Key, OptionData in next, Selections do
					OptionCount += 1
					do
						local typ = OptionData and type(OptionData)
						if typ ~= "table" then
							OptionData = {
								Name = ((typ == "string") and (type(Key) == "number") and OptionData) or Key,
								Callback = ((typ == "function") and OptionData) or ClosePrompt
							}
						end
					end
					ButtonsProxy[Key] = AddOption(OptionData, Key, OptionCount, Buttons, ClosePrompt, PromptEvent, KeepOpen)
				end
			end
			do
				local to = PromptData.Timeout
				to = to and tonumber(to)
				if to then
					task.delay(to, ClosePrompt, "timeout_")
				end
			end
			ChoicePopup.Parent = MainScreenGui
			makeDraggable(ChoicePopup, ChoicePopup)
			return PromptObj, ChoicePopup
		end
	end
	do
		local Popups = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		library.NotifyLayout = UIListLayout
		Popups.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Popups.BackgroundTransparency = 1
		Popups.Name = generateRandomName()
		Popups.Position = UDim2.new(0, 10, 0, 10)
		Popups.Size = UDim2.new(1, -20, 1, -20)
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.Padding = UDim.new(0, 5)
		UIListLayout.Parent = Popups
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
		Popups.Parent = MainScreenGui
		library.NotificationsFrame = Popups
		local Inverse = true
		local os_clock = os.clock
		local Notifications = {}
		library.Notifications = Notifications
		local function fadeInstances(List, Target, Duration)
			for _, Entry in ipairs(List) do
				tweenService:Create(Entry[1], TweenInfo.new(Duration, library.configuration.easingStyle, library.configuration.easingDirection), {
					[Entry[2]] = Target
				}):Play()
			end
		end
		spawn(function()
			local v1, vtop, htop = Enum.FillDirection.Vertical, Enum.VerticalAlignment.Top, Enum.HorizontalAlignment.Center
			while wait_check() do
				local Len = #Notifications
				while wait_check() and (Len <= 0) do
					Len = #Notifications
					if wait_check(0.25) then
					else
						return
					end
				end
				Inverse = ((UIListLayout.FillDirection == v1) and (UIListLayout.VerticalAlignment ~= vtop)) or (UIListLayout.HorizontalAlignment ~= htop)
				local BreathingRoom, now = 10, os_clock()
				local Order = 0
				for Index = Len, 1, -1 do
					BreathingRoom -= 1
					if BreathingRoom <= 0 then
						if wait_check() then
							BreathingRoom, now = 10, os_clock()
						else
							return
						end
					end
					local Noti = Notifications[Index]
					local Obj = Noti and Noti.Object
					if Obj and Noti.Active and (now < Noti.Expires) then
						if Noti.TextLabel.Text ~= Noti.Text then
							Noti:SetText(Noti.Text)
						end
						if Noti.CountdownLabel then
							local Remaining = math.max(Noti.Expires - now, 0)
							Noti.CountdownLabel.Text = string.format("%.1fs", Remaining)
						end
						if Obj.Visible then
							Order += 1
							Obj.LayoutOrder = Order * ((Inverse and 1) or -1)
						end
						continue
					end
					table.remove(Notifications, Index)
					if Noti.Object then
						-- ✅ Beim automatischen Ablaufen ebenfalls smooth raustweenen statt hart zerstören (+ Fade-Out)
						local ObjToKill = Noti.Object
						local FadeList = Noti.FadeParts
						Noti.Object = nil
						Noti.Active = false
						if Noti.ProgressTween then
							pcall(function()
								Noti.ProgressTween:Pause()
							end)
						end
						task.spawn(function()
							pcall(function()
								task.wait()
								tweenService:Create(ObjToKill, TweenInfo.new(0.3, library.configuration.easingStyle, library.configuration.easingDirection), {
									Size = UDim2.new(0, 0, 0, 35)
								}):Play()
								if FadeList then
									fadeInstances(FadeList, 1, 0.3)
								end
								task.wait(0.3)
							end)
							if ObjToKill then
								ObjToKill:Destroy()
							end
						end)
					else
						Noti.Destroy()
					end
				end
			end
		end)
		local sharedNotifySound = nil
		function library.Notify(self, NotificationData, ...)
			if rawequal(self, library) then
			else
				NotificationData, self = self, library
			end
			local now = os_clock()
			local dur = NotificationData.Time or 6
			local TextStr = NotificationData.Text or NotificationData.String or NotificationData.Value or NotificationData.Message or NotificationData.Msg
			TextStr = ((TextStr == nil) and "No text given") or tostring(TextStr)
			local NotificationObj = {
				InitTime = now,
				Active = true,
				Duration = dur,
				Expires = now + dur,
				Text = TextStr,
				Arguments = NotificationData
			}
			local Notification = Instance.new("Frame")
			NotificationObj.Object = Notification
			local Border = Instance.new("Frame")
			local Inner = Instance.new("Frame")
			local Border_2 = Instance.new("Frame")
			local Text = Instance.new("TextLabel")
			NotificationObj.TextLabel = Text
			local Bar = Instance.new("Frame")
			local ProgressBar = Instance.new("Frame")
			local NotificationStroke, BorderStroke, InnerStroke, Border_2Stroke
			local NotiType = NotificationData.Type
			local NotiColor = ((NotiType == "success") and Color3.fromRGB(80, 200, 120)) or ((NotiType == "error") and Color3.fromRGB(220, 80, 80)) or nil
			Notification.AnchorPoint = Vector2.new(1, 0)
			Notification.BackgroundColor3 = library.colors.background
			colored[1 + #colored] = {Notification, "BackgroundColor3", "background"}
			Notification.BorderSizePixel = 0
			Notification.BackgroundTransparency = 1
			Notification.Name = generateRandomName()
			Notification.Position = UDim2.new(1, -10, 0, 10)
			Notification.Size = UDim2.new(0, 5e4, 0, 35)
			addCorner(Notification, 6)
			do
				NotificationStroke = Instance.new("UIStroke")
				NotificationStroke.Name = generateRandomName()
				NotificationStroke.Parent = Notification
				NotificationStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				NotificationStroke.Thickness = 1
				NotificationStroke.Transparency = 1
				NotificationStroke.Color = library.colors.outerBorder
				colored[1 + #colored] = {NotificationStroke, "Color", "outerBorder"}
			end
			Border.AnchorPoint = Vector2.new(0.5, 0.5)
			Border.BackgroundColor3 = library.colors.background
			colored[1 + #colored] = {Border, "BackgroundColor3", "background"}
			Border.BorderSizePixel = 0
			Border.BackgroundTransparency = 1
			Border.Name = generateRandomName()
			Border.Parent = Notification
			Border.Position = UDim2.new(0.5, 0, 0.5, 0)
			Border.Size = UDim2.new(1, 0, 1, 0)
			addCorner(Border, 6)
			do
				BorderStroke = Instance.new("UIStroke")
				BorderStroke.Name = generateRandomName()
				BorderStroke.Parent = Border
				BorderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				BorderStroke.Thickness = 1
				BorderStroke.Transparency = 1
				BorderStroke.Color = library.colors.innerBorder
				colored[1 + #colored] = {BorderStroke, "Color", "innerBorder"}
			end
			Inner.AnchorPoint = Vector2.one / 2
			Inner.BackgroundColor3 = library.colors.background
			colored[1 + #colored] = {Inner, "BackgroundColor3", "background"}
			Inner.BorderSizePixel = 0
			Inner.BackgroundTransparency = 1
			Inner.ClipsDescendants = true
			Inner.Name = generateRandomName()
			Inner.Parent = Notification
			Inner.Position = UDim2.new(0.5, 0, 0.5, 0)
			Inner.Size = UDim2.new(1, -8, 1, -8)
			addCorner(Inner, 5)
			do
				InnerStroke = Instance.new("UIStroke")
				InnerStroke.Name = generateRandomName()
				InnerStroke.Parent = Inner
				InnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				InnerStroke.Thickness = 1
				InnerStroke.Transparency = 1
				InnerStroke.Color = library.colors.outerBorder
				colored[1 + #colored] = {InnerStroke, "Color", "outerBorder"}
			end
			Border_2.AnchorPoint = Vector2.one / 2
			Border_2.BackgroundColor3 = library.colors.background
			colored[1 + #colored] = {Border_2, "BackgroundColor3", "background"}
			Border_2.BorderSizePixel = 0
			Border_2.BackgroundTransparency = 1
			Border_2.ClipsDescendants = true
			Border_2.Name = generateRandomName()
			Border_2.Parent = Inner
			Border_2.Position = UDim2.new(0.5, 0, 0.5, 0)
			Border_2.Size = UDim2.new(1, 0, 1, 0)
			addCorner(Border_2, 5)
			do
				Border_2Stroke = Instance.new("UIStroke")
				Border_2Stroke.Name = generateRandomName()
				Border_2Stroke.Parent = Border_2
				Border_2Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				Border_2Stroke.Thickness = 1
				Border_2Stroke.Transparency = 1
				Border_2Stroke.Color = library.colors.innerBorder
				colored[1 + #colored] = {Border_2Stroke, "Color", "innerBorder"}
			end
			Text.AnchorPoint = Vector2.new(0, 0.5)
			Text.BackgroundTransparency = 1
			Text.Font = Enum.Font.Code
			Text.FontSize = Enum.FontSize.Size14
			Text.Name = generateRandomName()
			Text.Parent = Border_2
			Text.Position = UDim2.new(0, 8, 0, 11)
			Text.Size = UDim2.new(1, -8, 1, -13)
			Text.Text = TextStr
			Text.TextColor3 = library.colors.elementText
			colored[1 + #colored] = {Text, "TextColor3", "elementText"}
			Text.TextScaled = true
			Text.TextSize = 14
			Text.TextStrokeTransparency = 0.75
			Text.TextTransparency = 1
			Text.TextWrap = true
			Text.TextWrapped = true
			Text.TextXAlignment = Enum.TextXAlignment.Left
			Bar.BackgroundColor3 = NotiColor or library.colors.main
			if NotiColor then
			else
				colored[1 + #colored] = {Bar, "BackgroundColor3", "main"}
			end
			Bar.BackgroundTransparency = 1
			Bar.BorderSizePixel = 0
			Bar.Name = generateRandomName()
			Bar.Parent = Border_2
			Bar.Size = UDim2.new(0, 3, 1, 0)
			ProgressBar.AnchorPoint = Vector2.new(0, 1)
			ProgressBar.BackgroundColor3 = NotiColor or library.colors.main
			if NotiColor then
			else
				colored[1 + #colored] = {ProgressBar, "BackgroundColor3", "main"}
			end
			ProgressBar.BackgroundTransparency = 1
			ProgressBar.BorderSizePixel = 0
			ProgressBar.Name = generateRandomName()
			ProgressBar.Parent = Border_2
			ProgressBar.Position = UDim2.new(0, 2, 1, 0)
			ProgressBar.Size = UDim2.new(1, -4, 0, 2)
			addCorner(ProgressBar, 1)
			local CountdownLabel = Instance.new("TextLabel")
			NotificationObj.CountdownLabel = CountdownLabel
			CountdownLabel.AnchorPoint = Vector2.new(1, 1)
			CountdownLabel.BackgroundTransparency = 1
			CountdownLabel.Font = Enum.Font.Code
			CountdownLabel.FontSize = Enum.FontSize.Size8
			CountdownLabel.Name = generateRandomName()
			CountdownLabel.Parent = Border_2
			CountdownLabel.Position = UDim2.new(1, -5, 1, -3)
			CountdownLabel.Size = UDim2.new(0, 30, 0, 10)
			CountdownLabel.Text = string.format("%.1fs", dur)
			CountdownLabel.TextColor3 = library.colors.otherElementText
			colored[1 + #colored] = {CountdownLabel, "TextColor3", "otherElementText"}
			CountdownLabel.TextScaled = true
			CountdownLabel.TextSize = 8
			CountdownLabel.TextTransparency = 1
			CountdownLabel.TextXAlignment = Enum.TextXAlignment.Right
			CountdownLabel.TextYAlignment = Enum.TextYAlignment.Bottom
			local FadeParts = {
				{Notification, "BackgroundTransparency"},
				{Border, "BackgroundTransparency"},
				{Inner, "BackgroundTransparency"},
				{Border_2, "BackgroundTransparency"},
				{Text, "TextTransparency"},
				{Bar, "BackgroundTransparency"},
				{ProgressBar, "BackgroundTransparency"},
				{CountdownLabel, "TextTransparency"},
				{NotificationStroke, "Transparency"},
				{BorderStroke, "Transparency"},
				{InnerStroke, "Transparency"},
				{Border_2Stroke, "Transparency"}
			}
			NotificationObj.FadeParts = FadeParts
			if NotificationData.Sound ~= false then
				task.spawn(function()
					pcall(function()
						if not sharedNotifySound then
							sharedNotifySound = Instance.new("Sound")
							sharedNotifySound.SoundId = "rbxassetid://105884435662737"
							sharedNotifySound.Volume = 0.5
							sharedNotifySound.Parent = game:GetService("SoundService")
						end
						sharedNotifySound:Stop()
						sharedNotifySound.TimePosition = 0
						sharedNotifySound:Play()
					end)
				end)
			end
			local targetWidth = 44 + textToSize(Text).X
			Notification.Size = UDim2.new(0, 0, 0, 35)
			Notification.Parent = Popups
			Notification.LayoutOrder = #Notification.Parent:GetChildren() * ((Inverse and 1) or -1)
			if Popups.Parent then
			else
				Popups.Parent = MainScreenGui
			end
			-- ✅ Smoothes Rein-Tweenen (Breite wächst von 0 auf Zielgröße + Fade-In)
			-- Ein Frame warten bevor die Eingangs-Animation startet: sonst kann Roblox bei
			-- mehreren Notifies die kurz hintereinander/gleichzeitig erstellt werden die
			-- Start-Werte schon "fertig" rendern bevor der Tween greift -> dadurch poppen
			-- mittlere Notifies in einem Stapel ohne sichtbare Animation auf, während nur
			-- die erste/letzte sauber faden. Mit dem Wait bekommt JEDE Notify garantiert
			-- ihr eigenes Fade-In.
			local progressTween = tweenService:Create(ProgressBar, TweenInfo.new(dur, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				Size = UDim2.new(0, 0, 0, 2)
			})
			NotificationObj.ProgressTween = progressTween
			task.spawn(function()
				task.wait()
				if (not Notification) or (not Notification.Parent) then
					return
				end
				tweenService:Create(Notification, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
					Size = UDim2.new(0, targetWidth, 0, 35)
				}):Play()
				fadeInstances(FadeParts, 0, 0.35)
				progressTween:Play()
			end)
			NotificationObj.InputBegan = Notification.InputBegan
			NotificationObj.Destroying = Notification.Destroying
			NotificationObj.MouseEnter = Notification.MouseEnter
			NotificationObj.MouseLeave = Notification.MouseLeave
			function NotificationObj.SetText(self, Str)
				if rawequal(self, NotificationObj) then
				else
					Str = self
				end
				Str = ((Str == nil) and "No text given") or tostring(Str)
				Text.Text, NotificationObj.Text = Str, Str
				tweenService:Create(Notification, TweenInfo.new(0.3, library.configuration.easingStyle, library.configuration.easingDirection), {
					Size = UDim2.new(0, 24 + Text.TextBounds.X, 0, 35)
				}):Play()
				return Str, Text
			end
			function NotificationObj.Hide(self)
				if Notification and NotificationObj.Active then
					Notification.Visible = false
				end
			end
			function NotificationObj.Show(self)
				if Notification and NotificationObj.Active then
					Notification.Visible = true
				end
			end
			function NotificationObj.SetVisible(self, Visible)
				if Notification and NotificationObj.Active then
					if rawequal(self, NotificationObj) then
					else
						Visible = self
					end
					if Visible == nil then
						Notification.Visible = not Notification.Visible
					else
						Notification.Visible = (Visible and true) or false
					end
				end
			end
			local function Destroy()
				if Notification and Notification.Parent then
					NotificationObj.Active = false
					local ObjToKill = Notification
					NotificationObj.Object = nil
					if progressTween then
						pcall(function()
							progressTween:Pause()
						end)
					end
					-- ✅ Smoothes Raus-Tweenen statt hartem Destroy (+ Fade-Out)
					task.spawn(function()
						pcall(function()
							task.wait()
							tweenService:Create(ObjToKill, TweenInfo.new(0.3, library.configuration.easingStyle, library.configuration.easingDirection), {
								Size = UDim2.new(0, 0, 0, 35)
							}):Play()
							fadeInstances(FadeParts, 1, 0.3)
							task.wait(0.3)
						end)
						if ObjToKill then
							ObjToKill:Destroy()
						end
					end)
				else
					NotificationObj.Active = false
					NotificationObj.Object = nil
				end
			end
			NotificationObj.Destroy = Destroy
			Notifications[1 + #Notifications] = NotificationObj
			return NotificationObj, Notification, Text
		end
	end
end
-- ============================================================
-- MOBILE-GUI (eigenes, leichtes GUI nur für Handys/Tablets)
-- Auf Handys wird NICHT das PC-Menü gebaut, sondern dieses hier: gleiche Funktionen
-- (CreateWindow/CreateTab/CreateSection/AddToggle/AddSlider/...), gleiche Flags,
-- gleiche Configs - aber nur ein Bruchteil der Objekte (keine Verläufe, keine
-- Hintergrundbilder, keine Rahmen pro Element, keine Tooltips/Watermark/Keystrokes).
-- Das PC-Menü und der PC-Loader bleiben komplett unverändert.
-- Erzwingen: library.MobileMode = true/false oder CreateWindow({ Mobile = true/false }).
-- ============================================================
MobileUI = {}
library.MobileUI = MobileUI
do
	local FONT_MEDIUM = Enum.Font.GothamMedium
	local FONT_BOLD = Enum.Font.GothamBold
	local ROW_H = 34

	local function C(name)
		return library.colors[name]
	end
	local function colorHex(c)
		return string.format("#%02X%02X%02X", math.clamp(math.floor(c.R * 255 + 0.5), 0, 255), math.clamp(math.floor(c.G * 255 + 0.5), 0, 255), math.clamp(math.floor(c.B * 255 + 0.5), 0, 255))
	end
	-- Erstellt ein Objekt (über Instance_new -> wird beim Unload automatisch zerstört)
	local function new(className, props, parent)
		local obj = Instance_new(className)
		obj.Name = generateRandomName()
		if props then
			for k, v in next, props do
				obj[k] = v
			end
		end
		if parent then
			obj.Parent = parent
		end
		return obj
	end
	local function corner(parent, radius)
		return new("UICorner", {CornerRadius = (radius == "full" and UDim.new(1, 0)) or UDim.new(0, radius or 6)}, parent)
	end
	local function label(parent, props)
		props = props or {}
		props.BackgroundTransparency = 1
		props.BorderSizePixel = 0
		props.Font = props.Font or FONT_MEDIUM
		props.TextSize = props.TextSize or 13
		props.TextColor3 = props.TextColor3 or C("elementText")
		props.TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Left
		if props.TextTruncate == nil and not props.TextWrapped then
			props.TextTruncate = Enum.TextTruncate.AtEnd
		end
		return new("TextLabel", props, parent)
	end
	local function button(parent, props)
		props = props or {}
		props.AutoButtonColor = false
		props.BorderSizePixel = 0
		props.Font = props.Font or FONT_MEDIUM
		props.TextSize = props.TextSize or 13
		props.TextColor3 = props.TextColor3 or C("elementText")
		if props.Text == nil then
			props.Text = ""
		end
		return new("TextButton", props, parent)
	end
	-- obj:Set(v) und obj.Set(v) beide erlauben (wie im PC-Menü)
	local function pickArg(obj, a, b)
		if b == nil and a ~= obj then
			return a
		end
		return b
	end
	local function isPress(input)
		return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
	end
	local function unnamed(counterKey, prefix)
		library[counterKey] = 1 + (library[counterKey] or 0)
		return prefix .. tostring(library[counterKey])
	end
	local function warnReused(flag)
		if elements[flag] ~= nil then
			warn(debug.traceback("Warning! Re-used flag '" .. tostring(flag) .. "'", 3))
		end
	end
	local function fireCallback(fn, ...)
		if type(fn) == "function" then
			task.spawn(fn, ...)
		end
	end

	-- Ziehen auf einem Balken (Slider, Farbregler): Maus und Finger. Bei Touch erst nach
	-- eindeutiger waagerechter Bewegung schieben (senkrecht = Scrollen), Antippen setzt den Wert.
	local function attachBarDrag(hitArea, onPosition)
		local active, startPos, decided, isTouch = nil, nil, false, false
		local function finish(input)
			if not active then
				return
			end
			local wasTouch, wasDecided, cur = isTouch, decided, active
			active, startPos, decided, isTouch = nil, nil, false, false
			if wasTouch and not wasDecided and input == cur then
				onPosition(input.Position.X)
			end
		end
		library.signals[1 + #library.signals] = hitArea.InputBegan:Connect(function(input)
			if not isPress(input) then
				return
			end
			if active then
				local st = active.UserInputState
				if st ~= Enum.UserInputState.End and st ~= Enum.UserInputState.Cancel then
					return
				end
			end
			active = input
			isTouch = input.UserInputType == Enum.UserInputType.Touch
			startPos = Vector2.new(input.Position.X, input.Position.Y)
			decided = false
			if not isTouch then
				decided = true
				onPosition(input.Position.X)
			end
		end)
		library.signals[1 + #library.signals] = userInputService.InputChanged:Connect(function(input)
			if not active then
				return
			end
			if isTouch then
				if input ~= active then
					return
				end
				if not decided then
					local dx = math.abs(input.Position.X - startPos.X)
					local dy = math.abs(input.Position.Y - startPos.Y)
					if dx >= 6 and dx >= dy then
						decided = true
					elseif dy >= 10 then
						-- senkrecht gewischt -> war ein Scroll-Versuch, nichts ändern
						active, startPos, decided, isTouch = nil, nil, false, false
						return
					else
						return
					end
				end
				onPosition(input.Position.X)
			elseif input.UserInputType == Enum.UserInputType.MouseMovement then
				onPosition(input.Position.X)
			end
		end)
		library.signals[1 + #library.signals] = userInputService.InputEnded:Connect(function(input)
			if active and (input == active or (not isTouch and input.UserInputType == Enum.UserInputType.MouseButton1)) then
				finish(input)
			end
		end)
	end
	local function ratioOnBar(bar, x)
		local w = bar.AbsoluteSize.X
		if not (w > 0) then
			return nil
		end
		local r = (x - bar.AbsolutePosition.X) / w
		if r ~= r then
			return nil
		end
		return math.clamp(r, 0, 1)
	end

	-- ---------------- Config-Dateien (gleiches Format/gleicher Ordner wie am PC) ----------------
	local hasFiles = (type(writefile) == "function") and (type(readfile) == "function")
	local function workspaceFolder()
		local folderName = sanitizeConfigName(tostring(library.WorkspaceName or ""))
		if #folderName == 0 then
			folderName = "Unnamed Workspace"
		end
		return "D3v1lHub Lib/" .. folderName
	end
	local function ensureFolder()
		pcall(function()
			if isfolder and makefolder then
				if not isfolder("D3v1lHub Lib") then
					makefolder("D3v1lHub Lib")
				end
				local folder = workspaceFolder()
				if not isfolder(folder) then
					makefolder(folder)
				end
			end
		end)
	end
	local function listConfigs()
		local names, seen = {}, {}
		if not (hasFiles and type(listfiles) == "function") then
			return names
		end
		local folder = workspaceFolder()
		if isfolder then
			local okf, exists = pcall(isfolder, folder)
			if not (okf and exists) then
				return names
			end
		end
		local okl, files = pcall(listfiles, folder)
		if okl and type(files) == "table" then
			for _, f in next, files do
				local n = extractConfigName(f)
				if n and #n > 0 and not seen[n] then
					seen[n] = true
					names[1 + #names] = n
				end
			end
		end
		table.sort(names, function(a, b)
			return string.lower(a) < string.lower(b)
		end)
		return names
	end
	local function persistable(cflag, data)
		return data and type(cflag) == "string" and data.Type ~= "Persistence" and data.Type ~= "Button" and data.Type ~= "Label" and not configIgnoredFlags[cflag] and string.sub(cflag, 1, 11) ~= "__Designer." and string.sub(cflag, 1, 9) ~= "__Mobile."
	end
	local function saveConfig(name)
		name = sanitizeConfigName(name or "")
		if #name == 0 then
			return false, "Invalid name"
		end
		if not hasFiles then
			return false, "Executor cannot save files"
		end
		local saving = {}
		for cflag, data in next, elements do
			if persistable(cflag, data) then
				local ok, sv = serializeFlagValue(cflag, library_flags[cflag], data.Type)
				if ok and sv ~= nil then
					saving[cflag] = sv
				end
			end
		end
		saving.__meta = {savedAt = os.time(), version = 1}
		local good, content = JSONEncode(saving)
		if not (good and content) then
			return false, "Encode error"
		end
		ensureFolder()
		local okw = pcall(writefile, workspaceFolder() .. "/" .. name .. ".txt", content)
		return okw, (okw and name) or "Write error"
	end
	local function loadConfig(name)
		name = sanitizeConfigName(name or "")
		if #name == 0 or not hasFiles then
			return false, "Invalid name"
		end
		local path = workspaceFolder() .. "/" .. name .. ".txt"
		if isfile then
			local okf, exists = pcall(isfile, path)
			if not (okf and exists) then
				return false, "Not found"
			end
		end
		local okr, content = pcall(readfile, path)
		if not okr or type(content) ~= "string" or #content < 2 then
			return false, "Not found"
		end
		local good, data = JSONDecode(content)
		if not (good and type(data) == "table") then
			return false, "Broken file"
		end
		local applied = 0
		for cflag, val in next, data do
			local element = (type(cflag) == "string") and elements[cflag]
			if element and persistable(cflag, element) then
				local converted, usable = deserializeFlagValue(val, element)
				if usable and converted ~= nil then
					local ok = pcall(function()
						if element.Set then
							element:Set(converted)
						else
							library_flags[cflag] = converted
						end
					end)
					if ok then
						applied = applied + 1
					end
				end
			end
		end
		return true, applied
	end
	local function deleteConfig(name)
		name = sanitizeConfigName(name or "")
		if #name == 0 or type(delfile) ~= "function" then
			return false
		end
		return (pcall(delfile, workspaceFolder() .. "/" .. name .. ".txt"))
	end
	local function readAutoload()
		if not hasFiles then
			return nil
		end
		local path = workspaceFolder() .. "/__autoload.json"
		if isfile then
			local okf, exists = pcall(isfile, path)
			if not (okf and exists) then
				return nil
			end
		end
		local okr, content = pcall(readfile, path)
		if not okr or type(content) ~= "string" then
			return nil
		end
		local good, data = JSONDecode(content)
		if good and type(data) == "table" and type(data.name) == "string" then
			local n = sanitizeConfigName(data.name)
			if #n > 0 then
				return n
			end
		end
		return nil
	end
	local function writeAutoload(name)
		if not hasFiles then
			return false
		end
		ensureFolder()
		local good, content = JSONEncode({name = name})
		if not (good and content) then
			return false
		end
		return (pcall(writefile, workspaceFolder() .. "/__autoload.json", content))
	end
	MobileUI.SaveConfig, MobileUI.LoadConfig, MobileUI.DeleteConfig, MobileUI.ListConfigs = saveConfig, loadConfig, deleteConfig, listConfigs

	local function notify(text, kind)
		pcall(function()
			library:Notify({Text = text, Time = 3, Type = kind})
		end)
	end

	-- ============================================================
	-- MOBILE-FENSTER
	-- ============================================================
	function MobileUI.CreateWindow(options)
		options = options or {}
		local windowName = options.Name or "Unnamed Window"
		options.Name = windowName
		pcall(DebugLog.Mark, DebugLog, "Mobile-GUI: CreateWindow startet")
		if windowName and #windowName > 0 and library.WorkspaceName == "D3v1lHub Lib" then
			library.WorkspaceName = convertfilename(windowName, "D3v1lHub Lib")
		end
		-- Anti-Double-Loading (wie am PC): alte Instanz sauber entfernen
		if typeof(getgenv) == "function" then
			local genv = getgenv()
			if genv.D3v1lHub_ActiveTerminate then
				pcall(genv.D3v1lHub_ActiveTerminate)
				genv.D3v1lHub_ActiveTerminate = nil
			end
		end
		library.IsMobile = true

		local gui = Instance_new("ScreenGui")
		gui.Name = generateRandomName()
		gui.ResetOnSpawn = false
		gui.DisplayOrder = 10
		gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		if not protectAndParentGui(gui, library.gui_parent) then
			pcall(function()
				gui.Parent = library.gui_parent
			end)
		end
		-- Notify & Co. benutzen dieses GUI
		library.MainScreenGui, MainScreenGui = gui, gui

		local main = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(480, 300), BackgroundColor3 = C("background"), BorderSizePixel = 0, Active = true}, gui)
		corner(main, 10)
		new("UIStroke", {Color = C("main"), Thickness = 1, Transparency = 0.25, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, main)
		library.MobileMain = main

		-- Titelleiste (zum Verschieben) mit Ausblenden-Knopf
		local topBar = new("Frame", {Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = C("sectionBackground"), BorderSizePixel = 0, Active = true}, main)
		corner(topBar, 10)
		new("Frame", {Position = UDim2.new(0, 0, 1, -10), Size = UDim2.new(1, 0, 0, 10), BackgroundColor3 = C("sectionBackground"), BorderSizePixel = 0}, topBar)
		local titleText = tostring(windowName)
		if string.sub(titleText, -3) == "Hub" and #titleText > 3 then
			titleText = string.sub(titleText, 1, -4) .. '<font color="' .. colorHex(C("main")) .. '">Hub</font>'
		end
		label(topBar, {Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -60, 1, 0), Font = FONT_BOLD, TextSize = 15, RichText = true, Text = titleText})
		local hideButton = button(topBar, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0), Size = UDim2.fromOffset(30, 26), BackgroundColor3 = C("topGradient"), Text = "–", Font = FONT_BOLD, TextSize = 16})
		corner(hideButton, 6)

		-- Inhalt: links Tabs, rechts die Seite des gewählten Tabs
		local body = new("Frame", {Position = UDim2.fromOffset(0, 36), Size = UDim2.new(1, 0, 1, -36), BackgroundTransparency = 1}, main)
		local tabList = new("ScrollingFrame", {Position = UDim2.fromOffset(6, 6), Size = UDim2.new(0, 104, 1, -12), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y}, body)
		new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, tabList)
		new("Frame", {Position = UDim2.fromOffset(115, 8), Size = UDim2.new(0, 1, 1, -16), BackgroundColor3 = C("innerBorder"), BorderSizePixel = 0}, body)
		local pages = new("Frame", {Position = UDim2.fromOffset(122, 6), Size = UDim2.new(1, -128, 1, -12), BackgroundTransparency = 1, ClipsDescendants = true}, body)

		-- Overlay für Dropdown-Listen und Farbwahl (EINS für alles, Inhalt nur solange offen)
		local overlay = button(main, {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.35, Visible = false, ZIndex = 50})
		corner(overlay, 10)
		local overlayPanel = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -40, 1, -30), BackgroundColor3 = C("sectionBackground"), BorderSizePixel = 0, Active = true, ZIndex = 51}, overlay)
		corner(overlayPanel, 8)
		new("UIStroke", {Color = C("main"), Thickness = 1, Transparency = 0.3, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, overlayPanel)
		local overlayContent = nil
		local overlayOnClose = nil
		local function closeOverlay()
			local cb = overlayOnClose
			overlayOnClose = nil
			if overlayContent then
				pcall(function()
					overlayContent:Destroy()
				end)
				overlayContent = nil
			end
			overlay.Visible = false
			if cb then
				pcall(cb)
			end
		end
		local function openOverlay(onClose)
			closeOverlay()
			overlayContent = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 52}, overlayPanel)
			overlayOnClose = onClose
			overlay.Visible = true
			return overlayContent
		end
		-- Tipp neben das Panel schließt es
		overlay.Activated:Connect(closeOverlay)
		library.signals[1 + #library.signals] = main:GetPropertyChangedSignal("Visible"):Connect(function()
			if not main.Visible then
				closeOverlay()
			end
		end)

		-- Fenster an das Display anpassen
		local function fitToScreen()
			local cam = workspace.CurrentCamera
			local vp = cam and cam.ViewportSize
			if not vp or vp.X < 50 or vp.Y < 50 then
				return
			end
			local inset = Vector2.new(0, 0)
			pcall(function()
				inset = game:GetService("GuiService"):GetGuiInset()
			end)
			local availW = vp.X - 24
			local availH = vp.Y - inset.Y - 24
			local w = math.min(math.clamp(math.floor(vp.X * 0.62), 340, 640), availW)
			local h = math.min(math.clamp(math.floor(availH * 0.9), 200, 420), availH)
			main.Size = UDim2.fromOffset(math.max(w, 200), math.max(h, 150))
			main.Position = UDim2.fromScale(0.5, 0.5)
		end
		fitToScreen()
		do
			local lastViewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize
			local queued = false
			local function queueFit()
				if queued then
					return
				end
				queued = true
				task.delay(0.25, function()
					queued = false
					local cam = workspace.CurrentCamera
					local vp = cam and cam.ViewportSize
					if not vp or not main.Parent then
						return
					end
					if lastViewport and math.abs(vp.X - lastViewport.X) < 4 and math.abs(vp.Y - lastViewport.Y) < 4 then
						return
					end
					lastViewport = vp
					pcall(fitToScreen)
				end)
			end
			local viewportConnection = nil
			local function hookCamera()
				if viewportConnection then
					viewportConnection:Disconnect()
					viewportConnection = nil
				end
				local cam = workspace.CurrentCamera
				if cam then
					viewportConnection = cam:GetPropertyChangedSignal("ViewportSize"):Connect(queueFit)
					library.signals[1 + #library.signals] = viewportConnection
				end
			end
			pcall(hookCamera)
			pcall(function()
				library.signals[1 + #library.signals] = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
					pcall(hookCamera)
					queueFit()
				end)
			end)
		end

		-- Fenster an der Titelleiste verschieben (Finger oder Maus)
		do
			local dragInput, dragStart, startPos = nil, nil, nil
			library.signals[1 + #library.signals] = topBar.InputBegan:Connect(function(input)
				if isPress(input) and not dragInput then
					dragInput, dragStart, startPos = input, input.Position, main.Position
				end
			end)
			library.signals[1 + #library.signals] = userInputService.InputChanged:Connect(function(input)
				if not dragInput then
					return
				end
				local same = (input == dragInput) or (dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement)
				if same then
					local delta = input.Position - dragStart
					main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end
			end)
			library.signals[1 + #library.signals] = userInputService.InputEnded:Connect(function(input)
				if dragInput and (input == dragInput or (dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseButton1)) then
					dragInput = nil
				end
			end)
		end

		-- Runder, verschiebbarer Knopf mit Decal: Tippen = Menü ein/aus
		local toggleGui = Instance_new("ScreenGui")
		toggleGui.Name = generateRandomName()
		toggleGui.ResetOnSpawn = false
		toggleGui.DisplayOrder = 11
		toggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		if not protectAndParentGui(toggleGui, library.gui_parent) then
			pcall(function()
				toggleGui.Parent = library.gui_parent
			end)
		end
		library.__MobileToggleGui = toggleGui
		do
			local buttonImage = options.MobileButtonImage or options.MobileButtonDecal or "rbxassetid://133158046147209"
			if type(buttonImage) == "number" then
				buttonImage = "rbxassetid://" .. tostring(buttonImage)
			end
			local buttonSize = tonumber(options.MobileButtonSize) or 54
			local toggleButton = new("ImageButton", {AutoButtonColor = false, BackgroundColor3 = C("background"), BorderSizePixel = 0, Image = buttonImage, ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromOffset(buttonSize, buttonSize), Position = UDim2.new(0, 16, 0.3, 0), ZIndex = 10}, toggleGui)
			corner(toggleButton, "full")
			new("UIStroke", {ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2, Color = C("main")}, toggleButton)
			library.MobileToggleButton = toggleButton
			local dragInput, dragStart, buttonStart, moved = nil, nil, nil, false
			library.signals[1 + #library.signals] = toggleButton.InputBegan:Connect(function(input)
				if dragInput then
					local st = dragInput.UserInputState
					if st ~= Enum.UserInputState.End and st ~= Enum.UserInputState.Cancel then
						return
					end
					dragInput = nil
				end
				if isPress(input) then
					dragInput, dragStart, buttonStart, moved = input, input.Position, toggleButton.AbsolutePosition, false
					toggleButton.ImageTransparency = 0.25
				end
			end)
			library.signals[1 + #library.signals] = userInputService.InputChanged:Connect(function(input)
				if not dragInput then
					return
				end
				local same = (input == dragInput) or (dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement)
				if not same then
					return
				end
				local delta = input.Position - dragStart
				if not moved and (math.abs(delta.X) > 8 or math.abs(delta.Y) > 8) then
					moved = true
				end
				if moved then
					local area = toggleGui.AbsoluteSize
					local size = toggleButton.AbsoluteSize
					local x = math.clamp(buttonStart.X + delta.X - toggleGui.AbsolutePosition.X, 0, math.max(0, area.X - size.X))
					local y = math.clamp(buttonStart.Y + delta.Y - toggleGui.AbsolutePosition.Y, 0, math.max(0, area.Y - size.Y))
					toggleButton.Position = UDim2.fromOffset(x, y)
				end
			end)
			library.signals[1 + #library.signals] = userInputService.InputEnded:Connect(function(input)
				if not dragInput then
					return
				end
				local same = (input == dragInput) or (dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseButton1)
				if not same then
					return
				end
				dragInput = nil
				toggleButton.ImageTransparency = 0
				if not moved then
					main.Visible = not main.Visible
				end
			end)
		end
		hideButton.Activated:Connect(function()
			main.Visible = false
		end)

		-- Unload (wird auch vom erneuten Ausführen des Scripts benutzt)
		local terminated = false
		local function terminateGui()
			if terminated then
				return
			end
			terminated = true
			pcall(closeOverlay)
			pcall(function()
				toggleGui:Destroy()
			end)
			library.__MobileToggleGui = nil
			pcall(function()
				gui:Destroy()
			end)
			library.MainScreenGui, MainScreenGui = nil, nil
			pcall(library.unload)
		end
		if typeof(getgenv) == "function" then
			getgenv().D3v1lHub_ActiveTerminate = terminateGui
		end

		local windowFunctions = {
			tabCount = 0,
			selected = {},
			Flags = elements,
			IsMobile = true,
			Mobile = true
		}
		windowFunctions.Terminate = terminateGui
		windowFunctions.Unload = terminateGui
		function windowFunctions:Show(x)
			main.Visible = (x == nil) or (x == true) or (x == 1)
			return main.Visible
		end
		function windowFunctions:Hide(x)
			main.Visible = (x == false) or (x == 0)
			return main.Visible
		end
		function windowFunctions:Visibility(x)
			if x == nil then
				main.Visible = not main.Visible
			else
				main.Visible = x and true
			end
			return main.Visible
		end
		-- Größe richtet sich auf Handys immer nach dem Display
		function windowFunctions:SetSize()
			fitToScreen()
			return main.Size.X.Offset, main.Size.Y.Offset
		end
		function windowFunctions:GetSize()
			return main.Size.X.Offset, main.Size.Y.Offset
		end
		function windowFunctions:ResetSize()
			fitToScreen()
		end
		function windowFunctions:MoveTabSlider()
		end
		function windowFunctions:UpdateAll()
			for _, element in next, elements do
				if type(element) == "table" and element.Update then
					pcall(element.Update)
				end
			end
		end
		library.UpdateAll = windowFunctions.UpdateAll

		local tabs = {}
		local selectedTab = nil
		local function selectTab(tab)
			if selectedTab == tab then
				return
			end
			closeOverlay()
			for _, t in ipairs(tabs) do
				local active = (t == tab)
				t.Page.Visible = active
				t.Button.BackgroundColor3 = active and darkenColor(C("main"), 2.2) or C("topGradient")
				t.Button.TextColor3 = active and C("elementText") or C("tabText")
				t.Accent.Visible = active
			end
			selectedTab = tab
			windowFunctions.LastTab = tab.Functions
		end

		function windowFunctions:CreateTab(tabOptions, ...)
			tabOptions = (tabOptions and type(tabOptions) == "string" and resolvevararg("Tab", tabOptions, ...)) or tabOptions or {Name = "Tab"}
			local tabName = tabOptions.Name or "Unnamed Tab"
			tabOptions.Name = tabName
			pcall(DebugLog.Mark, DebugLog, "Mobile-Tab: " .. tostring(tabName))
			windowFunctions.tabCount = windowFunctions.tabCount + 1
			local order = tabOptions.LastTab and 100000 or windowFunctions.tabCount
			local tabButton = button(tabList, {Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = C("topGradient"), Text = tostring(tabName), TextColor3 = C("tabText"), TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = order})
			corner(tabButton, 6)
			local accent = new("Frame", {Position = UDim2.fromOffset(0, 7), Size = UDim2.new(0, 3, 1, -14), BackgroundColor3 = C("main"), BorderSizePixel = 0, Visible = false}, tabButton)
			corner(accent, "full")
			local page = new("ScrollingFrame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false, ScrollBarThickness = 4, ScrollBarImageColor3 = C("main"), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y}, pages)
			new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, page)
			new("UIPadding", {PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8)}, page)

			local sectionCount = 0
			local tabFunctions = {Flags = {}, Name = tabName}
			local tabEntry = {Button = tabButton, Accent = accent, Page = page, Functions = tabFunctions}
			tabs[1 + #tabs] = tabEntry
			tabButton.Activated:Connect(function()
				selectTab(tabEntry)
			end)
			function tabFunctions:Select()
				selectTab(tabEntry)
			end
			tabFunctions.Remove = function()
				tabButton.Parent = nil
				page.Parent = nil
			end
			if not selectedTab then
				selectTab(tabEntry)
			end

			function tabFunctions:CreateSection(sectionOptions, ...)
				sectionOptions = (sectionOptions and type(sectionOptions) == "string" and resolvevararg("Tab", sectionOptions, ...)) or sectionOptions or {}
				local sectionName = sectionOptions.Name or "Unnamed Section"
				sectionOptions.Name = sectionName
				pcall(DebugLog.Mark, DebugLog, "Mobile-Section: " .. tostring(sectionName))
				sectionCount = sectionCount + 1
				local sectionFrame = new("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = C("sectionBackground"), BorderSizePixel = 0, LayoutOrder = sectionCount}, page)
				corner(sectionFrame, 8)
				new("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, sectionFrame)
				new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, sectionFrame)
				label(sectionFrame, {Size = UDim2.new(1, 0, 0, 18), Font = FONT_BOLD, TextSize = 14, TextColor3 = C("section"), Text = tostring(sectionName), LayoutOrder = 0})
				-- Elemente liegen in einem eigenen Halter (ohne Überschrift) -> Suche/DependsOn
				-- können leere Sections korrekt ausblenden
				local holder = new("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 1}, sectionFrame)
				new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, holder)
				local elementCount = 0
				local function nextOrder()
					elementCount = elementCount + 1
					return elementCount
				end
				local sectionFunctions = {Flags = {}, Name = sectionName}
				function sectionFunctions:Update()
					if not sectionFrame.Visible then
						sectionFrame.Visible = true
					end
				end
				function sectionFunctions:UpdateAll()
					for _, element in next, sectionFunctions.Flags do
						if type(element) == "table" and element.Update then
							pcall(element.Update)
						end
					end
				end
				sectionFunctions.Remove = function()
					sectionFrame.Parent = nil
				end
				library.__AllSections = library.__AllSections or {}
				library.__AllSections[1 + #library.__AllSections] = {Frame = sectionFrame, Holder = holder, Functions = sectionFunctions}

				local function register(flag, element)
					tabFunctions.Flags[flag], sectionFunctions.Flags[flag], elements[flag] = element, element, element
				end
				local function makeRow(height)
					local row = new("Frame", {Size = UDim2.new(1, 0, 0, height or ROW_H), BackgroundColor3 = C("topGradient"), BorderSizePixel = 0, LayoutOrder = nextOrder()}, holder)
					corner(row, 6)
					return row
				end
				local function removeRow(row)
					return function()
						if row then
							row.Parent = nil
						end
					end
				end
				-- Gemeinsames Sperren/Entsperren (Disabled/Locked)
				local function addLocking(element, getLocked, setLocked)
					element.SetLocked = function(t, state)
						if type(t) ~= "table" then
							state = t
						end
						if state == nil then
							setLocked(not getLocked())
						else
							setLocked(state and true or false)
						end
						return getLocked()
					end
					element.Lock = function()
						setLocked(true)
						return true
					end
					element.Unlock = function()
						setLocked(false)
						return false
					end
					element.SetDisabled = element.SetLocked
					element.Disable = element.Lock
					element.Enable = element.Unlock
				end

				-- ---------------- Toggle ----------------
				function sectionFunctions:AddToggle(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Tab", o, ...)) or o
					local name = assert(o.Name, "Missing Name for new toggle.")
					local flag = o.Flag or unnamed("unnamedtoggles", "Toggle")
					warnReused(flag)
					local locked = (o.Locked or o.Disabled) and true or false
					local row = makeRow()
					local hit = button(row, {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 2})
					local nameLabel = label(row, {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -66, 1, 0), Text = tostring(name)})
					local track = new("Frame", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(40, 20), BackgroundColor3 = C("innerBorder"), BorderSizePixel = 0}, row)
					corner(track, "full")
					local knob = new("Frame", {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 2, 0.5, 0), Size = UDim2.fromOffset(16, 16), BackgroundColor3 = C("elementText"), BorderSizePixel = 0}, track)
					corner(knob, "full")
					local element
					local function render(animate)
						local on = library_flags[flag] and true or false
						local info = TweenInfo.new(animate and 0.15 or 0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						tweenService:Create(knob, info, {Position = on and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}):Play()
						track.BackgroundColor3 = on and C("main") or C("innerBorder")
						nameLabel.Text = tostring(o.Name or name)
						nameLabel.TextTransparency = locked and 0.55 or 0
						track.BackgroundTransparency = locked and 0.5 or 0
					end
					local function apply(value, fire)
						local last = library_flags[flag]
						value = value and true or false
						library_flags[flag] = value
						if o.Location then
							o.Location[o.LocationFlag or flag] = value
						end
						render(true)
						if fire and o.Callback and (last ~= value or o.AllowDuplicateCalls) then
							fireCallback(o.Callback, value)
						end
						return value
					end
					local function Set(a, b)
						return apply(pickArg(element, a, b), true)
					end
					hit.Activated:Connect(function()
						if locked then
							return
						end
						local newValue = not library_flags[flag]
						if type(o.Condition) == "function" then
							local ok, allowed = pcall(o.Condition, newValue, not newValue)
							if ok and not allowed then
								return
							end
						end
						apply(newValue, true)
					end)
					-- Taste aus Keybind-Option (nur wenn eine Tastatur angeschlossen ist)
					if o.Keybind and typeof(o.Keybind) ~= "boolean" then
						local kb = o.Keybind
						local key = (typeof(kb) == "EnumItem" and kb) or (type(kb) == "table" and (kb.Value or kb.Key)) or nil
						if typeof(key) == "EnumItem" then
							library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(input, processed)
								if processed or locked or userInputService:GetFocusedTextBox() then
									return
								end
								if input.KeyCode == key or input.UserInputType == key then
									apply(not library_flags[flag], true)
								end
							end)
						end
					end
					local initial = o.Value
					if initial == nil then
						initial = o.Enabled
					end
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = "Toggle",
						Parent = sectionFunctions,
						Instance = nameLabel,
						Container = row,
						DisplayName = name,
						Get = function()
							return library_flags[flag]
						end,
						Set = Set,
						RawSet = function(a, b)
							return apply(pickArg(element, a, b), false)
						end,
						Update = function()
							render(false)
							return library_flags[flag]
						end,
						Remove = removeRow(row),
						SetCondition = function(t, condition)
							if type(t) ~= "table" and condition == nil then
								condition = t
							end
							o.Condition = condition
							return condition
						end
					}
					addLocking(element, function()
						return locked
					end, function(v)
						locked = v
						render(false)
					end)
					if initial ~= nil then
						apply(initial, true)
					else
						library_flags[flag] = false
						render(false)
					end
					element.Default = library_flags[flag] and true or false
					element.Reset = function()
						return Set(nil, element.Default)
					end
					register(flag, element)
					return element
				end

				-- ---------------- Slider ----------------
				function sectionFunctions:AddSlider(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Slider", o, ...)) or o
					local name = assert(o.Name, "Missing Name for new slider.")
					assert(o.Max, "Missing Max for new slider.")
					assert(o.Min, "Missing Min for new slider.")
					local flag = o.Flag or unnamed("unnamedsliders", "Slider")
					warnReused(flag)
					local decimals = tonumber(o.Decimals or o.Precision or o.Precise)
					if not decimals and (o.Max - o.Min) <= 1 then
						decimals = 1
					end
					if decimals then
						decimals = math.clamp(decimals, 0, 99)
						if decimals <= 0 then
							decimals = nil
						end
					end
					local function display(val, was)
						local str = (decimals and string.format("%0." .. tostring(decimals) .. "f", val)) or tostring(val)
						local formatType = o.Format and type(o.Format)
						if formatType == "string" then
							local ok, res = pcall(string.format, o.Format, val)
							return ok and res or str
						elseif formatType == "function" then
							local ok, res = pcall(o.Format, val, was)
							if ok and res ~= nil then
								return tostring(res)
							end
							return "Format Function Errored"
						end
						return tostring(o.Name or name) .. ": " .. str
					end
					local useTextbox = o.Textbox or o.InputBox or o.CustomInput
					local row = makeRow(50)
					local valueLabel = label(row, {Position = UDim2.fromOffset(10, 5), Size = UDim2.new(1, useTextbox and -76 or -20, 0, 18)})
					local box = nil
					if useTextbox then
						box = new("TextBox", {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 4), Size = UDim2.fromOffset(60, 20), BackgroundColor3 = C("bottomGradient"), BorderSizePixel = 0, ClearTextOnFocus = false, Font = FONT_MEDIUM, TextSize = 12, TextColor3 = C("elementText"), Text = ""}, row)
						corner(box, 5)
					end
					local bar = new("Frame", {Position = UDim2.new(0, 10, 1, -17), Size = UDim2.new(1, -20, 0, 8), BackgroundColor3 = C("innerBorder"), BorderSizePixel = 0}, row)
					corner(bar, "full")
					local fill = new("Frame", {Size = UDim2.fromScale(0, 1), BackgroundColor3 = C("main"), BorderSizePixel = 0}, bar)
					corner(fill, "full")
					local hit = button(row, {Position = UDim2.new(0, 0, 1, -30), Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, ZIndex = 2})
					local element
					local function render(was)
						local v = library_flags[flag]
						fill.Size = UDim2.fromScale(safeFillRatio(v, o.Min, o.Max), 1)
						valueLabel.Text = display(v, was)
						if box and not box:IsFocused() then
							box.Text = tostring(v)
						end
					end
					local function normalize(v)
						v = tonumber(v)
						if not v or v ~= v then
							return nil
						end
						if not o.IllegalInput then
							v = math.clamp(v, math.min(o.Min, o.Max), math.max(o.Min, o.Max))
						end
						if decimals then
							v = tonumber(string.format("%0." .. tostring(decimals) .. "f", v)) or v
						end
						return v
					end
					local function apply(value, fire)
						value = normalize(value)
						if value == nil then
							return library_flags[flag]
						end
						local last = library_flags[flag]
						library_flags[flag] = value
						if o.Location then
							o.Location[o.LocationFlag or flag] = value
						end
						render(last)
						if fire and o.Callback and (last ~= value or o.AllowDuplicateCalls) then
							fireCallback(o.Callback, value, last)
						end
						return value
					end
					attachBarDrag(hit, function(x)
						local r = ratioOnBar(bar, x)
						if r == nil then
							return
						end
						local raw = o.Min + r * (o.Max - o.Min)
						if not decimals then
							raw = math.floor(raw + 0.5)
						end
						apply(raw, true)
					end)
					if box then
						box.FocusLost:Connect(function()
							local n = tonumber(box.Text)
							if n then
								apply(n, true)
							else
								render()
							end
						end)
					end
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = "Slider",
						Parent = sectionFunctions,
						Instance = valueLabel,
						Container = row,
						DisplayName = name,
						Get = function()
							return library_flags[flag]
						end,
						Set = function(a, b)
							return apply(pickArg(element, a, b), true)
						end,
						RawSet = function(a, b)
							return apply(pickArg(element, a, b), false)
						end,
						Update = function()
							render()
							return library_flags[flag]
						end,
						Remove = removeRow(row),
						SetMin = function(a, b)
							o.Min = tonumber(pickArg(element, a, b)) or o.Min
							apply(library_flags[flag], false)
						end,
						SetMax = function(a, b)
							o.Max = tonumber(pickArg(element, a, b)) or o.Max
							apply(library_flags[flag], false)
						end,
						SetConstraints = function(t, minV, maxV)
							if type(t) ~= "table" then
								t, minV, maxV = nil, t, minV
							end
							o.Min = tonumber(minV) or o.Min
							o.Max = tonumber(maxV) or o.Max
							apply(library_flags[flag], false)
						end
					}
					if o.Value ~= nil and normalize(o.Value) ~= nil then
						apply(o.Value, true)
					else
						library_flags[flag] = o.Min
						if o.Location then
							o.Location[o.LocationFlag or flag] = o.Min
						end
						render()
					end
					element.Default = library_flags[flag]
					element.Reset = function()
						return element.Set(element.Default)
					end
					register(flag, element)
					return element
				end

				-- ---------------- Button(s) ----------------
				function sectionFunctions:AddButton(...)
					local args
					if ... and not select(2, ...) and type(...) == "table" and #... > 0 and type((...)[1]) == "table" and (...)[1].Name then
						args = ...
					else
						args = {...}
					end
					local list = {}
					for _, bo in ipairs(args) do
						bo = (bo and bo[1] and type(bo[1]) == "string" and resolvevararg("Button", unpack(bo))) or bo
						if type(bo) == "table" then
							list[1 + #list] = bo
						end
					end
					local container = new("Frame", {Size = UDim2.new(1, 0, 0, ROW_H), BackgroundTransparency = 1, LayoutOrder = nextOrder()}, holder)
					new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, container)
					local count = math.max(#list, 1)
					local buttons = {}
					for index, bo in ipairs(list) do
						local name = assert(bo.Name, "Missing Name for new button.")
						local callback = bo.Callback or function()
						end
						local locked = (bo.Locked or bo.Disabled) and true or false
						local btn = button(container, {Size = UDim2.new(1 / count, -((count - 1) * 6) / count, 1, 0), BackgroundColor3 = C("topGradient"), Text = tostring(name), TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = index})
						corner(btn, 6)
						local stroke = new("UIStroke", {Color = C("main"), Thickness = 1, Transparency = 0.6, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, btn)
						local element
						local function render()
							btn.Text = tostring(bo.Name or name)
							btn.TextTransparency = locked and 0.55 or 0
							stroke.Transparency = locked and 0.85 or 0.6
						end
						local function press()
							if type(bo.Condition) == "function" then
								local ok, allowed = pcall(bo.Condition)
								if ok and not allowed then
									return
								end
							end
							fireCallback(callback)
						end
						btn.Activated:Connect(function()
							if locked then
								return
							end
							tweenService:Create(btn, TweenInfo.new(0.08), {BackgroundColor3 = darkenColor(C("main"), 2)}):Play()
							task.delay(0.12, function()
								tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = C("topGradient")}):Play()
							end)
							press()
						end)
						element = {
							Options = bo,
							Name = name,
							Flag = name,
							Type = "Button",
							Parent = sectionFunctions,
							Instance = btn,
							Container = container,
							ButtonFrame = btn,
							Frame = container,
							DisplayName = name,
							Get = function()
								return nil
							end,
							Press = function()
								if not locked then
									press()
								end
							end,
							RawPress = press,
							SetText = function(a, b)
								bo.Name = tostring(pickArg(element, a, b))
								render()
								return bo.Name
							end,
							SetCallback = function(a, b)
								local fn = pickArg(element, a, b)
								if type(fn) == "function" then
									callback = fn
								end
								return callback
							end,
							SetCondition = function(t, condition)
								if type(t) ~= "table" and condition == nil then
									condition = t
								end
								bo.Condition = condition
								return condition
							end,
							Update = function()
								render()
							end,
							Remove = function()
								btn.Parent = nil
							end
						}
						addLocking(element, function()
							return locked
						end, function(v)
							locked = v
							render()
						end)
						render()
						register(name, element)
						buttons[1 + #buttons] = element
					end
					function buttons.PressAll()
						for _, b in ipairs(buttons) do
							b.Press()
						end
					end
					function buttons.UpdateAll()
						for _, b in ipairs(buttons) do
							b.Update()
						end
					end
					buttons.Update = buttons.UpdateAll
					function buttons.RemoveAll()
						container.Parent = nil
					end
					buttons.Remove = buttons.RemoveAll
					if #buttons == 1 then
						for k, v in next, buttons[1] do
							if buttons[k] == nil then
								buttons[k] = v
							end
						end
					end
					return buttons
				end

				-- ---------------- Label ----------------
				function sectionFunctions:AddLabel(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Label", o, ...)) or o
					local text = o.Text or o.Value or o.Name
					local flag = o.Flag or unnamed("unnamedlabels", "Label")
					warnReused(flag)
					local lbl = label(holder, {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true, TextTruncate = Enum.TextTruncate.None, TextColor3 = C("otherElementText"), Text = tostring(text or ""), LayoutOrder = nextOrder()})
					new("UIPadding", {PaddingLeft = UDim.new(0, 4), PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 2)}, lbl)
					local element
					local function set(a, b)
						local v = pickArg(element, a, b)
						lbl.Text = tostring(v == nil and "" or v)
						return lbl.Text
					end
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = "Label",
						Default = lbl.Text,
						Parent = sectionFunctions,
						Instance = lbl,
						Container = lbl,
						DisplayName = text,
						Get = function()
							return lbl.Text, lbl
						end,
						Set = set,
						SetText = set,
						RawSet = set,
						Update = function()
							return lbl.Text
						end,
						Remove = function()
							lbl.Parent = nil
						end
					}
					element.Reset = function()
						return set(nil, element.Default)
					end
					register(flag, element)
					return element
				end

				-- ---------------- Textbox ----------------
				function sectionFunctions:AddTextbox(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Textbox", o, ...)) or o
					local name = assert(o.Name, "Missing Name for new textbox.")
					local flag = o.Flag or unnamed("unnamedtextboxes", "Textbox")
					warnReused(flag)
					local row = makeRow()
					local nameLabel = label(row, {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(0.42, -10, 1, 0), Text = tostring(name)})
					local box = new("TextBox", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0), Size = UDim2.new(0.58, -6, 0, 24), BackgroundColor3 = C("bottomGradient"), BorderSizePixel = 0, ClearTextOnFocus = false, Font = FONT_MEDIUM, TextSize = 12, TextColor3 = C("elementText"), PlaceholderColor3 = C("otherElementText"), PlaceholderText = tostring(o.Placeholder or o.Value or ""), Text = "", TextTruncate = Enum.TextTruncate.AtEnd}, row)
					corner(box, 5)
					new("UIPadding", {PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6)}, box)
					local element
					local function apply(value, fire)
						local last = library_flags[flag]
						value = (value == nil and "") or tostring(value)
						library_flags[flag] = value
						if o.Location then
							o.Location[o.LocationFlag or flag] = value
						end
						if box.Text ~= value then
							box.Text = value
						end
						if fire and o.Callback and (last ~= value or o.AllowDuplicateCalls) then
							fireCallback(o.Callback, value, last, box)
						end
						return value
					end
					box.FocusLost:Connect(function()
						apply(box.Text, true)
					end)
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = "Textbox",
						Parent = sectionFunctions,
						Instance = box,
						Container = row,
						DisplayName = name,
						Get = function()
							return library_flags[flag]
						end,
						Set = function(a, b)
							return apply(pickArg(element, a, b), true)
						end,
						RawSet = function(a, b)
							return apply(pickArg(element, a, b), false)
						end,
						Update = function()
							nameLabel.Text = tostring(o.Name or name)
							return library_flags[flag]
						end,
						Remove = removeRow(row)
					}
					if o.Value ~= nil then
						apply(o.Value, true)
					else
						library_flags[flag] = nil
					end
					element.Default = library_flags[flag]
					element.Reset = function()
						return element.Set(element.Default)
					end
					register(flag, element)
					return element
				end

				-- ---------------- Keybind ----------------
				-- Ohne Tastatur: Antippen löst die "Pressed"-Funktion aus. Mit Tastatur: Antippen
				-- und dann eine Taste drücken legt die Taste fest (Esc/Backspace = NONE).
				function sectionFunctions:AddKeybind(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Keybind", o, ...)) or o
					local name = assert(o.Name, "Missing Name for new keybind.")
					local flag = o.Flag or unnamed("unnamedkeybinds", "Keybind")
					warnReused(flag)
					local row = makeRow()
					local hit = button(row, {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 2})
					local nameLabel = label(row, {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -96, 1, 0), Text = tostring(name)})
					local keyLabel = label(row, {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 0), Size = UDim2.new(0, 80, 1, 0), TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = C("otherElementText")})
					local element
					local binding = false
					local function keyName(key)
						if key == nil then
							return "NONE"
						end
						if typeof(key) == "EnumItem" then
							return key.Name
						end
						return tostring(key)
					end
					local function render()
						nameLabel.Text = tostring(o.Name or name)
						keyLabel.Text = binding and "[...]" or ("[" .. keyName(library_flags[flag]) .. "]")
					end
					local function apply(key, fire)
						if key == "nil" or key == "NONE" or key == "none" then
							key = nil
						end
						local last = library_flags[flag]
						library_flags[flag] = key
						if o.Location then
							o.Location[o.LocationFlag or flag] = key
						end
						render()
						if fire and o.Callback and (last ~= key or o.AllowDuplicateCalls) then
							fireCallback(o.Callback, key, last)
						end
						return key
					end
					hit.Activated:Connect(function()
						local hasKeyboard = false
						pcall(function()
							hasKeyboard = userInputService.KeyboardEnabled
						end)
						if not hasKeyboard then
							if type(o.Pressed) == "function" then
								fireCallback(o.Pressed)
							end
							return
						end
						if binding then
							return
						end
						binding = true
						render()
						local connection
						connection = userInputService.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.Keyboard then
								connection:Disconnect()
								binding = false
								if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then
									apply(nil, true)
								else
									apply(input.KeyCode, true)
								end
							elseif input.UserInputType == Enum.UserInputType.Touch then
								connection:Disconnect()
								binding = false
								render()
							end
						end)
						library.signals[1 + #library.signals] = connection
					end)
					library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(input, processed)
						if processed or binding or userInputService:GetFocusedTextBox() then
							return
						end
						local key = library_flags[flag]
						if key ~= nil and (input.KeyCode == key or input.UserInputType == key) and type(o.Pressed) == "function" then
							fireCallback(o.Pressed, input)
						end
					end)
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = "Keybind",
						Parent = sectionFunctions,
						Instance = keyLabel,
						Container = row,
						DisplayName = name,
						Get = function()
							return library_flags[flag]
						end,
						Set = function(a, b)
							return apply(pickArg(element, a, b), true)
						end,
						RawSet = function(a, b)
							return apply(pickArg(element, a, b), false)
						end,
						Update = function()
							render()
							return library_flags[flag]
						end,
						Remove = removeRow(row)
					}
					local preset = o.Value
					if typeof(preset) ~= "EnumItem" then
						preset = nil
					end
					library_flags[flag] = preset
					render()
					element.Default = preset
					element.Reset = function()
						return element.Set(element.Default)
					end
					register(flag, element)
					return element
				end

				-- ---------------- Dropdown / SearchBox ----------------
				local function makeDropdown(o, elementType)
					local name = assert(o.Name, "Missing Name for new dropdown.")
					local listSource = assert(o.List, "Missing List for new dropdown.")
					local flag = o.Flag or unnamed((elementType == "SearchBox") and "unnamedsearchbox" or "unnameddropdown", elementType)
					warnReused(flag)
					local multi = o.MultiSelect or o.Multi or o.Multiple
					local blank = (not multi) and (o.BlankValue or o.NoValueString or o.Nothing) or nil
					if o.SpecialType == "Player" then
						local exclude = o.ExcludeLocalPlayer and true or false
						listSource = function()
							local names = {}
							for _, plr in ipairs(playersservice:GetPlayers()) do
								if not (exclude and plr == playersservice.LocalPlayer) then
									names[1 + #names] = plr.Name
								end
							end
							table.sort(names, function(a, b)
								return a:lower() < b:lower()
							end)
							return names
						end
					elseif o.SpecialType == "Team" then
						listSource = function()
							local names = {}
							for _, team in ipairs(game:GetService("Teams"):GetTeams()) do
								names[1 + #names] = team.Name
							end
							table.sort(names, function(a, b)
								return a:lower() < b:lower()
							end)
							return names
						end
					end
					local resolve = getresolver(listSource, o.Filter, o.Method)
					local list = {}
					local function refreshList()
						local ok, res = pcall(resolve)
						list = (ok and type(res) == "table") and res or {}
						if not next(list) and o.EmptyValue ~= nil then
							table.insert(list, 1, o.EmptyValue)
						end
						return list
					end
					refreshList()
					local disabledValues = (type(o.DisabledValues) == "table" and o.DisabledValues) or {}
					local function isDisabled(v)
						return table.find(disabledValues, tostring(v)) ~= nil
					end
					local function formatValue(v)
						if v ~= nil and type(o.FormatDisplayValue) == "function" then
							local ok, res = pcall(o.FormatDisplayValue, v)
							if ok and res ~= nil then
								return tostring(res)
							end
						end
						return tostring(v)
					end
					local row = makeRow(52)
					local hit = button(row, {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 2})
					local nameLabel = label(row, {Position = UDim2.fromOffset(10, 4), Size = UDim2.new(1, -20, 0, 18), Text = tostring(name)})
					local valueBox = new("Frame", {Position = UDim2.new(0, 8, 0, 25), Size = UDim2.new(1, -16, 0, 21), BackgroundColor3 = C("bottomGradient"), BorderSizePixel = 0}, row)
					corner(valueBox, 5)
					local valueLabel = label(valueBox, {Position = UDim2.fromOffset(8, 0), Size = UDim2.new(1, -30, 1, 0), TextSize = 12, TextColor3 = C("otherElementText")})
					label(valueBox, {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 0), Size = UDim2.new(0, 14, 1, 0), TextXAlignment = Enum.TextXAlignment.Right, TextSize = 11, TextColor3 = C("main"), Text = "▼"})
					local element
					local overlayRebuild = nil -- gesetzt, solange die Liste dieses Dropdowns offen ist
					local function displayText()
						local v = library_flags[flag]
						if multi then
							if type(v) == "table" and #v > 0 then
								local parts = {}
								for i, item in ipairs(v) do
									parts[i] = formatValue(item)
								end
								return table.concat(parts, ", ")
							end
							return (type(multi) == "string" and multi) or tostring(blank or "Select Item(s)")
						end
						if v == nil then
							return tostring(blank or "None")
						end
						return formatValue(v)
					end
					local function render()
						nameLabel.Text = tostring(o.Name or name)
						valueLabel.Text = displayText()
					end
					local function applySingle(value, fire)
						local last = library_flags[flag]
						library_flags[flag] = value
						if o.Location then
							o.Location[o.LocationFlag or flag] = value
						end
						render()
						if fire and o.Callback and (last ~= value or o.AllowDuplicateCalls) then
							fireCallback(o.Callback, value, last)
						end
						return value
					end
					-- Mehrfachauswahl: die Tabelle bleibt dieselbe (wie am PC), Inhalt wird ersetzt
					local function applyMulti(values, fire)
						local current = library_flags[flag]
						if type(current) ~= "table" then
							current = {}
							library_flags[flag] = current
						end
						local before = {unpack(current)}
						table.clear(current)
						if type(values) == "table" then
							for _, v in ipairs(values) do
								if v ~= nil and not table.find(current, v) then
									current[1 + #current] = v
								end
							end
						elseif values ~= nil then
							current[1] = values
						end
						if o.Location then
							o.Location[o.LocationFlag or flag] = current
						end
						render()
						local changed = #before ~= #current
						if not changed then
							for i, v in ipairs(current) do
								if before[i] ~= v then
									changed = true
									break
								end
							end
						end
						if fire and o.Callback and (changed or o.AllowDuplicateCalls) then
							fireCallback(o.Callback, current, before)
						end
						return current
					end
					local function apply(value, fire)
						if multi then
							return applyMulti(value, fire)
						end
						if type(value) == "table" then
							value = value[1]
						end
						return applySingle(value, fire)
					end
					-- Liste im Overlay
					local function openList()
						refreshList()
						local content = openOverlay(function()
							overlayRebuild = nil
						end)
						label(content, {Position = UDim2.fromOffset(12, 8), Size = UDim2.new(1, -24, 0, 20), Font = FONT_BOLD, TextSize = 14, Text = tostring(o.Name or name), ZIndex = 53})
						local top = 32
						local searchBox = nil
						if o.Searchable or elementType == "SearchBox" then
							searchBox = new("TextBox", {Position = UDim2.fromOffset(10, top), Size = UDim2.new(1, -20, 0, 28), BackgroundColor3 = C("bottomGradient"), BorderSizePixel = 0, ClearTextOnFocus = false, Font = FONT_MEDIUM, TextSize = 13, TextColor3 = C("elementText"), PlaceholderColor3 = C("otherElementText"), PlaceholderText = "Search...", Text = "", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 53}, content)
							corner(searchBox, 5)
							new("UIPadding", {PaddingLeft = UDim.new(0, 8)}, searchBox)
							top = top + 34
						end
						local bottomSpace = multi and 46 or 8
						local scroller = new("ScrollingFrame", {Position = UDim2.fromOffset(10, top), Size = UDim2.new(1, -20, 1, -(top + bottomSpace)), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 4, ScrollBarImageColor3 = C("main"), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 53}, content)
						new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, scroller)
						if multi then
							local doneButton = button(content, {AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -8), Size = UDim2.new(1, -20, 0, 32), BackgroundColor3 = C("main"), Text = "Done", Font = FONT_BOLD, TextSize = 14, TextColor3 = Color3.new(1, 1, 1), ZIndex = 53}, nil)
							corner(doneButton, 6)
							doneButton.Activated:Connect(closeOverlay)
						end
						local function build()
							for _, child in ipairs(scroller:GetChildren()) do
								if child:IsA("GuiObject") then
									child:Destroy()
								end
							end
							local term = searchBox and string.lower(searchBox.Text) or ""
							local current = library_flags[flag]
							local items = {}
							if blank and not table.find(list, blank) then
								items[1] = blank
							end
							for _, v in ipairs(list) do
								items[1 + #items] = v
							end
							local shown = 0
							for index, v in ipairs(items) do
								local text = formatValue(v)
								if term == "" or string.find(string.lower(text), term, 1, true) or string.find(string.lower(tostring(v)), term, 1, true) then
									shown = shown + 1
									local selected = (multi and type(current) == "table" and table.find(current, v) ~= nil) or (not multi and current == v)
									local disabled = isDisabled(v)
									local item = button(scroller, {Size = UDim2.new(1, -6, 0, 32), BackgroundColor3 = selected and darkenColor(C("main"), 2) or C("topGradient"), Text = "", LayoutOrder = index, ZIndex = 54})
									corner(item, 6)
									label(item, {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -40, 1, 0), Text = text, TextColor3 = selected and C("elementText") or C("otherElementText"), TextTransparency = disabled and 0.6 or 0, ZIndex = 55})
									if selected then
										label(item, {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 0), Size = UDim2.new(0, 20, 1, 0), TextXAlignment = Enum.TextXAlignment.Right, Text = "✓", TextColor3 = C("main"), Font = FONT_BOLD, ZIndex = 55})
									end
									item.Activated:Connect(function()
										if disabled then
											return
										end
										if multi then
											local values = {}
											local cur = library_flags[flag]
											if type(cur) == "table" then
												for _, x in ipairs(cur) do
													values[1 + #values] = x
												end
											end
											local at = table.find(values, v)
											if at then
												table.remove(values, at)
											else
												values[1 + #values] = v
											end
											applyMulti(values, true)
											build()
										else
											applySingle(v, true)
											closeOverlay()
										end
									end)
								end
							end
							if shown == 0 then
								label(scroller, {Size = UDim2.new(1, -6, 0, 28), TextXAlignment = Enum.TextXAlignment.Center, TextColor3 = C("otherElementText"), Text = "No entries", ZIndex = 54})
							end
						end
						build()
						overlayRebuild = build
						if searchBox then
							searchBox:GetPropertyChangedSignal("Text"):Connect(build)
						end
					end
					hit.Activated:Connect(openList)
					local function relistIfOpen()
						if overlayRebuild then
							pcall(overlayRebuild)
						end
					end
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = elementType,
						Parent = sectionFunctions,
						Instance = valueLabel,
						Container = row,
						DisplayName = name,
						Get = function()
							return library_flags[flag]
						end,
						Set = function(a, b)
							return apply(pickArg(element, a, b), true)
						end,
						RawSet = function(a, b)
							return apply(pickArg(element, a, b), false)
						end,
						Update = function()
							render()
							return displayText()
						end,
						Remove = removeRow(row),
						resolvelist = function()
							return refreshList()
						end,
						UpdateList = function(t, newList, updateValues)
							if (newList == nil and t ~= nil and t ~= element) or (type(t) == "table" and t ~= element and type(newList) ~= "table") then
								newList, updateValues = t, newList
							end
							if newList == element then
								newList = nil
							end
							if newList ~= nil then
								listSource = newList
								o.List = newList
							end
							resolve = getresolver(listSource, o.Filter, o.Method)
							refreshList()
							if updateValues and not multi and library_flags[flag] ~= nil and not table.find(list, library_flags[flag]) then
								applySingle(list[1], true)
							end
							render()
							relistIfOpen()
							return list
						end,
						SetDisabledValues = function(t, values)
							if values == nil and t ~= element then
								values = t
							end
							if type(values) == "table" then
								disabledValues = values
							end
							relistIfOpen()
							return disabledValues
						end,
						AddDisabledValues = function(t, values)
							if values == nil and t ~= element then
								values = t
							end
							if type(values) == "table" then
								for _, v in ipairs(values) do
									disabledValues[1 + #disabledValues] = v
								end
							elseif values ~= nil then
								disabledValues[1 + #disabledValues] = tostring(values)
							end
							relistIfOpen()
							return disabledValues
						end
					}
					element.Refresh = element.UpdateList
					element.SetValues = element.UpdateList
					-- Spieler/Teams live aktualisieren
					if o.SpecialType == "Player" then
						library.signals[1 + #library.signals] = playersservice.PlayerAdded:Connect(function()
							refreshList()
							relistIfOpen()
						end)
						library.signals[1 + #library.signals] = playersservice.PlayerRemoving:Connect(function()
							task.defer(function()
								refreshList()
								relistIfOpen()
							end)
						end)
					elseif o.SpecialType == "Team" then
						pcall(function()
							local teams = game:GetService("Teams")
							library.signals[1 + #library.signals] = teams.ChildAdded:Connect(function()
								refreshList()
								relistIfOpen()
							end)
							library.signals[1 + #library.signals] = teams.ChildRemoved:Connect(function()
								refreshList()
								relistIfOpen()
							end)
						end)
					end
					-- Startwert
					local initial = o.Value
					if blank and initial == nil then
						initial = blank
					end
					if multi then
						library_flags[flag] = {}
						if initial ~= nil then
							applyMulti((type(initial) == "table") and initial or {initial}, true)
						end
					else
						if initial == nil then
							initial = list[1]
						end
						if o.Value ~= nil or blank ~= nil then
							applySingle(initial, true)
						else
							library_flags[flag] = initial
						end
					end
					if o.Location and not multi then
						o.Location[o.LocationFlag or flag] = library_flags[flag]
					end
					render()
					element.Default = library_flags[flag]
					element.Reset = function()
						return element.Set(element.Default)
					end
					register(flag, element)
					return element
				end
				function sectionFunctions:AddDropdown(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Dropdown", o, ...)) or o
					return makeDropdown(o, "Dropdown")
				end
				function sectionFunctions:AddSearchBox(o, ...)
					o = (o and type(o) == "string" and resolvevararg("SearchBox", o, ...)) or o
					o.Searchable = true
					return makeDropdown(o, "SearchBox")
				end

				-- ---------------- Colorpicker ----------------
				function sectionFunctions:AddColorpicker(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Colorpicker", o, ...)) or o
					local name = assert(o.Name, "Missing Name for new colorpicker.")
					local flag = o.Flag or unnamed("unnamedcolorpickers", "Colorpicker")
					warnReused(flag)
					local function toColor(v)
						if typeof(v) == "Color3" then
							return v
						end
						if v == "random" or o.Random == true then
							return Color3.new(math.random(), math.random(), math.random())
						end
						if type(v) == "string" and v ~= "rainbow" then
							local ok, c = pcall(Color3FromHex, v)
							if ok and typeof(c) == "Color3" then
								return c
							end
						end
						return nil
					end
					local row = makeRow()
					local hit = button(row, {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 2})
					local nameLabel = label(row, {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -64, 1, 0), Text = tostring(name)})
					local swatch = new("Frame", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(40, 20), BorderSizePixel = 0}, row)
					corner(swatch, 5)
					local element
					local function render()
						local c = library_flags[flag]
						if typeof(c) == "Color3" then
							swatch.BackgroundColor3 = c
						end
						nameLabel.Text = tostring(o.Name or name)
					end
					local function apply(value, fire)
						local c = toColor(value)
						if not c then
							return library_flags[flag]
						end
						local last = library_flags[flag]
						library_flags[flag] = c
						if o.Location then
							o.Location[o.LocationFlag or flag] = c
						end
						render()
						if fire and o.Callback and (last ~= c or o.AllowDuplicateCalls) then
							fireCallback(o.Callback, c, last)
						end
						return c
					end
					-- Farbwahl im Overlay: Farbton/Sättigung/Helligkeit als Balken + Hex-Feld
					local function openPicker()
						local h, s, v = Color3.toHSV(library_flags[flag] or Color3.new(1, 1, 1))
						local content = openOverlay()
						label(content, {Position = UDim2.fromOffset(12, 8), Size = UDim2.new(1, -24, 0, 20), Font = FONT_BOLD, TextSize = 14, Text = tostring(o.Name or name), ZIndex = 53})
						local preview = new("Frame", {Position = UDim2.fromOffset(12, 34), Size = UDim2.fromOffset(48, 28), BorderSizePixel = 0, ZIndex = 53}, content)
						corner(preview, 6)
						local hexBox = new("TextBox", {Position = UDim2.fromOffset(68, 34), Size = UDim2.new(1, -80, 0, 28), BackgroundColor3 = C("bottomGradient"), BorderSizePixel = 0, ClearTextOnFocus = false, Font = FONT_MEDIUM, TextSize = 13, TextColor3 = C("elementText"), Text = "", ZIndex = 53}, content)
						corner(hexBox, 5)
						local bars = {}
						local function makeBar(index, title)
							local y = 72 + (index - 1) * 40
							label(content, {Position = UDim2.fromOffset(12, y), Size = UDim2.new(1, -24, 0, 14), TextSize = 11, TextColor3 = C("otherElementText"), Text = title, ZIndex = 53})
							local barFrame = new("Frame", {Position = UDim2.fromOffset(12, y + 17), Size = UDim2.new(1, -24, 0, 14), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 53}, content)
							corner(barFrame, "full")
							local gradient = new("UIGradient", {}, barFrame)
							local knobFrame = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(8, 20), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ZIndex = 54}, barFrame)
							corner(knobFrame, "full")
							new("UIStroke", {Color = Color3.new(0, 0, 0), Thickness = 1}, knobFrame)
							local hitArea = button(content, {Position = UDim2.fromOffset(12, y + 10), Size = UDim2.new(1, -24, 0, 28), BackgroundTransparency = 1, ZIndex = 55})
							bars[index] = {Frame = barFrame, Gradient = gradient, Knob = knobFrame, Hit = hitArea}
						end
						makeBar(1, "Hue")
						makeBar(2, "Saturation")
						makeBar(3, "Brightness")
						do
							local keys = {}
							for i = 0, 6 do
								keys[#keys + 1] = ColorSequenceKeypoint.new(i / 6, Color3.fromHSV(i / 6, 1, 1))
							end
							bars[1].Gradient.Color = ColorSequence.new(keys)
						end
						local function refresh(fire)
							local c = Color3.fromHSV(h, s, v)
							preview.BackgroundColor3 = c
							bars[2].Gradient.Color = ColorSequence.new(Color3.fromHSV(h, 0, v), Color3.fromHSV(h, 1, v))
							bars[3].Gradient.Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.fromHSV(h, s, 1))
							bars[1].Knob.Position = UDim2.fromScale(h, 0.5)
							bars[2].Knob.Position = UDim2.fromScale(s, 0.5)
							bars[3].Knob.Position = UDim2.fromScale(v, 0.5)
							if not hexBox:IsFocused() then
								hexBox.Text = "#" .. Color3ToHex(c)
							end
							if fire then
								apply(c, true)
							end
						end
						for index, bar in ipairs(bars) do
							attachBarDrag(bar.Hit, function(x)
								local r = ratioOnBar(bar.Frame, x)
								if r == nil or not content.Parent then
									return
								end
								if index == 1 then
									h = math.min(r, 0.999)
								elseif index == 2 then
									s = r
								else
									v = r
								end
								refresh(true)
							end)
						end
						hexBox.FocusLost:Connect(function()
							local c = toColor(hexBox.Text)
							if c then
								h, s, v = Color3.toHSV(c)
								refresh(true)
							else
								refresh(false)
							end
						end)
						local randomButton = button(content, {AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 12, 1, -8), Size = UDim2.new(0.5, -15, 0, 30), BackgroundColor3 = C("topGradient"), Text = "Random", ZIndex = 53})
						corner(randomButton, 6)
						randomButton.Activated:Connect(function()
							h, s, v = math.random(), 0.5 + math.random() * 0.5, 0.6 + math.random() * 0.4
							refresh(true)
						end)
						local doneButton = button(content, {AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -12, 1, -8), Size = UDim2.new(0.5, -15, 0, 30), BackgroundColor3 = C("main"), Text = "Done", Font = FONT_BOLD, TextColor3 = Color3.new(1, 1, 1), ZIndex = 53})
						corner(doneButton, 6)
						doneButton.Activated:Connect(closeOverlay)
						refresh(false)
					end
					hit.Activated:Connect(openPicker)
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = "Colorpicker",
						Parent = sectionFunctions,
						Instance = swatch,
						Container = row,
						DisplayName = name,
						Get = function()
							return library_flags[flag]
						end,
						Set = function(a, b)
							return apply(pickArg(element, a, b), true)
						end,
						RawSet = function(a, b)
							return apply(pickArg(element, a, b), false)
						end,
						Update = function()
							render()
							return library_flags[flag]
						end,
						Remove = removeRow(row),
						GetRainbow = function()
							return false
						end,
						SetRainbow = function()
							return false
						end
					}
					if o.Value ~= nil and toColor(o.Value) then
						apply(o.Value, true)
					else
						library_flags[flag] = Color3.new(1, 1, 1)
						if o.Location then
							o.Location[o.LocationFlag or flag] = library_flags[flag]
						end
						render()
					end
					element.Default = library_flags[flag]
					element.Reset = function()
						return element.Set(element.Default)
					end
					register(flag, element)
					return element
				end

				-- ---------------- Config-Profil (AddPersistence) ----------------
				function sectionFunctions:AddPersistence(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Tab", o, ...)) or o or {}
					local flag = o.Flag or unnamed("unnamedpersistence", "Persistence")
					local nameBox = sectionFunctions:AddTextbox({Name = "Config Name", Flag = "__Mobile.ConfigName." .. flag, Placeholder = "name"})
					local configList = sectionFunctions:AddDropdown({Name = "Configs", Flag = "__Mobile.ConfigList." .. flag, List = function()
						return listConfigs()
					end, Nothing = "None", Callback = function(v)
						if v and v ~= "None" then
							nameBox:RawSet(v)
						end
					end})
					local infoLabel = nil
					local function currentName()
						local n = library_flags["__Mobile.ConfigName." .. flag]
						if type(n) ~= "string" or #sanitizeConfigName(n) == 0 then
							n = library_flags["__Mobile.ConfigList." .. flag]
						end
						if n == "None" then
							return nil
						end
						return n
					end
					local function refreshInfo()
						if infoLabel then
							infoLabel:Set("Autoload: " .. tostring(readAutoload() or "none"))
						end
						configList:UpdateList()
					end
					sectionFunctions:AddButton({{Name = "Save", Callback = function()
						local ok, info = saveConfig(currentName())
						notify(ok and ("Config saved: " .. tostring(info)) or ("Save failed: " .. tostring(info)), ok and "success" or "error")
						refreshInfo()
					end}, {Name = "Load", Callback = function()
						local ok, info = loadConfig(currentName())
						notify(ok and "Config loaded" or ("Load failed: " .. tostring(info)), ok and "success" or "error")
					end}})
					sectionFunctions:AddButton({{Name = "Delete", Callback = function()
						local ok = deleteConfig(currentName())
						notify(ok and "Config deleted" or "Delete failed", ok and "success" or "error")
						refreshInfo()
					end}, {Name = "Set Autoload", Callback = function()
						local n = sanitizeConfigName(currentName() or "")
						if #n == 0 then
							notify("Enter or select a config first", "error")
							return
						end
						local ok = writeAutoload(n)
						notify(ok and ("Autoload: " .. n) or "Could not save autoload", ok and "success" or "error")
						refreshInfo()
					end}})
					infoLabel = sectionFunctions:AddLabel({Text = "Autoload: " .. tostring(readAutoload() or "none")})
					local element
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = "Persistence",
						Parent = sectionFunctions,
						Container = nameBox.Container,
						Get = currentName,
						Set = function(a, b)
							local v = pickArg(element, a, b)
							nameBox:RawSet(v)
							return v
						end,
						SaveFile = function(a, b)
							return saveConfig(pickArg(element, a, b) or currentName())
						end,
						LoadFile = function(a, b)
							return loadConfig(pickArg(element, a, b) or currentName())
						end,
						Update = refreshInfo
					}
					elements[flag] = element
					return element
				end

				-- Kurzformen wie im PC-Menü
				for alias, target in next, {
					AddColorPicker = "AddColorpicker", AddDropDown = "AddDropdown", AddTextBox = "AddTextbox", Bind = "AddKeybind", Box = "AddTextbox", Button = "AddButton", CP = "AddColorpicker", ColorPicker = "AddColorpicker", Colorpicker = "AddColorpicker", Cp = "AddColorpicker", CreateButton = "AddButton", CreateColorPicker = "AddColorpicker", CreateColorpicker = "AddColorpicker", CreateDropdown = "AddDropdown", CreateKeybind = "AddKeybind", CreateLabel = "AddLabel", CreatePersistence = "AddPersistence", CreateSaveLoad = "AddPersistence", CreateSearchBox = "AddSearchBox", CreateSearchbox = "AddSearchBox", CreateSlider = "AddSlider", CreateTextBox = "AddTextbox", CreateTextbox = "AddTextbox", CreateToggle = "AddToggle", DD = "AddDropdown", Dd = "AddDropdown", DropDown = "AddDropdown", Dropdown = "AddDropdown", Keybind = "AddKeybind", Label = "AddLabel", NewButton = "AddButton", NewColorPicker = "AddColorpicker", NewColorpicker = "AddColorpicker", NewDropDown = "AddDropdown", NewDropdown = "AddDropdown", NewKeybind = "AddKeybind", NewLabel = "AddLabel", NewPersistence = "AddPersistence", NewSearchBox = "AddSearchBox", NewSearchbox = "AddSearchBox", NewSlider = "AddSlider", NewTextBox = "AddTextbox", NewTextbox = "AddTextbox", NewToggle = "AddToggle", NumberConstraint = "AddSlider", Persistence = "AddPersistence", SBox = "AddSearchBox", SL = "AddPersistence", SaveLoad = "AddPersistence", Sbox = "AddSearchBox", SearchBox = "AddSearchBox", Searchbox = "AddSearchBox", Slide = "AddSlider", Slider = "AddSlider", Text = "AddLabel", TextBox = "AddTextbox", Textbox = "AddTextbox", Tog = "AddToggle", Toggle = "AddToggle"
				} do
					sectionFunctions[alias] = sectionFunctions[target]
				end
				return sectionFunctions
			end
			tabFunctions.AddSection = tabFunctions.CreateSection
			tabFunctions.NewSection = tabFunctions.CreateSection
			tabFunctions.Section = tabFunctions.CreateSection
			tabFunctions.Sec = tabFunctions.CreateSection
			tabFunctions.S = tabFunctions.CreateSection
			function tabFunctions:UpdateAll()
				for _, element in next, tabFunctions.Flags do
					if type(element) == "table" and element.Update then
						pcall(element.Update)
					end
				end
			end
			return tabFunctions
		end
		windowFunctions.AddTab = windowFunctions.CreateTab
		windowFunctions.NewTab = windowFunctions.CreateTab
		windowFunctions.Tab = windowFunctions.CreateTab
		windowFunctions.T = windowFunctions.CreateTab

		-- Settings-Tab für Mobile: Configs + Menü (statt des großen PC-Designers)
		function windowFunctions:CreateDesigner(designerOptions)
			designerOptions = (type(designerOptions) == "table" and designerOptions) or {}
			if library.MobileDesigner then
				return library.MobileDesigner
			end
			local settingsTab = windowFunctions:CreateTab({Name = designerOptions.Name or "Settings", LastTab = true})
			library.MobileDesigner = settingsTab
			local configSection = settingsTab:CreateSection({Name = "Config"})
			if hasFiles then
				configSection:AddPersistence({Flag = "__Mobile.Config"})
			else
				configSection:AddLabel({Text = "Your executor cannot save files."})
			end
			local menuSection = settingsTab:CreateSection({Name = "Menu"})
			menuSection:AddButton({{Name = "Unload GUI", Callback = function()
				terminateGui()
			end}})
			if designerOptions.Credit ~= false then
				menuSection:AddLabel({Text = "Library by d3v1lhub2222"})
			end
			local info = designerOptions.Info or options.Info
			if type(info) == "string" then
				menuSection:AddLabel({Text = info})
			elseif type(info) == "table" then
				for _, line in ipairs(info) do
					menuSection:AddLabel({Text = tostring(line)})
				end
			end
			menuSection:AddLabel({Text = "Library Version: " .. tostring(library.Version or "?") .. " (Mobile)"})
			return settingsTab
		end
		windowFunctions.AddDesigner = windowFunctions.CreateDesigner
		windowFunctions.NewDesigner = windowFunctions.CreateDesigner
		windowFunctions.Designer = windowFunctions.CreateDesigner
		windowFunctions.D = windowFunctions.CreateDesigner

		-- Settings-Tab (wie am PC bei Themeable) erst NACH den Tabs des Scripts anlegen,
		-- danach die Autoload-Config laden
		local themeable = options.Themeable or options.DefaultTheme or options.Theme
		task.spawn(function()
			local function countElements()
				local c = 0
				for _ in next, elements do
					c = c + 1
				end
				return c
			end
			-- warten, bis das Script alle Elemente erstellt hat (Anzahl bleibt stabil)
			local started = os.clock()
			local lastCount, stableSince = countElements(), os.clock()
			while os.clock() - started < 15 do
				task.wait(0.25)
				if terminated or not library.IsGuiValid() then
					return
				end
				local nowCount = countElements()
				if nowCount ~= lastCount then
					lastCount, stableSince = nowCount, os.clock()
				elseif (os.clock() - stableSince >= 0.75) and (os.clock() - started >= 1) then
					break
				end
			end
			if themeable then
				local themeInfo = (type(themeable) == "table") and themeable or nil
				local ok, err = pcall(windowFunctions.CreateDesigner, windowFunctions, themeInfo)
				if not ok then
					warn("[Mobile] Settings-Tab konnte nicht erstellt werden:", err)
				end
			end
			local autoName = readAutoload()
			if autoName then
				pcall(DebugLog.Mark, DebugLog, "Mobile-Autoload: " .. autoName)
				local ok, info = loadConfig(autoName)
				if ok then
					notify("Autoload: " .. autoName, "success")
				else
					warn("[Mobile] Autoload fehlgeschlagen:", info)
				end
			end
			pcall(DebugLog.Mark, DebugLog, "Mobile-GUI vollständig (" .. tostring(countElements()) .. " Elemente)")
		end)

		pcall(DebugLog.Mark, DebugLog, "Mobile-GUI: CreateWindow fertig")
		return windowFunctions
	end
end
-- Mobile.lua: CreateWindow baut immer das leichte Mobile-GUI (der Loader hat das Gerät schon erkannt)
function library:CreateWindow(options, ...)
	options = (options and type(options) == "string" and resolvevararg("Window", options, ...)) or options or {}
	return MobileUI.CreateWindow(options)
end
library.NewWindow = library.CreateWindow
library.AddWindow = library.CreateWindow
library.Window = library.CreateWindow
library.W = library.CreateWindow
pcall(DebugLog.Mark, DebugLog, "Library geladen")
return library, library_flags, library.subs