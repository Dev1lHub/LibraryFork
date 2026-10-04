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

-- ============================================================
-- CURSOR MODULE
-- ============================================================
local CursorModule = {}
CursorModule.Toggled = false
CursorModule.MenuFrame = nil -- wird gesetzt, sobald das Fenster (main) erstellt wurde

function CursorModule:Enable()
	if self.Toggled then
		return -- läuft bereits, keinen zweiten Loop starten (sonst konkurrierende Zustände)
	end
	
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local RenderStepped = RunService.RenderStepped
	
	self.Toggled = true
	
	task.spawn(function()
		local success, Cursor = pcall(function() return Drawing.new('Triangle') end)
		local success2, CursorOutline = pcall(function() return Drawing.new('Triangle') end)
		
		if not success or not success2 then
			self.Toggled = false
			return
		end
		
		Cursor.Thickness = 1
		Cursor.Filled = true
		Cursor.Visible = true
		
		CursorOutline.Thickness = 1
		CursorOutline.Filled = false
		CursorOutline.Color = Color3.new(0, 0, 0)
		CursorOutline.Visible = true
		
		local tickStart = tick()
		local State = UserInputService.MouseIconEnabled
		local BehaviorState = UserInputService.MouseBehavior
		local wasMenuVisible = false -- für Flanken-Erkennung (nur beim Wechsel etwas ändern)
		
		while self.Toggled do
			-- ✅ NUR ZEIGEN WENN MENU OFFEN IST
			local menuVisible = (CursorModule.MenuFrame and CursorModule.MenuFrame.Visible) and true or false
			
			if menuVisible then
				if not wasMenuVisible then
					-- Menu wurde gerade geöffnet → aktuellen Mausstatus (inkl. Shiftlock) jetzt merken,
					-- BEVOR wir ihn überschreiben, damit wir ihn beim Schließen korrekt wiederherstellen können
					BehaviorState = UserInputService.MouseBehavior
				end
				
				-- ✅ Rechtsklick gehalten → normale Roblox-Kamera-Drehung zulassen (nicht überschreiben)
				local rightMouseHeld = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
				UserInputService.MouseIconEnabled = false
				
				if rightMouseHeld then
					-- Während des Drehens: eigenen Cursor ausblenden und Roblox selbst
					-- über MouseBehavior entscheiden lassen (üblicherweise LockCenter zum Drehen)
					Cursor.Visible = false
					CursorOutline.Visible = false
				else
					-- Jeden Frame erzwingen, da z.B. Shiftlock (Roblox's eigener MouseLockController)
					-- MouseBehavior sonst ständig wieder auf LockCenter zurücksetzt
					if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
						UserInputService.MouseBehavior = Enum.MouseBehavior.Default
					end
					
					local mPos = UserInputService:GetMouseLocation()
					
					local timePassed = (tick() - tickStart) * 2
					local pulse = (math.sin(timePassed) + 1) / 2
					
					local colorLightLila = Color3.fromRGB(185, 110, 255)
					local colorDarkLila = Color3.fromRGB(75, 20, 120)
					
					Cursor.Color = colorLightLila:Lerp(colorDarkLila, pulse)
					
					Cursor.PointA = Vector2.new(mPos.X, mPos.Y)
					Cursor.PointB = Vector2.new(mPos.X + 16, mPos.Y + 6)
					Cursor.PointC = Vector2.new(mPos.X + 6, mPos.Y + 16)
					
					CursorOutline.PointA = Cursor.PointA
					CursorOutline.PointB = Cursor.PointB
					CursorOutline.PointC = Cursor.PointC
					
					Cursor.Visible = true
					CursorOutline.Visible = true
				end
			else
				UserInputService.MouseIconEnabled = State
				
				if wasMenuVisible then
					-- Menu wurde gerade geschlossen → ursprüngliches Mausverhalten (z.B. Shiftlock/LockCenter) einmalig wiederherstellen
					-- (danach NICHT mehr jeden Frame erzwingen, sonst kämpft es gegen die normale Kamera-/Shiftlock-Steuerung des Spiels)
					UserInputService.MouseBehavior = BehaviorState
				end
				
				Cursor.Visible = false
				CursorOutline.Visible = false
			end
			
			wasMenuVisible = menuVisible
			RenderStepped:Wait()
		end
		
		UserInputService.MouseIconEnabled = State
		UserInputService.MouseBehavior = BehaviorState
		Cursor:Remove()
		CursorOutline:Remove()
	end)
end

function CursorModule:Disable()
	self.Toggled = false
end

-- ============================================================
-- WATERMARK MODULE
-- ============================================================
local WatermarkModule = {}
WatermarkModule.WatermarkOuter = nil

function WatermarkModule:Create()
	local CoreGui = game:GetService("CoreGui")
	local RunService = game:GetService("RunService")
	local Stats = game:GetService("Stats")
	local UserInputService = game:GetService("UserInputService")
	local MarketplaceService = game:GetService("MarketplaceService")
	
	local syn = (typeof(getgenv) == "function" and getgenv().syn) or nil
	local gethui = (typeof(gethui) == "function" and gethui) or nil
	
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = generateRandomName()
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	protectAndParentGui(ScreenGui)
	
	local MainColor = (self.GetMainColor and self.GetMainColor()) or Color3.fromRGB(168, 85, 247)
	local TopGradColor = Color3.fromRGB(32, 32, 37) -- grau, noch dunkler
	local BottomGradColor = Color3.fromRGB(6, 6, 8) -- schwarz

	local WatermarkOuter = Instance.new("Frame")
	WatermarkOuter.Name = generateRandomName()
	WatermarkOuter.BorderSizePixel = 0
	WatermarkOuter.Position = UDim2.new(0, 20, 0, 150) -- weiter unten links statt oben
	WatermarkOuter.Size = UDim2.new(0, 0, 0, 20)
	WatermarkOuter.AutomaticSize = Enum.AutomaticSize.X
	WatermarkOuter.ZIndex = 200
	WatermarkOuter.Visible = true
	WatermarkOuter.Parent = ScreenGui
	addCorner(WatermarkOuter, 4)
	do
		local WatermarkOuterStroke = Instance.new("UIStroke")
		WatermarkOuterStroke.Name = generateRandomName()
		WatermarkOuterStroke.Parent = WatermarkOuter
		WatermarkOuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		WatermarkOuterStroke.Thickness = 1
		WatermarkOuterStroke.Color = Color3.new(0, 0, 0)
	end

	local WatermarkInner = Instance.new("Frame")
	WatermarkInner.Name = generateRandomName()
	WatermarkInner.BackgroundColor3 = MainColor
	WatermarkInner.BorderSizePixel = 0
	WatermarkInner.ClipsDescendants = true
	WatermarkInner.Size = UDim2.new(1, 0, 1, 0)
	WatermarkInner.ZIndex = 201
	WatermarkInner.Parent = WatermarkOuter
	addCorner(WatermarkInner, 3)
	if self.RegisterColor then
		self.RegisterColor(WatermarkInner, "BackgroundColor3")
	end

	local InnerFrame = Instance.new("Frame")
	InnerFrame.Name = generateRandomName()
	InnerFrame.BackgroundColor3 = Color3.new(1, 1, 1)
	InnerFrame.BorderSizePixel = 0
	InnerFrame.Position = UDim2.new(0, 1, 0, 1)
	InnerFrame.Size = UDim2.new(1, -2, 1, -2)
	InnerFrame.ZIndex = 202
	InnerFrame.Parent = WatermarkInner
	addCorner(InnerFrame, 3)
	
	local Gradient = Instance.new("UIGradient")
	Gradient.Name = generateRandomName()
	Gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, TopGradColor),
		ColorSequenceKeypoint.new(1, BottomGradColor),
	})
	Gradient.Rotation = 90
	Gradient.Parent = InnerFrame
	
	local WatermarkLabel = Instance.new("TextLabel")
	WatermarkLabel.Name = generateRandomName()
	WatermarkLabel.Position = UDim2.new(0, 6, 0, 0)
	WatermarkLabel.Size = UDim2.new(0, 0, 1, 0)
	WatermarkLabel.AutomaticSize = Enum.AutomaticSize.X
	WatermarkLabel.BackgroundTransparency = 1
	WatermarkLabel.TextColor3 = MainColor
	WatermarkLabel.Font = Enum.Font.Code
	WatermarkLabel.TextSize = 13
	WatermarkLabel.TextXAlignment = Enum.TextXAlignment.Left
	WatermarkLabel.ZIndex = 203
	WatermarkLabel.Text = "D3v1lHub | Loading... | FPS: 0 | Ping: 0ms"
	WatermarkLabel.Parent = InnerFrame
	if self.RegisterColor then
		self.RegisterColor(WatermarkLabel, "TextColor3")
	end
	
	local UIPadding = Instance.new("UIPadding")
	UIPadding.Name = generateRandomName()
	UIPadding.PaddingRight = UDim.new(0, 8)
	UIPadding.Parent = WatermarkLabel
	
	local gameName = "Unknown Game"
	pcall(function()
		local info = MarketplaceService:GetProductInfo(game.PlaceId)
		if info and info.Name then
			gameName = info.Name
		end
	end)
	
	local dragging, dragInput, dragStart, startPos
	WatermarkOuter.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = WatermarkOuter.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	WatermarkOuter.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			WatermarkOuter.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	
	task.spawn(function()
		while task.wait(0.5) do
			pcall(function()
				local fps = math.floor(1 / RunService.RenderStepped:Wait())
				local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
				WatermarkLabel.Text = string.format("D3v1lHub | %s | FPS: %d | Ping: %dms", gameName, fps, ping)
			end)
		end
	end)
	
	self.WatermarkOuter = WatermarkOuter
	return WatermarkOuter
end

function WatermarkModule:Hide()
	if self.WatermarkOuter then
		self.WatermarkOuter.Visible = false
	end
end

function WatermarkModule:Show()
	if self.WatermarkOuter then
		self.WatermarkOuter.Visible = true
	end
end

-- ============================================================
-- KEYBINDS LIST MODULE (listet automatisch alle vergebenen Keybinds auf, Look angelehnt an Linoria)
-- ============================================================
local KeybindsListModule = {}
KeybindsListModule.Frame = nil
KeybindsListModule.Container = nil
KeybindsListModule.Entries = {}
KeybindsListModule.MainColor = Color3.fromRGB(168, 85, 247)
KeybindsListModule.IdleColor = Color3.fromRGB(200, 200, 210)

function KeybindsListModule:Create()
	if self.Frame then
		return self.Frame
	end
	
	local UserInputService = game:GetService("UserInputService")
	
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = generateRandomName()
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	protectAndParentGui(ScreenGui)
	
	local TopGradColor = Color3.fromRGB(32, 32, 37) -- grau, noch dunkler, wie beim Watermark
	local BottomGradColor = Color3.fromRGB(6, 6, 8) -- schwarz, wie beim Watermark

	if self.GetMainColor then
		self.MainColor = self.GetMainColor()
	end

	local Outer = Instance.new("Frame")
	Outer.Name = generateRandomName()
	Outer.AnchorPoint = Vector2.new(0, 0)
	Outer.BorderSizePixel = 0
	Outer.Position = UDim2.new(0, 20, 0, 178) -- direkt unter dem Watermark (Position 20,150 + Höhe 20 + Abstand), weiter unten links
	Outer.Size = UDim2.new(0, 180, 0, 20) -- Höhe wird ab jetzt manuell verwaltet (siehe applyHeight weiter unten), AutomaticSize hat den äußeren Rahmen beim Einklappen nicht mitschrumpfen lassen
	Outer.ZIndex = 300
	Outer.Visible = false
	Outer.Parent = ScreenGui
	addCorner(Outer, 4)
	do
		local OuterStroke = Instance.new("UIStroke")
		OuterStroke.Name = generateRandomName()
		OuterStroke.Parent = Outer
		OuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		OuterStroke.Thickness = 1
		OuterStroke.Color = Color3.new(0, 0, 0)
	end

	-- Ab hier identischer Aufbau wie beim Watermark: Inner (Akzentfarbe als dünner Rahmen) -> GradientFrame (grau/pink Gradient)
	local Inner = Instance.new("Frame")
	Inner.Name = generateRandomName()
	Inner.BackgroundColor3 = self.MainColor
	Inner.BorderSizePixel = 0
	Inner.ClipsDescendants = true
	Inner.Size = UDim2.new(1, 0, 1, 0)
	Inner.ZIndex = 301
	Inner.Parent = Outer
	addCorner(Inner, 3)

	local GradientFrame = Instance.new("Frame")
	GradientFrame.Name = generateRandomName()
	GradientFrame.BackgroundColor3 = Color3.new(1, 1, 1)
	GradientFrame.BorderSizePixel = 0
	GradientFrame.Position = UDim2.new(0, 1, 0, 1)
	GradientFrame.Size = UDim2.new(1, -2, 1, -2)
	GradientFrame.ZIndex = 302
	GradientFrame.Parent = Inner
	addCorner(GradientFrame, 3)

	local Gradient = Instance.new("UIGradient")
	Gradient.Name = generateRandomName()
	Gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, TopGradColor),
		ColorSequenceKeypoint.new(1, BottomGradColor),
	})
	Gradient.Rotation = 90
	Gradient.Parent = GradientFrame

	local ColorBar = Instance.new("Frame")
	ColorBar.Name = generateRandomName()
	ColorBar.BackgroundColor3 = self.MainColor
	ColorBar.BorderSizePixel = 0
	ColorBar.Size = UDim2.new(1, 0, 0, 2)
	ColorBar.ZIndex = 303
	ColorBar.Parent = GradientFrame

	local Title = Instance.new("TextLabel")
	Title.Name = generateRandomName()
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 6, 0, 3)
	Title.Size = UDim2.new(1, -24, 0, 16)
	Title.Font = Enum.Font.Code
	Title.TextSize = 13
	Title.TextColor3 = self.MainColor
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Text = "Keybinds"
	Title.ZIndex = 303
	Title.Parent = GradientFrame

	-- Pfeil zum Ein-/Ausklappen: eingeklappt steht nur noch "Keybinds" da
	local ToggleArrow = Instance.new("TextButton")
	ToggleArrow.Name = generateRandomName()
	ToggleArrow.AnchorPoint = Vector2.new(1, 0.5)
	ToggleArrow.BackgroundTransparency = 1
	ToggleArrow.Position = UDim2.new(1, -4, 0, 11)
	ToggleArrow.Size = UDim2.new(0, 16, 0, 16)
	ToggleArrow.Font = Enum.Font.Code
	ToggleArrow.TextSize = 13
	ToggleArrow.Text = "v"
	ToggleArrow.TextColor3 = self.MainColor
	ToggleArrow.ZIndex = 303
	ToggleArrow.Parent = GradientFrame
	if self.RegisterColor then
		self.RegisterColor(self, "MainColor")
		self.RegisterColor(Inner, "BackgroundColor3")
		self.RegisterColor(ColorBar, "BackgroundColor3")
		self.RegisterColor(Title, "TextColor3")
		self.RegisterColor(ToggleArrow, "TextColor3")
	end

	-- CollapseWrapper klemmt/animiert die Höhe des Inhalts, damit das Ein-/Ausklappen sanft statt abrupt passiert
	local CollapseWrapper = Instance.new("Frame")
	CollapseWrapper.Name = generateRandomName()
	CollapseWrapper.BackgroundTransparency = 1
	CollapseWrapper.ClipsDescendants = true
	CollapseWrapper.Position = UDim2.new(0, 0, 0, 20)
	CollapseWrapper.Size = UDim2.new(1, 0, 0, 0)
	CollapseWrapper.ZIndex = 303
	CollapseWrapper.Parent = GradientFrame

	local Container = Instance.new("Frame")
	Container.Name = generateRandomName()
	Container.BackgroundTransparency = 1
	Container.Position = UDim2.new(0, 0, 0, 0)
	Container.Size = UDim2.new(1, 0, 0, 0)
	Container.AutomaticSize = Enum.AutomaticSize.Y
	Container.ZIndex = 303
	Container.Parent = CollapseWrapper

	-- Der ganze äußere Rahmen (Outer) wird jetzt selbst mitanimiert, nicht nur der Inhalt dahinter -
	-- vorher schrumpfte nur der Text weg, die Box drumherum blieb gleich groß.
	local TweenService = game:GetService("TweenService")
	local BASE_HEIGHT = 20 -- Höhe der Titelzeile allein (eingeklappter Zustand)
	local collapseTween, outerTween = nil, nil
	local collapsed = false
	local function applyHeight(height, animate)
		if collapseTween then
			collapseTween:Cancel()
		end
		if outerTween then
			outerTween:Cancel()
		end
		local wrapperTarget = UDim2.new(1, 0, 0, math.max(height - BASE_HEIGHT, 0))
		local outerTarget = UDim2.new(0, 180, 0, height)
		if animate then
			local info = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			collapseTween = TweenService:Create(CollapseWrapper, info, {Size = wrapperTarget})
			outerTween = TweenService:Create(Outer, info, {Size = outerTarget})
			collapseTween:Play()
			outerTween:Play()
		else
			CollapseWrapper.Size = wrapperTarget
			Outer.Size = outerTarget
		end
	end
	-- Höhe live an den Inhalt anpassen (neue Keybinds können jederzeit über Upsert() dazukommen),
	-- solange nicht eingeklappt ist; im eingeklappten Zustand bleibt sie bei BASE_HEIGHT
	Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if not collapsed then
			applyHeight(BASE_HEIGHT + Container.AbsoluteSize.Y, false)
		end
	end)
	task.defer(function()
		-- Startgröße auf die tatsächliche Inhaltshöhe setzen, sobald sie feststeht
		applyHeight(BASE_HEIGHT + Container.AbsoluteSize.Y, false)
	end)
	ToggleArrow.MouseButton1Click:Connect(function()
		collapsed = not collapsed
		local targetHeight = collapsed and BASE_HEIGHT or (BASE_HEIGHT + Container.AbsoluteSize.Y)
		applyHeight(targetHeight, true)
		ToggleArrow.Text = collapsed and "^" or "v"
	end)

	local ListLayout = Instance.new("UIListLayout")
	ListLayout.FillDirection = Enum.FillDirection.Vertical
	ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ListLayout.Padding = UDim.new(0, 2)
	ListLayout.Parent = Container

	local Padding = Instance.new("UIPadding")
	Padding.PaddingLeft = UDim.new(0, 6)
	Padding.PaddingBottom = UDim.new(0, 4)
	Padding.Parent = Container
	
	-- Draggable (gleiches Muster wie beim Watermark)
	local dragging, dragInput, dragStart, startPos
	Outer.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Outer.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	Outer.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			Outer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	
	self.ScreenGui = ScreenGui
	self.Frame = Outer
	self.Container = Container
	self.Entries = {}
	
	return Outer
end

function KeybindsListModule:Show()
	if not self.Frame then
		self:Create()
	end
	self.Frame.Visible = true
end

function KeybindsListModule:Hide()
	if self.Frame then
		self.Frame.Visible = false
	end
end

-- Erstellt oder aktualisiert die Zeile für einen Keybind (id = eindeutiger Flag-Name)
function KeybindsListModule:Upsert(id, name, keyText)
	if not self.Frame then
		self:Create()
	end
	
	keyText = keyText or "NONE"
	
	local entry = self.Entries[id]
	if not entry then
		local Row = Instance.new("Frame")
		Row.BackgroundTransparency = 1
		Row.Size = UDim2.new(1, -6, 0, 16)
		Row.ZIndex = 303
		Row.LayoutOrder = (function()
			local n = 0
			for _ in pairs(self.Entries) do
				n = n + 1
			end
			return n
		end)()
		Row.Parent = self.Container
		
		local Label = Instance.new("TextLabel")
		Label.BackgroundTransparency = 1
		Label.Size = UDim2.new(1, 0, 1, 0)
		Label.Font = Enum.Font.Code
		Label.TextSize = 13
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.TextColor3 = self.IdleColor
		Label.ZIndex = 304
		Label.Parent = Row
		
		entry = {
			Row = Row,
			Label = Label,
			Active = false
		}
		self.Entries[id] = entry
	end
	
	entry.Name = name
	entry.KeyText = keyText
	entry.Label.Text = string.format("[%s] %s", tostring(keyText), tostring(name))
	entry.Row.Visible = (keyText ~= nil and keyText ~= "NONE" and keyText ~= "")
	entry.Label.TextColor3 = entry.Active and self.MainColor or self.IdleColor
end

-- Hebt den Eintrag farblich hervor, solange die zugehörige Funktion aktiv ist
function KeybindsListModule:SetActive(id, active)
	local entry = self.Entries[id]
	if not entry then
		return
	end

	entry.Active = active and true or false
	entry.Label.TextColor3 = entry.Active and self.MainColor or self.IdleColor
end

-- ============================================================
-- KEYSTROKES MODULE (WASD + SPACE Tastatur-Anzeige, Look angelehnt an Watermark/Keybinds-Liste)
-- ============================================================
local KeystrokesModule = {}
KeystrokesModule.ScreenGui = nil
KeystrokesModule.Holder = nil
KeystrokesModule.Keys = {}
KeystrokesModule.Connection = nil
KeystrokesModule.JumpButton = nil
KeystrokesModule.JumpDown = false
KeystrokesModule.MainColor = Color3.fromRGB(168, 85, 247)

function KeystrokesModule:Create()
	if self.Holder then
		return self.Holder
	end

	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local plr = Players.LocalPlayer
	local pg = plr:WaitForChild("PlayerGui")

	if self.GetMainColor then
		self.MainColor = self.GetMainColor()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = generateRandomName()
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	protectAndParentGui(ScreenGui, pg)

	local TweenService = game:GetService("TweenService")

	local Holder = Instance.new("Frame")
	Holder.Name = generateRandomName()
	Holder.AnchorPoint = Vector2.new(1, 1)
	Holder.BackgroundTransparency = 1
	Holder.Active = true
	Holder.Position = UDim2.new(1, -20, 1, -20) -- unten rechts, gleicher 20px-Abstand wie zuvor unten links
	Holder.Size = UDim2.fromOffset(150, 171) -- +6px Höhe, damit die W-Taste inkl. Border oben nicht mehr an der CanvasGroup-Kante anliegt (siehe Top-Padding unten)
	Holder.ZIndex = 300
	Holder.Visible = true
	Holder.Parent = ScreenGui

	-- CanvasGroup als Inhalts-Container: erlaubt ein einziges GroupTransparency-Tween fürs Ein-/Ausblenden
	-- des gesamten Panels, statt jede Taste einzeln faden zu müssen. Deckt exakt das Holder-Rechteck ab
	-- und ist am gleichen Eck (unten rechts) verankert, damit der Scale-In/Out optisch aus der Ecke wächst.
	local Content = Instance.new("CanvasGroup")
	Content.Name = generateRandomName()
	Content.AnchorPoint = Vector2.new(1, 1)
	Content.BackgroundTransparency = 1
	Content.GroupTransparency = 0
	Content.Position = UDim2.new(1, 0, 1, 0)
	Content.Size = UDim2.new(1, 0, 1, 0)
	Content.ZIndex = 300
	Content.Parent = Holder

	local ContentScale = Instance.new("UIScale")
	ContentScale.Name = generateRandomName()
	ContentScale.Scale = 1
	ContentScale.Parent = Content

	self.Content = Content
	self.ContentScale = ContentScale

	local dragging, dragInput, dragStart, startPos
	Holder.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Holder.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	Holder.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			Holder.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	local NormalColor = Color3.fromRGB(28, 28, 32)
	local NormalTextColor = Color3.fromRGB(200, 200, 210) -- gleicher Grauton wie KeybindsListModule.IdleColor
	local ActiveTextColor = Color3.fromRGB(255, 255, 255)

	local function makeKey(name, text, size, pos)
		local outerSizeX, outerSizeY = size.X.Offset + 4, size.Y.Offset + 4

		local Outer = Instance.new("Frame")
		Outer.Name = generateRandomName()
		Outer.BackgroundColor3 = Color3.fromRGB(6, 6, 8) -- schwarz, wie beim Watermark/Keybinds-Liste
		Outer.BorderSizePixel = 0
		Outer.Size = UDim2.new(0, outerSizeX, 0, outerSizeY)
		-- mittig verankert (statt oben-links), damit der UIScale-"Pop" beim Tastendruck symmetrisch
		-- aus der Mitte wächst statt sich nach unten rechts zu verschieben
		Outer.AnchorPoint = Vector2.new(0.5, 0.5)
		Outer.Position = UDim2.new(0, pos.X.Offset - 2 + outerSizeX / 2, 0, pos.Y.Offset - 2 + outerSizeY / 2)
		Outer.ZIndex = 300
		Outer.Parent = Content
		addCorner(Outer, 4)

		local OuterScale = Instance.new("UIScale")
		OuterScale.Name = generateRandomName()
		OuterScale.Scale = 1
		OuterScale.Parent = Outer
		do
			local OuterStroke = Instance.new("UIStroke")
			OuterStroke.Name = generateRandomName()
			OuterStroke.Parent = Outer
			OuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			OuterStroke.Thickness = 1
			OuterStroke.Color = Color3.new(0, 0, 0)
		end

		local Key = Instance.new("TextLabel")
		Key.Name = name
		Key.BackgroundColor3 = NormalColor
		Key.BorderSizePixel = 0
		Key.Position = UDim2.fromOffset(2, 2)
		Key.Size = UDim2.new(1, -4, 1, -4)
		Key.Font = Enum.Font.Code
		Key.Text = text
		Key.TextColor3 = NormalTextColor
		Key.TextSize = name == "SPACE" and 13 or 20
		Key.TextXAlignment = Enum.TextXAlignment.Center
		Key.TextYAlignment = Enum.TextYAlignment.Center
		Key.ZIndex = 301
		Key.Parent = Outer
		addCorner(Key, 3)

		local KeyStroke = Instance.new("UIStroke")
		KeyStroke.Name = generateRandomName()
		KeyStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		KeyStroke.Thickness = 1
		KeyStroke.Color = self.MainColor
		KeyStroke.Transparency = 0.5 -- idle: dezent gedimmter Rand, wird beim Tastendruck weggetweent
		KeyStroke.Parent = Key
		if self.RegisterColor then
			self.RegisterColor(KeyStroke, "Color")
		end

		return {Label = Key, Stroke = KeyStroke, Scale = OuterScale, Active = false}
	end

	-- +6px Top-Padding für alle Tasten (Y-Offset), damit die W-Taste samt Border und dem 1.08x-Scale-"Pop"
	-- nicht mehr oben von der CanvasGroup (Content) abgeschnitten wird; Holder.Size.Y wurde entsprechend erhöht
	self.Keys = {
		W = makeKey("W", "W", UDim2.fromOffset(42, 42), UDim2.fromOffset(54, 6)),
		A = makeKey("A", "A", UDim2.fromOffset(42, 42), UDim2.fromOffset(4, 56)),
		S = makeKey("S", "S", UDim2.fromOffset(42, 42), UDim2.fromOffset(54, 56)),
		D = makeKey("D", "D", UDim2.fromOffset(42, 42), UDim2.fromOffset(104, 56)),
		SPACE = makeKey("SPACE", "SPACE", UDim2.fromOffset(90, 42), UDim2.fromOffset(30, 106))
	}

	function self:SetKeyState(name, on)
		local key = self.Keys[name]
		if not key then
			return
		end

		on = on and true or false
		if key.Active == on then
			return -- wird pro RenderStepped-Frame aufgerufen; ohne diese Sperre würde das Tween jeden Frame neu starten
		end
		key.Active = on

		local targetColor = on and self.MainColor or NormalColor
		local targetTextColor = on and ActiveTextColor or NormalTextColor
		local targetStrokeTransparency = on and 0 or 0.5
		-- kurze, knackige Dauer (0.08-0.12s), damit schnelles WASD-Tippen nicht "hinterherhinkt"
		local feedbackInfo = TweenInfo.new(on and 0.08 or 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		if key.ColorTween then
			key.ColorTween:Cancel()
		end
		key.ColorTween = TweenService:Create(key.Label, feedbackInfo, {BackgroundColor3 = targetColor, TextColor3 = targetTextColor})
		key.ColorTween:Play()

		if key.StrokeTween then
			key.StrokeTween:Cancel()
		end
		key.StrokeTween = TweenService:Create(key.Stroke, feedbackInfo, {Transparency = targetStrokeTransparency})
		key.StrokeTween:Play()

		-- Scale-"Pop": kurz hoch- und wieder runtertweenen. Läuft eine vorherige Pop-Animation noch,
		-- wird sie sauber abgebrochen (Tween + Completed-Connection), damit sich bei schnellem
		-- Drücken/Loslassen nichts überlagert oder hängen bleibt.
		if key.PopConnection then
			key.PopConnection:Disconnect()
			key.PopConnection = nil
		end
		if key.ScaleTween then
			key.ScaleTween:Cancel()
		end

		if on then
			local popTween = TweenService:Create(key.Scale, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.08})
			key.ScaleTween = popTween
			popTween:Play()
			key.PopConnection = popTween.Completed:Connect(function(state)
				key.PopConnection = nil
				if state == Enum.PlaybackState.Completed then
					local settleTween = TweenService:Create(key.Scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1})
					key.ScaleTween = settleTween
					settleTween:Play()
				end
			end)
		else
			local settleTween = TweenService:Create(key.Scale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1})
			key.ScaleTween = settleTween
			settleTween:Play()
		end
	end

	if self.RegisterColor then
		self.RegisterColor(self, "MainColor")
	end

	self.ScreenGui = ScreenGui
	self.Holder = Holder

	return Holder
end

-- Ermittelt die Mobile-Bewegungsrichtung (WASD-Äquivalent) relativ zur Kamera
function KeystrokesModule:GetMobileMovement()
	local Players = game:GetService("Players")
	local plr = Players.LocalPlayer
	local char = plr and plr.Character
	if not char then
		return Vector3.zero
	end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then
		return Vector3.zero
	end

	local move = hum.MoveDirection
	if move.Magnitude < 0.05 then
		return Vector3.zero
	end

	local cam = workspace.CurrentCamera
	if not cam then
		return Vector3.zero
	end

	local look = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
	local right = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)

	if look.Magnitude > 0 then
		look = look.Unit
	end

	if right.Magnitude > 0 then
		right = right.Unit
	end

	return Vector3.new(move:Dot(right), 0, move:Dot(look))
end

-- Hängt sich an den mobilen Sprung-Button (TouchGui) für das SPACE-Äquivalent auf Mobile
function KeystrokesModule:SetupJumpButton()
	if self.JumpButton then
		return
	end

	local Players = game:GetService("Players")
	local plr = Players.LocalPlayer
	local pg = plr:WaitForChild("PlayerGui")

	local touchGui = pg:FindFirstChild("TouchGui")
	if not touchGui then
		return
	end

	local controlFrame = touchGui:FindFirstChild("TouchControlFrame")
	if not controlFrame then
		return
	end

	local button = controlFrame:FindFirstChild("JumpButton")
	if not button or not button:IsA("GuiButton") then
		return
	end

	self.JumpButton = button

	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			self.JumpDown = true
		end
	end)

	button.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			self.JumpDown = false
		end
	end)
end

-- Startet die RenderStepped-Abfrage der Tasten (wird nur ausgeführt, solange das Feature sichtbar ist)
function KeystrokesModule:StartLoop()
	if self.Connection then
		return
	end

	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local mobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

	if mobile and not self.JumpButton then
		task.spawn(function()
			while self.Holder and self.Connection and not self.JumpButton do
				self:SetupJumpButton()
				task.wait(0.25)
			end
		end)
	end

	self.Connection = RunService.RenderStepped:Connect(function()
		if mobile then
			local move = self:GetMobileMovement()
			self:SetKeyState("W", move.Z > 0.35)
			self:SetKeyState("S", move.Z < -0.35)
			self:SetKeyState("A", move.X < -0.35)
			self:SetKeyState("D", move.X > 0.35)
			self:SetKeyState("SPACE", self.JumpDown)
		else
			self:SetKeyState("W", UserInputService:IsKeyDown(Enum.KeyCode.W))
			self:SetKeyState("A", UserInputService:IsKeyDown(Enum.KeyCode.A))
			self:SetKeyState("S", UserInputService:IsKeyDown(Enum.KeyCode.S))
			self:SetKeyState("D", UserInputService:IsKeyDown(Enum.KeyCode.D))
			self:SetKeyState("SPACE", UserInputService:IsKeyDown(Enum.KeyCode.Space))
		end
	end)
end

-- Stoppt die RenderStepped-Abfrage, damit im ausgeblendeten Zustand keine Performance verschwendet wird
function KeystrokesModule:StopLoop()
	if self.Connection then
		self.Connection:Disconnect()
		self.Connection = nil
	end
end

-- Liefert den Easing-Stil des Panel-Fades (angelehnt an das Ein-/Ausblenden der Notify-Popups);
-- wird erst nach Erstellung von "library" via KeystrokesModule.GetEasing gesetzt, daher der Fallback
function KeystrokesModule:GetPanelEasing()
	if self.GetEasing then
		local style, direction = self.GetEasing()
		if style and direction then
			return style, direction
		end
	end
	return Enum.EasingStyle.Quart, Enum.EasingDirection.Out
end

function KeystrokesModule:Show()
	if not self.Holder then
		self:Create()
	end

	self.HideGeneration = (self.HideGeneration or 0) + 1
	self.Holder.Visible = true

	if self.Content and self.ContentScale then
		local TweenService = game:GetService("TweenService")
		local style, direction = self:GetPanelEasing()

		if self.PanelFadeTween then
			self.PanelFadeTween:Cancel()
		end
		if self.PanelScaleTween then
			self.PanelScaleTween:Cancel()
		end

		local info = TweenInfo.new(0.25, style, direction)
		self.PanelFadeTween = TweenService:Create(self.Content, info, {GroupTransparency = 0})
		self.PanelFadeTween:Play()
		self.PanelScaleTween = TweenService:Create(self.ContentScale, info, {Scale = 1})
		self.PanelScaleTween:Play()
	end

	self:StartLoop()
end

function KeystrokesModule:Hide()
	if not self.Holder then
		return
	end

	self:StopLoop()

	if self.Content and self.ContentScale then
		local TweenService = game:GetService("TweenService")
		local style, direction = self:GetPanelEasing()

		if self.PanelFadeTween then
			self.PanelFadeTween:Cancel()
		end
		if self.PanelScaleTween then
			self.PanelScaleTween:Cancel()
		end

		local Holder = self.Holder
		local info = TweenInfo.new(0.2, style, direction)
		self.PanelFadeTween = TweenService:Create(self.Content, info, {GroupTransparency = 1})
		self.PanelFadeTween:Play()
		self.PanelScaleTween = TweenService:Create(self.ContentScale, info, {Scale = 0.85})
		self.PanelScaleTween:Play()

		-- Generation-Token (gleiches Prinzip wie makeMarquee): verhindert, dass ein verspätetes
		-- "jetzt ausblenden" den Holder wieder versteckt, falls zwischenzeitlich erneut Show() kam
		local generation = self.HideGeneration or 0
		task.delay(0.2, function()
			if self.HideGeneration == generation and Holder then
				Holder.Visible = false
			end
		end)
	else
		self.Holder.Visible = false
	end
end

local library = {
	Version = "0.66",
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
							local fold = isfolder("./D3v1lHub Lib")
							if fold then
							else
								makefolder("./D3v1lHub Lib")
							end
							fold = isfolder("./D3v1lHub Lib/Themes")
							if fold then
							else
								makefolder("./D3v1lHub Lib/Themes")
							end
							fold = isfolder("./D3v1lHub Lib/Themes/SynapseAssetsCache")
							if fold then
							else
								makefolder("./D3v1lHub Lib/Themes/SynapseAssetsCache")
							end
							if not fold or not isfile("./D3v1lHub Lib/Themes/SynapseAssetsCache/" .. codename .. ".dat") then
								local res = game:HttpGet(string.sub(image, 15))
								if res ~= nil then
									writefile("./D3v1lHub Lib/Themes/SynapseAssetsCache/" .. codename .. ".dat", res)
								end
							end
							return getsynasset(readfile("./D3v1lHub Lib/Themes/SynapseAssetsCache/" .. codename .. ".dat"))
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
					elseif nfo.AssetTypeId == 13 then
						local decal = game:GetObjects("rbxassetid://" .. image)[1]
						image = "rbxassetid://" .. ((decal and decal.Texture) or "0"):match("%d+$")
						decal = (decal and decal:Destroy() and nil) or nil
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
-- Watermark & Keybinds-Liste wurden vor "library" definiert und können dessen Farb-System
-- daher nicht direkt referenzieren; wir reichen ihnen hier nachträglich Zugriff durch.
WatermarkModule.GetMainColor = function()
	return library.colors.main
end
WatermarkModule.RegisterColor = function(inst, prop)
	colored[1 + #colored] = {inst, prop, "main"}
end
KeybindsListModule.GetMainColor = WatermarkModule.GetMainColor
KeybindsListModule.RegisterColor = WatermarkModule.RegisterColor
KeystrokesModule.GetMainColor = WatermarkModule.GetMainColor
KeystrokesModule.RegisterColor = WatermarkModule.RegisterColor
KeystrokesModule.GetEasing = function()
	return library.configuration.easingStyle, library.configuration.easingDirection
end
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
local function applySearch(query)
	query = tostring(query or "")
	local lowerQuery = query:lower():gsub("^%s+", ""):gsub("%s+$", "")
	local searching = lowerQuery ~= ""

	if not searching then
		for _, obj in next, elements do
			if obj and obj.Container then
				obj.Container.Visible = true
			end
		end
	else
		-- Erst alles in dieser Suchrunde verstecken ...
		for _, obj in next, elements do
			if obj and obj.Container then
				obj.Container.Visible = false
			end
		end
		-- ... dann jedes passende Element (und damit seinen Container) wieder einblenden.
		-- Zwei Elemente können sich einen Container teilen (z.B. mehrere AddButton-Einträge
		-- in einer Reihe) - deshalb erst alles verstecken und danach nur Treffer zeigen.
		for _, obj in next, elements do
			if obj and obj.Container then
				local name = tostring(obj.DisplayName or (obj.Options and obj.Options.Name) or obj.Name or "")
				if name:lower():find(lowerQuery, 1, true) then
					obj.Container.Visible = true
				end
			end
		end
	end

	for _, entry in next, library.__AllSections do
		if entry.Frame and entry.Holder then
			local showSection = true
			if searching then
				showSection = false
				for _, child in next, entry.Holder:GetChildren() do
					if child:IsA("GuiObject") and child.Visible then
						showSection = true
						break
					end
				end
			end
			entry.Frame.Visible = showSection
			if entry.Functions and entry.Functions.Update then
				pcall(entry.Functions.Update, entry.Functions)
			end
		end
	end
end
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
	local bigv2 = Vector2.one * math.huge
	function textToSize(object)
		return textService:GetTextSize(object.Text, object.TextSize, object.Font, bigv2)
	end
end
library.subs.textToSize = textToSize
-- ============================================================
-- Linoria-Feature-Port: Tooltip-System (AddToolTip)
-- Zeigt eine kleine schwebende Box neben dem Mauszeiger, sobald man
-- über HoverInstance hovert. DisabledInfoStr wird stattdessen gezeigt,
-- wenn TooltipTable.Disabled == true ist (z.B. bei gesperrten/deaktivierten Elementen).
-- ============================================================
local Tooltips = {}
function library:AddToolTip(InfoStr, DisabledInfoStr, HoverInstance)
	InfoStr = (typeof(InfoStr) == "string" and InfoStr ~= "" and InfoStr) or nil
	DisabledInfoStr = (typeof(DisabledInfoStr) == "string" and DisabledInfoStr ~= "" and DisabledInfoStr) or nil
	if not InfoStr and not DisabledInfoStr then
		return nil
	end
	if not HoverInstance then
		return nil
	end

	local TooltipOuter = Instance_new("Frame")
	TooltipOuter.Name = generateRandomName()
	TooltipOuter.BackgroundColor3 = library.colors.background
	colored[1 + #colored] = {TooltipOuter, "BackgroundColor3", "background"}
	TooltipOuter.BorderSizePixel = 0
	TooltipOuter.ZIndex = 1000
	TooltipOuter.Visible = false
	TooltipOuter.Parent = MainScreenGui
	addCorner(TooltipOuter, 4)
	do
		local TooltipOuterStroke = Instance_new("UIStroke")
		TooltipOuterStroke.Name = generateRandomName()
		TooltipOuterStroke.Parent = TooltipOuter
		TooltipOuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		TooltipOuterStroke.Thickness = 1
		TooltipOuterStroke.Color = library.colors.outerBorder
		colored[1 + #colored] = {TooltipOuterStroke, "Color", "outerBorder"}
	end

	local TooltipLabel = Instance_new("TextLabel")
	TooltipLabel.Name = generateRandomName()
	TooltipLabel.Parent = TooltipOuter
	TooltipLabel.BackgroundTransparency = 1
	TooltipLabel.Position = UDim2.fromOffset(6, 3)
	TooltipLabel.Font = Enum.Font.Code
	TooltipLabel.Text = InfoStr or DisabledInfoStr or ""
	TooltipLabel.TextColor3 = library.colors.elementText
	colored[1 + #colored] = {TooltipLabel, "TextColor3", "elementText"}
	TooltipLabel.TextSize = 14
	TooltipLabel.ZIndex = TooltipOuter.ZIndex + 1
	TooltipLabel.TextXAlignment = Enum.TextXAlignment.Left

	local TooltipTable = {
		Instance = TooltipOuter,
		Disabled = false,
		Signals = {}
	}
	local IsHovering = false

	local function UpdateText(Text)
		if Text == nil then
			return
		end
		TooltipLabel.Text = Text
		local size = textToSize(TooltipLabel)
		TooltipOuter.Size = UDim2.fromOffset(size.X + 12, size.Y + 6)
		TooltipLabel.Size = UDim2.fromOffset(size.X, size.Y)
	end

	local function GiveSignal(Connection)
		if Connection then
			TooltipTable.Signals[1 + #TooltipTable.Signals] = Connection
		end
		return Connection
	end

	UpdateText(InfoStr or DisabledInfoStr)

	GiveSignal(HoverInstance.MouseEnter:Connect(function()
		if not TooltipTable.Disabled then
			if not InfoStr then
				TooltipOuter.Visible = false
				return
			end
			if TooltipLabel.Text ~= InfoStr then
				UpdateText(InfoStr)
			end
		else
			if not DisabledInfoStr then
				TooltipOuter.Visible = false
				return
			end
			if TooltipLabel.Text ~= DisabledInfoStr then
				UpdateText(DisabledInfoStr)
			end
		end

		IsHovering = true
		TooltipOuter.Position = UDim2.fromOffset(mouse.X + 15, mouse.Y + 12)
		TooltipOuter.Visible = true

		while IsHovering do
			if TooltipTable.Disabled and not DisabledInfoStr then
				break
			end
			runService.Heartbeat:Wait()
			if not IsHovering then
				break
			end
			TooltipOuter.Position = UDim2.fromOffset(mouse.X + 15, mouse.Y + 12)
		end

		IsHovering = false
		TooltipOuter.Visible = false
	end))

	GiveSignal(HoverInstance.MouseLeave:Connect(function()
		IsHovering = false
		TooltipOuter.Visible = false
	end))

	function TooltipTable:Destroy()
		for Idx = #TooltipTable.Signals, 1, -1 do
			local Connection = table.remove(TooltipTable.Signals, Idx)
			if Connection and Connection.Connected then
				Connection:Disconnect()
			end
		end
		if TooltipOuter then
			TooltipOuter:Destroy()
		end
	end

	Tooltips[1 + #Tooltips] = TooltipTable
	return TooltipTable
end
library.subs.AddToolTip = library.AddToolTip
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
	local onAccept = options.OnAccept or options.Callback
	local onDecline = options.OnDecline
	local soundService = game:GetService("SoundService")
	local backgroundTransparency = options.BackgroundTransparency or 0.3
	local backgroundAsset = options.BackgroundAsset -- optional, kein Default-Fremdasset
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

	local function addTextStroke(textLabel)
		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Thickness = 1.5
		stroke.Parent = textLabel
	end

	local function applyBackground(parentFrame)
		if backgroundAsset and backgroundAsset ~= "" then
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
			if onAccept then
				task.spawn(onAccept)
			end
		end)
	end

	YesBtn.MouseButton1Click:Connect(function()
		startLoadingSequence()
	end)

	NoBtn.MouseButton1Click:Connect(function()
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
local function Color3FromHex(hex)
	hex = hex:gsub("#", ""):upper():gsub("0X", "")
	return Color3.fromRGB(tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16))
end
library.subs.Color3FromHex = Color3FromHex
local floor = math.floor
local function Color3ToHex(color)
	local r, g, b = string.format("%X", floor(color.R * 255)), string.format("%X", floor(color.G * 255)), string.format("%X", floor(color.B * 255))
	if #r < 2 then
		r = "0" .. r
	end
	if #g < 2 then
		g = "0" .. g
	end
	if #b < 2 then
		b = "0" .. b
	end
	return string.format("%s%s%s", r, g, b)
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
function library:CreateWindow(options, ...)
	options = (options and type(options) == "string" and resolvevararg("Window", options, ...)) or options
	local homepage = nil
	local windowoptions = options
	local windowName = options.Name or "Unnamed Window"
	options.Name = windowName
	if windowName and #windowName > 0 and library.WorkspaceName == "D3v1lHub Lib" then
		library.WorkspaceName = convertfilename(windowName, "D3v1lHub Lib")
	end
	-- Anti-Double-Loading: falls die Library (z.B. durch erneutes Ausführen des Skripts) bereits einmal
	-- geladen wurde, wird die alte Instanz sauber über ihre eigene Unload-Logik entfernt, bevor eine neue entsteht
	if typeof(getgenv) == "function" then
		local genv = getgenv()
		if genv.D3v1lHub_ActiveTerminate then
			pcall(genv.D3v1lHub_ActiveTerminate)
			genv.D3v1lHub_ActiveTerminate = nil
		end
	end
	local d3v1lLibrary = Instance_new("ScreenGui")
	library.MainScreenGui, MainScreenGui = d3v1lLibrary, d3v1lLibrary
	local main = Instance_new("Frame")
	local mainBorder = Instance_new("Frame")
	local tabSlider = Instance_new("Frame")
	local innerMain = Instance_new("Frame")
	local innerMainBorder = Instance_new("Frame")
	local innerBackdrop = Instance_new("ImageLabel")
	local innerMainHolder = Instance_new("Frame")
	local tabsHolder = Instance_new("ImageLabel")
	local tabHolderList = Instance_new("UIListLayout")
	local tabHolderPadding = Instance_new("UIPadding")
	local headline = Instance_new("TextLabel")
	local splitter = Instance_new("TextLabel")
	local titleBar = Instance_new("ImageLabel")
	local titleBarList = Instance_new("UIListLayout")
	local titleBarPadding = Instance_new("UIPadding")
	local unloadButton = Instance_new("TextButton")
	local gameNameLabel = Instance_new("TextLabel")
	local splitter2 = Instance_new("TextLabel")
	local execNameLabel = Instance_new("TextLabel")
	local submenuOpen = nil
	-- Fuer das automatische Schliessen von offenen Dropdowns/Colorpickern bei Klick ausserhalb
	-- bzw. beim Schliessen des ganzen Menüs: wird von jedem Dropdown-artigen Element beim
	-- Oeffnen befuellt (Close-Funktion + Liste der Frames, bei denen ein Klick NICHT schliessen soll)
	local submenuCloseFn = nil
	local submenuOpenFrames = nil
	library.globals["__Window" .. options.Name] = {
		submenuOpen = submenuOpen
	}
	d3v1lLibrary.Name = generateRandomName()
	protectAndParentGui(d3v1lLibrary, library.gui_parent)
	d3v1lLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	d3v1lLibrary.DisplayOrder = 10
	d3v1lLibrary.ResetOnSpawn = false
	main.Name = generateRandomName()
	main.Parent = d3v1lLibrary
	CursorModule.MenuFrame = main -- damit CursorModule den echten Sichtbarkeits-Status des Menüs kennt
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.BackgroundColor3 = library.colors.background
	colored[1 + #colored] = {main, "BackgroundColor3", "background"}
	main.BorderSizePixel = 0
	main.ClipsDescendants = true -- verhindert, dass Inhalte über die abgerundeten Ecken hinausragen
	main.Position = UDim2.fromScale(0.5, 0.5)
	main.Size = UDim2.fromOffset(480, 550) -- Breite wieder etwas größer, damit die Groupboxen mehr Platz haben (Höhe bleibt kompakt)
	addCorner(main, 8)
	do
		local mainStroke = Instance_new("UIStroke")
		mainStroke.Name = generateRandomName()
		mainStroke.Parent = main
		mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		mainStroke.Thickness = 1
		mainStroke.Color = library.colors.outerBorder
		colored[1 + #colored] = {mainStroke, "Color", "outerBorder"}
	end
	makeDraggable(main, main)
	mainBorder.Name = generateRandomName()
	mainBorder.Parent = main
	mainBorder.AnchorPoint = Vector2.new(0.5, 0.5)
	mainBorder.BackgroundColor3 = library.colors.background
	colored[1 + #colored] = {mainBorder, "BackgroundColor3", "background"}
	mainBorder.BorderSizePixel = 0
	mainBorder.Position = UDim2.fromScale(0.5, 0.5)
	mainBorder.Size = UDim2.fromScale(1, 1)
	addCorner(mainBorder, 8)
	do
		local mainBorderStroke = Instance_new("UIStroke")
		mainBorderStroke.Name = generateRandomName()
		mainBorderStroke.Parent = mainBorder
		mainBorderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		mainBorderStroke.Thickness = 1
		mainBorderStroke.Color = library.colors.innerBorder
		colored[1 + #colored] = {mainBorderStroke, "Color", "innerBorder"}
	end
	innerMain.Name = generateRandomName()
	innerMain.Parent = main
	innerMain.AnchorPoint = Vector2.new(0.5, 0.5)
	innerMain.BackgroundColor3 = library.colors.background
	colored[1 + #colored] = {innerMain, "BackgroundColor3", "background"}
	innerMain.BorderSizePixel = 0
	innerMain.ClipsDescendants = true -- Groupboxen/Hintergrundbild etc. bleiben innerhalb der runden Ecken
	innerMain.Position = UDim2.fromScale(0.5, 0.5)
	innerMain.Size = UDim2.new(1, -14, 1, -14)
	addCorner(innerMain, 6)
	do
		local innerMainStroke = Instance_new("UIStroke")
		innerMainStroke.Name = generateRandomName()
		innerMainStroke.Parent = innerMain
		innerMainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		innerMainStroke.Thickness = 1
		innerMainStroke.Color = library.colors.outerBorder
		colored[1 + #colored] = {innerMainStroke, "Color", "outerBorder"}
	end
	innerMainBorder.Name = generateRandomName()
	innerMainBorder.Parent = innerMain
	innerMainBorder.AnchorPoint = Vector2.new(0.5, 0.5)
	innerMainBorder.BackgroundColor3 = library.colors.background
	colored[1 + #colored] = {innerMainBorder, "BackgroundColor3", "background"}
	innerMainBorder.BorderSizePixel = 0
	innerMainBorder.Position = UDim2.fromScale(0.5, 0.5)
	innerMainBorder.Size = UDim2.fromScale(1, 1)
	addCorner(innerMainBorder, 6)
	do
		local innerMainBorderStroke = Instance_new("UIStroke")
		innerMainBorderStroke.Name = generateRandomName()
		innerMainBorderStroke.Parent = innerMainBorder
		innerMainBorderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		innerMainBorderStroke.Thickness = 1
		innerMainBorderStroke.Color = library.colors.innerBorder
		colored[1 + #colored] = {innerMainBorderStroke, "Color", "innerBorder"}
	end
	innerMainHolder.Name = generateRandomName()
	innerMainHolder.Parent = innerMain
	innerMainHolder.BackgroundColor3 = Color3.new(1, 1, 1)
	innerMainHolder.BackgroundTransparency = 1
	innerMainHolder.Position = UDim2.new(0, 8, 0, 50)
	innerMainHolder.Size = UDim2.new(1, -16, 1, -50) -- gleicher Abstand (8px) links UND rechts, Groupboxen sitzen näher am Fensterrand
	innerBackdrop.Name = generateRandomName()
	innerBackdrop.Parent = innerMainHolder
	innerBackdrop.BackgroundColor3 = Color3.new(1, 1, 1)
	innerBackdrop.BackgroundTransparency = 1
	innerBackdrop.Size = UDim2.fromScale(1, 1)
	innerBackdrop.ZIndex = -1
	innerBackdrop.Visible = library_flags["__Designer.Background.UseBackgroundImage"] and true
	innerBackdrop.ImageColor3 = library_flags["__Designer.Background.ImageColor"] or Color3.new(1, 1, 1)
	innerBackdrop.ImageTransparency = (library_flags["__Designer.Background.ImageTransparency"] or 95) / 100
	innerBackdrop.Image = resolveid(library_flags["__Designer.Background.ImageAssetID"], "__Designer.Background.ImageAssetID") or ""
	library.Backdrop = innerBackdrop
	-- Einheitliche Unload-Logik (wird von der Top-Bar UND vom Designer "Terminate GUI"-Button genutzt)
	local function terminateGui()
		if CursorModule then
			CursorModule:Disable()
			CursorModule.Toggled = false
		end
		if WatermarkModule and WatermarkModule.WatermarkOuter then
			pcall(function()
				WatermarkModule.WatermarkOuter:Destroy()
				WatermarkModule.WatermarkOuter = nil
			end)
		end
		if KeybindsListModule and KeybindsListModule.ScreenGui then
			pcall(function()
				KeybindsListModule.ScreenGui:Destroy()
				KeybindsListModule.Frame = nil
				KeybindsListModule.ScreenGui = nil
			end)
		end
		if KeystrokesModule and KeystrokesModule.ScreenGui then
			pcall(function()
				KeystrokesModule:StopLoop()
				KeystrokesModule.ScreenGui:Destroy()
				KeystrokesModule.Holder = nil
				KeystrokesModule.ScreenGui = nil
				KeystrokesModule.JumpButton = nil
			end)
		end
		if library.MainScreenGui then
			pcall(function()
				library.MainScreenGui:Destroy()
				library.MainScreenGui = nil
				MainScreenGui = nil
			end)
		end
		library.unload()
	end
	-- Anti-Double-Loading: diese Instanz als "aktiv" registrieren, damit ein erneutes Laden des Skripts
	-- sie über terminateGui() sauber entfernen kann, bevor die neue GUI aufgebaut wird
	if typeof(getgenv) == "function" then
		getgenv().D3v1lHub_ActiveTerminate = terminateGui
	end
	-- Neue obere Leiste: Unload-Button | D3v1lHub | Spiel | Executor -------- Search
	local MarketplaceService = game:GetService("MarketplaceService")
	local currentGameName = "Unknown Game"
	pcall(function()
		local info = MarketplaceService:GetProductInfo(game.PlaceId)
		if info and info.Name then
			currentGameName = info.Name
		end
	end)
	local currentExecName = "Unknown"
	pcall(function()
		if typeof(identifyexecutor) == "function" then
			local n = identifyexecutor()
			if n then
				currentExecName = tostring(n)
			end
		elseif typeof(getexecutorname) == "function" then
			local n = getexecutorname()
			if n then
				currentExecName = tostring(n)
			end
		elseif typeof(getgenv) == "function" and getgenv().syn then
			currentExecName = "Synapse"
		end
	end)
	titleBar.Name = generateRandomName()
	titleBar.Parent = innerMain
	titleBar.BackgroundColor3 = library.colors.sectionBackground -- bewusst anders als die Tabs-Leiste (kein Gradient-Look), damit beide Leisten sich unterscheiden
	colored[1 + #colored] = {titleBar, "BackgroundColor3", "sectionBackground"}
	titleBar.BorderSizePixel = 0
	titleBar.Position = UDim2.fromOffset(1, 1)
	titleBar.Size = UDim2.new(1, -2, 0, 23)
	titleBar.Image = "rbxassetid://2454009026"
	addCorner(titleBar, 6)
	titleBar.ImageColor3 = library.colors.sectionBackground
	colored[1 + #colored] = {titleBar, "ImageColor3", "sectionBackground"}
	titleBarList.Name = generateRandomName()
	titleBarList.Parent = titleBar
	titleBarList.FillDirection = Enum.FillDirection.Horizontal
	titleBarList.SortOrder = Enum.SortOrder.LayoutOrder
	titleBarList.VerticalAlignment = Enum.VerticalAlignment.Center
	titleBarList.Padding = UDim:new(5)
	titleBarPadding.Name = generateRandomName()
	titleBarPadding.Parent = titleBar
	titleBarPadding.PaddingLeft = UDim:new(6)
	unloadButton.Name = generateRandomName()
	unloadButton.Parent = titleBar
	unloadButton.LayoutOrder = 1
	unloadButton.BackgroundColor3 = library.colors.topGradient
	colored[1 + #colored] = {unloadButton, "BackgroundColor3", "topGradient"}
	unloadButton.BorderSizePixel = 0
	unloadButton.Size = UDim2.fromOffset(16, 16)
	addCorner(unloadButton, 3)
	do
		local unloadButtonStroke = Instance_new("UIStroke")
		unloadButtonStroke.Name = generateRandomName()
		unloadButtonStroke.Parent = unloadButton
		unloadButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		unloadButtonStroke.Thickness = 1
		unloadButtonStroke.Color = library.colors.elementBorder
		colored[1 + #colored] = {unloadButtonStroke, "Color", "elementBorder"}
	end
	unloadButton.Font = Enum.Font.Code
	unloadButton.Text = "-"
	unloadButton.TextColor3 = library.colors.main
	colored[1 + #colored] = {unloadButton, "TextColor3", "main"}
	unloadButton.TextSize = 14
	library.signals[1 + #library.signals] = unloadButton.MouseButton1Click:Connect(function()
		pcall(terminateGui)
	end)
	headline.Name = generateRandomName()
	headline.Parent = titleBar
	headline.BackgroundColor3 = Color3.new(1, 1, 1)
	headline.BackgroundTransparency = 1
	headline.LayoutOrder = 2
	headline.Font = Enum.Font.Code
	headline.Text = (windowName and tostring(windowName)) or "???"
	headline.TextColor3 = library.colors.main
	colored[1 + #colored] = {headline, "TextColor3", "main"}
	headline.TextSize = 15 -- etwas größer als der Tab-Text, damit sich Titel- und Tableiste unterscheiden
	headline.TextStrokeColor3 = library.colors.outerBorder
	colored[1 + #colored] = {headline, "TextStrokeColor3", "outerBorder"}
	headline.TextStrokeTransparency = 0.75
	headline.Size = UDim2:new(textToSize(headline).X + 4, 1)
	splitter.Name = generateRandomName()
	splitter.Parent = titleBar
	splitter.BackgroundColor3 = Color3.new(1, 1, 1)
	splitter.BackgroundTransparency = 1
	splitter.LayoutOrder = 3
	splitter.Size = UDim2:new(6, 1)
	splitter.Font = Enum.Font.Code
	splitter.Text = "|"
	splitter.TextColor3 = library.colors.tabText
	colored[1 + #colored] = {splitter, "TextColor3", "tabText"}
	splitter.TextSize = 14
	splitter.TextStrokeColor3 = library.colors.tabText
	colored[1 + #colored] = {splitter, "TextStrokeColor3", "tabText"}
	splitter.TextStrokeTransparency = 0.75
	gameNameLabel.Name = generateRandomName()
	gameNameLabel.Parent = titleBar
	gameNameLabel.BackgroundColor3 = Color3.new(1, 1, 1)
	gameNameLabel.BackgroundTransparency = 1
	gameNameLabel.LayoutOrder = 4
	gameNameLabel.Font = Enum.Font.Code
	gameNameLabel.Text = currentGameName
	gameNameLabel.TextColor3 = library.colors.otherElementText
	colored[1 + #colored] = {gameNameLabel, "TextColor3", "otherElementText"}
	gameNameLabel.TextSize = 14
	gameNameLabel.TextStrokeColor3 = library.colors.outerBorder
	colored[1 + #colored] = {gameNameLabel, "TextStrokeColor3", "outerBorder"}
	gameNameLabel.TextStrokeTransparency = 0.75
	gameNameLabel.Size = UDim2:new(math.min(textToSize(gameNameLabel).X + 4, 90), 1)
	makeMarquee(gameNameLabel) -- falls der Spielname zu lang ist, läuft er als Laufschrift statt die Titelleiste zu sprengen
	splitter2.Name = generateRandomName()
	splitter2.Parent = titleBar
	splitter2.BackgroundColor3 = Color3.new(1, 1, 1)
	splitter2.BackgroundTransparency = 1
	splitter2.LayoutOrder = 5
	splitter2.Size = UDim2:new(6, 1)
	splitter2.Font = Enum.Font.Code
	splitter2.Text = "|"
	splitter2.TextColor3 = library.colors.tabText
	colored[1 + #colored] = {splitter2, "TextColor3", "tabText"}
	splitter2.TextSize = 14
	splitter2.TextStrokeColor3 = library.colors.tabText
	colored[1 + #colored] = {splitter2, "TextStrokeColor3", "tabText"}
	splitter2.TextStrokeTransparency = 0.75
	execNameLabel.Name = generateRandomName()
	execNameLabel.Parent = titleBar
	execNameLabel.BackgroundColor3 = Color3.new(1, 1, 1)
	execNameLabel.BackgroundTransparency = 1
	execNameLabel.LayoutOrder = 6
	execNameLabel.Font = Enum.Font.Code
	execNameLabel.Text = currentExecName
	execNameLabel.TextColor3 = library.colors.otherElementText
	colored[1 + #colored] = {execNameLabel, "TextColor3", "otherElementText"}
	execNameLabel.TextSize = 14
	execNameLabel.TextStrokeColor3 = library.colors.outerBorder
	colored[1 + #colored] = {execNameLabel, "TextStrokeColor3", "outerBorder"}
	execNameLabel.TextStrokeTransparency = 0.75
	execNameLabel.Size = UDim2:new(math.min(textToSize(execNameLabel).X + 4, 90), 1)
	makeMarquee(execNameLabel) -- falls der Executor-Name zu lang ist, läuft er als Laufschrift statt die Titelleiste zu sprengen
	tabsHolder.Name = generateRandomName()
	tabsHolder.Parent = innerMain
	tabsHolder.BackgroundColor3 = library.colors.topGradient
	colored[1 + #colored] = {tabsHolder, "BackgroundColor3", "topGradient"}
	tabsHolder.BorderSizePixel = 0
	tabsHolder.Position = UDim2.fromOffset(1, 26)
	tabsHolder.Size = UDim2.new(1, -2, 0, 23)
	tabsHolder.Image = "rbxassetid://2454009026"
	addCorner(tabsHolder, 6)
	tabsHolder.ImageColor3 = library.colors.bottomGradient
	colored[1 + #colored] = {tabsHolder, "ImageColor3", "bottomGradient"}
	tabHolderList.Name = generateRandomName()
	tabHolderList.Parent = tabsHolder
	tabHolderList.FillDirection = Enum.FillDirection.Horizontal
	tabHolderList.SortOrder = Enum.SortOrder.LayoutOrder
	tabHolderList.VerticalAlignment = Enum.VerticalAlignment.Center
	tabHolderList.Padding = UDim:new(9)
	tabHolderPadding.Name = generateRandomName()
	tabHolderPadding.Parent = tabsHolder
	tabHolderPadding.PaddingLeft = UDim:new(7)
	-- Search-Box jetzt ganz rechts in der NEUEN oberen Leiste (nicht mehr unten bei den Tabs)
	local searchBoxHolder = Instance_new("ImageLabel")
	local searchBoxInner = Instance_new("ImageLabel")
	local searchBoxInput = Instance_new("TextBox")
	searchBoxHolder.Name = generateRandomName()
	searchBoxHolder.Parent = innerMain -- NICHT titleBar! Sonst reißt dessen UIListLayout die Box mit in den Flow (Bug: landete ganz links)
	searchBoxHolder.Active = true
	searchBoxHolder.AnchorPoint = Vector2.new(1, 0)
	searchBoxHolder.BackgroundColor3 = library.colors.topGradient
	colored[1 + #colored] = {searchBoxHolder, "BackgroundColor3", "topGradient"}
	searchBoxHolder.BorderSizePixel = 0
	do
		local searchBoxHolderStroke = Instance_new("UIStroke")
		searchBoxHolderStroke.Name = generateRandomName()
		searchBoxHolderStroke.Parent = searchBoxHolder
		searchBoxHolderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		searchBoxHolderStroke.Thickness = 1
		searchBoxHolderStroke.Color = library.colors.elementBorder
		colored[1 + #colored] = {searchBoxHolderStroke, "Color", "elementBorder"}
	end
	searchBoxHolder.Position = UDim2.new(1, -4, 0, 3) -- oben rechts, mittig in der titleBar-Zeile (die bei y=1..24 liegt)
	searchBoxHolder.Selectable = true
	searchBoxHolder.Size = UDim2.fromOffset(110, 17)
	searchBoxHolder.ZIndex = 5
	searchBoxHolder.Image = "rbxassetid://2454009026"
	addCorner(searchBoxHolder, 4)
	searchBoxHolder.ImageColor3 = library.colors.bottomGradient
	colored[1 + #colored] = {searchBoxHolder, "ImageColor3", "bottomGradient"}
	searchBoxInner.Name = generateRandomName()
	searchBoxInner.Parent = searchBoxHolder
	searchBoxInner.Active = true
	searchBoxInner.AnchorPoint = Vector2.new(0.5, 0.5)
	searchBoxInner.BackgroundColor3 = library.colors.topGradient
	colored[1 + #colored] = {searchBoxInner, "BackgroundColor3", "topGradient"}
	searchBoxInner.BorderSizePixel = 0
	do
		local searchBoxInnerStroke = Instance_new("UIStroke")
		searchBoxInnerStroke.Name = generateRandomName()
		searchBoxInnerStroke.Parent = searchBoxInner
		searchBoxInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		searchBoxInnerStroke.Thickness = 1
		searchBoxInnerStroke.Color = library.colors.elementBorder
		colored[1 + #colored] = {searchBoxInnerStroke, "Color", "elementBorder"}
	end
	searchBoxInner.Position = UDim2.fromScale(0.5, 0.5)
	searchBoxInner.Selectable = true
	searchBoxInner.Size = UDim2.new(1, -4, 1, -4)
	searchBoxInner.ZIndex = 5
	searchBoxInner.Image = "rbxassetid://2454009026"
	addCorner(searchBoxInner, 4)
	searchBoxInner.ImageColor3 = library.colors.bottomGradient
	colored[1 + #colored] = {searchBoxInner, "ImageColor3", "bottomGradient"}
	searchBoxInput.Name = generateRandomName()
	searchBoxInput.Parent = searchBoxInner
	searchBoxInput.BackgroundColor3 = Color3.new(1, 1, 1)
	searchBoxInput.BackgroundTransparency = 1
	searchBoxInput.ClearTextOnFocus = false
	searchBoxInput.Position = UDim2.fromOffset(4, 0)
	searchBoxInput.Size = UDim2.new(1, -6, 1, 0)
	searchBoxInput.ZIndex = 6
	searchBoxInput.Font = Enum.Font.Code
	searchBoxInput.LineHeight = 1.15
	searchBoxInput.Text = ""
	searchBoxInput.PlaceholderText = "Search"
	searchBoxInput.TextColor3 = library.colors.otherElementText
	colored[1 + #colored] = {searchBoxInput, "TextColor3", "otherElementText"}
	searchBoxInput.TextSize = 13
	searchBoxInput.TextXAlignment = Enum.TextXAlignment.Left
	library.signals[1 + #library.signals] = searchBoxInput:GetPropertyChangedSignal("Text"):Connect(function()
		applySearch(searchBoxInput.Text)
	end)
	tabSlider.Name = generateRandomName()
	tabSlider.Parent = main
	tabSlider.BackgroundColor3 = library.colors.main
	colored[1 + #colored] = {tabSlider, "BackgroundColor3", "main"}
	tabSlider.BorderSizePixel = 0
	tabSlider.Position = UDim2.fromOffset(100, 30)
	tabSlider.Size = UDim2:fromOffset(1)
	tabSlider.Visible = false
	local IgnoreCoreInputs = nil
	do
		local os_clock = os.clock
		library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(keyCode)
			if IgnoreCoreInputs or userInputService:GetFocusedTextBox() then
				return
			elseif keyCode.KeyCode == library.configuration.hideKeybind then
				if not lasthidebing or ((os_clock() - lasthidebing) > 12) then
					main.Visible = not main.Visible
				end
				lasthidebing = nil
			end
		end)
	end
	local windowFunctions = {
		tabCount = 0,
		selected = {},
		Flags = elements
	}
	library.globals["__Window" .. windowName].windowFunctions = windowFunctions
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
	-- ✅ Offene Dropdowns/Colorpicker/Searchboxen automatisch schließen:
	-- erstens wenn man irgendwo außerhalb von ihnen klickt,
	-- zweitens wenn das ganze Menü unsichtbar wird/geschlossen wird
	local function closeOpenSubmenu()
		if submenuCloseFn then
			local fn = submenuCloseFn
			submenuCloseFn, submenuOpenFrames = nil, nil
			pcall(fn)
		end
	end
	-- ✅ Es darf immer nur ein Dropdown/Colorpicker/Searchbox gleichzeitig offen sein:
	-- wird ein anderes als das aktuell offene geöffnet, wird das alte vorher automatisch geschlossen
	local function closeOtherSubmenu(selfRef)
		if (submenuOpen ~= nil) and (submenuOpen ~= selfRef) then
			closeOpenSubmenu()
		end
	end
	library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(input, processed)
		if not submenuCloseFn then
			return
		end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.MouseButton2 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		-- ✅ GetMouseLocation() liefert die ROHE Bildschirmposition (inkl. oberer Roblox-Topbar-Inset),
		-- während AbsolutePosition/AbsoluteSize der Dropdown-Frames (deren ScreenGui IgnoreGuiInset
		-- NICHT gesetzt hat) relativ zum Bereich UNTER der Topbar gemessen werden. Ohne Korrektur war
		-- die Mausposition dadurch um die Inset-Höhe (~36px) verschoben - unauffällig bei den obersten
		-- Einträgen, aber je weiter unten im Dropdown man geklickt hat (3., 4. Eintrag usw.), desto öfter
		-- hat der Klick dadurch fälschlich als "außerhalb" gegolten und das Dropdown sofort wieder zu.
		local pos = userInputService:GetMouseLocation() - game:GetService("GuiService"):GetGuiInset()
		local inside = false
		if submenuOpenFrames then
			for _, fr in ipairs(submenuOpenFrames) do
				if fr and fr.Parent and fr.Visible then
					local ap, asz = fr.AbsolutePosition, fr.AbsoluteSize
					if (pos.X >= ap.X) and (pos.X <= ap.X + asz.X) and (pos.Y >= ap.Y) and (pos.Y <= ap.Y + asz.Y) then
						inside = true
						break
					end
				end
			end
		end
		if not inside then
			task.defer(closeOpenSubmenu)
		end
	end)
	library.signals[1 + #library.signals] = main:GetPropertyChangedSignal("Visible"):Connect(function()
		if not main.Visible then
			closeOpenSubmenu()
		end
	end)
	function windowFunctions:MoveTabSlider(tabObject)
		spawn(function()
			tabSlider.Visible = true
			tweenService:Create(tabSlider, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
				Size = UDim2.fromOffset(tabObject.AbsoluteSize.X, 1),
				Position = UDim2.fromOffset(tabObject.AbsolutePosition.X, tabObject.AbsolutePosition.Y + tabObject.AbsoluteSize.Y) - UDim2.fromOffset(main.AbsolutePosition.X, main.AbsolutePosition.Y)
			}):Play()
		end)
	end
	windowFunctions.LastTab = nil
	function windowFunctions:CreateTab(options, ...)
		options = (options and (type(options) == "string") and resolvevararg("Tab", options, ...)) or options or {
			Name = "D3v1lHub Style: Elite Lego Hax"
		}
		local image = options.Image
		if image then
			image = resolveid(image)
		end
		local tabName = options.Name or "Unnamed Tab"
		options.Name = tabName
		windowFunctions.tabCount = windowFunctions.tabCount + 1
		local newTab = Instance_new((image and "ImageButton") or "TextButton")
		local newTabHolder = Instance_new("Frame")
		library.globals["__Window" .. windowName].newTabHolder = newTabHolder
		local left = Instance_new("ScrollingFrame")
		local leftList = Instance_new("UIListLayout")
		local leftPadding = Instance_new("UIPadding")
		local right = Instance_new("ScrollingFrame")
		local rightList = Instance_new("UIListLayout")
		local rightPadding = Instance_new("UIPadding")
		newTab.Name = generateRandomName()
		newTab.Parent = tabsHolder
		newTab.BackgroundTransparency = 1
		newTab.LayoutOrder = (options.LastTab and 99999) or tonumber(options.TabOrder or options.LayoutOrder) or (2 + windowFunctions.tabCount)
		local colored_newTab_BackgroundColor3 = {newTab, "BackgroundColor3", "main"}
		colored[1 + #colored] = colored_newTab_BackgroundColor3
		newTab.BackgroundColor3 = library.colors.main
		local colored_newTab_TextColor3 = nil
		if image then
			newTab.Image = image
			newTab.ImageColor3 = options.ImageColor or options.Color or Color3.new(1, 1, 1)
			newTab.Size = UDim2:new(tabsHolder.AbsoluteSize.Y, 1)
		else
			colored_newTab_TextColor3 = {newTab, "TextColor3", "tabText"}
			colored[1 + #colored] = colored_newTab_TextColor3
			newTab.Font = Enum.Font.Code
			newTab.Text = (tabName and tostring(tabName)) or "???"
			if windowFunctions.tabCount ~= 1 then
				colored_newTab_TextColor3[4] = 1.35
				newTab.TextColor3 = darkenColor(library.colors.tabText, 1.35)
			else
				newTab.TextColor3 = library.colors.tabText
			end
			newTab.TextSize = 14
			newTab.TextStrokeColor3 = Color3.fromRGB(42, 42, 42)
			newTab.TextStrokeTransparency = 0.75
			newTab.Size = UDim2:new(textToSize(newTab).X + 4, 1)
		end
		if windowFunctions.tabCount > 1 then
			-- kleiner Trennstrich links vom Tab, damit man die einzelnen Tabs klar auseinanderhalten kann
			local tabDivider = Instance_new("Frame")
			tabDivider.Name = generateRandomName()
			tabDivider.AnchorPoint = Vector2.new(0, 0.5)
			tabDivider.Position = UDim2.new(0, -3, 0.5, 0)
			tabDivider.Size = UDim2.new(0, 1, 0, 14)
			tabDivider.BackgroundColor3 = Color3.fromRGB(55, 54, 62) -- dezent/unauffällig, wie gewünscht
			tabDivider.BackgroundTransparency = 0.35
			tabDivider.BorderSizePixel = 0
			tabDivider.ZIndex = 2
			tabDivider.Parent = newTab
		end
		local function goto()
			if not library.colorpicker and not submenuOpen and (windowFunctions.selected.button ~= newTab) and newTab.Parent and newTabHolder.Parent then
				pcall(function()
					for _, e in next, library.elements do
						if e and (type(e) == "table") then
							if e.Update then
								pcall(e.Update)
							end
							if e.UpdateAll then
								pcall(e.UpdateAll)
							end
						end
					end
				end)
				if windowFunctions.LastTab then
					windowFunctions.LastTab[4] = 1.35
				end
				windowFunctions:MoveTabSlider(newTab)
				if windowFunctions.selected.button.ClassName == "TextButton" then
					tweenService:Create(windowFunctions.selected.button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = darkenColor(library.colors.tabText, 1.35)
					}):Play()
				end
				if colored_newTab_TextColor3 then
					colored_newTab_TextColor3[4] = nil
				end
				windowFunctions.selected.holder.Visible = false
				windowFunctions.selected.button = newTab
				windowFunctions.selected.holder = newTabHolder
				if windowFunctions.selected.button.ClassName == "TextButton" then
					tweenService:Create(windowFunctions.selected.button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = library.colors.tabText
					}):Play()
				end
				windowFunctions.selected.holder.Visible = true
				windowFunctions.LastTab = colored_newTab_TextColor3
			end
		end
		if not homepage and newTab.LayoutOrder <= 4 then
			homepage = goto
		end
		library.signals[1 + #library.signals] = newTab.MouseButton1Click:Connect(goto)
		-- dezentes Aufleuchten im Hintergrund beim Hovern über den Tab
		library.signals[1 + #library.signals] = newTab.MouseEnter:Connect(function()
			tweenService:Create(newTab, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
				BackgroundTransparency = 0.88
			}):Play()
		end)
		library.signals[1 + #library.signals] = newTab.MouseLeave:Connect(function()
			tweenService:Create(newTab, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
				BackgroundTransparency = 1
			}):Play()
		end)
		if windowFunctions.tabCount == 1 then
			-- Direkt nach dem Parenten sind AbsolutePosition/AbsoluteSize teils noch nicht final
			-- (Layout braucht einen Frame) -> Slider würde falsch/verschoben landen. Daher 1 Frame warten.
			task.defer(function()
				tabSlider.Size = UDim2.fromOffset(newTab.AbsoluteSize.X, 1)
				tabSlider.Position = UDim2.fromOffset(newTab.AbsolutePosition.X, newTab.AbsolutePosition.Y + newTab.AbsoluteSize.Y) - UDim2.fromOffset(main.AbsolutePosition.X, main.AbsolutePosition.Y)
				tabSlider.Visible = true
			end)
			windowFunctions.selected.holder = newTabHolder
			windowFunctions.selected.button = newTab
		end
		newTabHolder.Name = generateRandomName() .. "TabHolder"
		newTabHolder.Parent = innerMainHolder
		newTabHolder.BackgroundColor3 = Color3.new(1, 1, 1)
		newTabHolder.BackgroundTransparency = 1
		newTabHolder.Size = UDim2.fromScale(1, 1)
		newTabHolder.Visible = windowFunctions.tabCount == 1
		left.Name = generateRandomName()
		left.Parent = newTabHolder
		left.BackgroundColor3 = Color3.new(1, 1, 1)
		left.BackgroundTransparency = 1
		left.Size = UDim2.fromScale(0.5, 1)
		left.CanvasSize = UDim2.new()
		left.ScrollBarThickness = 0
		leftList.Name = generateRandomName()
		leftList.Parent = left
		leftList.HorizontalAlignment = Enum.HorizontalAlignment.Center
		leftList.SortOrder = Enum.SortOrder.LayoutOrder
		leftList.Padding = UDim:new(12) -- etwas größerer Abstand zwischen den Groupboxes untereinander
		leftPadding.Name = generateRandomName()
		leftPadding.Parent = left
		leftPadding.PaddingTop = UDim:new(12)
		right.Name = generateRandomName()
		right.Parent = newTabHolder
		right.BackgroundColor3 = Color3.new(1, 1, 1)
		right.BackgroundTransparency = 1
		right.Size = UDim2.fromScale(0.5, 1)
		right.CanvasSize = UDim2.new()
		right.ScrollBarThickness = 0
		right.Position = UDim2.new(0.5)
		rightList.Name = generateRandomName()
		rightList.Parent = right
		rightList.HorizontalAlignment = Enum.HorizontalAlignment.Center
		rightList.SortOrder = Enum.SortOrder.LayoutOrder
		rightList.Padding = UDim:new(12) -- etwas größerer Abstand zwischen den Groupboxes untereinander
		rightPadding.Name = generateRandomName()
		rightPadding.Parent = right
		rightPadding.PaddingTop = UDim:new(12)
		local tabFunctions = {
			Flags = {},
			Remove = function()
				local relod = nil
				if newTab then
					newTab.Parent = nil
					relod = true
				end
				if newTabHolder then
					newTabHolder.Parent = nil
					relod = true
				end
				if relod then
					windowFunctions:UpdateAll()
				end
			end,
			Select = goto
		}
		function tabFunctions:CreateSection(options, ...)
			options = (options and type(options) == "string" and resolvevararg("Tab", options, ...)) or options
			local sectionName, holderSide = options.Name or "Unnamed Section", options.Side
			options.Name = sectionName
			local newSection = Instance_new("Frame")
			local newSectionBorder = Instance_new("Frame")
			local insideBorderHider = Instance_new("Frame")
			local outsideBorderHider = Instance_new("Frame")
			local sectionHolder = Instance_new("Frame")
			local sectionList = Instance_new("UIListLayout")
			local sectionPadding = Instance_new("UIPadding")
			local sectionHeadline = Instance_new("TextLabel")
			colorpickerconflicts[1 + #colorpickerconflicts] = insideBorderHider
			colorpickerconflicts[1 + #colorpickerconflicts] = outsideBorderHider
			colorpickerconflicts[1 + #colorpickerconflicts] = sectionHeadline
			newSection.Name = generateRandomName()
			newSection.Parent = (holderSide and (((holderSide:lower() == "left") and left) or right)) or left
			newSection.BackgroundColor3 = library.colors.sectionBackground
			colored[1 + #colored] = {newSection, "BackgroundColor3", "sectionBackground"}
			newSection.BorderSizePixel = 0
			newSection.Size = UDim2.new(1, -4) -- minimaler Abstand zwischen Groupbox und Spaltenrand, Groupboxen füllen die Spalte fast komplett aus
			newSection.Visible = false
			addCorner(newSection, 6)
			do
				local newSectionStroke = Instance_new("UIStroke")
				newSectionStroke.Name = generateRandomName()
				newSectionStroke.Parent = newSection
				newSectionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				newSectionStroke.Thickness = 1
				newSectionStroke.Color = library.colors.outerBorder
				colored[1 + #colored] = {newSectionStroke, "Color", "outerBorder"}
			end
			newSectionBorder.Name = generateRandomName()
			newSectionBorder.Parent = newSection
			newSectionBorder.BackgroundColor3 = library.colors.sectionBackground
			colored[1 + #colored] = {newSectionBorder, "BackgroundColor3", "sectionBackground"}
			newSectionBorder.BorderSizePixel = 0
			newSectionBorder.Size = UDim2.fromScale(1, 1)
			addCorner(newSectionBorder, 6)
			do
				local newSectionBorderStroke = Instance_new("UIStroke")
				newSectionBorderStroke.Name = generateRandomName()
				newSectionBorderStroke.Parent = newSectionBorder
				newSectionBorderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				newSectionBorderStroke.Thickness = 1
				newSectionBorderStroke.Color = library.colors.innerBorder
				colored[1 + #colored] = {newSectionBorderStroke, "Color", "innerBorder"}
			end
			sectionHolder.Name = generateRandomName()
			sectionHolder.Parent = newSection
			sectionHolder.BackgroundColor3 = Color3.new(1, 1, 1)
			sectionHolder.BackgroundTransparency = 1
			sectionHolder.Size = UDim2.fromScale(1, 1)
			sectionList.Name = generateRandomName()
			sectionList.Parent = sectionHolder
			sectionList.HorizontalAlignment = Enum.HorizontalAlignment.Center
			sectionList.SortOrder = Enum.SortOrder.LayoutOrder
			sectionList.Padding = UDim:new(1)
			sectionPadding.Name = generateRandomName()
			sectionPadding.Parent = sectionHolder
			sectionPadding.PaddingTop = UDim:new(9)
			sectionHeadline.Name = generateRandomName()
			sectionHeadline.Parent = newSection
			sectionHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
			sectionHeadline.BackgroundTransparency = 1
			sectionHeadline.Position = UDim2.fromOffset(18, -8)
			sectionHeadline.ZIndex = 2
			sectionHeadline.Font = Enum.Font.Code
			sectionHeadline.LineHeight = 1.15
			sectionHeadline.Text = (sectionName and sectionName or "???")
			sectionHeadline.TextColor3 = library.colors.section
			colored[1 + #colored] = {sectionHeadline, "TextColor3", "section"}
			sectionHeadline.TextSize = 14
			sectionHeadline.Size = UDim2.fromOffset(textToSize(sectionHeadline).X + 4, 12)
			insideBorderHider.Name = generateRandomName()
			insideBorderHider.Parent = newSection
			insideBorderHider.BackgroundColor3 = library.colors.sectionBackground
			colored[1 + #colored] = {insideBorderHider, "BackgroundColor3", "sectionBackground"}
			insideBorderHider.BorderSizePixel = 0
			insideBorderHider.Position = UDim2.fromOffset(15)
			insideBorderHider.Size = UDim2.fromOffset(sectionHeadline.AbsoluteSize.X + 3, 1)
			outsideBorderHider.Name = generateRandomName()
			outsideBorderHider.Parent = newSection
			outsideBorderHider.BackgroundColor3 = library.colors.background
			colored[1 + #colored] = {outsideBorderHider, "BackgroundColor3", "background"}
			outsideBorderHider.BorderSizePixel = 0
			outsideBorderHider.Position = UDim2.fromOffset(15, -1)
			outsideBorderHider.Size = UDim2.fromOffset(sectionHeadline.AbsoluteSize.X + 3, 1)
			local sectionFunctions = {
				Flags = {},
				Remove = function()
					if newSection then
						newSection.Parent = nil
						windowFunctions:UpdateAll()
					end
				end
			}
			library.__AllSections = library.__AllSections or {}
			library.__AllSections[1 + #library.__AllSections] = {
				Frame = newSection,
				Holder = sectionHolder,
				Functions = sectionFunctions
			}
			function sectionFunctions:Update(extra)
				local currentHolder = newSection.Parent
				if not newSection.Visible then
					newSection.Visible = true
				end
				newSection.Size = UDim2.new(1, -20, 0, (15 + sectionList.AbsoluteContentSize.Y))
				if currentHolder then
					currentHolder.CanvasSize = UDim2:fromOffset(currentHolder:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y + 22 + (tonumber(extra) or 0))
				end
			end
			function sectionFunctions:UpdateAll(...)
				for _, obj in next, sectionFunctions.Flags do
					if obj then
						if obj.Update then
							pcall(obj.Update)
						end
						if obj.UpdateAll then
							pcall(obj.UpdateAll)
						end
					end
				end
				sectionFunctions:Update(...)
			end
			function sectionFunctions:AddToggle(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Tab", options, ...)) or options
				local toggleName, alreadyEnabled, callback, flagName = assert(options.Name, "Missing Name for new toggle."), options.Value or options.Enabled, options.Callback, options.Flag or (function()
					library.unnamedtoggles = 1 + (library.unnamedtoggles or 0)
					return "Toggle" .. tostring(library.unnamedtoggles)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local newToggle = Instance_new("Frame")
				local toggle = Instance_new("ImageLabel")
				local toggleInner = Instance_new("ImageLabel")
				local toggleButton = Instance_new("TextButton")
				local toggleHeadline = Instance_new("TextLabel")
				local keybindPositioner = Instance_new("Frame")
				local keybindList = Instance_new("UIListLayout")
				local keybindButton = Instance_new("TextButton")
				local lockedup = options.Locked or options.Disabled
				newToggle.Name = generateRandomName()
				newToggle.Parent = sectionHolder
				newToggle.BackgroundColor3 = Color3.new(1, 1, 1)
				newToggle.BackgroundTransparency = 1
				newToggle.Size = UDim2.new(1, 0, 0, 19)
				toggle.Name = generateRandomName()
				toggle.Parent = newToggle
				toggle.Active = true
				toggle.BackgroundColor3 = library.colors.topGradient
				local colored_toggle_BackgroundColor3 = {toggle, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_toggle_BackgroundColor3
				toggle.BorderSizePixel = 0
				do
					local toggleStroke = Instance_new("UIStroke")
					toggleStroke.Name = generateRandomName()
					toggleStroke.Parent = toggle
					toggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					toggleStroke.Thickness = 1
					toggleStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {toggleStroke, "Color", "elementBorder"}
				end
				toggle.Position = UDim2.fromScale(0.0308237672, 0.165842205)
				toggle.Selectable = true
				toggle.Size = UDim2.fromOffset(12, 12)
				toggle.Image = "rbxassetid://2454009026"
				addCorner(toggle, 3)
				toggle.ImageColor3 = library.colors.bottomGradient
				local colored_toggle_ImageColor3 = {toggle, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_toggle_ImageColor3
				toggleInner.Name = generateRandomName()
				toggleInner.Parent = toggle
				toggleInner.Active = true
				toggleInner.AnchorPoint = Vector2.new(0.5, 0.5)
				toggleInner.BackgroundColor3 = library.colors.topGradient
				local colored_toggleInner_BackgroundColor3 = {toggleInner, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_toggleInner_BackgroundColor3
				toggleInner.BorderSizePixel = 0
				do
					local toggleInnerStroke = Instance_new("UIStroke")
					toggleInnerStroke.Name = generateRandomName()
					toggleInnerStroke.Parent = toggleInner
					toggleInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					toggleInnerStroke.Thickness = 1
					toggleInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {toggleInnerStroke, "Color", "elementBorder"}
				end
				toggleInner.Position = UDim2.fromScale(0.5, 0.5)
				toggleInner.Selectable = true
				toggleInner.Size = UDim2.new(1, -4, 1, -4)
				toggleInner.Image = "rbxassetid://2454009026"
				addCorner(toggleInner, 3)
				toggleInner.ImageColor3 = library.colors.bottomGradient
				local colored_toggleInner_ImageColor3 = {toggleInner, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_toggleInner_ImageColor3
				toggleButton.Name = generateRandomName()
				toggleButton.Parent = newToggle
				toggleButton.BackgroundColor3 = Color3.new(1, 1, 1)
				toggleButton.BackgroundTransparency = 1
				toggleButton.Size = UDim2.fromScale(1, 1)
				toggleButton.ZIndex = 5
				toggleButton.Font = Enum.Font.SourceSans
				toggleButton.Text = ""
				toggleButton.TextColor3 = Color3.new()
				toggleButton.TextSize = 14
				toggleButton.TextTransparency = 1
				toggleHeadline.Name = generateRandomName()
				toggleHeadline.Parent = newToggle
				toggleHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				toggleHeadline.BackgroundTransparency = 1
				toggleHeadline.Position = UDim2.fromScale(0.123, 0.165842161)
				toggleHeadline.Size = UDim2.fromOffset(170, 11)
				toggleHeadline.Font = Enum.Font.Code
				toggleHeadline.Text = toggleName or "???"
				makeMarquee(toggleHeadline)
				toggleHeadline.TextColor3 = library.colors.elementText
				local colored_toggleHeadline_TextColor3 = {toggleHeadline, "TextColor3", "elementText", (lockedup and 0.5) or nil}
				colored[1 + #colored] = colored_toggleHeadline_TextColor3
				toggleHeadline.TextSize = 14
				toggleHeadline.TextXAlignment = Enum.TextXAlignment.Left
				-- Linoria-Feature-Port: Tooltip (Tooltip / DisabledTooltip)
				local Tooltip = nil
				if typeof(options.Tooltip) == "string" or typeof(options.DisabledTooltip) == "string" then
					Tooltip = library:AddToolTip(options.Tooltip, options.DisabledTooltip, newToggle)
					if Tooltip then
						Tooltip.Disabled = lockedup and true or false
					end
				end
				local last_v = nil
				local kbSyncFlag = nil -- wird gesetzt, falls dieser Toggle einen Keybind besitzt (für die Keybinds-Liste)
				local function Set(t, newStatus)
					if nil == newStatus and t ~= nil then
						newStatus = t
					end
					last_v = library_flags[flagName]
					if options.Condition ~= nil then
						if type(options.Condition) == "function" then
							local v, e = pcall(options.Condition, newStatus, last_v)
							if e then
								if not v then
									warn(debug.traceback(string.format("Error in toggle %s's Condition function: %s", flagName, e), 2))
								end
							else
								return last_v
							end
						end
					end
					if newStatus ~= nil and type(newStatus) == "boolean" then
						library_flags[flagName] = newStatus
						if options.Location then
							options.Location[options.LocationFlag or flagName] = newStatus
						end
						if kbSyncFlag then
							KeybindsListModule:SetActive(kbSyncFlag, newStatus)
						end
						if callback and (last_v ~= newStatus or options.AllowDuplicateCalls) then
							colored_toggleInner_BackgroundColor3[3] = (newStatus and "main") or "topGradient"
							colored_toggleInner_BackgroundColor3[4] = (newStatus and 1.5) or nil
							colored_toggleInner_ImageColor3[3] = (newStatus and "main") or "bottomGradient"
							colored_toggleInner_ImageColor3[4] = (newStatus and 2.5) or nil
							tweenService:Create(toggleInner, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = (newStatus and darkenColor(library.colors.main, 1.5)) or library.colors.topGradient,
								ImageColor3 = (newStatus and darkenColor(library.colors.main, 2.5)) or library.colors.bottomGradient
							}):Play()
							task.spawn(callback, newStatus, last_v)
						end
					end
					return newStatus
				end
				options.Keybind = options.Keybind or options.Key or options.KeyBind
				local haskbflag, kbUpdate, kbData = nil, nil, nil
				if options.Keybind then
					local options = options.Keybind
					local htyp = typeof(options)
					if htyp == "EnumItem" then
						options = {
							Value = options
						}
					elseif htyp ~= "table" then
						options = {}
					end
					local presetKeybind, callback, kbpresscallback, kbflag = options.Value or options.Key, options.Callback, options.Pressed, options.Flag or (function()
						if flagName then
							return flagName .. "_ToggleKeybind"
						end
						library.unnamedkeybinds = 1 + (library.unnamedkeybinds or 0)
						return "Keybind" .. tostring(library.unnamedkeybinds)
					end)()
					if elements[kbflag] ~= nil or kbflag == flagName then
						warn(debug.traceback("Warning! Re-used flag '" .. kbflag .. "'", 3))
					end
					haskbflag = kbflag
					kbSyncFlag = kbflag
					library.keyHandler = keyHandler
					local keyHandler = options.KeyNames or keyHandler
					local bindedKey = presetKeybind
					local justBinded = false
					local keyName = keyHandler.allowedKeys[bindedKey] or (bindedKey and (bindedKey.Name or tostring(bindedKey):gsub("Enum.KeyCode.", ""))) or "NONE"
					local newKeybind = newToggle
					local function syncKbList()
						local shownKey = keybindButton.Text:match("^%[(.-)%]$")
						KeybindsListModule:Upsert(kbflag, toggleName, shownKey or "NONE")
					end
					keybindPositioner.Name = generateRandomName()
					keybindPositioner.Parent = newKeybind
					keybindPositioner.BackgroundColor3 = Color3.new(1, 1, 1)
					keybindPositioner.BackgroundTransparency = 1
					keybindPositioner.Position = UDim2.new(0, 2, 0, 0)
					keybindPositioner.Size = UDim2.new(1, -4, 0, 19) -- relativ statt fest 214px, sonst ragt der Keybind-Button in schmalen (2-spaltigen) Groupboxen raus
					keybindPositioner.ZIndex = 1 + toggleButton.ZIndex
					keybindList.Name = generateRandomName()
					keybindList.Parent = keybindPositioner
					keybindList.FillDirection = Enum.FillDirection.Horizontal
					keybindList.HorizontalAlignment = Enum.HorizontalAlignment.Right
					keybindList.SortOrder = Enum.SortOrder.LayoutOrder
					keybindList.VerticalAlignment = Enum.VerticalAlignment.Center
					keybindButton.Name = generateRandomName()
					keybindButton.Parent = keybindPositioner
					keybindButton.Active = false
					keybindButton.BackgroundColor3 = Color3.new(1, 1, 1)
					keybindButton.BackgroundTransparency = 1
					keybindButton.Position = UDim2.fromScale(0.598130822, 0.184210524)
					keybindButton.Selectable = false
					keybindButton.Size = UDim2.fromOffset(46, 12)
					keybindButton.Font = Enum.Font.Code
					keybindButton.Text = "[" .. (keyName or (presetKeybind and tostring(presetKeybind):gsub("Enum.KeyCode.", "")) or "NONE") .. "]"
					keybindButton.TextColor3 = library.colors.otherElementText
					local colored_keybindButton_TextColor3 = {keybindButton, "TextColor3", "otherElementText"}
					colored[1 + #colored] = colored_keybindButton_TextColor3
					keybindButton.TextSize = 14
					keybindButton.TextXAlignment = Enum.TextXAlignment.Right
					keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
					syncKbList()
					local klast_v = bindedKey or presetKeybind
					local function newkey()
						if lockedup then
							return
						end
						local old_texts = keybindButton.Text
						colored_keybindButton_TextColor3[3] = "main"
						colored_keybindButton_TextColor3[4] = nil
						tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							TextColor3 = library.colors.main
						}):Play()
						if klast_v then
							keybindButton.Text = "(Was " .. (klast_v and tostring(klast_v):gsub("Enum.KeyCode.", "") or "[NONE]") .. ") [...]"
						else
							keybindButton.Text = "[...]"
						end
						local receivingKey = nil
						receivingKey = userInputService.InputBegan:Connect(function(key)
							if lockedup then
								return receivingKey:Disconnect()
							end
							klast_v = library_flags[kbflag]
							if not keyHandler.notAllowedKeys[key.KeyCode] then
								if key.KeyCode ~= Enum.KeyCode.Unknown then
									bindedKey = (key.KeyCode ~= Enum.KeyCode.Escape and key.KeyCode) or library_flags[kbflag]
									library_flags[kbflag] = bindedKey
									if options.Location then
										options.Location[options.LocationFlag or kbflag] = bindedKey
									end
									if bindedKey then
										keyName = keyHandler.allowedKeys[bindedKey] or (bindedKey and (bindedKey.Name or tostring(bindedKey):gsub("Enum.KeyCode.", ""))) or "NONE"
										keybindButton.Text = "[" .. (keyName or (bindedKey and bindedKey.Name) or "NONE") .. "]"
										keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
										syncKbList()
										justBinded = true
										colored_keybindButton_TextColor3[3] = "otherElementText"
										colored_keybindButton_TextColor3[4] = nil
										tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
											TextColor3 = library.colors.otherElementText
										}):Play()
										receivingKey:Disconnect()
									end
									if callback and klast_v ~= bindedKey then
										task.spawn(callback, bindedKey, klast_v)
									end
									return
								elseif key.KeyCode == Enum.KeyCode.Unknown and not keyHandler.notAllowedMouseInputs[key.UserInputType] then
									bindedKey = key.UserInputType
									library_flags[kbflag] = bindedKey
									if options.Location then
										options.Location[options.LocationFlag or kbflag] = bindedKey
									end
									keyName = keyHandler.allowedKeys[bindedKey]
									keybindButton.Text = "[" .. (keyName or (bindedKey and bindedKey.Name) or tostring(bindedKey.KeyCode):gsub("Enum.KeyCode.", "")) .. "]"
									keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
									syncKbList()
									justBinded = true
									colored_keybindButton_TextColor3[3] = "otherElementText"
									colored_keybindButton_TextColor3[4] = nil
									tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
										TextColor3 = library.colors.otherElementText
									}):Play()
									receivingKey:Disconnect()
									if callback and klast_v ~= bindedKey then
										task.spawn(callback, bindedKey, klast_v)
									end
									return
								end
							end
							if key.KeyCode == Enum.KeyCode.Backspace or Enum.KeyCode.Escape == key.KeyCode then
								old_texts, bindedKey = "[NONE]", nil
							end
							keybindButton.Text = old_texts
							syncKbList()
							colored_keybindButton_TextColor3[3] = "otherElementText"
							colored_keybindButton_TextColor3[4] = nil
							tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								TextColor3 = library.colors.otherElementText
							}):Play()
							receivingKey:Disconnect()
							if callback and klast_v ~= bindedKey then
								task.spawn(callback, bindedKey, klast_v)
							end
						end)
						library.signals[1 + #library.signals] = receivingKey
					end
					library.signals[1 + #library.signals] = keybindButton.MouseButton1Click:Connect(newkey)
					if kbpresscallback and not justBinded then
						library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(key, chatting)
							chatting = chatting or (userInputService:GetFocusedTextBox() and true)
							if not chatting and not justBinded then
								if not keyHandler.notAllowedKeys[key.KeyCode] and not keyHandler.notAllowedMouseInputs[key.UserInputType] then
									if bindedKey == key.UserInputType or not justBinded and bindedKey == key.KeyCode then
										if kbpresscallback then
											task.spawn(kbpresscallback, key, chatting)
										end
									end
									justBinded = false
								end
							end
						end)
					end
					options.Mode = (options.Mode and string.lower(tostring(options.Mode))) or "dynamic"
					local modes = {
						dynamic = 1,
						hold = 1,
						toggle = 1
					}
					library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(input, chatting)
						if justBinded then
							wait(0.1)
							justBinded = false
							return
						elseif lockedup then
							return
						end
						chatting = chatting or userInputService:GetFocusedTextBox()
						if not chatting then
							local key = library_flags[kbflag]
							local mode = options.Mode
							if not modes[mode] then
								mode = "dynamic"
								options.Mode = mode
							end
							if key == input.KeyCode or key == input.UserInputType then
								if mode == "dynamic" or mode == "both" or mode == "hold" then
									if mode == "dynamic" and library_flags[flagName] then
										return Set(false)
									end
									Set(true)
									local now = os.clock()
									local waittil = nil
									if mode == "dynamic" then
										waittil = Instance.new("BindableEvent")
									end
									local xconnection = nil
									xconnection = userInputService.InputEnded:Connect(function(input, chatting)
										chatting = chatting or userInputService:GetFocusedTextBox()
										if not chatting and (key == input.KeyCode or key == input.UserInputType) then
											xconnection = (xconnection and xconnection:Disconnect() and nil) or nil
											if mode == "hold" or os.clock() - now > math.clamp(tonumber(options.DynamicTime) or 0.65, 0.05, 20) then
												Set(false)
											end
										end
									end)
									library.signals[1 + #library.signals] = xconnection
								else
									Set(not library_flags[flagName])
								end
							end
						end
					end)
					local function kbset(t, key)
						if nil == key and t ~= nil then
							key = t
						end
						if key == "nil" or key == "NONE" or key == "none" then
							key = nil
						end
						last_v = library_flags[kbflag]
						bindedKey = key
						library_flags[kbflag] = key
						if options.Location then
							options.Location[options.LocationFlag or kbflag] = key
						end
						keyName = (key == nil and "NONE") or keyHandler.allowedKeys[key]
						keybindButton.Text = "[" .. (keyName or key.Name or tostring(key):gsub("Enum.KeyCode.", "")) .. "]"
						keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
						syncKbList()
						justBinded = true
						colored_keybindButton_TextColor3[3] = "otherElementText"
						colored_keybindButton_TextColor3[4] = nil
						tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							TextColor3 = library.colors.otherElementText
						}):Play()
						if callback and (last_v ~= key or options.AllowDuplicateCalls) then
							task.spawn(callback, key, last_v)
						end
						return key
					end
					if presetKeybind ~= nil then
						kbset(presetKeybind)
					else
						library_flags[kbflag] = bindedKey
						if options.Location then
							options.Location[options.LocationFlag or kbflag] = bindedKey
						end
					end
					local default = library_flags[kbflag]
					local function UpdateKb()
						callback, kbpresscallback = options.Callback, options.Pressed
						local key = library_flags[kbflag]
						bindedKey = key
						keyName = keyHandler.allowedKeys[bindedKey] or (bindedKey and (bindedKey.Name or tostring(bindedKey):gsub("Enum.KeyCode.", ""))) or "NONE"
						keybindButton.Text = "[" .. (keyName or (key and key.Name) or tostring(key):gsub("Enum.KeyCode.", "")) .. "]"
						keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
						syncKbList()
						colored_keybindButton_TextColor3[3] = "otherElementText"
						colored_keybindButton_TextColor3[4] = (lockedup and 2.5) or nil
						tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							TextColor3 = (lockedup and darkenColor(library.colors.otherElementText, colored_keybindButton_TextColor3[4])) or library.colors.otherElementText
						}):Play()
						return key
					end
					kbUpdate = UpdateKb
					local objectdata = {
						Options = options,
						Name = kbflag,
						Flag = kbflag,
						Type = "Keybind",
						Default = default,
						Parent = sectionFunctions,
						Instance = keybindButton,
						Container = newToggle,
						DisplayName = toggleName,
						Get = function()
							return library_flags[kbflag]
						end,
						Set = kbset,
						RawSet = function(t, key)
							if t ~= nil and key == nil then
								key = t
							end
							library_flags[kbflag] = key
							UpdateKb()
							return key
						end,
						Update = UpdateKb,
						Reset = function()
							return kbset(nil, default)
						end
					}
					kbData = objectdata
					tabFunctions.Flags[kbflag], sectionFunctions.Flags[kbflag], elements[kbflag] = objectdata, objectdata, objectdata
				end
				sectionFunctions:Update()
				library.signals[1 + #library.signals] = toggleButton.MouseButton1Click:Connect(function()
					if not library.colorpicker and not submenuOpen and not lockedup then
						local newval = not library_flags[flagName]
						if options.Condition ~= nil then
							if type(options.Condition) == "function" then
								local v, e = pcall(options.Condition, newval, not newval)
								if e then
									if not v then
										warn(debug.traceback(string.format("Error in toggle %s's Condition function: %s", flagName, e), 2))
									end
								else
									return last_v
								end
							end
						end
						library_flags[flagName] = newval
						if options.Location then
							options.Location[options.LocationFlag or flagName] = newval
						end
						if kbSyncFlag then
							KeybindsListModule:SetActive(kbSyncFlag, newval)
						end
						colored_toggleInner_BackgroundColor3[3] = (newval and "main") or "topGradient"
						colored_toggleInner_BackgroundColor3[4] = (newval and 1.5) or nil
						colored_toggleInner_ImageColor3[3] = (newval and "main") or "bottomGradient"
						colored_toggleInner_ImageColor3[4] = (newval and 2.5) or nil
						tweenService:Create(toggleInner, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = (newval and darkenColor(library.colors.main, 1.5)) or library.colors.topGradient,
							ImageColor3 = (newval and darkenColor(library.colors.main, 2.5)) or library.colors.bottomGradient
						}):Play()
						if callback then
							task.spawn(callback, newval)
						end
					end
				end)
				library.signals[1 + #library.signals] = newToggle.MouseEnter:Connect(function()
					colored_toggle_BackgroundColor3[3] = "main"
					colored_toggle_BackgroundColor3[4] = 1.5
					colored_toggle_ImageColor3[3] = "main"
					colored_toggle_ImageColor3[4] = 2.5
					tweenService:Create(toggle, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end)
				library.signals[1 + #library.signals] = newToggle.MouseLeave:Connect(function()
					colored_toggle_BackgroundColor3[3] = "topGradient"
					colored_toggle_BackgroundColor3[4] = nil
					colored_toggle_ImageColor3[3] = "bottomGradient"
					colored_toggle_ImageColor3[4] = nil
					tweenService:Create(toggle, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = library.colors.topGradient,
						ImageColor3 = library.colors.bottomGradient
					}):Play()
				end)
				if library_flags[flagName] then
					colored_toggleInner_BackgroundColor3[3] = "main"
					colored_toggleInner_BackgroundColor3[4] = 1.5
					colored_toggleInner_ImageColor3[3] = "main"
					colored_toggleInner_ImageColor3[4] = 2.5
					tweenService:Create(toggleInner, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end
				if kbSyncFlag then
					KeybindsListModule:SetActive(kbSyncFlag, library_flags[flagName] and true or false)
				end
				local function Update()
					toggleName, callback = options.Name or toggleName, options.Callback
					local boolstatus = library_flags[flagName]
					colored_toggleInner_BackgroundColor3[3] = (boolstatus and "main") or "topGradient"
					colored_toggleInner_BackgroundColor3[4] = (boolstatus and 1.5) or nil
					colored_toggleInner_ImageColor3[3] = (boolstatus and "main") or "bottomGradient"
					colored_toggleInner_ImageColor3[4] = (boolstatus and 2.5) or nil
					if kbSyncFlag then
						KeybindsListModule:SetActive(kbSyncFlag, boolstatus and true or false)
					end
					if lockedup then
						colored_toggleInner_BackgroundColor3[4] = 1 + (colored_toggleInner_BackgroundColor3[4] or 1)
						colored_toggleInner_ImageColor3[4] = 1 + (colored_toggleInner_ImageColor3[4] or 1)
					end
					tweenService:Create(toggleInner, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = (boolstatus and darkenColor(library.colors.main, colored_toggleInner_BackgroundColor3[4])) or library.colors.topGradient,
						ImageColor3 = (boolstatus and darkenColor(library.colors.main, colored_toggleInner_ImageColor3[4])) or library.colors.bottomGradient
					}):Play()
					colored_toggleHeadline_TextColor3[4] = (lockedup and 2.5) or nil
					tweenService:Create(toggleHeadline, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = (lockedup and darkenColor(library.colors.elementText, colored_toggleHeadline_TextColor3[4])) or library.colors.elementText
					}):Play()
					toggleHeadline.Text = toggleName or "???"
					if Tooltip then
						Tooltip.Disabled = lockedup and true or false
					end
					return boolstatus
				end
				if alreadyEnabled ~= nil then
					Set(alreadyEnabled)
				else
					library_flags[flagName] = alreadyEnabled and true
					if options.Location then
						options.Location[options.LocationFlag or flagName] = alreadyEnabled and true
					end
				end
				local default = library_flags[flagName] and true
				Update()
				if kbUpdate then
					kbUpdate()
				end
				local objectdata = {
					Options = options,
					Type = "Toggle",
					Name = flagName,
					Flag = flagName,
					Default = default,
					Parent = sectionFunctions,
					Instance = toggleButton,
					Container = newToggle,
					DisplayName = toggleName,
					Set = Set,
					Remove = function()
						if newToggle then
							newToggle.Parent = nil
							sectionFunctions:Update()
						end
					end,
					RawSet = function(t, newStatus, condition)
						if t ~= nil and type(t) ~= "table" then
							newStatus, condition = t, newStatus
						end
						last_v = library_flags[flagName]
						if (condition ~= false) and (condition ~= 0) then
							local overridecondition = condition and (type(condition) == "function") and condition
							if overridecondition or (options.Condition ~= nil) then
								if type(overridecondition or options.Condition) == "function" then
									local v, e = pcall(overridecondition or options.Condition, newStatus, last_v)
									if e then
										if not v then
											warn(debug.traceback(string.format("Error in toggle (RawSet) %s's Condition function: %s", flagName, e), 2))
										end
									else
										return last_v
									end
								end
							end
						end
						library_flags[flagName] = newStatus
						if options.Location then
							options.Location[options.LocationFlag or flagName] = newStatus
						end
						Update()
						return newStatus
					end,
					KeybindData = kbData,
					Get = function()
						return library_flags[flagName]
					end,
					Update = Update,
					Reset = function()
						return Set(nil, default)
					end,
					SetLocked = function(t, state)
						if type(t) ~= "table" then
							state = t
						end
						local last_v = lockedup
						if state == nil then
							lockedup = not lockedup
						else
							lockedup = state
						end
						if lockedup ~= last_v then
							colored_toggleHeadline_TextColor3[4] = (lockedup and 2.5) or nil
							Update()
							if kbUpdate then
								kbUpdate()
							end
						end
						return lockedup
					end,
					Lock = function()
						if not lockedup then
							lockedup = true
							colored_toggleHeadline_TextColor3[4] = 2.5
							Update()
							if kbUpdate then
								kbUpdate()
							end
						end
						return lockedup
					end,
					Unlock = function()
						if lockedup then
							lockedup = false
							colored_toggleHeadline_TextColor3[4] = nil
							Update()
							if kbUpdate then
								kbUpdate()
							end
						end
						return lockedup
					end,
					SetCondition = function(t, condition)
						if type(t) ~= "table" and condition == nil then
							condition = t
						end
						options.Condition = condition
						return condition
					end
				}
				-- Disabled = grau/unklickbar machen (Alias auf das bestehende Locked-System)
				objectdata.SetDisabled = objectdata.SetLocked
				objectdata.Disable = objectdata.Lock
				objectdata.Enable = objectdata.Unlock
				if kbData then
					kbData.ToggleData = objectdata
				end
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.CreateToggle = sectionFunctions.AddToggle
			sectionFunctions.NewToggle = sectionFunctions.AddToggle
			sectionFunctions.Toggle = sectionFunctions.AddToggle
			sectionFunctions.Tog = sectionFunctions.AddToggle
			function sectionFunctions:AddButton(...)
				local args = nil
				if ... and not select(2, ...) and type(...) == "table" and #... > 0 and type((...)[1]) == "table" and (...)[1].Name then
					args = ...
				else
					args = {...}
				end
				local buttons, offset = {}, 0
				local frames = {}
				local fram = nil
				for _, options in next, args do
					options = (options and options[1] and type(options[1]) == "string" and resolvevararg("Button", unpack(options))) or options
					local buttonName, callback = assert(options.Name, "Missing Name for new button."), options.Callback or (warn("AddButton missing callback. Name:", options.Name or "No Name", debug.traceback("")) and nil) or function()
					end
					local lockedup = options.Locked or options.Disabled
					local realButton = Instance_new("TextButton")
					realButton.Name = generateRandomName()
					realButton.BackgroundColor3 = Color3.new(1, 1, 1)
					realButton.BackgroundTransparency = 1
					realButton.Size = UDim2.fromScale(1, 1)
					realButton.ZIndex = 5
					realButton.Font = Enum.Font.Code
					realButton.Text = (buttonName and tostring(buttonName)) or "???"
					realButton.TextColor3 = library.colors.elementText
					local colored_realButton_TextColor3 = {realButton, "TextColor3", "elementText"}
					colored[1 + #colored] = colored_realButton_TextColor3
					realButton.TextSize = 14
					local textsize = textToSize(realButton).X + 14
					if newSection.Parent and (newSection.Parent.AbsoluteSize.X < (offset + textsize + 8)) then
						offset, fram = 0, nil
					end
					local newButton = fram or Instance_new("Frame")
					fram = newButton
					local framButtons = frames[fram] or {}
					frames[fram] = framButtons
					local button = Instance_new("ImageLabel")
					newButton.Name = generateRandomName()
					newButton.Parent = sectionHolder
					newButton.BackgroundColor3 = Color3.new(1, 1, 1)
					newButton.BackgroundTransparency = 1
					newButton.Size = UDim2.new(1, 0, 0, 24)
					button.Name = generateRandomName()
					button.Parent = newButton
					button.Active = true
					button.BackgroundColor3 = library.colors.topGradient
					local colored_button_BackgroundColor3 = {button, "BackgroundColor3", "topGradient"}
					colored[1 + #colored] = colored_button_BackgroundColor3
					button.BorderSizePixel = 0
					do
						local buttonStroke = Instance_new("UIStroke")
						buttonStroke.Name = generateRandomName()
						buttonStroke.Parent = button
						buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
						buttonStroke.Thickness = 1
						buttonStroke.Color = library.colors.elementBorder
						colored[1 + #colored] = {buttonStroke, "Color", "elementBorder"}
					end
					button.Position = UDim2.new(0.031, offset, 0.166)
					button.Selectable = true
					button.Size = UDim2.fromOffset(28, 18)
					button.Image = "rbxassetid://2454009026"
					addCorner(button, 4)
					button.ImageColor3 = library.colors.bottomGradient
					local colored_button_ImageColor3 = {button, "ImageColor3", "bottomGradient"}
					colored[1 + #colored] = colored_button_ImageColor3
					local buttonInner = Instance_new("ImageLabel")
					buttonInner.Name = generateRandomName()
					buttonInner.Parent = button
					buttonInner.Active = true
					buttonInner.AnchorPoint = Vector2.new(0.5, 0.5)
					buttonInner.BackgroundColor3 = library.colors.topGradient
					local colored_buttonInner_BackgroundColor3 = {buttonInner, "BackgroundColor3", "topGradient"}
					colored[1 + #colored] = colored_buttonInner_BackgroundColor3
					buttonInner.BorderSizePixel = 0
					do
						local buttonInnerStroke = Instance_new("UIStroke")
						buttonInnerStroke.Name = generateRandomName()
						buttonInnerStroke.Parent = buttonInner
						buttonInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
						buttonInnerStroke.Thickness = 1
						buttonInnerStroke.Color = library.colors.elementBorder
						colored[1 + #colored] = {buttonInnerStroke, "Color", "elementBorder"}
					end
					buttonInner.Position = UDim2.fromScale(0.5, 0.5)
					buttonInner.Selectable = true
					buttonInner.Size = UDim2.new(1, -4, 1, -4)
					buttonInner.Image = "rbxassetid://2454009026"
					addCorner(buttonInner, 4)
					buttonInner.ImageColor3 = library.colors.bottomGradient
					local colored_buttonInner_ImageColor3 = {buttonInner, "ImageColor3", "bottomGradient"}
					colored[1 + #colored] = colored_buttonInner_ImageColor3
					button.Size = UDim2.fromOffset(textsize, 18)
					realButton.Parent = button
					offset = offset + textsize + 6
					sectionFunctions:Update()
					-- Linoria-Feature-Port: Tooltip (Tooltip / DisabledTooltip)
					local Tooltip = nil
					if typeof(options.Tooltip) == "string" or typeof(options.DisabledTooltip) == "string" then
						Tooltip = library:AddToolTip(options.Tooltip, options.DisabledTooltip, button)
						if Tooltip then
							Tooltip.Disabled = lockedup and true or false
						end
					end
					local presses = 0
					library.signals[1 + #library.signals] = realButton.MouseButton1Click:Connect(function()
						if lockedup then
							return
						end
						if options.Condition ~= nil and type(options.Condition) == "function" then
							local v, e = pcall(options.Condition, presses)
							if e then
								if not v then
									warn(debug.traceback(string.format("Error in button %s's Condition function: %s", buttonName, e), 2))
								end
							else
								return
							end
						end
						if not library.colorpicker and not submenuOpen then
							presses = 1 + presses
							task.spawn(callback, presses)
						end
					end)
					local imin = nil
					library.signals[1 + #library.signals] = button.MouseEnter:Connect(function()
						imin = 1
						colored_button_BackgroundColor3[3] = "main"
						colored_button_BackgroundColor3[4] = 1.5
						colored_button_ImageColor3[3] = "main"
						colored_button_ImageColor3[4] = 2.5
						tweenService:Create(button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = darkenColor(library.colors.main, 1.5),
							ImageColor3 = darkenColor(library.colors.main, 2.5)
						}):Play()
					end)
					library.signals[1 + #library.signals] = button.MouseLeave:Connect(function()
						imin = nil
						colored_button_BackgroundColor3[3] = "topGradient"
						colored_button_BackgroundColor3[4] = nil
						colored_button_ImageColor3[3] = "bottomGradient"
						colored_button_ImageColor3[4] = nil
						tweenService:Create(button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
					end)
					local function Update(Recursive)
						buttonName, callback = options.Name or buttonName, options.Callback or (warn(debug.traceback("AddButton missing callback. Name:" .. (options.Name or buttonName or "No Name"), 2)) and nil) or function()
						end
						colored_button_BackgroundColor3[3] = (imin and "main") or "topGradient"
						colored_button_BackgroundColor3[4] = (imin and 1.5) or nil
						colored_button_ImageColor3[3] = (imin and "main") or "bottomGradient"
						colored_button_ImageColor3[4] = (imin and 2.5) or nil
						colored_buttonInner_BackgroundColor3[4] = nil
						colored_buttonInner_ImageColor3[4] = nil
						colored_realButton_TextColor3[4] = nil
						if lockedup then
							colored_button_BackgroundColor3[4] = 1.25
							colored_button_ImageColor3[4] = 1.25
							colored_buttonInner_BackgroundColor3[4] = 1.25
							colored_buttonInner_ImageColor3[4] = 1.25
							colored_realButton_TextColor3[4] = 1.75
						end
						tweenService:Create(button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = (imin and darkenColor(library.colors.main, colored_button_BackgroundColor3[4])) or darkenColor(library.colors.topGradient, colored_button_BackgroundColor3[4]),
							ImageColor3 = (imin and darkenColor(library.colors.main, colored_button_ImageColor3[4])) or darkenColor(library.colors.bottomGradient, colored_button_ImageColor3[4])
						}):Play()
						tweenService:Create(buttonInner, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = darkenColor(library.colors.topGradient, colored_buttonInner_BackgroundColor3[4]),
							ImageColor3 = darkenColor(library.colors.bottomGradient, colored_buttonInner_ImageColor3[4])
						}):Play()
						tweenService:Create(realButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							TextColor3 = darkenColor(library.colors.elementText, colored_realButton_TextColor3[4])
						}):Play()
						realButton.Text = (buttonName and tostring(buttonName)) or "???"
						if Tooltip then
							Tooltip.Disabled = lockedup and true or false
						end
						local newtextsize = textToSize(realButton).X + 14
						if textsize ~= newtextsize then
							textsize = newtextsize
							button.Size = UDim2.fromOffset(textsize, 18)
							if Recursive ~= "Recursive" then
								if buttons and buttons.UpdateAll then
									buttons.UpdateAll()
								end
							end
						end
						return presses, textsize
					end
					Update()
					local objectdata = {
						Options = options,
						Name = buttonName,
						Flag = buttonName,
						Type = "Button",
						Parent = sectionFunctions,
						Instance = realButton,
						Frame = fram or newButton,
						Container = fram or newButton,
						DisplayName = buttonName,
						ButtonFrame = button,
						Remove = function()
							if button then
								button.Parent = nil
								buttons.UpdateAll()
								sectionFunctions.UpdateAll()
							end
						end,
						Press = function(...)
							if lockedup then
								return presses
							end
							if options.Condition ~= nil and type(options.Condition) == "function" then
								local v, e = pcall(options.Condition, presses)
								if e then
									if v then
									else
										warn(debug.traceback(string.format("Error in button %s's Condition function: %s", buttonName, e), 2))
									end
								else
									return presses
								end
							end
							local args = {...}
							local a1 = args[1]
							if a1 and type(a1) == "table" then
								table.remove(args, 1)
							end
							presses = 1 + presses
							task.spawn(callback, presses, ...)
							return presses
						end,
						RawPress = function(...)
							local args = {...}
							local a1 = args[1]
							if a1 and type(a1) == "table" then
								table.remove(args, 1)
							end
							task.spawn(callback, presses, ...)
							return presses
						end,
						Get = function()
							return callback, presses
						end,
						SetLocked = function(t, state)
							if type(t) ~= "table" then
								state = t
							end
							local last_v = lockedup
							if state == nil then
								lockedup = not lockedup
							else
								lockedup = state
							end
							if lockedup ~= last_v then
								Update()
							end
							return lockedup
						end,
						Lock = function()
							if not lockedup then
								lockedup = true
								Update()
							end
							return lockedup
						end,
						Unlock = function()
							if lockedup then
								lockedup = false
								Update()
							end
							return lockedup
						end,
						SetCondition = function(t, condition)
							if type(t) ~= "table" and condition == nil then
								condition = t
							end
							options.Condition = condition
							return condition
						end,
						Update = Update,
						SetText = function(t, str)
							if type(t) ~= "table" and str == nil then
								str = t
							end
							buttonName = str
							options.Name = str
							realButton.Text = (buttonName and tostring(buttonName)) or "???"
							return str
						end,
						SetCallback = function(t, call)
							if type(t) ~= "table" and call == nil then
								call = t
							end
							options.Callback = call
							callback = call
							return call
						end
					}
					-- Disabled = grau/unklickbar machen (Alias auf das bestehende Locked-System)
					objectdata.SetDisabled = objectdata.SetLocked
					objectdata.Disable = objectdata.Lock
					objectdata.Enable = objectdata.Unlock
					tabFunctions.Flags[buttonName], sectionFunctions.Flags[buttonName], elements[buttonName] = objectdata, objectdata, objectdata
					buttons[1 + #buttons] = objectdata
					framButtons[1 + #framButtons] = objectdata
				end
				function buttons.PressAll()
					for _, v in next, buttons do
						v.Press()
					end
				end
				function buttons.UpdateAll()
					for fram, Fram in next, frames do
						if Fram and fram then
							local offset = 0
							for _, v in next, Fram do
								if v and v.Instance and fram:IsAncestorOf(v.Instance) then
									local _, textsize = v.Update("Recursive")
									textsize = tonumber(textsize) or (textToSize(v.Instance).X + 14)
									v.ButtonFrame.Position = UDim2.new(0.031, offset, 0.166)
									offset = offset + textsize + 6
								end
							end
						end
					end
				end
				buttons.Update = buttons.UpdateAll
				function buttons.RemoveAll()
					for _, v in next, buttons do
						v.Remove()
					end
				end
				function buttons.Remove()
					for fram in next, frames do
						if fram then
							fram.Parent = nil
						end
					end
				end
				if #buttons == 1 then
					for k, v in next, buttons[1] do
						if buttons[k] == nil then
							buttons[k] = v
						end
					end
				end
				return buttons
			end
			sectionFunctions.CreateButton = sectionFunctions.AddButton
			sectionFunctions.NewButton = sectionFunctions.AddButton
			sectionFunctions.Button = sectionFunctions.AddButton
			function sectionFunctions:AddTextbox(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Textbox", options, ...)) or options
				local textboxName, presetValue, placeholder, callback, flagName = assert(options.Name, "Missing Name for new textbox."), options.Value, options.Placeholder, options.Callback, options.Flag or (function()
					library.unnamedtextboxes = 1 + (library.unnamedtextboxes or 0)
					return "Textbox" .. tostring(library.unnamedtextboxes)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local requiredtype = options.Type
				local newTextbox = Instance_new("Frame")
				local textbox = Instance_new("ImageLabel")
				local textboxInner = Instance_new("ImageLabel")
				local realTextbox = Instance_new("TextBox")
				local textboxHeadline = Instance_new("TextLabel")
				newTextbox.Name = generateRandomName() .. "Holder"
				newTextbox.Parent = sectionHolder
				newTextbox.BackgroundColor3 = Color3.new(1, 1, 1)
				newTextbox.BackgroundTransparency = 1
				newTextbox.Size = UDim2.new(1, 0, 0, 42)
				textbox.Name = generateRandomName()
				textbox.Parent = newTextbox
				textbox.Active = true
				textbox.BackgroundColor3 = library.colors.topGradient
				local colored_textbox_BackgroundColor3 = {textbox, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_textbox_BackgroundColor3
				textbox.BorderSizePixel = 0
				do
					local textboxStroke = Instance_new("UIStroke")
					textboxStroke.Name = generateRandomName()
					textboxStroke.Parent = textbox
					textboxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					textboxStroke.Thickness = 1
					textboxStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {textboxStroke, "Color", "elementBorder"}
				end
				textbox.Position = UDim2.fromScale(0.031, 0.48)
				textbox.Selectable = true
				textbox.Size = UDim2.new(0.938, 0, 0, 18) -- relativ statt fest 206px, sonst ragt es in schmalen Groupboxen raus
				textbox.Image = "rbxassetid://2454009026"
				addCorner(textbox, 4)
				textbox.ImageColor3 = library.colors.bottomGradient
				local colored_textbox_ImageColor3 = {textbox, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_textbox_ImageColor3
				textboxInner.Name = generateRandomName()
				textboxInner.Parent = textbox
				textboxInner.Active = true
				textboxInner.AnchorPoint = Vector2.new(0.5, 0.5)
				textboxInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {textboxInner, "BackgroundColor3", "topGradient"}
				textboxInner.BorderSizePixel = 0
				do
					local textboxInnerStroke = Instance_new("UIStroke")
					textboxInnerStroke.Name = generateRandomName()
					textboxInnerStroke.Parent = textboxInner
					textboxInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					textboxInnerStroke.Thickness = 1
					textboxInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {textboxInnerStroke, "Color", "elementBorder"}
				end
				textboxInner.Position = UDim2.fromScale(0.5, 0.5)
				textboxInner.Selectable = true
				textboxInner.Size = UDim2.new(1, -4, 1, -4)
				textboxInner.Image = "rbxassetid://2454009026"
				addCorner(textboxInner, 4)
				textboxInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {textboxInner, "ImageColor3", "bottomGradient"}
				realTextbox.Name = generateRandomName()
				if options.Rich or options.RichText or options.RichTextBox then
					realTextbox.RichText = true
				end
				if options.MultiLine or options.Lines then
					realTextbox.MultiLine = true
				end
				if options.Font or options.TextFont then
					realTextbox.Font = options.Font
				end
				if options.TextScaled or options.Scaled then
					realTextbox.TextScaled = true
				end
				realTextbox.BackgroundColor3 = Color3.new(1, 1, 1)
				realTextbox.BackgroundTransparency = 1
				realTextbox.Position = UDim2.new(0.0295485705)
				realTextbox.Size = UDim2.fromScale(0.97, 1)
				realTextbox.ZIndex = 5
				realTextbox.Font = Enum.Font.Code
				realTextbox.LineHeight = 1.15
				realTextbox.Text = tostring(presetValue)
				realTextbox.TextColor3 = library.colors.otherElementText
				colored[1 + #colored] = {realTextbox, "TextColor3", "otherElementText"}
				realTextbox.TextSize = 14
				if options.ClearTextOnFocus or options.ClearText then
					realTextbox.ClearTextOnFocus = true
				else
					realTextbox.ClearTextOnFocus = false
				end
				realTextbox.PlaceholderText = (placeholder ~= nil and tostring(placeholder)) or (presetValue ~= nil and tostring(presetValue)) or ""
				realTextbox.TextXAlignment = Enum.TextXAlignment.Left
				if options.CustomProperties and type(options.CustomProperties) == "table" then
					for k, v in next, options.CustomProperties do
						local oof, e = pcall(function()
							realTextbox[k] = v
						end)
						if not oof and e then
							warn("Error setting Textbox", flagName, "|", e, debug.traceback(""))
						end
					end
				end
				realTextbox.Parent = textbox
				textboxHeadline.Name = generateRandomName()
				textboxHeadline.Parent = newTextbox
				textboxHeadline.Active = true
				textboxHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				textboxHeadline.BackgroundTransparency = 1
				textboxHeadline.Position = UDim2.new(0.031)
				textboxHeadline.Selectable = true
				textboxHeadline.Size = UDim2.new(0.938, 0, 0, 20)
				textboxHeadline.ZIndex = 5
				textboxHeadline.Font = Enum.Font.Code
				textboxHeadline.LineHeight = 1.15
				textboxHeadline.Text = (textboxName and tostring(textboxName)) or "???"
				makeMarquee(textboxHeadline)
				textboxHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {textboxHeadline, "TextColor3", "elementText"}
				textboxHeadline.TextSize = 14
				textboxHeadline.TextXAlignment = Enum.TextXAlignment.Left
				-- Linoria-Feature-Port: Tooltip (Tooltip / DisabledTooltip)
				if typeof(options.Tooltip) == "string" or typeof(options.DisabledTooltip) == "string" then
					library:AddToolTip(options.Tooltip, options.DisabledTooltip, newTextbox)
				end
				sectionFunctions:Update()
				local last_v = presetValue
				local function resolvevalue(val)
					if options.PreFormat then
						local typ = type(options.PreFormat)
						if typ == "function" then
							local x, e = pcall(options.PreFormat, val)
							if not x and e then
								warn("Error in Pre-Format (Textbox " .. flagName .. "):", e)
							else
								val = e
							end
						end
					end
					if requiredtype == "number" then
						if not options.Hex and not options.Binary and not options.Base then
							val = tonumber(val) or tonumber(val:gsub("%D", ""), 10) or 0
						else
							val = tonumber(val, (options.Hex and 16) or (options.Binary and 2) or options.Base or 10) or 0
						end
						if options.Max or options.Min then
							val = math.clamp(val, options.Min or -math.huge, options.Max or math.huge)
						end
						local decimalprecision = tonumber(options.Decimals or options.Precision or options.Precise)
						if decimalprecision then
							val = tonumber(string.format("%0." .. tostring(decimalprecision) .. "f", val))
						end
					end
					if options.PostFormat then
						local typ = type(options.PostFormat)
						if typ == "function" then
							local x, e = pcall(options.PostFormat, val)
							if not x and e then
								warn("Error in Post-Format (Textbox " .. flagName .. "):", e)
							else
								val = e
							end
						end
					end
					return (val and tonumber(val)) or val
				end
				library.signals[1 + #library.signals] = realTextbox.FocusLost:Connect(function()
					last_v = library_flags[flagName]
					local val = resolvevalue(realTextbox.Text)
					library_flags[flagName] = val
					if options.Location then
						options.Location[options.LocationFlag or flagName] = val
					end
					if callback and last_v ~= val then
						task.spawn(callback, tostring(val), last_v, realTextbox)
					end
				end)
				library.signals[1 + #library.signals] = newTextbox.MouseEnter:Connect(function()
					colored_textbox_BackgroundColor3[3] = "main"
					colored_textbox_BackgroundColor3[4] = 1.5
					colored_textbox_ImageColor3[3] = "main"
					colored_textbox_ImageColor3[4] = 2.5
					tweenService:Create(textbox, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end)
				library.signals[1 + #library.signals] = newTextbox.MouseLeave:Connect(function()
					colored_textbox_BackgroundColor3[3] = "topGradient"
					colored_textbox_BackgroundColor3[4] = nil
					colored_textbox_ImageColor3[3] = "bottomGradient"
					colored_textbox_ImageColor3[4] = nil
					tweenService:Create(textbox, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = library.colors.topGradient,
						ImageColor3 = library.colors.bottomGradient
					}):Play()
				end)
				local function set(t, str)
					if nil == str and t ~= nil then
						str = t
					end
					last_v = library_flags[flagName]
					library_flags[flagName] = str
					if options.Location then
						options.Location[options.LocationFlag or flagName] = str
					end
					local sstr = (str ~= nil and tostring(str)) or "Empty Text"
					if realTextbox.Text ~= sstr then
						realTextbox.Text = sstr
					end
					if callback and (last_v ~= str or options.AllowDuplicateCalls) then
						task.spawn(callback, str, last_v, realTextbox)
					end
					return str
				end
				if presetValue ~= nil then
					set(presetValue)
				else
					library_flags[flagName] = presetValue
					if options.Location then
						options.Location[options.LocationFlag or flagName] = presetValue
					end
				end
				local default = library_flags[flagName]
				local function update()
					textboxName, placeholder, callback = options.Name or textboxName, options.Placeholder or placeholder, options.Callback
					local str = library_flags[flagName]
					str = (str ~= nil and tostring(str)) or "Empty Text"
					if realTextbox.Text ~= str then
						realTextbox.Text = str
					end
					textboxHeadline.Text = (textboxName and tostring(textboxName)) or "???"
					return str
				end
				local objectdata = {
					Options = options,
					Name = flagName,
					Flag = flagName,
					Type = "Textbox",
					Default = default,
					Parent = sectionFunctions,
					Instance = realTextbox,
					Container = newTextbox,
					DisplayName = textboxName,
					Get = function()
						return library_flags[flagName]
					end,
					Set = set,
					Update = update,
					Remove = function()
						if newTextbox then
							newTextbox.Parent = nil
							sectionFunctions:Update()
						end
					end,
					RawSet = function(t, str)
						if t ~= nil and str == nil then
							str = t
						end
						last_v = library_flags[flagName]
						library_flags[flagName] = str
						if options.Location then
							options.Location[options.LocationFlag or flagName] = str
						end
						update()
						return str
					end,
					Reset = function()
						return set(nil, default)
					end
				}
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.AddTextBox = sectionFunctions.AddTextbox
			sectionFunctions.NewTextBox = sectionFunctions.AddTextbox
			sectionFunctions.CreateTextBox = sectionFunctions.AddTextbox
			sectionFunctions.TextBox = sectionFunctions.AddTextbox
			sectionFunctions.NewTextbox = sectionFunctions.AddTextbox
			sectionFunctions.CreateTextbox = sectionFunctions.AddTextbox
			sectionFunctions.Textbox = sectionFunctions.AddTextbox
			sectionFunctions.Box = sectionFunctions.AddTextbox
			function sectionFunctions:AddKeybind(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Keybind", options, ...)) or options
				local keybindName, presetKeybind, callback, presscallback, flag = assert(options.Name, "Missing Name for new keybind."), options.Value, options.Callback, options.Pressed, options.Flag or (function()
					library.unnamedkeybinds = 1 + (library.unnamedkeybinds or 0)
					return "Keybind" .. tostring(library.unnamedkeybinds)
				end)()
				local IsCore = (options.CoreBinding and true) or nil
				if elements[flag] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flag .. "'", 3))
				end
				library.keyHandler = keyHandler
				local keyHandler = options.KeyNames or keyHandler
				local newKeybind = Instance_new("Frame")
				local keybindHeadline = Instance_new("TextLabel")
				local keybindPositioner = Instance_new("Frame")
				local keybindList = Instance_new("UIListLayout")
				local keybindButton = Instance_new("TextButton")
				local bindedKey = presetKeybind
				local justBinded = false
				local keyName = (presetKeybind and tostring(presetKeybind):gsub("Enum.KeyCode.", "") or "")
				newKeybind.Name = generateRandomName()
				newKeybind.Parent = sectionHolder
				newKeybind.BackgroundColor3 = Color3.new(1, 1, 1)
				newKeybind.BackgroundTransparency = 1
				newKeybind.Size = UDim2.new(1, 0, 0, 19)
				keybindHeadline.Name = generateRandomName()
				keybindHeadline.Parent = newKeybind
				keybindHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				keybindHeadline.BackgroundTransparency = 1
				keybindHeadline.Position = UDim2.fromScale(0.031, 0.165842161)
				keybindHeadline.Size = UDim2.fromOffset(215, 12)
				keybindHeadline.Font = Enum.Font.Code
				keybindHeadline.Text = (keybindName and tostring(keybindName)) or "???"
				makeMarquee(keybindHeadline)
				keybindHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {keybindHeadline, "TextColor3", "elementText"}
				keybindHeadline.TextSize = 14
				keybindHeadline.TextXAlignment = Enum.TextXAlignment.Left
				-- Linoria-Feature-Port: Tooltip (Tooltip / DisabledTooltip)
				if typeof(options.Tooltip) == "string" or typeof(options.DisabledTooltip) == "string" then
					library:AddToolTip(options.Tooltip, options.DisabledTooltip, newKeybind)
				end
				keybindPositioner.Name = generateRandomName()
				keybindPositioner.Parent = newKeybind
				keybindPositioner.BackgroundColor3 = Color3.new(1, 1, 1)
				keybindPositioner.BackgroundTransparency = 1
				keybindPositioner.Position = UDim2.new(0, 2, 0, 0)
				keybindPositioner.Size = UDim2.new(1, -4, 0, 19) -- relativ statt fest 214px, sonst ragt der Keybind-Button in schmalen (2-spaltigen) Groupboxen raus
				keybindList.Name = generateRandomName()
				keybindList.Parent = keybindPositioner
				keybindList.FillDirection = Enum.FillDirection.Horizontal
				keybindList.HorizontalAlignment = Enum.HorizontalAlignment.Right
				keybindList.SortOrder = Enum.SortOrder.LayoutOrder
				keybindList.VerticalAlignment = Enum.VerticalAlignment.Center
				keybindButton.Name = generateRandomName()
				keybindButton.Parent = keybindPositioner
				keybindButton.Active = false
				keybindButton.BackgroundColor3 = Color3.new(1, 1, 1)
				keybindButton.BackgroundTransparency = 1
				keybindButton.Position = UDim2.fromScale(0.598130822, 0.184210524)
				keybindButton.Selectable = false
				keybindButton.Size = UDim2.fromOffset(46, 12)
				keybindButton.Font = Enum.Font.Code
				keybindButton.Text = "[" .. (presetKeybind and tostring(presetKeybind):gsub("Enum.KeyCode.", "") or "NONE") .. "]"
				keybindButton.TextColor3 = library.colors.otherElementText
				local colored_keybindButton_TextColor3 = {keybindButton, "TextColor3", "otherElementText"}
				colored[1 + #colored] = colored_keybindButton_TextColor3
				keybindButton.TextSize = 14
				keybindButton.TextXAlignment = Enum.TextXAlignment.Right
				keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
				local function syncKbList()
					local shownKey = keybindButton.Text:match("^%[(.-)%]$")
					KeybindsListModule:Upsert(flag, keybindName, shownKey or "NONE")
				end
				syncKbList()
				sectionFunctions:Update()
				local last_v = bindedKey or presetKeybind
				local function newkey()
					local IgnoreKey = nil
					if IsCore then
						IgnoreKey = tick()
						IgnoreCoreInputs = IgnoreKey
					end
					local old_texts = keybindButton.Text
					colored_keybindButton_TextColor3[3] = "main"
					colored_keybindButton_TextColor3[4] = nil
					tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = library.colors.main
					}):Play()
					if last_v then
						keybindButton.Text = "(Was " .. (last_v and tostring(last_v):gsub("Enum.KeyCode.", "") or "[NONE]") .. ") [...]"
					else
						keybindButton.Text = "[...]"
					end
					local receivingKey = nil
					receivingKey = userInputService.InputBegan:Connect(function(key)
						last_v = library_flags[flag]
						if not keyHandler.notAllowedKeys[key.KeyCode] then
							if key.KeyCode ~= Enum.KeyCode.Unknown then
								bindedKey = (key.KeyCode ~= Enum.KeyCode.Escape and key.KeyCode) or library_flags[flag]
								library_flags[flag] = bindedKey
								if options.Location then
									options.Location[options.LocationFlag or flag] = bindedKey
								end
								if bindedKey then
									keyName = keyHandler.allowedKeys[bindedKey]
									keybindButton.Text = "[" .. (keyName or bindedKey.Name or tostring(key.KeyCode):gsub("Enum.KeyCode.", "")) .. "]"
									keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
									syncKbList()
									justBinded = true
									colored_keybindButton_TextColor3[3] = "otherElementText"
									colored_keybindButton_TextColor3[4] = nil
									tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
										TextColor3 = library.colors.otherElementText
									}):Play()
									receivingKey:Disconnect()
								end
								if callback and last_v ~= bindedKey then
									task.spawn(callback, bindedKey, last_v)
								end
								if IsCore then
									delay(0.1, function()
										if IgnoreCoreInputs and (IgnoreCoreInputs == IgnoreKey) then
											IgnoreCoreInputs = nil
										end
									end)
								end
								return
							elseif key.KeyCode == Enum.KeyCode.Unknown and not keyHandler.notAllowedMouseInputs[key.UserInputType] then
								bindedKey = key.UserInputType
								library_flags[flag] = bindedKey
								if options.Location then
									options.Location[options.LocationFlag or flag] = bindedKey
								end
								keyName = keyHandler.allowedKeys[bindedKey]
								keybindButton.Text = "[" .. (keyName or bindedKey.Name or tostring(key.KeyCode):gsub("Enum.KeyCode.", "")) .. "]"
								keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
								syncKbList()
								justBinded = true
								colored_keybindButton_TextColor3[3] = "otherElementText"
								colored_keybindButton_TextColor3[4] = nil
								tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									TextColor3 = library.colors.otherElementText
								}):Play()
								receivingKey:Disconnect()
								if callback and last_v ~= bindedKey then
									task.spawn(callback, bindedKey, last_v)
								end
								if IsCore then
									delay(0.1, function()
										if IgnoreCoreInputs and (IgnoreCoreInputs == IgnoreKey) then
											IgnoreCoreInputs = nil
										end
									end)
								end
								return
							end
						end
						if key.KeyCode == Enum.KeyCode.Backspace or Enum.KeyCode.Escape == key.KeyCode then
							old_texts, bindedKey = "[NONE]", nil
						end
						keybindButton.Text = old_texts
						syncKbList()
						colored_keybindButton_TextColor3[3] = "otherElementText"
						colored_keybindButton_TextColor3[4] = nil
						tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							TextColor3 = library.colors.otherElementText
						}):Play()
						receivingKey:Disconnect()
						if callback and last_v ~= bindedKey then
							task.spawn(callback, bindedKey, last_v)
						end
					end)
					library.signals[1 + #library.signals] = receivingKey
				end
				library.signals[1 + #library.signals] = keybindButton.MouseButton1Click:Connect(newkey)
				library.signals[1 + #library.signals] = newKeybind.InputEnded:Connect(function(input)
					if not library.colorpicker and not submenuOpen and input.UserInputType == Enum.UserInputType.MouseButton1 then
						newkey()
					end
				end)
				if presscallback then
					library.signals[1 + #library.signals] = userInputService.InputBegan:Connect(function(key, chatting)
						if not keyHandler.notAllowedKeys[key.KeyCode] and not keyHandler.notAllowedMouseInputs[key.UserInputType] then
							if not justBinded and bindedKey == key.UserInputType or not justBinded and bindedKey == key.KeyCode and not chatting then
								if presscallback then
									task.spawn(presscallback, key, chatting)
								end
							end
							if justBinded then
								justBinded = false
							end
						end
					end)
				end
				local function set(t, key)
					if (nil == key) and (t ~= nil) then
						key = t
					end
					if (key == "nil") or (key == "NONE") or (key == "none") then
						key = nil
					end
					last_v = library_flags[flag]
					bindedKey = key
					library_flags[flag] = key
					if options.Location then
						options.Location[options.LocationFlag or flag] = key
					end
					keyName = (key == nil and "NONE") or keyHandler.allowedKeys[key]
					keybindButton.Text = "[" .. (keyName or key.Name or tostring(key):gsub("Enum.KeyCode.", "")) .. "]"
					keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
					syncKbList()
					justBinded = true
					colored_keybindButton_TextColor3[3] = "otherElementText"
					colored_keybindButton_TextColor3[4] = nil
					tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = library.colors.otherElementText
					}):Play()
					if callback and ((last_v ~= key) or options.AllowDuplicateCalls) then
						task.spawn(callback, key, last_v)
					end
					return key
				end
				if presetKeybind ~= nil then
					set(presetKeybind)
				else
					library_flags[flag] = bindedKey
					if options.Location then
						options.Location[options.LocationFlag or flag] = bindedKey
					end
				end
				local default = library_flags[flag]
				local function update()
					keybindName, callback, presscallback = options.Name or keybindName, options.Callback, options.Pressed
					local key = library_flags[flag]
					keyName = (key == nil and "NONE") or keyHandler.allowedKeys[key]
					keybindButton.Text = "[" .. (keyName or key.Name or tostring(key):gsub("Enum.KeyCode.", "")) .. "]"
					keybindButton.Size = UDim2.fromOffset(textToSize(keybindButton).X + 4, 12)
					syncKbList()
					colored_keybindButton_TextColor3[3] = "otherElementText"
					colored_keybindButton_TextColor3[4] = nil
					tweenService:Create(keybindButton, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						TextColor3 = library.colors.otherElementText
					}):Play()
					keybindHeadline.Text = (keybindName and tostring(keybindName)) or "???"
					return key
				end
				local objectdata = {
					Options = options,
					Name = flag,
					Flag = flag,
					Type = "Keybind",
					Default = default,
					Parent = sectionFunctions,
					Instance = keybindButton,
					Container = newKeybind,
					DisplayName = keybindName,
					Get = function()
						return library_flags[flag]
					end,
					Set = set,
					Remove = function()
						if newKeybind then
							newKeybind.Parent = nil
							sectionFunctions:Update()
						end
					end,
					RawSet = function(t, key)
						if nil == key and t ~= nil then
							key = t
						end
						if key == "nil" or key == "NONE" or key == "none" then
							key = nil
						end
						last_v = library_flags[flag]
						bindedKey = key
						library_flags[flag] = key
						if options.Location then
							options.Location[options.LocationFlag or flag] = key
						end
						justBinded = true
						return key
					end,
					Update = update,
					Reset = function()
						return set(nil, default)
					end
				}
				tabFunctions.Flags[flag], sectionFunctions.Flags[flag], elements[flag] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.NewKeybind = sectionFunctions.AddKeybind
			sectionFunctions.CreateKeybind = sectionFunctions.AddKeybind
			sectionFunctions.Keybind = sectionFunctions.AddKeybind
			sectionFunctions.Bind = sectionFunctions.AddKeybind
			function sectionFunctions:AddLabel(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Label", options, ...)) or options
				local labelName, flag = options.Text or options.Value or options.Name, options.Flag or (function()
					library.unnamedlabels = 1 + (library.unnamedlabels or 0)
					return "Label" .. tostring(library.unnamedlabels)
				end)()
				if elements[flag] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flag .. "'", 3))
				end
				local newLabel = Instance_new("Frame")
				local labelHeadline = Instance_new("TextLabel")
				local labelPositioner = Instance_new("Frame")
				local labelButton = Instance_new("TextButton")
				newLabel.Name = generateRandomName()
				newLabel.Parent = sectionHolder
				newLabel.BackgroundColor3 = Color3.new(1, 1, 1)
				newLabel.BackgroundTransparency = 1
				newLabel.Size = UDim2.new(1, 0, 0, 19)
				labelHeadline.Name = generateRandomName()
				labelHeadline.Parent = newLabel
				labelHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				labelHeadline.BackgroundTransparency = 1
				labelHeadline.Position = UDim2.new(0.031, 0, 0.165842161, 0)
				labelHeadline.Size = UDim2.new(0.969, -8, 0, 12) -- relativ statt fest 215px, sonst ragt die Laufschrift bei langen Labels über den Groupbox-Rand (wie bei Toggles/Dropdowns)
				labelHeadline.Font = Enum.Font.Code
				labelHeadline.Text = (labelName and tostring(labelName)) or "Empty Text"
				local labelHeadlineRefresh = makeMarquee(labelHeadline)
				labelHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {labelHeadline, "TextColor3", "elementText"}
				labelHeadline.TextSize = 14
				labelHeadline.TextXAlignment = Enum.TextXAlignment.Left
				-- Linoria-Feature-Port: Tooltip (Tooltip / DisabledTooltip)
				if typeof(options.Tooltip) == "string" or typeof(options.DisabledTooltip) == "string" then
					library:AddToolTip(options.Tooltip, options.DisabledTooltip, newLabel)
				end
				labelPositioner.Name = generateRandomName()
				labelPositioner.Parent = newLabel
				labelPositioner.BackgroundColor3 = Color3.new(1, 1, 1)
				labelPositioner.BackgroundTransparency = 1
				labelPositioner.Position = UDim2.new(0.00448430516)
				labelPositioner.Size = UDim2.fromOffset(214, 19)
				sectionFunctions:Update()
				local function set(t, str)
					if nil == str and t ~= nil then
						str = t
					end
					labelHeadline.Text = (nil ~= str and tostring(str)) or "Empty Text"
					labelHeadlineRefresh()
					return str
				end
				local default = labelHeadline.Text
				local objectdata = {
					Options = options,
					Name = flag,
					Flag = flag,
					Type = "Label",
					Default = default,
					Parent = sectionFunctions,
					Instance = labelHeadline,
					Container = newLabel,
					DisplayName = labelName,
					Get = function()
						return labelHeadline.Text, labelHeadline
					end,
					Set = set,
					SetText = set,
					Remove = function()
						if newLabel then
							newLabel.Parent = nil
							sectionFunctions:Update()
						end
					end,
					RawSet = set,
					Update = function()
						return labelHeadline.Text
					end,
					Reset = function()
						return set(nil, default)
					end
				}
				tabFunctions.Flags[flag], sectionFunctions.Flags[flag], elements[flag] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.NewLabel = sectionFunctions.AddLabel
			sectionFunctions.CreateLabel = sectionFunctions.AddLabel
			sectionFunctions.Label = sectionFunctions.AddLabel
			sectionFunctions.Text = sectionFunctions.AddLabel
			function sectionFunctions:AddSlider(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Slider", options, ...)) or options
				local sliderName, maxValue, minValue, presetValue, callback, flagName = assert(options.Name, "Missing Name for new slider."), assert(options.Max, "Missing Max for new slider."), assert(options.Min, "Missing Min for new slider."), options.Value, options.Callback, options.Flag or (function()
					library.unnamedsliders = 1 + (library.unnamedsliders or 0)
					return "Slider" .. tostring(library.unnamedsliders)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local decimalprecision = tonumber(options.Decimals or options.Precision or options.Precise)
				if not decimalprecision and options.Max - options.Min <= 1 then
					decimalprecision = 1
				end
				if decimalprecision then
					decimalprecision = math.clamp(decimalprecision, 0, 99)
					if decimalprecision <= 0 then
						decimalprecision = nil
					end
					decimalprecision = tostring(decimalprecision)
				end
				local formattyp = options.Format and type(options.Format)
				local function resolvedisplay(val, was)
					local str = nil
					if decimalprecision then
						str = string.format("%0." .. decimalprecision .. "f", val)
					end
					str = str or tostring(val)
					if formattyp == "string" then
						return string.format(options.Format, val)
					elseif formattyp == "function" then
						local oof, g = pcall(options.Format, val, was)
						if not oof or not g then
							warn("Your format function for", sliderName, "Slider:", flagName, "has returned nothing. It should return a string to display.", debug.traceback(""))
							return "Format Function Errored"
						end
						return tostring(g)
					end
					return (sliderName or "???") .. ": " .. str
				end
				local usetextbox = options.Textbox or options.InputBox or options.CustomInput
				local newSlider = Instance_new("Frame")
				local slider = Instance_new("ImageLabel")
				local sliderInner = Instance_new("ImageLabel")
				local sliderColored = Instance_new("ImageLabel")
				local sliderHeadline = Instance_new("TextLabel")
				local startingValue = presetValue or minValue
				local sliderDragging = false
				newSlider.Name = generateRandomName()
				newSlider.Parent = sectionHolder
				newSlider.BackgroundColor3 = Color3.new(1, 1, 1)
				newSlider.BackgroundTransparency = 1
				newSlider.Size = UDim2.new(1, 0, 0, 42)
				slider.Name = generateRandomName()
				slider.Parent = newSlider
				slider.Active = true
				slider.BackgroundColor3 = library.colors.topGradient
				local colored_slider_BackgroundColor3 = {slider, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_slider_BackgroundColor3
				slider.BorderSizePixel = 0
				do
					local sliderStroke = Instance_new("UIStroke")
					sliderStroke.Name = generateRandomName()
					sliderStroke.Parent = slider
					sliderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					sliderStroke.Thickness = 1
					sliderStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {sliderStroke, "Color", "elementBorder"}
				end
				slider.Position = UDim2.fromScale(0.031, 0.48)
				slider.Selectable = true
				slider.Size = (usetextbox and UDim2.new(0.969, -60, 0, 18)) or UDim2.new(0.938, 0, 0, 18) -- relativ statt fest 156/206px, sonst ragt es in schmalen Groupboxen raus
				slider.Image = "rbxassetid://2454009026"
				addCorner(slider, 4)
				slider.ImageColor3 = library.colors.bottomGradient
				local colored_slider_ImageColor3 = {slider, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_slider_ImageColor3
				sliderInner.Name = generateRandomName()
				sliderInner.Parent = slider
				sliderInner.Active = true
				sliderInner.AnchorPoint = Vector2.new(0.5, 0.5)
				sliderInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {sliderInner, "BackgroundColor3", "topGradient"}
				sliderInner.BorderSizePixel = 0
				do
					local sliderInnerStroke = Instance_new("UIStroke")
					sliderInnerStroke.Name = generateRandomName()
					sliderInnerStroke.Parent = sliderInner
					sliderInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					sliderInnerStroke.Thickness = 1
					sliderInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {sliderInnerStroke, "Color", "elementBorder"}
				end
				sliderInner.Position = UDim2.fromScale(0.5, 0.5)
				sliderInner.Selectable = true
				sliderInner.Size = UDim2.new(1, -4, 1, -4)
				sliderInner.Image = "rbxassetid://2454009026"
				addCorner(sliderInner, 4)
				sliderInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {sliderInner, "ImageColor3", "bottomGradient"}
				sliderColored.Name = generateRandomName()
				sliderColored.Parent = sliderInner
				sliderColored.Active = true
				sliderColored.BackgroundColor3 = darkenColor(library.colors.main, 1.5)
				colored[1 + #colored] = {sliderColored, "BackgroundColor3", "main", 1.5}
				sliderColored.BorderSizePixel = 0
				sliderColored.Selectable = true
				sliderColored.Size = UDim2.fromScale(((startingValue or minValue) - minValue) / (maxValue - minValue), 1)
				sliderColored.Image = "rbxassetid://2454009026"
				addCorner(sliderColored, 4)
				sliderColored.ImageColor3 = darkenColor(library.colors.main, 2.5)
				colored[1 + #colored] = {sliderColored, "ImageColor3", "main", 2.5}
				sliderHeadline.Name = generateRandomName()
				sliderHeadline.Parent = newSlider
				sliderHeadline.Active = true
				sliderHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				sliderHeadline.BackgroundTransparency = 1
				sliderHeadline.Position = UDim2.new(0.031)
				sliderHeadline.Selectable = true
				sliderHeadline.Size = UDim2.new(0.938, 0, 0, 20)
				sliderHeadline.ZIndex = 5
				sliderHeadline.Font = Enum.Font.Code
				sliderHeadline.LineHeight = 1.15
				sliderHeadline.Text = resolvedisplay(startingValue)
				local sliderHeadlineRefresh = makeMarquee(sliderHeadline)
				sliderHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {sliderHeadline, "TextColor3", "elementText"}
				sliderHeadline.TextSize = 14
				sliderHeadline.TextXAlignment = Enum.TextXAlignment.Left
				-- Linoria-Feature-Port: Tooltip (Tooltip / DisabledTooltip)
				if typeof(options.Tooltip) == "string" or typeof(options.DisabledTooltip) == "string" then
					library:AddToolTip(options.Tooltip, options.DisabledTooltip, newSlider)
				end
				local realTextbox = nil
				local function Set(t, newValue)
					if nil == newValue and t ~= nil then
						newValue = t
					end
					minValue, maxValue = options.Min, options.Max
					if newValue and (options.IllegalInput or ((not minValue or newValue >= minValue) and (not maxValue or newValue <= maxValue))) then
						local last_val = library_flags[flagName]
						library_flags[flagName] = newValue
						if options.Location then
							options.Location[options.LocationFlag or flagName] = newValue
						end
						do
							local newValue = (options.IllegalInput and math.clamp(newValue, minValue or -math.huge, maxValue or math.huge)) or newValue
							tweenService:Create(sliderColored, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
								Size = UDim2.fromScale(((newValue or minValue) - minValue) / (maxValue - minValue), 1)
							}):Play()
						end
						sliderHeadline.Text = resolvedisplay(newValue, last_val)
						sliderHeadlineRefresh()
						if usetextbox and realTextbox then
							realTextbox.Text = tostring(newValue)
						end
						if callback and (last_val ~= newValue or options.AllowDuplicateCalls) then
							task.spawn(callback, newValue, last_val)
						end
					end
					return newValue
				end
				if presetValue ~= nil then
					Set(presetValue)
				else
					library_flags[flagName] = startingValue
					if options.Location then
						options.Location[options.LocationFlag or flagName] = startingValue
					end
				end
				if usetextbox then
					if type(usetextbox) ~= "table" then
						usetextbox = options
					end
					local textbox = Instance_new("ImageLabel")
					local textboxInner = Instance_new("ImageLabel")
					realTextbox = Instance_new("TextBox")
					textbox.Name = generateRandomName()
					textbox.Parent = newSlider
					textbox.Active = true
					textbox.BackgroundColor3 = library.colors.topGradient
					local colored_textbox_BackgroundColor3 = {textbox, "BackgroundColor3", "topGradient"}
					colored[1 + #colored] = colored_textbox_BackgroundColor3
					textbox.BorderSizePixel = 0
					do
						local textboxStroke = Instance_new("UIStroke")
						textboxStroke.Name = generateRandomName()
						textboxStroke.Parent = textbox
						textboxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
						textboxStroke.Thickness = 1
						textboxStroke.Color = library.colors.elementBorder
						colored[1 + #colored] = {textboxStroke, "Color", "elementBorder"}
					end
					textbox.Position = UDim2.new(1, -54, 0.48)
					textbox.Selectable = true
					textbox.Size = UDim2.fromOffset(43, 18)
					textbox.Image = "rbxassetid://2454009026"
					addCorner(textbox, 4)
					textbox.ImageColor3 = library.colors.bottomGradient
					local colored_textbox_ImageColor3 = {textbox, "ImageColor3", "bottomGradient"}
					colored[1 + #colored] = colored_textbox_ImageColor3
					textboxInner.Name = generateRandomName()
					textboxInner.Parent = textbox
					textboxInner.Active = true
					textboxInner.AnchorPoint = Vector2.new(0.5, 0.5)
					textboxInner.BackgroundColor3 = library.colors.topGradient
					colored[1 + #colored] = {textboxInner, "BackgroundColor3", "topGradient"}
					textboxInner.BorderSizePixel = 0
					do
						local textboxInnerStroke = Instance_new("UIStroke")
						textboxInnerStroke.Name = generateRandomName()
						textboxInnerStroke.Parent = textboxInner
						textboxInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
						textboxInnerStroke.Thickness = 1
						textboxInnerStroke.Color = library.colors.elementBorder
						colored[1 + #colored] = {textboxInnerStroke, "Color", "elementBorder"}
					end
					textboxInner.Position = UDim2.fromScale(0.5, 0.5)
					textboxInner.Selectable = true
					textboxInner.Size = UDim2.new(1, -4, 1, -4)
					textboxInner.Image = "rbxassetid://2454009026"
					addCorner(textboxInner, 4)
					textboxInner.ImageColor3 = library.colors.bottomGradient
					colored[1 + #colored] = {textboxInner, "ImageColor3", "bottomGradient"}
					realTextbox.Name = generateRandomName()
					realTextbox.Parent = textbox
					realTextbox.BackgroundColor3 = Color3.new(1, 1, 1)
					realTextbox.BackgroundTransparency = 1
					realTextbox.Position = UDim2.new(0.0295485705)
					realTextbox.Size = UDim2.fromScale(0.97, 1)
					realTextbox.ZIndex = 5
					realTextbox.ClearTextOnFocus = false
					realTextbox.Font = Enum.Font.Code
					realTextbox.LineHeight = 1.15
					realTextbox.Text = tostring(presetValue)
					realTextbox.TextColor3 = library.colors.otherElementText
					colored[1 + #colored] = {realTextbox, "TextColor3", "otherElementText"}
					realTextbox.TextSize = 14
					realTextbox.PlaceholderText = (presetValue ~= nil and tostring(presetValue)) or ""
					library.signals[1 + #library.signals] = realTextbox.FocusLost:Connect(function()
						local val = realTextbox.Text
						if usetextbox.PreFormat then
							local typ = type(usetextbox.PreFormat)
							if typ == "function" then
								local x, e = pcall(usetextbox.PreFormat, val)
								if not x and e then
									warn("Error in Pre-Format (Textbox " .. flagName .. "):", e)
								else
									val = e
								end
							end
						end
						val = (not usetextbox.Hex and not usetextbox.Binary and not usetextbox.Base and (tonumber(val) or tonumber(val:gsub("%D", ""), 10) or 0)) or tonumber(val, (usetextbox.Hex and 16) or (usetextbox.Binary and 2) or usetextbox.Base or 10) or 0
						if not options.IllegalInput and (options.Max or options.Min) then
							val = math.clamp(val, options.Min or -math.huge, options.Max or math.huge)
						end
						local decimalprecision = tonumber(options.Decimals or options.Precision or options.Precise)
						if decimalprecision then
							val = tonumber(string.format("%0." .. tostring(decimalprecision) .. "f", val))
						end
						if usetextbox.PostFormat then
							local typ = type(usetextbox.PostFormat)
							if typ == "function" then
								local x, e = pcall(usetextbox.PostFormat, val)
								if not x and e then
									warn("Error in Post-Format (Textbox " .. flagName .. "):", e)
								else
									val = e
								end
							end
						end
						Set((val and tonumber(val)) or presetValue or 0)
					end)
					library.signals[1 + #library.signals] = textbox.MouseEnter:Connect(function()
						colored_textbox_BackgroundColor3[3] = "main"
						colored_textbox_BackgroundColor3[4] = 1.5
						colored_textbox_ImageColor3[3] = "main"
						colored_textbox_ImageColor3[4] = 2.5
						tweenService:Create(textbox, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = darkenColor(library.colors.main, 1.5),
							ImageColor3 = darkenColor(library.colors.main, 2.5)
						}):Play()
					end)
					library.signals[1 + #library.signals] = textbox.MouseLeave:Connect(function()
						colored_textbox_BackgroundColor3[3] = "topGradient"
						colored_textbox_BackgroundColor3[4] = nil
						colored_textbox_ImageColor3[3] = "bottomGradient"
						colored_textbox_ImageColor3[4] = nil
						tweenService:Create(textbox, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
					end)
				end
				sectionFunctions:Update()
				library.signals[1 + #library.signals] = slider.MouseEnter:Connect(function()
					colored_slider_BackgroundColor3[3] = "main"
					colored_slider_BackgroundColor3[4] = 1.5
					colored_slider_ImageColor3[3] = "main"
					colored_slider_ImageColor3[4] = 2.5
					tweenService:Create(slider, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end)
				library.signals[1 + #library.signals] = slider.MouseLeave:Connect(function()
					colored_slider_BackgroundColor3[3] = "topGradient"
					colored_slider_BackgroundColor3[4] = nil
					colored_slider_ImageColor3[3] = "bottomGradient"
					colored_slider_ImageColor3[4] = nil
					tweenService:Create(slider, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = library.colors.topGradient,
						ImageColor3 = library.colors.bottomGradient
					}):Play()
				end)
				local function sliding(input, sb, sc)
					local last_val = library_flags[flagName]
					local pos = UDim2.fromScale(math.clamp((input.Position.X - sb.AbsolutePosition.X) / sb.AbsoluteSize.X, 0, 1), 1)
					tweenService:Create(sc, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
						Size = pos
					}):Play()
					local sliderValue = nil
					if decimalprecision then
						sliderValue = tonumber(string.format("%0." .. decimalprecision .. "f", ((pos.X.Scale * maxValue) / maxValue) * (maxValue - minValue) + minValue))
					end
					sliderValue = sliderValue or tonumber(string.format("%0.2f", (floor(((pos.X.Scale * maxValue) / maxValue) * (maxValue - minValue) + minValue))))
					library_flags[flagName] = sliderValue
					if options.Location then
						options.Location[options.LocationFlag or flagName] = sliderValue
					end
					sliderHeadline.Text = resolvedisplay(sliderValue, last_val)
					sliderHeadlineRefresh()
					if usetextbox and realTextbox then
						realTextbox.Text = tostring(sliderValue)
					end
					if callback and last_val ~= sliderValue then
						task.spawn(callback, sliderValue, last_val)
					end
					last_val = sliderValue
				end
				library.signals[1 + #library.signals] = newSlider.InputBegan:Connect(function(input)
					if not library.colorpicker and input.UserInputType == Enum.UserInputType.MouseButton1 then
						sliderDragging = true
						isDraggingSomething = true
					end
				end)
				library.signals[1 + #library.signals] = newSlider.InputEnded:Connect(function(input)
					if not library.colorpicker and input.UserInputType == Enum.UserInputType.MouseButton1 then
						sliderDragging = false
						isDraggingSomething = false
					end
				end)
				library.signals[1 + #library.signals] = newSlider.InputBegan:Connect(function(input)
					if not library.colorpicker and not isDraggingSomething and input.UserInputType == Enum.UserInputType.MouseButton1 then
						isDraggingSomething = true
						sliding(input, sliderInner, sliderColored)
					end
				end)
				library.signals[1 + #library.signals] = userInputService.InputChanged:Connect(function(input)
					if not library.colorpicker and sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						sliding(input, sliderInner, sliderColored)
					end
				end)
				local default = library_flags[flagName]
				local function Update(t, last_val)
					if last_val == nil and t ~= nil and type(t) ~= "table" then
						last_val = t
					end
					sliderName, maxValue, minValue, callback = options.Name or sliderName, options.Max or maxValue, options.Min or minValue, options.Callback
					local newValue = library_flags[flagName]
					do
						local newValue = math.clamp(newValue, options.Min or -math.huge, options.Max or math.huge)
						tweenService:Create(sliderColored, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
							Size = UDim2.fromScale(((newValue or minValue) - minValue) / (maxValue - minValue), 1)
						}):Play()
					end
					sliderHeadline.Text = resolvedisplay(newValue, last_val)
					sliderHeadlineRefresh()
					if usetextbox and realTextbox then
						realTextbox.Text = tostring(newValue)
					end
					return newValue
				end
				local objectdata = {
					Options = options,
					Name = flagName,
					Flag = flagName,
					Type = "Slider",
					Default = default,
					Parent = sectionFunctions,
					Instance = sliderHeadline,
					Container = newSlider,
					DisplayName = sliderName,
					Set = Set,
					Get = function()
						return library_flags[flagName]
					end,
					SetConstraints = function(t, min, max)
						if t and type(t) ~= "table" then
							min, max = t, min
						end
						if min then
							options.Min = min
						end
						if max then
							options.Max = max
						end
						Update()
					end,
					SetMin = function(t, min)
						if min == nil and t ~= nil then
							min = t
						end
						if min and min ~= options.Min then
							options.Min = min
							Update()
						end
					end,
					SetMax = function(t, max)
						if max == nil and t ~= nil then
							max = t
						end
						if max and max ~= options.Max then
							options.Max = max
							Update()
						end
					end,
					Update = Update,
					Remove = function()
						if newSlider then
							newSlider.Parent = nil
							sectionFunctions:Update()
						end
					end,
					RawSet = function(t, newValue)
						if nil == newValue and t ~= nil then
							newValue = t
						end
						local last_val = library_flags[flagName]
						library_flags[flagName] = newValue
						if options.Location then
							options.Location[options.LocationFlag or flagName] = newValue
						end
						Update(nil, last_val)
					end,
					Reset = function()
						return Set(nil, default)
					end
				}
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.NewSlider = sectionFunctions.AddSlider
			sectionFunctions.CreateSlider = sectionFunctions.AddSlider
			sectionFunctions.NumberConstraint = sectionFunctions.AddSlider
			sectionFunctions.Slider = sectionFunctions.AddSlider
			sectionFunctions.Slide = sectionFunctions.AddSlider
			function sectionFunctions:AddSearchBox(options, ...)
				options = (options and (type(options) == "string") and resolvevararg("SearchBox", options, ...)) or options
				local dropdownName, listt, val, callback, flagName = assert(options.Name, "Missing Name for new searchbox."), assert(options.List, "Missing List for new searchbox."), options.Value, options.Callback, options.Flag or (function()
					library.unnamedsearchbox = 1 + (library.unnamedsearchbox or 0)
					return "SearchBox" .. tostring(library.unnamedsearchbox)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local newDropdown = Instance_new("Frame")
				local dropdown = Instance_new("ImageLabel")
				local dropdownInner = Instance_new("ImageLabel")
				local dropdownToggle = Instance_new("ImageButton")
				local dropdownSelection = Instance_new("TextBox")
				local dropdownHeadline = Instance_new("TextLabel")
				local dropdownHolderFrame = Instance_new("ImageLabel")
				local dropdownHolderInner = Instance_new("ImageLabel")
				local realDropdownHolder = Instance_new("ScrollingFrame")
				local realDropdownHolderList = Instance_new("UIListLayout")
				local dropdownEnabled = false
				local resolvelist = getresolver(listt, options.Filter)
				local list = resolvelist()
				if next(list) then
				else
					local EmptyVal = options.EmptyValue
					if EmptyVal ~= nil then
						table.insert(list, 1, EmptyVal)
					end
				end
				local multiselect = options.MultiSelect or options.Multi or options.Multiple
				local passed_multiselect = multiselect and type(multiselect)
				local blankstring = not multiselect and (options.BlankValue or options.NoValueString or options.Nothing)
				local selectedOption = val or list[1] or blankstring
				local addcallback = options.ItemAdded or options.AddedCallback
				local delcallback = options.ItemRemoved or options.RemovedCallback
				local clrcallback = options.ItemsCleared or options.ClearedCallback
				local modcallback = options.ItemChanged or options.ChangedCallback
				if blankstring and val == nil then
					val = blankstring
				end
				if val ~= nil then
					selectedOption = val
				end
				if multiselect and (not selectedOption or type(selectedOption) ~= "table") then
					selectedOption = {}
				end
				local selectedObjects = {}
				local optionCount = 0
				newDropdown.Name = generateRandomName()
				newDropdown.Parent = sectionHolder
				newDropdown.BackgroundColor3 = Color3.new(1, 1, 1)
				newDropdown.BackgroundTransparency = 1
				newDropdown.Size = UDim2.new(1, 0, 0, 42)
				dropdown.Name = generateRandomName()
				dropdown.Parent = newDropdown
				dropdown.Active = true
				dropdown.BackgroundColor3 = library.colors.topGradient
				local colored_dropdown_BackgroundColor3 = {dropdown, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_dropdown_BackgroundColor3
				dropdown.BorderSizePixel = 0
				do
					local dropdownStroke = Instance_new("UIStroke")
					dropdownStroke.Name = generateRandomName()
					dropdownStroke.Parent = dropdown
					dropdownStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					dropdownStroke.Thickness = 1
					dropdownStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {dropdownStroke, "Color", "elementBorder"}
				end
				dropdown.Position = UDim2.fromScale(0.027, 0.45)
				dropdown.Selectable = true
				dropdown.Size = UDim2.new(0.946, 0, 0, 18) -- relativ statt fest 206px, sonst ragt es in schmalen Groupboxen raus
				dropdown.Image = "rbxassetid://2454009026"
				addCorner(dropdown, 4)
				dropdown.ImageColor3 = library.colors.bottomGradient
				local colored_dropdown_ImageColor3 = {dropdown, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_dropdown_ImageColor3
				dropdownInner.Name = generateRandomName()
				dropdownInner.Parent = dropdown
				dropdownInner.Active = true
				dropdownInner.AnchorPoint = Vector2.new(0.5, 0.5)
				dropdownInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownInner, "BackgroundColor3", "topGradient"}
				dropdownInner.BorderSizePixel = 0
				do
					local dropdownInnerStroke = Instance_new("UIStroke")
					dropdownInnerStroke.Name = generateRandomName()
					dropdownInnerStroke.Parent = dropdownInner
					dropdownInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					dropdownInnerStroke.Thickness = 1
					dropdownInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {dropdownInnerStroke, "Color", "elementBorder"}
				end
				dropdownInner.Position = UDim2.fromScale(0.5, 0.5)
				dropdownInner.Selectable = true
				dropdownInner.Size = UDim2.new(1, -4, 1, -4)
				dropdownInner.Image = "rbxassetid://2454009026"
				addCorner(dropdownInner, 4)
				dropdownInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownInner, "ImageColor3", "bottomGradient"}
				dropdownToggle.Name = generateRandomName()
				dropdownToggle.Parent = dropdown
				dropdownToggle.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownToggle.BackgroundTransparency = 1
				dropdownToggle.Position = UDim2.fromScale(0.9, 0.17)
				dropdownToggle.Rotation = 90
				dropdownToggle.Size = UDim2.fromOffset(12, 12)
				dropdownToggle.ZIndex = 6
				dropdownToggle.Image = "rbxassetid://71659683"
				dropdownToggle.ImageColor3 = Color3.fromRGB(171, 171, 171)
				dropdownSelection.Name = generateRandomName()
				dropdownSelection.Parent = dropdown
				dropdownSelection.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownSelection.BackgroundTransparency = 1
				dropdownSelection.Position = UDim2.new(0.0295485705)
				dropdownSelection.Size = UDim2.fromScale(0.85, 1)
				dropdownSelection.ZIndex = 5
				dropdownSelection.Font = Enum.Font.Code
				dropdownSelection.LineHeight = 1.15
				dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or tostring((multiselect and (blankstring or "Select Item(s)")) or (selectedOption and tostring(selectedOption)) or blankstring or "No Blank String")
				dropdownSelection.TextColor3 = library.colors.otherElementText
				colored[1 + #colored] = {dropdownSelection, "TextColor3", "otherElementText"}
				dropdownSelection.TextSize = 14
				dropdownSelection.TextXAlignment = Enum.TextXAlignment.Left
				dropdownSelection.ClearTextOnFocus = true
				dropdownHeadline.Name = generateRandomName()
				dropdownHeadline.Parent = newDropdown
				dropdownHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownHeadline.BackgroundTransparency = 1
				dropdownHeadline.Position = UDim2.fromScale(0.034, 0.03)
				dropdownHeadline.Size = UDim2.new(0.932, 0, 0, 11)
				dropdownHeadline.Font = Enum.Font.Code
				dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
				makeMarquee(dropdownHeadline)
				dropdownHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {dropdownHeadline, "TextColor3", "elementText"}
				dropdownHeadline.TextSize = 14
				dropdownHeadline.TextXAlignment = Enum.TextXAlignment.Left
				dropdownHolderFrame.Name = generateRandomName()
				dropdownHolderFrame.Parent = newDropdown
				dropdownHolderFrame.Active = true
				dropdownHolderFrame.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownHolderFrame, "BackgroundColor3", "topGradient"}
				dropdownHolderFrame.BorderSizePixel = 0
				do
					local dropdownHolderFrameStroke = Instance_new("UIStroke")
					dropdownHolderFrameStroke.Name = generateRandomName()
					dropdownHolderFrameStroke.Parent = dropdownHolderFrame
					dropdownHolderFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					dropdownHolderFrameStroke.Thickness = 1
					dropdownHolderFrameStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {dropdownHolderFrameStroke, "Color", "elementBorder"}
				end
				dropdownHolderFrame.Position = UDim2.fromScale(0.025, 1.012)
				dropdownHolderFrame.Selectable = true
				dropdownHolderFrame.Size = UDim2.new(0.95, 0, 0, 22)
				dropdownHolderFrame.Visible = false
				dropdownHolderFrame.Image = "rbxassetid://2454009026"
				addCorner(dropdownHolderFrame, 6)
				dropdownHolderFrame.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownHolderFrame, "ImageColor3", "bottomGradient"}
				dropdownHolderInner.Name = generateRandomName()
				dropdownHolderInner.Parent = dropdownHolderFrame
				dropdownHolderInner.Active = true
				dropdownHolderInner.AnchorPoint = Vector2.new(0.5, 0.5)
				dropdownHolderInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownHolderInner, "BackgroundColor3", "topGradient"}
				dropdownHolderInner.BorderSizePixel = 0
				do
					local dropdownHolderInnerStroke = Instance_new("UIStroke")
					dropdownHolderInnerStroke.Name = generateRandomName()
					dropdownHolderInnerStroke.Parent = dropdownHolderInner
					dropdownHolderInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					dropdownHolderInnerStroke.Thickness = 1
					dropdownHolderInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {dropdownHolderInnerStroke, "Color", "elementBorder"}
				end
				dropdownHolderInner.Position = UDim2.fromScale(0.5, 0.5)
				dropdownHolderInner.Selectable = true
				dropdownHolderInner.Size = UDim2.new(1, -4, 1, -4)
				dropdownHolderInner.Image = "rbxassetid://2454009026"
				addCorner(dropdownHolderInner, 6)
				dropdownHolderInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownHolderInner, "ImageColor3", "bottomGradient"}
				realDropdownHolder.Name = generateRandomName()
				realDropdownHolder.Parent = dropdownHolderInner
				realDropdownHolder.BackgroundColor3 = Color3.new(1, 1, 1)
				realDropdownHolder.BackgroundTransparency = 1
				realDropdownHolder.Selectable = false
				realDropdownHolder.Size = UDim2.fromScale(1, 1)
				realDropdownHolder.CanvasSize = UDim2.new()
				realDropdownHolder.ScrollBarThickness = 5
				realDropdownHolder.ScrollingDirection = Enum.ScrollingDirection.Y
				realDropdownHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
				realDropdownHolder.ScrollBarImageTransparency = 0.5
				realDropdownHolder.ScrollBarImageColor3 = library.colors.section
				colored[1 + #colored] = {realDropdownHolder, "ScrollBarImageColor3", "section"}
				realDropdownHolderList.Name = generateRandomName()
				realDropdownHolderList.Parent = realDropdownHolder
				realDropdownHolderList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				realDropdownHolderList.SortOrder = Enum.SortOrder.LayoutOrder
				sectionFunctions:Update()
				local restorezindex = {}
				library.signals[1 + #library.signals] = newDropdown.MouseEnter:Connect(function()
					colored_dropdown_BackgroundColor3[3] = "main"
					colored_dropdown_BackgroundColor3[4] = 1.5
					colored_dropdown_ImageColor3[3] = "main"
					colored_dropdown_ImageColor3[4] = 2.5
					tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end)
				library.signals[1 + #library.signals] = newDropdown.MouseLeave:Connect(function()
					if not dropdownEnabled then
						colored_dropdown_BackgroundColor3[3] = "topGradient"
						colored_dropdown_BackgroundColor3[4] = nil
						colored_dropdown_ImageColor3[3] = "bottomGradient"
						colored_dropdown_ImageColor3[4] = nil
						tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
					end
				end)
				local function UpdateDropdownHolder()
					if optionCount >= 6 then
						realDropdownHolder.CanvasSize = UDim2:fromOffset(realDropdownHolderList.AbsoluteContentSize.Y + 2)
					elseif optionCount <= 5 then
						dropdownHolderFrame.Size = UDim2.new(0.95, 0, 0, realDropdownHolderList.AbsoluteContentSize.Y + 4)
					end
				end
				local validate = nil
				local SetupValidation = nil
				do
					local Signals = {}
					local Setup = nil
					function SetupValidation()
						for k, v in next, Signals do
							v = v and v:Disconnect()
							Signals[k] = nil
						end
						if options.AutoValidate and list and (typeof(list) == "Instance") then
							local Val = library_flags[flagName] or selectedOption
							if multiselect then
								for _, v in next, Val do
									Setup(v)
								end
							else
								Setup(Val)
							end
						end
					end
					local gpcs = game.GetPropertyChangedSignal
					function Setup(v)
						if typeof(v) == "Instance" then
							local Signal = nil
							Signal = gpcs(v, "Parent"):Connect(function()
								if options.AutoValidate then
									if list and (v.Parent ~= list) then
										Signal = (Signal and Signal:Disconnect() and nil) or nil
										validate()
									end
								else
									for k, v in next, Signals do
										v = v and v:Disconnect()
										Signals[k] = nil
									end
								end
							end)
						end
					end
				end
				local function AddOptions(optionsTable, filter)
					if options.Sort then
						local didstuff, dosort = nil, options.Sort
						if type(dosort) == "function" then
							local g, h = pcall(table.sort, optionsTable, dosort)
							if g then
								didstuff = true
							elseif h then
								warn("Error sorting list:", h, debug.traceback(""))
							end
						end
						if not didstuff then
							table.sort(optionsTable, library.defaultSort)
						end
					end
					if blankstring and (optionsTable[1] ~= blankstring or table.find(optionsTable, blankstring, 2)) then
						local exists = table.find(optionsTable, blankstring)
						if exists then
							for _ = 1, 35 do
								table.remove(optionsTable, exists)
								exists = table.find(optionsTable, blankstring)
								if not exists then
									break
								end
							end
						end
						table.insert(optionsTable, 1, blankstring)
					end
					optionCount = 0
					realDropdownHolderList.Parent = nil
					realDropdownHolder:ClearAllChildren()
					realDropdownHolderList.Parent = realDropdownHolder
					for _, v in next, optionsTable do
						if not filter or tostring(v):lower():find(dropdownSelection.Text:lower(), 1, not options.RegEx) then
							optionCount = optionCount + 1
							UpdateDropdownHolder()
							local newOption = Instance_new("ImageLabel")
							local optionButton = Instance_new("TextButton")
							if selectedOption == v then
								selectedObjects[1] = newOption
								selectedObjects[2] = optionButton
							end
							newOption.Name = generateRandomName()
							newOption.Parent = realDropdownHolder
							local togged = (not multiselect and selectedOption == v) or (multiselect and table.find(selectedOption, v))
							newOption.BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient
							newOption.BorderSizePixel = 0
							newOption.Size = UDim2.new(1, -4, 0, 18)
							newOption.Image = "rbxassetid://2454009026"
							addCorner(newOption, 3)
							newOption.ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
							local stringed = tostring(v)
							optionButton.Name = stringed
							optionButton.Parent = newOption
							optionButton.Active = true
							optionButton.AnchorPoint = Vector2.new(0.5, 0.5)
							optionButton.BackgroundColor3 = Color3.new(1, 1, 1)
							optionButton.BackgroundTransparency = 1
							optionButton.Position = UDim2.fromScale(0.5, 0.5)
							optionButton.Selectable = true
							optionButton.Size = UDim2.new(1, -10, 1)
							optionButton.ZIndex = 5
							optionButton.Font = Enum.Font.Code
							optionButton.Text = (togged and (" " .. stringed)) or stringed
							optionButton.TextColor3 = (togged and library.colors.main) or library.colors.otherElementText
							optionButton.TextSize = 14
							optionButton.TextXAlignment = Enum.TextXAlignment.Left
							library.signals[1 + #library.signals] = optionButton[(multiselect and "MouseButton1Click") or "MouseButton1Down"]:Connect(function()
								if not library.colorpicker then
									dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or tostring(blankstring or "Select Item(s)")
									restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
									restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
									restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
									if multiselect then
										local cloned = {unpack(selectedOption)}
										local togged = table.find(selectedOption, v)
										if togged then
											table.remove(selectedOption, togged)
										else
											selectedOption[1 + #selectedOption] = v
										end
										togged = table.find(selectedOption, v)
										optionButton.Text = (togged and (" " .. stringed)) or stringed
										newOption.BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient
										newOption.ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
										optionButton.TextColor3 = (togged and library.colors.main) or library.colors.otherElementText
										if callback then
											task.spawn(callback, selectedOption, cloned)
										end
										if togged then
											if addcallback then
												task.spawn(addcallback, v, selectedOption)
											end
										elseif delcallback then
											task.spawn(delcallback, v, selectedOption)
										end
										if modcallback then
											task.spawn(modcallback, v, togged, selectedOption)
										end
										if #selectedOption == 0 and clrcallback then
											task.spawn(clrcallback, selectedOption, cloned)
										end
										return
									else
										dropdownSelection.Text = stringed
										if selectedOption ~= v then
											local last_v = library_flags[flagName]
											do
												local First = selectedObjects[1]
												if First then
													selectedObjects[1].BackgroundColor3 = library.colors.topGradient
													selectedObjects[1].ImageColor3 = library.colors.bottomGradient
												end
											end
											do
												local Second = selectedObjects[2]
												if Second then
													selectedObjects[2].Text = selectedObjects[2].Name
													selectedObjects[2].TextColor3 = library.colors.otherElementText
												end
											end
											selectedOption = v
											selectedObjects[1] = newOption
											selectedObjects[2] = optionButton
											newOption.BackgroundColor3 = library.colors.selectedOption
											newOption.ImageColor3 = library.colors.unselectedOption
											optionButton.TextColor3 = library.colors.main
											dropdownHolderFrame.Visible = false
											dropdownToggle.Rotation = 90
											dropdownEnabled = false
											newDropdown.ZIndex = 1
											colored_dropdown_BackgroundColor3[3] = "topGradient"
											colored_dropdown_BackgroundColor3[4] = nil
											colored_dropdown_ImageColor3[3] = "bottomGradient"
											colored_dropdown_ImageColor3[4] = nil
											tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
												BackgroundColor3 = library.colors.topGradient,
												ImageColor3 = library.colors.bottomGradient
											}):Play()
											library_flags[flagName] = selectedOption
											if options.Location then
												options.Location[options.LocationFlag or flagName] = selectedOption
											end
											dropdownSelection.Text = tostring(selectedOption)
											if submenuOpen then
												submenuOpen = nil
											end
											if callback then
												task.spawn(callback, selectedOption, last_v)
											end
										else
											submenuOpen = nil
											dropdownToggle.Rotation = 90
											colored_dropdown_BackgroundColor3[3] = "topGradient"
											colored_dropdown_BackgroundColor3[4] = nil
											colored_dropdown_ImageColor3[3] = "bottomGradient"
											colored_dropdown_ImageColor3[4] = nil
											tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
												BackgroundColor3 = library.colors.topGradient,
												ImageColor3 = library.colors.bottomGradient
											}):Play()
											dropdownHolderFrame.Visible = false
										end
									end
									for ins, z in next, restorezindex do
										ins.ZIndex = z
									end
								end
							end)
							library.signals[1 + #library.signals] = optionButton.MouseEnter:Connect(function()
								tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = library.colors.hoveredOptionTop,
									ImageColor3 = library.colors.hoveredOptionBottom
								}):Play()
							end)
							library.signals[1 + #library.signals] = optionButton.MouseLeave:Connect(function()
								local togged = (not multiselect and selectedOption == v) or (multiselect and table.find(selectedOption, v))
								tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient,
									ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
								}):Play()
							end)
							UpdateDropdownHolder()
						end
					end
				end
				local precisionscrolling, update = nil
				local showing = false
				local function display(dropdownEnabled, f)
					if dropdownEnabled then
						closeOtherSubmenu(dropdown)
					end
					if submenuOpen == dropdown or submenuOpen == nil then
						if dropdownEnabled then
							list = resolvelist()
							if next(list) then
							else
								local EmptyVal = options.EmptyValue
								if EmptyVal ~= nil then
									table.insert(list, 1, EmptyVal)
								end
							end
							AddOptions(list, f)
							submenuOpen = dropdown
							submenuCloseFn = function() display(false) end
							submenuOpenFrames = {newDropdown, dropdownHolderFrame}
							dropdownToggle.Rotation = 270
							restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
							restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
							restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
							newSection.ZIndex = 50 + newSection.ZIndex
							newDropdown.ZIndex = 2
							sectionHolder.ZIndex = 2
							colored_dropdown_BackgroundColor3[3] = "main"
							colored_dropdown_BackgroundColor3[4] = 1.5
							colored_dropdown_ImageColor3[3] = "main"
							colored_dropdown_ImageColor3[4] = 2.5
							tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = darkenColor(library.colors.main, 1.5),
								ImageColor3 = darkenColor(library.colors.main, 2.5)
							}):Play()
							dropdownHolderFrame.Visible = true
							if not options.DisablePrecisionScrolling then
								local scrollrate = tonumber(options.ScrollButtonRate or options.ScrollRate) or 5
								local upkey = options.ScrollUpButton or library.scrollupbutton or shared.scrollupbutton or Enum.KeyCode.Up
								local downkey = options.ScrollDownButton or library.scrolldownbutton or shared.scrolldownbutton or Enum.KeyCode.Down
								precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or userInputService.InputBegan:Connect(function(input)
									if input.UserInputType == Enum.UserInputType.Keyboard then
										local code = input.KeyCode
										local isup = code == upkey
										local isdown = code == downkey
										if isup or isdown then
											local txt = userInputService:GetFocusedTextBox()
											if not txt or txt == dropdownSelection then
												while wait_check() and userInputService:IsKeyDown(code) do
													realDropdownHolder.CanvasPosition = Vector2:new(math.clamp(realDropdownHolder.CanvasPosition.Y + ((isup and -scrollrate) or scrollrate), 0, realDropdownHolder.AbsoluteCanvasSize.Y))
												end
											end
										end
									end
								end)
								library.signals[1 + #library.signals] = precisionscrolling
							end
						else
							submenuOpen = nil
							dropdownToggle.Rotation = 90
							colored_dropdown_BackgroundColor3[3] = "topGradient"
							colored_dropdown_BackgroundColor3[4] = nil
							colored_dropdown_ImageColor3[3] = "bottomGradient"
							colored_dropdown_ImageColor3[4] = nil
							tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = library.colors.topGradient,
								ImageColor3 = library.colors.bottomGradient
							}):Play()
							dropdownHolderFrame.Visible = false
							for ins, z in next, restorezindex do
								ins.ZIndex = z
							end
							precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or nil
						end
					end
					showing = dropdownEnabled
					if showing or dropdownEnabled then
					else
						delay(0.01, update)
					end
				end
				local Set = (multiselect and function(t, dat)
					if nil == dat and t ~= nil then
						dat = t
					end
					local lastv = library_flags[flagName]
					if not lastv or selectedOption ~= lastv then
						if lastv and type(lastv) == "table" then
							selectedOption = library_flags[flagName]
						else
							library_flags[flagName] = selectedOption
						end
						warn("Attempting to use new table for", flagName, " Please use :Set(), because setting it through flags table may cause errors", debug.traceback(""))
						lastv = library_flags[flagName]
					end
					local cloned = {unpack(selectedOption)}
					if not dat then
						if #selectedOption ~= 0 then
							table.clear(selectedOption)
							if callback then
								task.spawn(callback, selectedOption, cloned)
							end
						end
						return selectedOption
					elseif type(dat) ~= "table" then
						warn("Expected table for argument #1 on Set for MultiSelect searchbox. Got", dat, debug.traceback(""))
						return selectedOption
					end
					for k = table.pack(unpack(dat)).n, 1, -1 do
						if dat[k] == nil then
							table.remove(dat, k)
						end
					end
					local proceed = #cloned ~= #dat
					table.clear(selectedOption)
					for k, v in next, dat do
						selectedOption[k] = v
						if not proceed and cloned[k] ~= v then
							proceed = 1
						end
					end
					dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or tostring(blankstring or "Select Item(s)")
					if proceed and callback then
						task.spawn(callback, selectedOption, cloned)
					end
					if options.AutoValidate then
						SetupValidation()
					end
					return selectedOption
				end) or function(t, str)
					if nil == str and t then
						str = t
					end
					local last_v = library_flags[flagName]
					selectedOption = str
					library_flags[flagName] = str
					if options.Location then
						options.Location[options.LocationFlag or flagName] = str
					end
					local sstr = (selectedOption and tostring(selectedOption)) or blankstring or "No Blank String"
					if dropdownSelection.Text ~= sstr then
						dropdownSelection.Text = sstr
					end
					if callback and (last_v ~= str or options.AllowDuplicateCalls) then
						task.spawn(callback, str, last_v)
					end
					if options.AutoValidate then
						SetupValidation()
					end
					return str
				end
				if val ~= nil then
					Set(val)
				else
					library_flags[flagName] = selectedOption
					if options.Location then
						options.Location[options.LocationFlag or flagName] = selectedOption
					end
					if options.AutoValidate then
						SetupValidation()
					end
				end
				library.signals[1 + #library.signals] = dropdownToggle.MouseButton1Click:Connect(function()
					showing = not showing
					display(showing)
				end)
				library.signals[1 + #library.signals] = dropdownSelection.Focused:Connect(function()
					showing = true
					display(true)
				end)
				library.signals[1 + #library.signals] = dropdownSelection:GetPropertyChangedSignal("Text"):Connect(function()
					if showing then
						display(true, #dropdownSelection.Text > 0)
					end
				end)
				if not multiselect then
					library.signals[1 + #library.signals] = dropdownSelection.FocusLost:Connect(function(b)
						if showing then
							wait()
						end
						showing = false
						display(false)
						if b then
							Set(dropdownSelection.Text)
						end
					end)
				end
				AddOptions(list)
				local default = library_flags[flagName]
				function update()
					dropdownName, callback = options.Name or dropdownName, options.Callback
					local sstr = (passed_multiselect == "string" and multiselect) or (not multiselect and library_flags[flagName] and tostring(library_flags[flagName])) or (not multiselect and selectedOption and tostring(selectedOption)) or blankstring or "Nothing"
					if dropdownSelection.Text ~= sstr then
						dropdownSelection.Text = sstr
					end
					dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
					return sstr
				end
				function validate(fallbackValue)
					if list and table.find(list, library_flags[flagName]) then
						update()
						return true
					end
					if fallbackValue ~= nil then
						if fallbackValue == "__DEFAULT" then
							fallbackValue = default
						end
					else
						fallbackValue = list[1]
					end
					if multiselect and type(fallbackValue) ~= "table" then
						fallbackValue = {fallbackValue}
					end
					return Set(fallbackValue)
				end
				local objectdata = {
					Options = options,
					Name = flagName,
					Flag = flagName,
					Type = "SearchBox",
					Default = default,
					Parent = sectionFunctions,
					Instance = dropdownSelection,
					Container = newDropdown,
					DisplayName = dropdownName,
					Validate = validate,
					Set = Set,
					Remove = function()
						if newDropdown then
							newDropdown.Parent = nil
							sectionFunctions:Update()
						end
					end,
					RawSet = ((multiselect and function(t, dat)
						if nil == dat and t ~= nil then
							dat = t
						end
						local lastv = library_flags[flagName]
						if not lastv or selectedOption ~= lastv then
							if lastv and type(lastv) == "table" then
								selectedOption = library_flags[flagName]
							else
								library_flags[flagName] = selectedOption
							end
							warn("Attempting to use new table for", flagName, " Please use :Set(), as setting through flags table may cause errors", debug.traceback(""))
							lastv = library_flags[flagName]
						end
						local cloned = {unpack(selectedOption)}
						if not dat then
							if #selectedOption ~= 0 then
								table.clear(selectedOption)
								if callback then
									task.spawn(callback, selectedOption, cloned)
								end
							end
							return selectedOption
						elseif type(dat) ~= "table" then
							warn("Expected table for argument #1 on Set for MultiSelect searchbox. Got", dat, debug.traceback(""))
							return selectedOption
						end
						for k = table.pack(unpack(dat)).n, 1, -1 do
							if dat[k] == nil then
								table.remove(dat, k)
							end
						end
						local proceed = #cloned ~= #dat
						table.clear(selectedOption)
						for k, v in next, dat do
							selectedOption[k] = v
							if not proceed and cloned[k] ~= v then
								proceed = 1
							end
						end
						update()
						return selectedOption
					end) or function(t, str)
						if nil == str and t then
							str = t
						end
						selectedOption = str
						library_flags[flagName] = str
						if options.Location then
							options.Location[options.LocationFlag or flagName] = str
						end
						update()
						return str
					end),
					Get = function()
						return library_flags[flagName]
					end,
					Update = update,
					Reset = function()
						return Set(nil, default)
					end
				}
				function objectdata.UpdateList(t, listt, updateValues)
					if (nil == listt and t ~= nil) or (type(t) == "table" and type(listt) ~= "table") then
						listt, updateValues = t, listt
					end
					if listt == objectdata then
						listt = nil
					end
					resolvelist = getresolver(listt or options.List, options.Filter, options.Method)
					list = resolvelist()
					if next(list) then
					else
						local EmptyVal = options.EmptyValue
						if EmptyVal ~= nil then
							table.insert(list, 1, EmptyVal)
						end
					end
					if updateValues then
						validate()
					end
					if showing then
						display(false)
						display(true)
					end
					return list
				end
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.NewSearchBox = sectionFunctions.AddSearchBox
			sectionFunctions.CreateSearchBox = sectionFunctions.AddSearchBox
			sectionFunctions.SearchBox = sectionFunctions.AddSearchBox
			sectionFunctions.CreateSearchbox = sectionFunctions.AddSearchBox
			sectionFunctions.NewSearchbox = sectionFunctions.AddSearchBox
			sectionFunctions.Searchbox = sectionFunctions.AddSearchBox
			sectionFunctions.Sbox = sectionFunctions.AddSearchBox
			sectionFunctions.SBox = sectionFunctions.AddSearchBox
			if isfolder and makefolder and listfiles and readfile and writefile then
				function sectionFunctions:AddPersistence(options, ...)
					options = (options and type(options) == "string" and resolvevararg("Tab", options, ...)) or options
					local dropdownName, custom_workspace, val, persistiveflags, suffix, callback, loadcallback, savecallback, postload, postsave, flagName = assert(options.Name, "Missing Name for new persistence."), options.Workspace or library.WorkspaceName, options.Value, options.Persistive or options.Flags or "all", options.Suffix, options.Callback, options.LoadCallback, options.SaveCallback, options.PostLoadCallback, options.PostSaveCallback, options.Flag or (function()
						library.unnamedpersistence = 1 + (library.unnamedpersistence or 0)
						return "Persistence" .. tostring(library.unnamedpersistence)
					end)()
					if elements[flagName] ~= nil then
						warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
					end
					local designerpersists = options.Desginer
					local newDropdown = Instance_new("Frame")
					local dropdown = Instance_new("ImageLabel")
					local dropdownInner = Instance_new("ImageLabel")
					local dropdownToggle = Instance_new("ImageButton")
					local dropdownSelection = Instance_new("TextBox")
					local dropdownHeadline = Instance_new("TextLabel")
					local dropdownHolderFrame = Instance_new("ImageLabel")
					local dropdownHolderInner = Instance_new("ImageLabel")
					local realDropdownHolder = Instance_new("ScrollingFrame")
					local realDropdownHolderList = Instance_new("UIListLayout")
					local dropdownEnabled = false
					if not isfolder("./D3v1lHub Lib") then
						makefolder("./D3v1lHub Lib")
					end
					local common_string = "./D3v1lHub Lib/" .. tostring(custom_workspace or library.WorkspaceName)
					local function resolvelist(nofold)
						if custom_workspace ~= options.Workspace then
							custom_workspace = options.Workspace
							common_string = "./D3v1lHub Lib/" .. tostring(custom_workspace or library.WorkspaceName)
						end
						if not isfolder or not makefolder or not listfiles then
							return {}
						end
						if not isfolder(common_string) then
							if nofold then
								return {}
							end
							makefolder(common_string)
						end
						assert(isfolder(common_string), "Couldn't create folder: " .. tostring(library.WorkspaceName or "No workspace name?"))
						local names, files = {}, listfiles(common_string)
						if #files > 0 then
							local len = #common_string + 2
							for _, f in next, files do
								names[1 + #names] = string.sub(f, len, -5)
							end
							table.sort(names)
						end
						return names
					end
					local list = resolvelist(true)
					local blankstring = options.BlankValue or options.NoValueString or options.Nothing
					local selectedObjects = {}
					local optionCount = 0
					if blankstring and val == nil then
						val = blankstring
					end
					local selectedOption = val or blankstring or list[1]
					newDropdown.Name = generateRandomName()
					newDropdown.Parent = sectionHolder
					newDropdown.BackgroundColor3 = Color3.new(1, 1, 1)
					newDropdown.BackgroundTransparency = 1
					newDropdown.Size = UDim2.new(1, 0, 0, 42)
					dropdown.Name = generateRandomName()
					dropdown.Parent = newDropdown
					dropdown.Active = true
					dropdown.BackgroundColor3 = library.colors.topGradient
					local colored_dropdown_BackgroundColor3 = {dropdown, "BackgroundColor3", "topGradient"}
					colored[1 + #colored] = colored_dropdown_BackgroundColor3
					dropdown.BorderSizePixel = 0
					do
						local dropdownStroke = Instance_new("UIStroke")
						dropdownStroke.Name = generateRandomName()
						dropdownStroke.Parent = dropdown
						dropdownStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
						dropdownStroke.Thickness = 1
						dropdownStroke.Color = library.colors.elementBorder
						colored[1 + #colored] = {dropdownStroke, "Color", "elementBorder"}
					end
					dropdown.Position = UDim2.fromScale(0.027, 0.45)
					dropdown.Selectable = true
					dropdown.Size = UDim2.new(0.946, 0, 0, 18) -- relativ statt fest 206px, sonst ragt es in schmalen Groupboxen raus
					dropdown.Image = "rbxassetid://2454009026"
					addCorner(dropdown, 4)
					dropdown.ImageColor3 = library.colors.bottomGradient
					local colored_dropdown_ImageColor3 = {dropdown, "ImageColor3", "bottomGradient"}
					colored[1 + #colored] = colored_dropdown_ImageColor3
					dropdownInner.Name = generateRandomName()
					dropdownInner.Parent = dropdown
					dropdownInner.Active = true
					dropdownInner.AnchorPoint = Vector2.new(0.5, 0.5)
					dropdownInner.BackgroundColor3 = library.colors.topGradient
					colored[1 + #colored] = {dropdownInner, "BackgroundColor3", "topGradient"}
					dropdownInner.BorderSizePixel = 0
					do
						local dropdownInnerStroke = Instance_new("UIStroke")
						dropdownInnerStroke.Name = generateRandomName()
						dropdownInnerStroke.Parent = dropdownInner
						dropdownInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
						dropdownInnerStroke.Thickness = 1
						dropdownInnerStroke.Color = library.colors.elementBorder
						colored[1 + #colored] = {dropdownInnerStroke, "Color", "elementBorder"}
					end
					dropdownInner.Position = UDim2.fromScale(0.5, 0.5)
					dropdownInner.Selectable = true
					dropdownInner.Size = UDim2.new(1, -4, 1, -4)
					dropdownInner.Image = "rbxassetid://2454009026"
					addCorner(dropdownInner, 4)
					dropdownInner.ImageColor3 = library.colors.bottomGradient
					colored[1 + #colored] = {dropdownInner, "ImageColor3", "bottomGradient"}
					dropdownToggle.Name = generateRandomName()
					dropdownToggle.Parent = dropdown
					dropdownToggle.BackgroundColor3 = Color3.new(1, 1, 1)
					dropdownToggle.BackgroundTransparency = 1
					dropdownToggle.Position = UDim2.fromScale(0.9, 0.17)
					dropdownToggle.Rotation = 90
					dropdownToggle.Size = UDim2.fromOffset(12, 12)
					dropdownToggle.ZIndex = 2
					dropdownToggle.Image = "rbxassetid://71659683"
					dropdownToggle.ImageColor3 = Color3.fromRGB(171, 171, 171)
					dropdownSelection.Name = generateRandomName()
					dropdownSelection.Parent = dropdown
					dropdownSelection.BackgroundColor3 = Color3.new(1, 1, 1)
					dropdownSelection.BackgroundTransparency = 1
					dropdownSelection.Position = UDim2.new(0.0295485705)
					dropdownSelection.Size = UDim2.fromScale(0.97, 1)
					dropdownSelection.ZIndex = 5
					dropdownSelection.Font = Enum.Font.Code
					dropdownSelection.LineHeight = 1.15
					dropdownSelection.Text = (selectedOption and tostring(selectedOption)) or "nil"
					dropdownSelection.TextColor3 = library.colors.otherElementText
					colored[1 + #colored] = {dropdownSelection, "TextColor3", "otherElementText"}
					dropdownSelection.TextSize = 14
					dropdownSelection.TextXAlignment = Enum.TextXAlignment.Left
					dropdownHeadline.Name = generateRandomName()
					dropdownHeadline.Parent = newDropdown
					dropdownHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
					dropdownHeadline.BackgroundTransparency = 1
					dropdownHeadline.Position = UDim2.fromScale(0.034, 0.03)
					dropdownHeadline.Size = UDim2.new(0.932, 0, 0, 11)
					dropdownHeadline.Font = Enum.Font.Code
					dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
					makeMarquee(dropdownHeadline)
					dropdownHeadline.TextColor3 = library.colors.elementText
					colored[1 + #colored] = {dropdownHeadline, "TextColor3", "elementText"}
					dropdownHeadline.TextSize = 14
					dropdownHeadline.TextXAlignment = Enum.TextXAlignment.Left
					dropdownHolderFrame.Name = generateRandomName()
					dropdownHolderFrame.Parent = newDropdown
					dropdownHolderFrame.Active = true
					dropdownHolderFrame.BackgroundColor3 = library.colors.topGradient
					colored[1 + #colored] = {dropdownHolderFrame, "BackgroundColor3", "topGradient"}
					dropdownHolderFrame.BorderSizePixel = 0
					do
						local dropdownHolderFrameStroke = Instance_new("UIStroke")
						dropdownHolderFrameStroke.Name = generateRandomName()
						dropdownHolderFrameStroke.Parent = dropdownHolderFrame
						dropdownHolderFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
						dropdownHolderFrameStroke.Thickness = 1
						dropdownHolderFrameStroke.Color = library.colors.elementBorder
						colored[1 + #colored] = {dropdownHolderFrameStroke, "Color", "elementBorder"}
					end
					dropdownHolderFrame.Position = UDim2.fromScale(0.025, 1.012)
					dropdownHolderFrame.Selectable = true
					dropdownHolderFrame.Size = UDim2.new(0.95, 0, 0, 22)
					dropdownHolderFrame.Visible = false
					dropdownHolderFrame.Image = "rbxassetid://2454009026"
					addCorner(dropdownHolderFrame, 6)
					dropdownHolderFrame.ImageColor3 = library.colors.bottomGradient
					colored[1 + #colored] = {dropdownHolderFrame, "ImageColor3", "bottomGradient"}
					dropdownHolderInner.Name = generateRandomName()
					dropdownHolderInner.Parent = dropdownHolderFrame
					dropdownHolderInner.Active = true
					dropdownHolderInner.AnchorPoint = Vector2.new(0.5, 0.5)
					dropdownHolderInner.BackgroundColor3 = library.colors.topGradient
					colored[1 + #colored] = {dropdownHolderInner, "BackgroundColor3", "topGradient"}
					dropdownHolderInner.BorderSizePixel = 0
					do
						local dropdownHolderInnerStroke = Instance_new("UIStroke")
						dropdownHolderInnerStroke.Name = generateRandomName()
						dropdownHolderInnerStroke.Parent = dropdownHolderInner
						dropdownHolderInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
						dropdownHolderInnerStroke.Thickness = 1
						dropdownHolderInnerStroke.Color = library.colors.elementBorder
						colored[1 + #colored] = {dropdownHolderInnerStroke, "Color", "elementBorder"}
					end
					dropdownHolderInner.Position = UDim2.fromScale(0.5, 0.5)
					dropdownHolderInner.Selectable = true
					dropdownHolderInner.Size = UDim2.new(1, -4, 1, -4)
					dropdownHolderInner.Image = "rbxassetid://2454009026"
					addCorner(dropdownHolderInner, 6)
					dropdownHolderInner.ImageColor3 = library.colors.bottomGradient
					colored[1 + #colored] = {dropdownHolderInner, "ImageColor3", "bottomGradient"}
					realDropdownHolder.Name = generateRandomName()
					realDropdownHolder.Parent = dropdownHolderInner
					realDropdownHolder.BackgroundColor3 = Color3.new(1, 1, 1)
					realDropdownHolder.BackgroundTransparency = 1
					realDropdownHolder.Selectable = false
					realDropdownHolder.Size = UDim2.fromScale(1, 1)
					realDropdownHolder.CanvasSize = UDim2.new()
					realDropdownHolder.ScrollBarThickness = 5
					realDropdownHolder.ScrollingDirection = Enum.ScrollingDirection.Y
					realDropdownHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
					realDropdownHolder.ScrollBarImageTransparency = 0.5
					realDropdownHolder.ScrollBarImageColor3 = library.colors.section
					colored[1 + #colored] = {realDropdownHolder, "ScrollBarImageColor3", "section"}
					realDropdownHolderList.Name = generateRandomName()
					realDropdownHolderList.Parent = realDropdownHolder
					realDropdownHolderList.HorizontalAlignment = Enum.HorizontalAlignment.Center
					realDropdownHolderList.SortOrder = Enum.SortOrder.LayoutOrder
					sectionFunctions:Update()
					library.signals[1 + #library.signals] = newDropdown.MouseEnter:Connect(function()
						colored_dropdown_BackgroundColor3[3] = "main"
						colored_dropdown_BackgroundColor3[4] = 1.5
						colored_dropdown_ImageColor3[3] = "main"
						colored_dropdown_ImageColor3[4] = 2.5
						tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = darkenColor(library.colors.main, 1.5),
							ImageColor3 = darkenColor(library.colors.main, 2.5)
						}):Play()
					end)
					library.signals[1 + #library.signals] = newDropdown.MouseLeave:Connect(function()
						if not dropdownEnabled then
							colored_dropdown_BackgroundColor3[3] = "topGradient"
							colored_dropdown_BackgroundColor3[4] = nil
							colored_dropdown_ImageColor3[3] = "bottomGradient"
							colored_dropdown_ImageColor3[4] = nil
							tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = library.colors.topGradient,
								ImageColor3 = library.colors.bottomGradient
							}):Play()
						end
					end)
					local restorezindex = {}
					local function UpdateDropdownHolder()
						if optionCount >= 6 then
							realDropdownHolder.CanvasSize = UDim2:fromOffset(realDropdownHolderList.AbsoluteContentSize.Y + 2)
						elseif optionCount <= 5 then
							dropdownHolderFrame.Size = UDim2.new(0.95, 0, 0, (realDropdownHolderList.AbsoluteContentSize.Y + 4))
						end
					end
					local function AddOptions(optionsTable, filter)
						if options.Sort then
							local didstuff, dosort = nil, options.Sort
							if type(dosort) == "function" then
								local g, h = pcall(table.sort, optionsTable, dosort)
								if g then
									didstuff = true
								elseif h then
									warn("Error sorting list:", h, debug.traceback(""))
								end
							end
							if not didstuff then
								table.sort(optionsTable, library.defaultSort)
							end
						end
						if blankstring and (optionsTable[1] ~= blankstring or table.find(optionsTable, blankstring, 2)) then
							local exists = table.find(optionsTable, blankstring)
							if exists then
								for _ = 1, 35 do
									table.remove(optionsTable, exists)
									exists = table.find(optionsTable, blankstring)
									if not exists then
										break
									end
								end
							end
							table.insert(optionsTable, 1, blankstring)
						end
						optionCount = 0
						realDropdownHolderList.Parent = nil
						realDropdownHolder:ClearAllChildren()
						realDropdownHolderList.Parent = realDropdownHolder
						for _, v in next, optionsTable do
							if not filter or tostring(v):lower():find(dropdownSelection.Text:lower(), 1, true) then
								optionCount = optionCount + 1
								UpdateDropdownHolder()
								local newOption = Instance_new("ImageLabel")
								local optionButton = Instance_new("TextButton")
								if selectedOption == v or not selectedObjects[1] or not selectedObjects[2] then
									selectedObjects[1] = newOption
									selectedObjects[2] = optionButton
								end
								newOption.Name = generateRandomName()
								newOption.Parent = realDropdownHolder
								newOption.BackgroundColor3 = (selectedOption == v and library.colors.selectedOption or library.colors.topGradient)
								newOption.BorderSizePixel = 0
								newOption.Size = UDim2.new(1, -4, 0, 18)
								newOption.Image = "rbxassetid://2454009026"
								addCorner(newOption, 3)
								newOption.ImageColor3 = (selectedOption == v and library.colors.unselectedOption or library.colors.bottomGradient)
								optionButton.Name = tostring(v)
								optionButton.Parent = newOption
								optionButton.AnchorPoint = Vector2.new(0.5, 0.5)
								optionButton.BackgroundColor3 = Color3.new(1, 1, 1)
								optionButton.BackgroundTransparency = 1
								optionButton.Position = UDim2.fromScale(0.5, 0.5)
								optionButton.Size = UDim2.new(1, -10, 1)
								optionButton.ZIndex = 5
								optionButton.Font = Enum.Font.Code
								optionButton.Text = (selectedOption == v and " " .. tostring(v)) or tostring(v)
								optionButton.TextColor3 = (selectedOption == v and library.colors.main or library.colors.otherElementText)
								optionButton.TextSize = 14
								optionButton.TextXAlignment = Enum.TextXAlignment.Left
								library.signals[1 + #library.signals] = optionButton.MouseButton1Down:Connect(function()
									dropdownSelection.Text = tostring(v)
									restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
									restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
									restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
									if selectedOption ~= v then
										local last_v = library_flags[flagName]
										selectedObjects[1].BackgroundColor3 = library.colors.topGradient
										selectedObjects[1].ImageColor3 = library.colors.bottomGradient
										selectedObjects[2].Text = selectedObjects[2].Name
										selectedObjects[2].TextColor3 = library.colors.otherElementText
										selectedOption = v
										selectedObjects[1] = newOption
										selectedObjects[2] = optionButton
										newOption.BackgroundColor3 = library.colors.selectedOption
										newOption.ImageColor3 = library.colors.unselectedOption
										optionButton.TextColor3 = library.colors.main
										dropdownHolderFrame.Visible = false
										dropdownToggle.Rotation = 90
										dropdownEnabled = false
										colored_dropdown_BackgroundColor3[3] = "topGradient"
										colored_dropdown_BackgroundColor3[4] = nil
										colored_dropdown_ImageColor3[3] = "bottomGradient"
										colored_dropdown_ImageColor3[4] = nil
										tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
											BackgroundColor3 = library.colors.topGradient,
											ImageColor3 = library.colors.bottomGradient
										}):Play()
										library_flags[flagName] = selectedOption
										if options.Location then
											options.Location[options.LocationFlag or flagName] = selectedOption
										end
										dropdownSelection.Text = tostring(selectedOption)
										if submenuOpen then
											submenuOpen = nil
										end
										if callback then
											task.spawn(callback, selectedOption, last_v)
										end
									else
										submenuOpen = nil
										dropdownToggle.Rotation = 90
										newDropdown.ZIndex = 1
										sectionHolder.ZIndex = 1
										colored_dropdown_BackgroundColor3[3] = "topGradient"
										colored_dropdown_BackgroundColor3[4] = nil
										colored_dropdown_ImageColor3[3] = "bottomGradient"
										colored_dropdown_ImageColor3[4] = nil
										tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
											BackgroundColor3 = library.colors.topGradient,
											ImageColor3 = library.colors.bottomGradient
										}):Play()
										dropdownHolderFrame.Visible = false
									end
									for ins, z in next, restorezindex do
										ins.ZIndex = z
									end
								end)
								library.signals[1 + #library.signals] = optionButton.MouseEnter:Connect(function()
									tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
										BackgroundColor3 = library.colors.hoveredOptionTop,
										ImageColor3 = library.colors.hoveredOptionBottom
									}):Play()
								end)
								library.signals[1 + #library.signals] = optionButton.MouseLeave:Connect(function()
									tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
										BackgroundColor3 = library.colors.unhoveredOptionTop,
										ImageColor3 = library.colors.unhoveredOptionBottom
									}):Play()
								end)
								UpdateDropdownHolder()
							end
						end
					end
					local precisionscrolling, update = nil
					local showing = false
					local function display(dropdownEnabled, f)
						if dropdownEnabled then
							closeOtherSubmenu(dropdown)
						end
						if submenuOpen == dropdown or submenuOpen == nil then
							if dropdownEnabled then
								list = resolvelist(true)
								AddOptions(list, f)
								submenuOpen = dropdown
								submenuCloseFn = function() display(false) end
								submenuOpenFrames = {newDropdown, dropdownHolderFrame}
								restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
								restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
								restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
								newSection.ZIndex = 50 + newSection.ZIndex
								dropdownToggle.Rotation = 270
								newDropdown.ZIndex = 2
								sectionHolder.ZIndex = 2
								colored_dropdown_BackgroundColor3[3] = "main"
								colored_dropdown_BackgroundColor3[4] = 1.5
								colored_dropdown_ImageColor3[3] = "main"
								colored_dropdown_ImageColor3[4] = 2.5
								tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = darkenColor(library.colors.main, 1.5),
									ImageColor3 = darkenColor(library.colors.main, 2.5)
								}):Play()
								dropdownHolderFrame.Visible = true
								if not options.DisablePrecisionScrolling then
									local upkey = options.ScrollUpButton or library.scrollupbutton or shared.scrollupbutton or Enum.KeyCode.Up
									local downkey = options.ScrollDownButton or library.scrolldownbutton or shared.scrolldownbutton or Enum.KeyCode.Down
									precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or userInputService.InputBegan:Connect(function(input)
										if input.UserInputType == Enum.UserInputType.Keyboard then
											local code = input.KeyCode
											local isup = code == upkey
											local isdown = code == downkey
											if isup or isdown then
												local txt = userInputService:GetFocusedTextBox()
												if not txt then
													while wait_check() and userInputService:IsKeyDown(code) do
														realDropdownHolder.CanvasPosition = Vector2:new(math.clamp(realDropdownHolder.CanvasPosition.Y + ((isup and -5) or 5), 0, realDropdownHolder.AbsoluteCanvasSize.Y))
													end
												end
											end
										end
									end)
									library.signals[1 + #library.signals] = precisionscrolling
								end
							else
								submenuOpen = nil
								dropdownToggle.Rotation = 90
								colored_dropdown_BackgroundColor3[3] = "topGradient"
								colored_dropdown_BackgroundColor3[4] = nil
								colored_dropdown_ImageColor3[3] = "bottomGradient"
								colored_dropdown_ImageColor3[4] = nil
								tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = library.colors.topGradient,
									ImageColor3 = library.colors.bottomGradient
								}):Play()
								dropdownHolderFrame.Visible = false
								for ins, z in next, restorezindex do
									ins.ZIndex = z
								end
								precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or nil
							end
							showing = dropdownEnabled
							if showing or dropdownEnabled then
							else
								delay(0.01, update)
							end
						end
					end
					local last_v = nil
					local function Set(t, str)
						if nil == str and t then
							str = t
						end
						selectedOption = str
						last_v = library_flags[flagName]
						library_flags[flagName] = str
						if options.Location then
							options.Location[options.LocationFlag or flagName] = str
						end
						local sstr = (selectedOption and tostring(selectedOption)) or blankstring or "No Blank String"
						if dropdownSelection.Text ~= sstr then
							dropdownSelection.Text = sstr
						end
						if callback and (last_v ~= str or options.AllowDuplicateCalls) then
							task.spawn(callback, str, last_v)
						end
						return str
					end
					if val ~= nil then
						Set(val)
					else
						Set("Default")
					end
					library.signals[1 + #library.signals] = dropdownSelection.Focused:Connect(function()
						showing = true
						display(true)
					end)
					library.signals[1 + #library.signals] = dropdownSelection:GetPropertyChangedSignal("Text"):Connect(function()
						if showing then
							display(true, #dropdownSelection.Text > 0)
						end
					end)
					library.signals[1 + #library.signals] = dropdownSelection.FocusLost:Connect(function(b)
						if showing then
							wait()
						end
						showing = false
						display(false)
						if b then
							Set(dropdownSelection.Text)
						end
					end)
					AddOptions(list)
					local function savestuff(s, get)
						if not s or type(s) ~= "string" then
							s = nil
						end
						local rawfile = "json__save"
						if not get then
							local filenameddst = string.gsub(s or dropdownSelection.Text or "", "%W", "")
							if #filenameddst == 0 then
								return false
							end
							rawfile = string.format("%s/%s.txt", common_string, filenameddst)
						end
						if savecallback then
							local x, e = pcall(savecallback, rawfile, library_flags[flagName])
							if not x and e then
								warn("Error while calling the Pre-Save callback:", e, debug.traceback(""))
							end
						end
						local working_with = {}
						if persistiveflags == 1 or persistiveflags == true or persistiveflags == "*" then
							persistiveflags = "all"
						elseif persistiveflags == 2 then
							persistiveflags = "tab"
						elseif persistiveflags == 3 then
							persistiveflags = "section"
						end
						if persistiveflags == "all" or persistiveflags == "tab" or persistiveflags == "section" then
							for cflag, data in next, (persistiveflags == "all" and elements) or (persistiveflags == "tab" and tabFunctions.Flags) or (persistiveflags == "section" and sectionFunctions.Flags) do
								if data.Type ~= "Persistence" and (designerpersists or string.sub(cflag, 1, 11) ~= "__Designer.") then
									working_with[cflag] = data
								end
							end
						elseif type(persistiveflags) == "table" then
							if #persistiveflags > 0 then
								local inverted = persistiveflags[0] == false or persistiveflags.Inverted
								for k, cflag in next, persistiveflags do
									if k > 0 then
										local data = elements[cflag]
										if data and data.Type ~= "Persistence" and (designerpersists or string.sub(cflag, 1, 11) ~= "__Designer.") then
											working_with[cflag] = (not inverted and data) or nil
										end
									end
								end
							else
								for cflag, persists in next, elements do
									if persists and (designerpersists or string.sub(cflag, 1, 11) ~= "__Designer.") then
										local data = elements[cflag]
										if data then
											working_with[cflag] = data
										end
									end
								end
							end
						end
						local saving = {}
						for cflag in next, working_with do
							local value = library_flags[cflag]
							local good, jval = nil, nil
							if value ~= nil then
								good, jval = JSONEncode(value)
							else
								good, jval = true, "null"
							end
							if not good or (jval == "null" and value ~= nil) then
								local typ = typeof(value)
								if typ == "Color3" then
									value = (library.rainbowflags[cflag] and "rainbow") or Color3ToHex(value)
								end
								value = tostring(value)
								good, jval = JSONEncode(value)
								if not good or (jval == "null" and value ~= nil) then
									warn("Could not save value:", value, debug.traceback(""))
								end
							end
							if good and jval then
								saving[cflag] = value
							end
						end
						local ret = nil
						local savedok = false
						local good, content = JSONEncode(saving)
						if good and content then
							if not get then
								if not isfolder(common_string) then
									makefolder(common_string)
								end
								writefile(rawfile, content)
								savedok = true
							else
								ret = content
							end
						end
						if postsave then
							local x, e = pcall(postsave, rawfile, library_flags[flagName])
							if not x and e then
								warn("Error while calling the Post-Save callback:", e, debug.traceback(""))
							end
						end
						if get then
							return ret
						end
						return savedok
					end
					local function loadstuff(s, jsonmode, silent)
						if not s or type(s) ~= "string" then
							s = nil
						end
						local filename = "json__load"
						if not jsonmode then
							local filenameddst = convertfilename(s or dropdownSelection.Text, nil, "")
							if #filenameddst == 0 then
								return false
							end
							filename = string.format("%s/%s.txt", common_string, filenameddst)
						end
						if loadcallback then
							local x, e = pcall(loadcallback, (jsonmode and s) or filename, library_flags[flagName])
							if not x and e then
								warn("Error while calling the Pre-Load callback:", e, debug.traceback(""))
							end
						end
						local loadedok = false
						if jsonmode or not isfile or isfile(filename) then
							local content = (jsonmode and s) or (not jsonmode and readfile(filename))
							if content and #content > 1 then
								local good, jcontent = JSONDecode(content)
								if good and jcontent then
									for cflag, val in next, jcontent do
										if val and type(val) == "string" and #val > 7 and #val < 64 and string.sub(val, 1, 5) == "Enum." then
											local e = string.find(val, ".", 6, true)
											if e then
												local en = Enum[string.sub(val, 6, e - 1)]
												en = en and en[string.sub(val, e + 1)]
												if en then
													val = en
												else
													warn("Tried & failed to convert '" .. val .. "' to EnumItem")
												end
											end
										end
										local data = elements[cflag]
										if data and data.Type ~= "Persistence" then
											if silent and data.RawSet then
												data:RawSet(val)
											elseif data.Set then
												data:Set(val)
											else
												library_flags[cflag] = val
											end
										end
									end
									loadedok = true
								end
							end
						end
						if postload then
							local x, e = pcall(postload, filename, library_flags[flagName])
							if not x and e then
								warn("Error while calling the Post-Load callback:", e, debug.traceback(""))
							end
						end
						return loadedok
					end
					local fram = nil
					do
						local buttons, offset = {}, 0
						for _, options in next, {{
							Name = "Save" .. ((suffix and (" " .. tostring(suffix))) or ""),
							Callback = savestuff
							}, {
								Name = "Load" .. ((suffix and (" " .. tostring(suffix))) or ""),
								Callback = loadstuff
							}} do
							local buttonName, callback = options.Name, options.Callback
							local realButton = Instance_new("TextButton")
							realButton.Name = generateRandomName()
							realButton.BackgroundColor3 = Color3.new(1, 1, 1)
							realButton.BackgroundTransparency = 1
							realButton.Size = UDim2.fromScale(1, 1)
							realButton.ZIndex = 5
							realButton.Font = Enum.Font.Code
							realButton.Text = (buttonName and tostring(buttonName)) or "???"
							realButton.TextColor3 = library.colors.elementText
							colored[1 + #colored] = {realButton, "TextColor3", "elementText"}
							realButton.TextSize = 14
							local textsize = textToSize(realButton).X + 14
							if newSection.Parent and (newSection.Parent.AbsoluteSize.X < (offset + textsize + 8)) then
								offset, fram = 0, nil
							end
							local newButton = fram or Instance_new("Frame")
							fram = newButton
							local button = Instance_new("ImageLabel")
							newButton.Name = generateRandomName()
							newButton.Parent = sectionHolder
							newButton.BackgroundColor3 = Color3.new(1, 1, 1)
							newButton.BackgroundTransparency = 1
							newButton.Size = UDim2.new(1, 0, 0, 24)
							button.Name = generateRandomName()
							button.Parent = newButton
							button.Active = true
							button.BackgroundColor3 = library.colors.topGradient
							local colored_button_BackgroundColor3 = {button, "BackgroundColor3", "topGradient"}
							colored[1 + #colored] = colored_button_BackgroundColor3
							button.BorderSizePixel = 0
							do
								local buttonStroke = Instance_new("UIStroke")
								buttonStroke.Name = generateRandomName()
								buttonStroke.Parent = button
								buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
								buttonStroke.Thickness = 1
								buttonStroke.Color = library.colors.elementBorder
								colored[1 + #colored] = {buttonStroke, "Color", "elementBorder"}
							end
							button.Position = UDim2.new(0.031, offset, 0.166)
							button.Selectable = true
							button.Size = UDim2.fromOffset(28, 18)
							button.Image = "rbxassetid://2454009026"
							addCorner(button, 4)
							button.ImageColor3 = library.colors.bottomGradient
							local colored_button_ImageColor3 = {button, "ImageColor3", "bottomGradient"}
							colored[1 + #colored] = colored_button_ImageColor3
							local buttonInner = Instance_new("ImageLabel")
							buttonInner.Name = generateRandomName()
							buttonInner.Parent = button
							buttonInner.Active = true
							buttonInner.AnchorPoint = Vector2.new(0.5, 0.5)
							buttonInner.BackgroundColor3 = library.colors.topGradient
							colored[1 + #colored] = {buttonInner, "BackgroundColor3", "topGradient"}
							buttonInner.BorderSizePixel = 0
							do
								local buttonInnerStroke = Instance_new("UIStroke")
								buttonInnerStroke.Name = generateRandomName()
								buttonInnerStroke.Parent = buttonInner
								buttonInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
								buttonInnerStroke.Thickness = 1
								buttonInnerStroke.Color = library.colors.elementBorder
								colored[1 + #colored] = {buttonInnerStroke, "Color", "elementBorder"}
							end
							buttonInner.Position = UDim2.fromScale(0.5, 0.5)
							buttonInner.Selectable = true
							buttonInner.Size = UDim2.new(1, -4, 1, -4)
							buttonInner.Image = "rbxassetid://2454009026"
							addCorner(buttonInner, 4)
							buttonInner.ImageColor3 = library.colors.bottomGradient
							colored[1 + #colored] = {buttonInner, "ImageColor3", "bottomGradient"}
							button.Size = UDim2.fromOffset(textsize, 18)
							realButton.Parent = button
							offset = offset + textsize + 6
							sectionFunctions:Update()
							local presses = 0
							library.signals[1 + #library.signals] = realButton.MouseButton1Click:Connect(function()
								if not library.colorpicker and not submenuOpen then
									presses = 1 + presses
									task.spawn(function()
										local ok = callback(presses)
										local isSaving = string.sub(tostring(buttonName), 1, 4) == "Save"
										local suffixname = (suffix and tostring(suffix)) or "Profile"
										if isSaving then
											library:Notify({
												Text = suffixname .. ((ok and " successfully saved") or " failed to save"),
												Time = 3,
												Type = (ok and "success") or "error"
											})
										else
											library:Notify({
												Text = suffixname .. ((ok and " successfully loaded") or " failed to load"),
												Time = 3,
												Type = (ok and "success") or "error"
											})
										end
									end)
								end
							end)
							library.signals[1 + #library.signals] = button.MouseEnter:Connect(function()
								colored_button_BackgroundColor3[3] = "main"
								colored_button_BackgroundColor3[4] = 1.5
								colored_button_ImageColor3[3] = "main"
								colored_button_ImageColor3[4] = 2.5
								tweenService:Create(button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = darkenColor(library.colors.main, 1.5),
									ImageColor3 = darkenColor(library.colors.main, 2.5)
								}):Play()
							end)
							library.signals[1 + #library.signals] = button.MouseLeave:Connect(function()
								colored_button_BackgroundColor3[3] = "topGradient"
								colored_button_BackgroundColor3[4] = nil
								colored_button_ImageColor3[3] = "bottomGradient"
								colored_button_ImageColor3[4] = nil
								tweenService:Create(button, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
									BackgroundColor3 = library.colors.topGradient,
									ImageColor3 = library.colors.bottomGradient
								}):Play()
							end)
						end
					end
					local default = library_flags[flagName]
					function update()
						dropdownName, custom_workspace, persistiveflags, suffix, callback, loadcallback, savecallback, postload, postsave = options.Name or dropdownName, options.Workspace or library.WorkspaceName, options.Persistive or options.Flags or "all", options.Suffix, options.Callback, options.LoadCallback, options.SaveCallback, options.PostLoadCallback, options.PostSaveCallback
						local sstr = tostring(library_flags[flagName])
						if dropdownSelection.Text ~= sstr then
							dropdownSelection.Text = sstr
						end
						dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
						return sstr
					end
					local objectdata = {
						Options = options,
						Name = flagName,
						Flag = flagName,
						Type = "Persistence",
						Default = default,
						Parent = sectionFunctions,
						Instance = dropdownSelection,
						Container = newDropdown,
						DisplayName = dropdownName,
						Set = Set,
						Remove = function()
							local relod = nil
							if newDropdown then
								newDropdown.Parent = nil
								relod = true
							end
							if fram then
								fram.Parent = nil
								relod = true
							end
							if relod then
								sectionFunctions:Update()
							end
						end,
						SaveFile = function(t, str, ret)
							if t ~= nil and type(t) ~= "table" then
								str, ret = t, str
							end
							if type(str) == "string" then
								str = str:match("(.+)%..+$") or str
							end
							return savestuff(str, ret)
						end,
						LoadFile = function(t, str, jsonmode)
							if t ~= nil and type(t) ~= "table" then
								str, jsonmode = t, str
							end
							if isfile and isfile(str) then
								return loadstuff(readfile(str), true)
							elseif not jsonmode and type(str) == "string" then
								str = str:match("(.+)%..+$") or str
							end
							return loadstuff(str, jsonmode)
						end,
						LoadJSON = function(_, json)
							return loadstuff(json, true)
						end,
						LoadFileRaw = function(t, str, jsonmode)
							if t ~= nil and type(t) ~= "table" then
								str, jsonmode = t, str
							end
							if isfile and isfile(str) then
								return loadstuff(readfile(str), true, true)
							elseif not jsonmode and type(str) == "string" then
								str = str:match("(.+)%..+$") or str
							end
							return loadstuff(str, jsonmode, true)
						end,
						LoadJSONRaw = function(_, json)
							return loadstuff(json, true, true)
						end,
						GetJSON = function(t, clipboard)
							if nil == clipboard and t ~= nil then
								clipboard = t
							end
							local json = savestuff(nil, true)
							local clipfunc = (clipboard and type(clipboard) == "function" and clipboard) or setclipboard
							if clipboard and clipfunc then
								clipfunc(json)
							end
							return json
						end,
						RawSet = function(t, str)
							if nil == str and t ~= nil then
								str = t
							end
							selectedOption = str
							last_v = library_flags[flagName]
							library_flags[flagName] = str
							if options.Location then
								options.Location[options.LocationFlag or flagName] = str
							end
							update()
							return str
						end,
						Get = function()
							return library_flags[flagName]
						end,
						Update = update,
						Reset = function()
							return Set(nil, default)
						end
					}
					tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
					return objectdata
				end
			else
				function sectionFunctions.AddPersistence()
					if not library.warnedpersistance then
						library.warnedpersistance = 1
						warn(debug.traceback("Persistance not supported"))
					end
					function sectionFunctions.AddPersistence()
					end
				end
			end
			sectionFunctions.NewPersistence = sectionFunctions.AddPersistence
			sectionFunctions.CreatePersistence = sectionFunctions.AddPersistence
			sectionFunctions.Persistence = sectionFunctions.AddPersistence
			sectionFunctions.CreateSaveLoad = sectionFunctions.AddPersistence
			sectionFunctions.SaveLoad = sectionFunctions.AddPersistence
			sectionFunctions.SL = sectionFunctions.AddPersistence
			function sectionFunctions:AddDropdown(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Dropdown", options, ...)) or options
				local dropdownName, listt, val, callback, flagName = assert(options.Name, "Missing Name for new searchbox."), assert(options.List, "Missing List for new searchbox."), options.Value, options.Callback, options.Flag or (function()
					library.unnameddropdown = 1 + (library.unnameddropdown or 0)
					return "Dropdown" .. tostring(library.unnameddropdown)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local newDropdown = Instance_new("Frame")
				local dropdown = Instance_new("ImageLabel")
				local dropdownInner = Instance_new("ImageLabel")
				local dropdownToggle = Instance_new("ImageButton")
				local dropdownSelection = Instance_new("TextLabel")
				local dropdownHeadline = Instance_new("TextLabel")
				local dropdownHolderFrame = Instance_new("ImageLabel")
				local dropdownHolderInner = Instance_new("ImageLabel")
				local realDropdownHolder = Instance_new("ScrollingFrame")
				local realDropdownHolderList = Instance_new("UIListLayout")
				local dropdownEnabled = false
				local multiselect = options.MultiSelect or options.Multi or options.Multiple
				local addcallback = options.ItemAdded or options.AddedCallback
				local delcallback = options.ItemRemoved or options.RemovedCallback
				local clrcallback = options.ItemsCleared or options.ClearedCallback
				local modcallback = options.ItemChanged or options.ChangedCallback
				local blankstring = not multiselect and (options.BlankValue or options.NoValueString or options.Nothing)
								-- Linoria-Feature-Port: SpecialType (Player/Team) ueberschreibt die Liste mit einer Live-Funktion
				if options.SpecialType == "Player" then
					local excludeLocalPlayer = options.ExcludeLocalPlayer and true or false
					listt = function()
						local names = {}
						for _, plr in ipairs(playersservice:GetPlayers()) do
							if not (excludeLocalPlayer and plr == playersservice.LocalPlayer) then
								names[1 + #names] = plr.Name
							end
						end
						table.sort(names, function(a, b) return a:lower() < b:lower() end)
						return names
					end
				elseif options.SpecialType == "Team" then
					listt = function()
						local teamsservice = game:GetService("Teams")
						local names = {}
						for _, tm in ipairs(teamsservice:GetTeams()) do
							names[1 + #names] = tm.Name
						end
						table.sort(names, function(a, b) return a:lower() < b:lower() end)
						return names
					end
				end
				-- Linoria-Feature-Port: DisabledValues (gesperrte, aber sichtbare Optionen)
				local disabledValues = (type(options.DisabledValues) == "table" and options.DisabledValues) or {}
				local function isValueDisabled(v)
					return table.find(disabledValues, tostring(v)) ~= nil
				end
				-- Linoria-Feature-Port: FormatDisplayValue (eigener Anzeigetext statt Rohwert)
				local function formatValue(v)
					if v ~= nil and type(options.FormatDisplayValue) == "function" then
						local ok, res = pcall(options.FormatDisplayValue, v)
						if ok and res ~= nil then
							return tostring(res)
						end
					end
					return tostring(v)
				end
				-- Linoria-Feature-Port: MaxVisibleDropdownItems (Hoehe der geoeffneten Liste begrenzen)
				local userMaxVisibleItems = (type(options.MaxVisibleDropdownItems) == "number" and math.clamp(options.MaxVisibleDropdownItems, 4, 16)) or nil
local resolvelist = getresolver(listt, options.Filter, options.Method)
				local list = resolvelist()
				if next(list) then
				else
					local EmptyVal = options.EmptyValue
					if EmptyVal ~= nil then
						table.insert(list, 1, EmptyVal)
					end
				end
				local selectedOption = list[1]
				local passed_multiselect = multiselect and type(multiselect)
				if blankstring and val == nil then
					val = blankstring
				end
				if val ~= nil then
					selectedOption = val
				end
				if multiselect and (not selectedOption or type(selectedOption) ~= "table") then
					selectedOption = {}
				end
				local selectedObjects = {}
				local optionCount = 0
				newDropdown.Name = generateRandomName()
				newDropdown.Parent = sectionHolder
				newDropdown.BackgroundColor3 = Color3.new(1, 1, 1)
				newDropdown.BackgroundTransparency = 1
				newDropdown.Size = UDim2.new(1, 0, 0, 42)
				dropdown.Name = generateRandomName()
				dropdown.Parent = newDropdown
				dropdown.Active = true
				dropdown.BackgroundColor3 = library.colors.topGradient
				local colored_dropdown_BackgroundColor3 = {dropdown, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_dropdown_BackgroundColor3
				dropdown.BorderSizePixel = 0
				do
					local dropdownStroke = Instance_new("UIStroke")
					dropdownStroke.Name = generateRandomName()
					dropdownStroke.Parent = dropdown
					dropdownStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					dropdownStroke.Thickness = 1
					dropdownStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {dropdownStroke, "Color", "elementBorder"}
				end
				dropdown.Position = UDim2.fromScale(0.027, 0.45)
				dropdown.Selectable = true
				dropdown.Size = UDim2.new(0.946, 0, 0, 18) -- relativ statt fest 206px, sonst ragt es in schmalen Groupboxen raus
				dropdown.Image = "rbxassetid://2454009026"
				addCorner(dropdown, 4)
				dropdown.ImageColor3 = library.colors.bottomGradient
				local colored_dropdown_ImageColor3 = {dropdown, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_dropdown_ImageColor3
				dropdownInner.Name = generateRandomName()
				dropdownInner.Parent = dropdown
				dropdownInner.Active = true
				dropdownInner.AnchorPoint = Vector2.new(0.5, 0.5)
				dropdownInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownInner, "BackgroundColor3", "topGradient"}
				dropdownInner.BorderSizePixel = 0
				do
					local dropdownInnerStroke = Instance_new("UIStroke")
					dropdownInnerStroke.Name = generateRandomName()
					dropdownInnerStroke.Parent = dropdownInner
					dropdownInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					dropdownInnerStroke.Thickness = 1
					dropdownInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {dropdownInnerStroke, "Color", "elementBorder"}
				end
				dropdownInner.Position = UDim2.fromScale(0.5, 0.5)
				dropdownInner.Selectable = true
				dropdownInner.Size = UDim2.new(1, -4, 1, -4)
				dropdownInner.Image = "rbxassetid://2454009026"
				addCorner(dropdownInner, 4)
				dropdownInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownInner, "ImageColor3", "bottomGradient"}
				dropdownToggle.Name = generateRandomName()
				dropdownToggle.Parent = dropdown
				dropdownToggle.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownToggle.BackgroundTransparency = 1
				dropdownToggle.Position = UDim2.fromScale(0.9, 0.17)
				dropdownToggle.Rotation = 90
				dropdownToggle.Size = UDim2.fromOffset(12, 12)
				dropdownToggle.ZIndex = 2
				dropdownToggle.Image = "rbxassetid://71659683"
				dropdownToggle.ImageColor3 = Color3.fromRGB(171, 171, 171)
				dropdownSelection.Name = generateRandomName()
				dropdownSelection.Parent = dropdown
				dropdownSelection.Active = true
				dropdownSelection.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownSelection.BackgroundTransparency = 1
				dropdownSelection.Position = UDim2.new(0.0295)
				dropdownSelection.Selectable = true
				dropdownSelection.Size = UDim2.fromScale(0.97, 1)
				dropdownSelection.ZIndex = 5
				dropdownSelection.Font = Enum.Font.Code
				dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or (multiselect and tostring(blankstring or "Select Item(s)")) or (selectedOption and formatValue(selectedOption)) or tostring(blankstring or "No Blank String")
				dropdownSelection.TextColor3 = library.colors.otherElementText
				colored[1 + #colored] = {dropdownSelection, "TextColor3", "otherElementText"}
				dropdownSelection.TextSize = 14
				dropdownSelection.TextXAlignment = Enum.TextXAlignment.Left
				local dropdownSearchBox = nil
				if options.Searchable then
					dropdownSearchBox = Instance_new("TextBox")
					dropdownSearchBox.Name = generateRandomName()
					dropdownSearchBox.Parent = dropdown
					dropdownSearchBox.Active = true
					dropdownSearchBox.BackgroundColor3 = Color3.new(1, 1, 1)
					dropdownSearchBox.BackgroundTransparency = 1
					dropdownSearchBox.Position = dropdownSelection.Position
					dropdownSearchBox.Selectable = true
					dropdownSearchBox.Size = dropdownSelection.Size
					dropdownSearchBox.ZIndex = 6
					dropdownSearchBox.Font = Enum.Font.Code
					dropdownSearchBox.ClearTextOnFocus = false
					dropdownSearchBox.Text = ""
					dropdownSearchBox.PlaceholderText = "Suchen..."
					dropdownSearchBox.PlaceholderColor3 = library.colors.otherElementText
					colored[1 + #colored] = {dropdownSearchBox, "PlaceholderColor3", "otherElementText"}
					dropdownSearchBox.TextColor3 = library.colors.otherElementText
					colored[1 + #colored] = {dropdownSearchBox, "TextColor3", "otherElementText"}
					dropdownSearchBox.TextSize = 14
					dropdownSearchBox.TextXAlignment = Enum.TextXAlignment.Left
					dropdownSearchBox.Visible = false
				end

				dropdownHeadline.Name = generateRandomName()
				dropdownHeadline.Parent = newDropdown
				dropdownHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				dropdownHeadline.BackgroundTransparency = 1
				dropdownHeadline.Position = UDim2.fromScale(0.034, 0.03)
				dropdownHeadline.Size = UDim2.new(0.932, 0, 0, 11)
				dropdownHeadline.Font = Enum.Font.Code
				dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
				makeMarquee(dropdownHeadline)
				dropdownHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {dropdownHeadline, "TextColor3", "elementText"}
				dropdownHeadline.TextSize = 14
				dropdownHeadline.TextXAlignment = Enum.TextXAlignment.Left
				-- Linoria-Feature-Port: Tooltip (Tooltip / DisabledTooltip)
				if typeof(options.Tooltip) == "string" or typeof(options.DisabledTooltip) == "string" then
					library:AddToolTip(options.Tooltip, options.DisabledTooltip, newDropdown)
				end
				dropdownHolderFrame.Name = generateRandomName()
				dropdownHolderFrame.Parent = newDropdown
				dropdownHolderFrame.Active = true
				dropdownHolderFrame.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownHolderFrame, "BackgroundColor3", "topGradient"}
				dropdownHolderFrame.BorderSizePixel = 0
				do
					local dropdownHolderFrameStroke = Instance_new("UIStroke")
					dropdownHolderFrameStroke.Name = generateRandomName()
					dropdownHolderFrameStroke.Parent = dropdownHolderFrame
					dropdownHolderFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					dropdownHolderFrameStroke.Thickness = 1
					dropdownHolderFrameStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {dropdownHolderFrameStroke, "Color", "elementBorder"}
				end
				dropdownHolderFrame.Position = UDim2.fromScale(0.025, 1.012)
				dropdownHolderFrame.Selectable = true
				dropdownHolderFrame.Size = UDim2.new(0.95, 0, 0, 22)
				dropdownHolderFrame.Visible = false
				dropdownHolderFrame.Image = "rbxassetid://2454009026"
				addCorner(dropdownHolderFrame, 6)
				dropdownHolderFrame.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownHolderFrame, "ImageColor3", "bottomGradient"}
				dropdownHolderInner.Name = generateRandomName()
				dropdownHolderInner.Parent = dropdownHolderFrame
				dropdownHolderInner.Active = true
				dropdownHolderInner.AnchorPoint = Vector2.new(0.5, 0.5)
				dropdownHolderInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {dropdownHolderInner, "BackgroundColor3", "topGradient"}
				dropdownHolderInner.BorderSizePixel = 0
				do
					local dropdownHolderInnerStroke = Instance_new("UIStroke")
					dropdownHolderInnerStroke.Name = generateRandomName()
					dropdownHolderInnerStroke.Parent = dropdownHolderInner
					dropdownHolderInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					dropdownHolderInnerStroke.Thickness = 1
					dropdownHolderInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {dropdownHolderInnerStroke, "Color", "elementBorder"}
				end
				dropdownHolderInner.Position = UDim2.fromScale(0.5, 0.5)
				dropdownHolderInner.Selectable = true
				dropdownHolderInner.Size = UDim2.new(1, -4, 1, -4)
				dropdownHolderInner.Image = "rbxassetid://2454009026"
				addCorner(dropdownHolderInner, 6)
				dropdownHolderInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {dropdownHolderInner, "ImageColor3", "bottomGradient"}
				realDropdownHolder.Name = generateRandomName()
				realDropdownHolder.Parent = dropdownHolderInner
				realDropdownHolder.BackgroundColor3 = Color3.new(1, 1, 1)
				realDropdownHolder.BackgroundTransparency = 1
				realDropdownHolder.Selectable = false
				realDropdownHolder.Size = UDim2.fromScale(1, 1)
				realDropdownHolder.CanvasSize = UDim2.new()
				realDropdownHolder.ScrollBarThickness = 5
				realDropdownHolder.ScrollingDirection = Enum.ScrollingDirection.Y
				realDropdownHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
				realDropdownHolder.ScrollBarImageTransparency = 0.5
				realDropdownHolder.ScrollBarImageColor3 = library.colors.section
				colored[1 + #colored] = {realDropdownHolder, "ScrollBarImageColor3", "section"}
				realDropdownHolderList.Name = generateRandomName()
				realDropdownHolderList.Parent = realDropdownHolder
				realDropdownHolderList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				realDropdownHolderList.SortOrder = Enum.SortOrder.LayoutOrder
				sectionFunctions:Update()
				local showing = false
				local function UpdateDropdownHolder()
					if optionCount >= 6 then
						realDropdownHolder.CanvasSize = UDim2:fromOffset(realDropdownHolderList.AbsoluteContentSize.Y + 2)
						if userMaxVisibleItems then
							-- Linoria-Feature-Port: MaxVisibleDropdownItems begrenzt die sichtbare Hoehe, der Rest scrollt
							dropdownHolderFrame.Size = UDim2.new(0.95, 0, 0, math.min(optionCount, userMaxVisibleItems) * 18 + 4)
						end
					elseif optionCount <= 5 then
						dropdownHolderFrame.Size = UDim2.new(0.95, 0, 0, realDropdownHolderList.AbsoluteContentSize.Y + 4)
					end
				end
				local validate = nil
				local SetupValidation = nil
				do
					local Signals = {}
					local Setup = nil
					function SetupValidation()
						for k, v in next, Signals do
							v = v and v:Disconnect()
							Signals[k] = nil
						end
						if options.AutoValidate and list and (typeof(list) == "Instance") then
							local Val = library_flags[flagName] or selectedOption
							if multiselect then
								for _, v in next, Val do
									Setup(v)
								end
							else
								Setup(Val)
							end
						end
					end
					local gpcs = game.GetPropertyChangedSignal
					function Setup(v)
						if typeof(v) == "Instance" then
							local Signal = nil
							Signal = gpcs(v, "Parent"):Connect(function()
								if options.AutoValidate then
									if list and (v.Parent ~= list) then
										Signal = (Signal and Signal:Disconnect() and nil) or nil
										validate()
									end
								else
									for k, v in next, Signals do
										v = v and v:Disconnect()
										Signals[k] = nil
									end
								end
							end)
						end
					end
				end
				local restorezindex = {}
				local Set = (multiselect and function(t, dat)
					if nil == dat and t ~= nil then
						dat = t
					end
					local lastv = library_flags[flagName]
					if not lastv or selectedOption ~= lastv then
						if lastv and type(lastv) == "table" then
							selectedOption = library_flags[flagName]
						else
							library_flags[flagName] = selectedOption
						end
						warn("Attempting to use new table for", flagName, " Please use :Set(), as setting through flags table may cause errors", debug.traceback(""))
						lastv = library_flags[flagName]
					end
					local cloned = {unpack(selectedOption)}
					if not dat then
						if #selectedOption ~= 0 then
							table.clear(selectedOption)
							if callback then
								task.spawn(callback, selectedOption, cloned)
							end
						end
						return selectedOption
					elseif type(dat) ~= "table" then
						warn("Expected table for argument #1 on Set for MultiSelect dropdown. Got", dat, debug.traceback(""))
						return selectedOption
					end
					for k = table.pack(unpack(dat)).n, 1, -1 do
						if dat[k] == nil then
							table.remove(dat, k)
						end
					end
					local proceed = #cloned ~= #dat
					table.clear(selectedOption)
					for k, v in next, dat do
						selectedOption[k] = v
						if not proceed and cloned[k] ~= v then
							proceed = 1
						end
					end
					dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or tostring(blankstring or "Select Item(s)")
					if proceed and callback then
						task.spawn(callback, selectedOption, cloned)
					end
					if options.AutoValidate then
						SetupValidation()
					end
					return selectedOption
				end) or function(t, str)
					if nil == str and t ~= nil then
						str = t
					end
					local last_v = library_flags[flagName]
					selectedOption = str
					library_flags[flagName] = str
					if options.Location then
						options.Location[options.LocationFlag or flagName] = str
					end
					local sstr = (selectedOption and formatValue(selectedOption)) or blankstring or "No Blank String"
					if dropdownSelection.Text ~= sstr then
						dropdownSelection.Text = sstr
					end
					if callback and (last_v ~= str or options.AllowDuplicateCalls) then
						task.spawn(callback, str, last_v)
					end
					if options.AutoValidate then
						SetupValidation()
					end
					return str
				end
				if val ~= nil then
					Set(val)
				else
					library_flags[flagName] = selectedOption
					if options.Location then
						options.Location[options.LocationFlag or flagName] = selectedOption
					end
					if options.AutoValidate then
						SetupValidation()
					end
				end
								local displayTextByButton = setmetatable({}, {__mode = "k"})
				local function GetFilteredList()
					if options.Searchable and dropdownSearchBox and dropdownSearchBox.Text ~= "" then
						local term = string.lower(dropdownSearchBox.Text)
						local filtered = {}
						for _, v in next, list do
							local ok, matched = pcall(function()
								return string.lower(tostring(v)):match(term)
							end)
							if ok and matched then
								filtered[1 + #filtered] = v
							end
						end
						return filtered
					end
					return list
				end
local function AddOptions(optionsTable)
					if options.Sort then
						local didstuff, dosort = nil, options.Sort
						if type(dosort) == "function" then
							local g, h = pcall(table.sort, optionsTable, dosort)
							if g then
								didstuff = true
							elseif h then
								warn("Error sorting list:", h, debug.traceback(""))
							end
						elseif (dosort ~= 1) and (dosort ~= true) then
							warn("Potential mistake for passed Sort argument:", dosort, debug.traceback(""))
						end
						if not didstuff then
							table.sort(optionsTable, library.defaultSort)
						end
					end
					if blankstring and ((optionsTable[1] ~= blankstring) or table.find(optionsTable, blankstring, 2)) then
						local exists = table.find(optionsTable, blankstring)
						if exists then
							for _ = 1, 35 do
								table.remove(optionsTable, exists)
								exists = table.find(optionsTable, blankstring)
								if not exists then
									break
								end
							end
						end
						table.insert(optionsTable, 1, blankstring)
					end
					optionCount = 0
					realDropdownHolderList.Parent = nil
					realDropdownHolder:ClearAllChildren()
					realDropdownHolderList.Parent = realDropdownHolder
					for _, v in next, optionsTable do
						optionCount = optionCount + 1
						local newOption = Instance_new("ImageLabel")
						local optionButton = Instance_new("TextButton")
						if selectedOption == v then
							selectedObjects[1] = newOption
							selectedObjects[2] = optionButton
						end
						newOption.Name = generateRandomName()
						newOption.Parent = realDropdownHolder
						local togged = (not multiselect and selectedOption == v) or (multiselect and table.find(selectedOption, v))
						newOption.BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient
						newOption.BorderSizePixel = 0
						newOption.Size = UDim2.new(1, -4, 0, 18)
						newOption.Image = "rbxassetid://2454009026"
						addCorner(newOption, 3)
						newOption.ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
						local stringed = tostring(v)
						local displayed = formatValue(v)
						local isDisabled = isValueDisabled(v)
						optionButton.Name = stringed
						optionButton.Parent = newOption
						optionButton.AnchorPoint = Vector2.new(0.5, 0.5)
						optionButton.BackgroundColor3 = Color3.new(1, 1, 1)
						optionButton.BackgroundTransparency = 1
						optionButton.Position = UDim2.fromScale(0.5, 0.5)
						optionButton.Size = UDim2.new(1, -10, 1)
						optionButton.ZIndex = 5
						optionButton.Font = Enum.Font.Code
						optionButton.Text = (togged and (" " .. displayed)) or displayed
						optionButton.TextColor3 = (isDisabled and darkenColor(library.colors.otherElementText, 1.8)) or (togged and library.colors.main) or library.colors.otherElementText
						optionButton.TextSize = 14
						optionButton.TextXAlignment = Enum.TextXAlignment.Left
						displayTextByButton[optionButton] = displayed
						if isDisabled then
							newOption.ImageTransparency = 0.4
						end
						library.signals[1 + #library.signals] = optionButton.MouseButton1Click:Connect(function()
							if isDisabled then
								return
							end
							if not library.colorpicker then
								restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
								restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
								restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
								if multiselect then
									local cloned = {unpack(selectedOption)}
									local togged = table.find(selectedOption, v)
									if togged then
										table.remove(selectedOption, togged)
									else
										selectedOption[1 + #selectedOption] = v
									end
									togged = table.find(selectedOption, v)
									optionButton.Text = (togged and (" " .. displayed)) or displayed
									newOption.BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient
									newOption.ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
									optionButton.TextColor3 = (isDisabled and darkenColor(library.colors.otherElementText, 1.8)) or (togged and library.colors.main) or library.colors.otherElementText
									dropdownSelection.Text = (passed_multiselect == "string" and multiselect) or tostring(blankstring or "Select Item(s)")
									if callback then
										task.spawn(callback, selectedOption, cloned)
									end
									if togged then
										if addcallback then
											task.spawn(addcallback, v, selectedOption)
										end
									elseif delcallback then
										task.spawn(delcallback, v, selectedOption)
									end
									if modcallback then
										task.spawn(modcallback, v, togged, selectedOption)
									end
									if #selectedOption == 0 and clrcallback then
										task.spawn(clrcallback, selectedOption, cloned)
									end
									return
								else
									if selectedOption ~= v then
										local last_v = library_flags[flagName]
										selectedObjects[1].BackgroundColor3 = library.colors.topGradient
										selectedObjects[1].ImageColor3 = library.colors.bottomGradient
										selectedObjects[2].Text = displayTextByButton[selectedObjects[2]] or selectedObjects[2].Name
										selectedObjects[2].TextColor3 = library.colors.otherElementText
										selectedOption = v
										dropdownSelection.Text = displayed
										selectedObjects[1] = newOption
										selectedObjects[2] = optionButton
										newOption.BackgroundColor3 = library.colors.selectedOption
										newOption.ImageColor3 = library.colors.unselectedOption
										optionButton.Text = " " .. displayed
										optionButton.TextColor3 = library.colors.main
										dropdownHolderFrame.Visible = false
										dropdownToggle.Rotation = 90
										dropdownEnabled = false
										newDropdown.ZIndex = 1
										colored_dropdown_BackgroundColor3[3] = "topGradient"
										colored_dropdown_BackgroundColor3[4] = nil
										colored_dropdown_ImageColor3[3] = "bottomGradient"
										colored_dropdown_ImageColor3[4] = nil
										tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
											BackgroundColor3 = library.colors.topGradient,
											ImageColor3 = library.colors.bottomGradient
										}):Play()
										library_flags[flagName] = selectedOption
										if options.Location then
											options.Location[options.LocationFlag or flagName] = selectedOption
										end
										submenuOpen = nil
										showing = false
										if callback then
											task.spawn(callback, selectedOption, last_v)
										end
									else
										showing = false
										submenuOpen = nil
										dropdownToggle.Rotation = 90
										newDropdown.ZIndex = 1
										sectionHolder.ZIndex = 1
										colored_dropdown_BackgroundColor3[3] = "topGradient"
										colored_dropdown_BackgroundColor3[4] = nil
										colored_dropdown_ImageColor3[3] = "bottomGradient"
										colored_dropdown_ImageColor3[4] = nil
										tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
											BackgroundColor3 = library.colors.topGradient,
											ImageColor3 = library.colors.bottomGradient
										}):Play()
										dropdownHolderFrame.Visible = false
									end
								end
								for ins, z in next, restorezindex do
									ins.ZIndex = z
								end
							end
						end)
						library.signals[1 + #library.signals] = optionButton.MouseEnter:Connect(function()
							tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = library.colors.hoveredOptionTop,
								ImageColor3 = library.colors.hoveredOptionBottom
							}):Play()
						end)
						library.signals[1 + #library.signals] = optionButton.MouseLeave:Connect(function()
							local togged = (not multiselect and selectedOption == v) or (multiselect and table.find(selectedOption, v))
							tweenService:Create(newOption, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
								BackgroundColor3 = (togged and library.colors.selectedOption) or library.colors.topGradient,
								ImageColor3 = (togged and library.colors.unselectedOption) or library.colors.bottomGradient
							}):Play()
						end)
						UpdateDropdownHolder()
					end
				end
				local precisionscrolling, update = nil
				local function display(dropdownEnabled)
					if dropdownEnabled then
						closeOtherSubmenu(dropdown)
					end
					list = resolvelist()
					if next(list) then
					else
						local EmptyVal = options.EmptyValue
						if EmptyVal ~= nil then
							table.insert(list, 1, EmptyVal)
						end
					end
					if dropdownEnabled then
						if options.Searchable and dropdownSearchBox then
							dropdownSearchBox.Text = ""
							dropdownSearchBox.Visible = true
							dropdownSelection.Visible = false
						end
						AddOptions(GetFilteredList())
						submenuOpen = dropdown
						submenuCloseFn = function() display(false) end
						submenuOpenFrames = {newDropdown, dropdownHolderFrame}
						dropdownToggle.Rotation = 270
						restorezindex[newSection] = restorezindex[newSection] or newSection.ZIndex
						restorezindex[newDropdown] = restorezindex[newDropdown] or newDropdown.ZIndex
						restorezindex[sectionHolder] = restorezindex[sectionHolder] or sectionHolder.ZIndex
						newSection.ZIndex = 50 + newSection.ZIndex
						newDropdown.ZIndex = 2
						sectionHolder.ZIndex = 2
						colored_dropdown_BackgroundColor3[3] = "main"
						colored_dropdown_BackgroundColor3[4] = 1.5
						colored_dropdown_ImageColor3[3] = "main"
						colored_dropdown_ImageColor3[4] = 2.5
						tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = darkenColor(library.colors.main, 1.5),
							ImageColor3 = darkenColor(library.colors.main, 2.5)
						}):Play()
						dropdownHolderFrame.Visible = true
						if not options.DisablePrecisionScrolling then
							local upkey = options.ScrollUpButton or library.scrollupbutton or shared.scrollupbutton or Enum.KeyCode.Up
							local downkey = options.ScrollDownButton or library.scrolldownbutton or shared.scrolldownbutton or Enum.KeyCode.Down
							precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or userInputService.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.Keyboard then
									local code = input.KeyCode
									local isup = code == upkey
									local isdown = code == downkey
									if isup or isdown then
										local txt = userInputService:GetFocusedTextBox()
										if not txt or txt == dropdownSelection then
											while wait_check() and userInputService:IsKeyDown(code) do
												realDropdownHolder.CanvasPosition = Vector2:new(math.clamp(realDropdownHolder.CanvasPosition.Y + ((isup and -5) or 5), 0, realDropdownHolder.AbsoluteCanvasSize.Y))
											end
										end
									end
								end
							end)
							library.signals[1 + #library.signals] = precisionscrolling
						end
					else
						if options.Searchable and dropdownSearchBox then
							dropdownSearchBox.Text = ""
							dropdownSearchBox.Visible = false
							dropdownSelection.Visible = true
						end
						submenuOpen = nil
						dropdownToggle.Rotation = 90
						colored_dropdown_BackgroundColor3[3] = "topGradient"
						colored_dropdown_BackgroundColor3[4] = nil
						colored_dropdown_ImageColor3[3] = "bottomGradient"
						colored_dropdown_ImageColor3[4] = nil
						tweenService:Create(dropdown, TweenInfo.new(0.35, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
						dropdownHolderFrame.Visible = false
						for ins, z in next, restorezindex do
							ins.ZIndex = z
						end
						precisionscrolling = (precisionscrolling and precisionscrolling:Disconnect() and nil) or nil
					end
					if not multiselect and (not next(list) or not table.find(list, library_flags[flagName])) then
						Set(list[1])
					end
					showing = dropdownEnabled
					if showing or dropdownEnabled then
					else
						delay(0.01, update)
					end
				end
				if options.Searchable and dropdownSearchBox then
					library.signals[1 + #library.signals] = dropdownSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
						AddOptions(GetFilteredList())
					end)
				end
				library.signals[1 + #library.signals] = newDropdown.InputEnded:Connect(function(input)
					if not library.colorpicker and input.UserInputType == Enum.UserInputType.MouseButton1 then
						showing = not showing
						display(showing)
					end
				end)
				library.signals[1 + #library.signals] = newDropdown.MouseEnter:Connect(function()
					colored_dropdown_BackgroundColor3[3] = "main"
					colored_dropdown_BackgroundColor3[4] = 1.5
					colored_dropdown_ImageColor3[3] = "main"
					colored_dropdown_ImageColor3[4] = 2.5
					tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
				end)
				library.signals[1 + #library.signals] = newDropdown.MouseLeave:Connect(function()
					if not dropdownEnabled then
						colored_dropdown_BackgroundColor3[3] = "topGradient"
						colored_dropdown_BackgroundColor3[4] = nil
						colored_dropdown_ImageColor3[3] = "bottomGradient"
						colored_dropdown_ImageColor3[4] = nil
						tweenService:Create(dropdown, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
					end
				end)
				library.signals[1 + #library.signals] = dropdownToggle.MouseButton1Click:Connect(function()
					if not library.colorpicker then
						showing = not showing
						display(showing)
					end
				end)
				AddOptions(GetFilteredList())
				local default = library_flags[flagName]
				function update()
					dropdownName, callback = options.Name or dropdownName, options.Callback
					local sstr = (passed_multiselect == "string" and multiselect) or (library_flags[flagName] and formatValue(library_flags[flagName])) or (selectedOption and formatValue(selectedOption)) or blankstring or "nil"
					if dropdownSelection.Text ~= sstr then
						dropdownSelection.Text = sstr
					end
					dropdownHeadline.Text = (dropdownName and tostring(dropdownName)) or "???"
					return sstr
				end
				function validate(fallbackValue)
					if list and table.find(list, library_flags[flagName]) then
						update()
						return true
					end
					if fallbackValue ~= nil then
						if fallbackValue == "__DEFAULT" then
							fallbackValue = fallbackValue
						end
					else
						fallbackValue = list[1]
					end
					return Set((multiselect and {fallbackValue}) or fallbackValue)
				end
				local objectdata = {
					Options = options,
					Name = flagName,
					Flag = flagName,
					Type = "Dropdown",
					Default = default,
					Parent = sectionFunctions,
					Instance = dropdownSelection,
					Container = newDropdown,
					DisplayName = dropdownName,
					Get = function()
						return library_flags[flagName]
					end,
					Set = Set,
					Remove = function()
						if newDropdown then
							newDropdown.Parent = nil
							sectionFunctions:Update()
						end
					end,
					RawSet = ((multiselect and function(t, dat)
						if nil == dat and t ~= nil then
							dat = t
						end
						local lastv = library_flags[flagName]
						if not lastv or selectedOption ~= lastv then
							if lastv and type(lastv) == "table" then
								selectedOption = library_flags[flagName]
							else
								library_flags[flagName] = selectedOption
							end
							warn("Attempting to use new table for", flagName, " Please use :Set(), as setting through flags table may cause errors", debug.traceback(""))
							lastv = library_flags[flagName]
						end
						local cloned = {unpack(selectedOption)}
						if not dat then
							if #selectedOption ~= 0 then
								table.clear(selectedOption)
							end
							return selectedOption
						elseif type(dat) ~= "table" then
							warn("Expected table for argument #1 on Set for MultiSelect dropdown. Got", dat, debug.traceback(""))
							return selectedOption
						end
						for k = table.pack(unpack(dat)).n, 1, -1 do
							if dat[k] == nil then
								table.remove(dat, k)
							end
						end
						table.clear(selectedOption)
						for k, v in next, dat do
							selectedOption[k] = v
						end
						return selectedOption
					end) or function(t, str)
						if nil == str and t ~= nil then
							str = t
						end
						selectedOption = str
						library_flags[flagName] = str
						if options.Location then
							options.Location[options.LocationFlag or flagName] = str
						end
						update()
						return str
					end),
					Update = update,
					Reset = function()
						return Set(nil, default)
					end
				}
				function objectdata.UpdateList(t, listt, updateValues)
					if (nil == listt and t ~= nil) or (type(t) == "table" and type(listt) ~= "table") then
						listt, updateValues = t, listt
					end
					if listt == objectdata then
						listt = nil
					end
					resolvelist = getresolver(listt or options.List, options.Filter, options.Method)
					list = resolvelist()
					if next(list) then
					else
						local EmptyVal = options.EmptyValue
						if EmptyVal ~= nil then
							table.insert(list, 1, EmptyVal)
						end
					end
					if updateValues then
						validate()
					end
					if showing then
						display(false)
						display(true)
					end
					return list
				end
								function objectdata.SetDisabledValues(t, newDisabledValues)
					if nil == newDisabledValues and t ~= nil then
						newDisabledValues = t
					end
					if type(newDisabledValues) == "table" then
						disabledValues = newDisabledValues
					end
					if showing then
						AddOptions(GetFilteredList())
					end
					return disabledValues
				end
				function objectdata.AddDisabledValues(t, newDisabledValues)
					if nil == newDisabledValues and t ~= nil then
						newDisabledValues = t
					end
					if type(newDisabledValues) == "table" then
						for _, v in next, newDisabledValues do
							disabledValues[1 + #disabledValues] = v
						end
					elseif type(newDisabledValues) == "string" then
						disabledValues[1 + #disabledValues] = newDisabledValues
					end
					if showing then
						AddOptions(GetFilteredList())
					end
					return disabledValues
				end
				-- Linoria-Feature-Port: SpecialType Live-Update bei Spieler-/Team-Aenderungen
				if options.SpecialType == "Player" or options.SpecialType == "Team" then
					local function RefreshSpecialList()
						list = resolvelist()
						if showing then
							AddOptions(GetFilteredList())
						end
					end
					if options.SpecialType == "Player" then
						library.signals[1 + #library.signals] = playersservice.PlayerAdded:Connect(RefreshSpecialList)
						library.signals[1 + #library.signals] = playersservice.PlayerRemoving:Connect(RefreshSpecialList)
					else
						local teamsservice = game:GetService("Teams")
						library.signals[1 + #library.signals] = teamsservice.ChildAdded:Connect(RefreshSpecialList)
						library.signals[1 + #library.signals] = teamsservice.ChildRemoved:Connect(RefreshSpecialList)
					end
				end
tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.AddDropDown = sectionFunctions.AddDropdown
			sectionFunctions.NewDropDown = sectionFunctions.AddDropdown
			sectionFunctions.NewDropdown = sectionFunctions.AddDropdown
			sectionFunctions.CreateDropdown = sectionFunctions.AddDropdown
			sectionFunctions.CreateDropdown = sectionFunctions.AddDropdown
			sectionFunctions.DropDown = sectionFunctions.AddDropdown
			sectionFunctions.Dropdown = sectionFunctions.AddDropdown
			sectionFunctions.DD = sectionFunctions.AddDropdown
			sectionFunctions.Dd = sectionFunctions.AddDropdown
			function sectionFunctions:AddColorpicker(options, ...)
				options = (options and type(options) == "string" and resolvevararg("Colorpicker", options, ...)) or options
				if options.Random == true then
					options.Value = "random"
				elseif options.Rainbow == true then
					options.Value = "rainbow"
				end
				local colorPickerName, presetColor, callback, flagName = assert(options.Name, "Missing Name for new colorpicker."), options.Value, options.Callback, options.Flag or (function()
					library.unnamedcolorpicker = 1 + (library.unnamedcolorpicker or 0)
					return "Colorpicker" .. tostring(library.unnamedcolorpicker)
				end)()
				if elements[flagName] ~= nil then
					warn(debug.traceback("Warning! Re-used flag '" .. flagName .. "'", 3))
				end
				local designers = options.__designer
				options.__designer = nil
				local rainbowColorMode = false
				if presetColor == "random" then
					presetColor = Color3.new(math.random(), math.random(), math.random())
				elseif presetColor == "rainbow" then
					presetColor = Color3.new(1, 1, 1)
					rainbowColorMode = true
				end
				local newColorPicker = Instance_new("Frame")
				local colorPicker = Instance_new("ImageLabel")
				local colorPickerInner = Instance_new("ImageLabel")
				local colorPickerHeadline = Instance_new("TextLabel")
				local colorPickerButton = Instance_new("TextButton")
				local colorPickerHolderFrame = Instance_new("ImageLabel")
				local colorPickerHolderInner = Instance_new("ImageLabel")
				local color = Instance_new("ImageLabel")
				local selectorColor = Instance_new("Frame")
				local hue = Instance_new("ImageLabel")
				local hueGradient = Instance_new("UIGradient")
				local selectorHue = Instance_new("Frame")
				local randomColor = Instance_new("ImageLabel")
				local randomColorInner = Instance_new("ImageLabel")
				local randomColorButton = Instance_new("ImageButton")
				local hexInputBox = Instance_new("TextBox")
				local hexInput = Instance_new("ImageLabel")
				local hexInputInner = Instance_new("ImageLabel")
				local rainbow = Instance_new("ImageLabel")
				local rainbowInner = Instance_new("ImageLabel")
				local rainbowButton = Instance_new("ImageButton")
				local startingColor = presetColor or Color3.new(1, 1, 1)
				local colorPickerEnabled = false
				local colorH, colorS, colorV = 1, 1, 1
				local colorInput, hueInput = nil, nil
				local oldBackgroundColor = Color3.new()
				local oldImageColor = oldBackgroundColor
				local oldColor = oldBackgroundColor
				local rainbowColorValue = 0
				newColorPicker.Name = generateRandomName()
				newColorPicker.Parent = sectionHolder
				newColorPicker.BackgroundColor3 = Color3.new(1, 1, 1)
				newColorPicker.BackgroundTransparency = 1
				newColorPicker.Size = UDim2.new(1, 0, 0, 19)
				colorPicker.Name = generateRandomName()
				colorPicker.Parent = newColorPicker
				colorPicker.Active = true
				colorPicker.BackgroundColor3 = library.colors.topGradient
				local colored_colorPicker_BackgroundColor3 = {colorPicker, "BackgroundColor3", "topGradient"}
				colored[1 + #colored] = colored_colorPicker_BackgroundColor3
				colorPicker.BorderSizePixel = 0
				do
					local colorPickerStroke = Instance_new("UIStroke")
					colorPickerStroke.Name = generateRandomName()
					colorPickerStroke.Parent = colorPicker
					colorPickerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					colorPickerStroke.Thickness = 1
					colorPickerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {colorPickerStroke, "Color", "elementBorder"}
				end
				colorPicker.Position = UDim2.fromScale(0.842, 0.113)
				colorPicker.Selectable = true
				colorPicker.Size = UDim2.fromOffset(24, 12)
				colorPicker.Image = "rbxassetid://2454009026"
				addCorner(colorPicker, 4)
				colorPicker.ImageColor3 = library.colors.bottomGradient
				local colored_colorPicker_ImageColor3 = {colorPicker, "ImageColor3", "bottomGradient"}
				colored[1 + #colored] = colored_colorPicker_ImageColor3
				colorPickerInner.Name = generateRandomName()
				colorPickerInner.Parent = colorPicker
				colorPickerInner.Active = true
				colorPickerInner.AnchorPoint = Vector2.new(0.5, 0.5)
				colorPickerInner.BorderSizePixel = 0
				do
					local colorPickerInnerStroke = Instance_new("UIStroke")
					colorPickerInnerStroke.Name = generateRandomName()
					colorPickerInnerStroke.Parent = colorPickerInner
					colorPickerInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					colorPickerInnerStroke.Thickness = 1
					colorPickerInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {colorPickerInnerStroke, "Color", "elementBorder"}
				end
				colorPickerInner.Position = UDim2.fromScale(0.5, 0.5)
				colorPickerInner.Selectable = true
				colorPickerInner.Size = UDim2.new(1, -4, 1, -4)
				colorPickerInner.Image = "rbxassetid://2454009026"
				addCorner(colorPickerInner, 4)
				colorPickerInner.BackgroundColor3 = darkenColor(startingColor, 1.5)
				colorPickerInner.ImageColor3 = darkenColor(startingColor, 2.5)
				colorPickerHeadline.Name = generateRandomName()
				colorPickerHeadline.Parent = newColorPicker
				colorPickerHeadline.BackgroundColor3 = Color3.new(1, 1, 1)
				colorPickerHeadline.BackgroundTransparency = 1
				colorPickerHeadline.Position = UDim2.fromScale(0.034, 0.113)
				colorPickerHeadline.Size = UDim2.fromOffset(173, 11)
				colorPickerHeadline.Font = Enum.Font.Code
				colorPickerHeadline.Text = colorPickerName or "???"
				makeMarquee(colorPickerHeadline)
				colorPickerHeadline.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {colorPickerHeadline, "TextColor3", "elementText"}
				colorPickerHeadline.TextSize = 14
				colorPickerHeadline.TextXAlignment = Enum.TextXAlignment.Left
				-- Linoria-Feature-Port: Tooltip (Tooltip / DisabledTooltip)
				if typeof(options.Tooltip) == "string" or typeof(options.DisabledTooltip) == "string" then
					library:AddToolTip(options.Tooltip, options.DisabledTooltip, newColorPicker)
				end
				colorPickerButton.Name = generateRandomName()
				colorPickerButton.Parent = newColorPicker
				colorPickerButton.BackgroundColor3 = Color3.new(1, 1, 1)
				colorPickerButton.BackgroundTransparency = 1
				colorPickerButton.Size = UDim2.fromScale(1, 1)
				colorPickerButton.ZIndex = 5
				colorPickerButton.Font = Enum.Font.SourceSans
				colorPickerButton.Text = ""
				colorPickerButton.TextColor3 = Color3.new()
				colorPickerButton.TextSize = 14
				colorPickerButton.TextTransparency = 1
				colorPickerButton.BorderSizePixel = 0
				do
					local colorPickerButtonStroke = Instance_new("UIStroke")
					colorPickerButtonStroke.Name = generateRandomName()
					colorPickerButtonStroke.Parent = colorPickerButton
					colorPickerButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					colorPickerButtonStroke.Thickness = 1
					colorPickerButtonStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {colorPickerButtonStroke, "Color", "elementBorder"}
				end
				local colored_colorPickerButton_BorderColor3 = {colorPickerButton, "BorderColor3", "elementBorder"}
				colored[1 + #colored] = colored_colorPickerButton_BorderColor3
				local function UpdateColorPicker(force, rainbsow)
					local last_vv = library_flags[flagName]
					local newColor = force or Color3.fromHSV(colorH, colorS, colorV)
					if not force then
						colorH, colorS, colorV = newColor:ToHSV()
					end
					colorPickerInner.BackgroundColor3 = darkenColor(newColor, 1.5)
					colorPickerInner.ImageColor3 = darkenColor(newColor, 2.5)
					color.BackgroundColor3 = Color3.fromHSV(colorH, 1, 1)
					library_flags[flagName] = newColor
					if options.Location then
						options.Location[options.LocationFlag or flagName] = newColor
					end
					hexInputBox.Text = Color3ToHex(newColor)
					if force then
						color.BackgroundColor3 = force
						selectorColor.Position = UDim2.new(force and select(3, Color3.toHSV(force)))
					end
					local pos = 1 - (Color3.toHSV(newColor))
					local scalex = selectorHue.Position.X.Scale
					if scalex ~= pos and not (((pos == 0) or (pos == 1)) and ((scalex == 1) or (scalex == 0))) then
						selectorHue.Position = UDim2.new(pos)
					end
					if callback and last_vv ~= newColor then
						task.spawn(callback, newColor, last_vv, rainbsow)
					end
				end
				local function closeColorPicker()
					colorPickerEnabled = false
					library.colorpicker = false
					colorPickerHolderFrame.Visible = false
					for _, v in next, colorpickerconflicts do
						v.Visible = true
					end
					submenuOpen = nil
					newColorPicker.ZIndex = 0
					newSection.ZIndex = newSection.ZIndex - 100
					colorPickerButton.BorderSizePixel = 0
					do
						local colorPickerButtonStroke = Instance_new("UIStroke")
						colorPickerButtonStroke.Name = generateRandomName()
						colorPickerButtonStroke.Parent = colorPickerButton
						colorPickerButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
						colorPickerButtonStroke.Thickness = 1
						colorPickerButtonStroke.Color = library.colors.elementBorder
						colored[1 + #colored] = {colorPickerButtonStroke, "Color", "elementBorder"}
					end
					colored_colorPickerButton_BorderColor3[3] = "elementBorder"
				end
				library.signals[1 + #library.signals] = colorPickerButton.MouseButton1Click:Connect(function()
					if not colorPickerEnabled then
						closeOtherSubmenu(colorPicker)
					end
					if submenuOpen == colorPicker or submenuOpen == nil then
						colorPickerEnabled = not colorPickerEnabled
						library.colorpicker = colorPickerEnabled
						colorPickerHolderFrame.Visible = colorPickerEnabled
						if colorPickerEnabled then
							for _, v in next, colorpickerconflicts do
								v.Visible = false
							end
							submenuOpen = colorPicker
							submenuCloseFn = closeColorPicker
							submenuOpenFrames = {newColorPicker, colorPickerHolderFrame}
							newColorPicker.ZIndex = 2
							newSection.ZIndex = 100 + newSection.ZIndex
							colorPickerButton.BorderColor3 = library.colors.main
							colored_colorPickerButton_BorderColor3[3] = "main"
							UpdateColorPicker()
						else
							closeColorPicker()
						end
					end
				end)
				colorPickerHolderFrame.Name = generateRandomName()
				colorPickerHolderFrame.Parent = newColorPicker
				colorPickerHolderFrame.Active = true
				colorPickerHolderFrame.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {colorPickerHolderFrame, "BackgroundColor3", "topGradient"}
				colorPickerHolderFrame.BorderSizePixel = 0
				do
					local colorPickerHolderFrameStroke = Instance_new("UIStroke")
					colorPickerHolderFrameStroke.Name = generateRandomName()
					colorPickerHolderFrameStroke.Parent = colorPickerHolderFrame
					colorPickerHolderFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					colorPickerHolderFrameStroke.Thickness = 1
					colorPickerHolderFrameStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {colorPickerHolderFrameStroke, "Color", "elementBorder"}
				end
				colorPickerHolderFrame.Selectable = true
				colorPickerHolderFrame.Position = UDim2.fromScale(0.025, 1.012)
				colorPickerHolderFrame.Size = UDim2.fromOffset(206, 250)
				if math.ceil(colorPickerHolderFrame.AbsolutePosition.Y + colorPickerHolderFrame.AbsoluteSize.Y) > floor(newTabHolder.AbsoluteSize.Y + newTabHolder.AbsolutePosition.Y) then
					colorPickerHolderFrame.Position = UDim2.new(0.025, 0, 1.012, -colorPickerHolderFrame.AbsoluteSize.Y - colorPickerButton.AbsoluteSize.Y - 2)
				end
				colorPickerHolderFrame.Visible = false
				colorPickerHolderFrame.Image = "rbxassetid://2454009026"
				addCorner(colorPickerHolderFrame, 6)
				colorPickerHolderFrame.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {colorPickerHolderFrame, "ImageColor3", "bottomGradient"}
				colorPickerHolderInner.Name = generateRandomName()
				colorPickerHolderInner.Parent = colorPickerHolderFrame
				colorPickerHolderInner.Active = true
				colorPickerHolderInner.AnchorPoint = Vector2.new(0.5, 0.5)
				colorPickerHolderInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {colorPickerHolderInner, "BackgroundColor3", "topGradient"}
				colorPickerHolderInner.BorderSizePixel = 0
				do
					local colorPickerHolderInnerStroke = Instance_new("UIStroke")
					colorPickerHolderInnerStroke.Name = generateRandomName()
					colorPickerHolderInnerStroke.Parent = colorPickerHolderInner
					colorPickerHolderInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					colorPickerHolderInnerStroke.Thickness = 1
					colorPickerHolderInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {colorPickerHolderInnerStroke, "Color", "elementBorder"}
				end
				colorPickerHolderInner.Position = UDim2.fromScale(0.5, 0.5)
				colorPickerHolderInner.Selectable = true
				colorPickerHolderInner.Size = UDim2.new(1, -4, 1, -4)
				colorPickerHolderInner.Image = "rbxassetid://2454009026"
				addCorner(colorPickerHolderInner, 6)
				colorPickerHolderInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {colorPickerHolderInner, "ImageColor3", "bottomGradient"}
				color.Name = generateRandomName()
				color.Parent = colorPickerHolderInner
				color.BackgroundColor3 = startingColor
				color.BorderSizePixel = 0
				color.Position = UDim2.fromOffset(5, 5)
				color.Size = UDim2.new(1, -10, 0, 192)
				color.Image = "rbxassetid://4155801252"
				selectorColor.Name = generateRandomName()
				selectorColor.Parent = color
				selectorColor.AnchorPoint = Vector2.new(0.5, 0.5)
				selectorColor.BackgroundColor3 = Color3.fromRGB(144, 144, 144)
				selectorColor.BorderColor3 = Color3.fromRGB(69, 65, 70)
				selectorColor.Position = UDim2.new(startingColor and select(3, Color3.toHSV(startingColor)))
				selectorColor.Size = UDim2.fromOffset(4, 4)
				hue.Name = generateRandomName()
				hue.Parent = colorPickerHolderInner
				hue.BackgroundColor3 = Color3.new(1, 1, 1)
				hue.BorderSizePixel = 0
				hue.Position = UDim2.fromOffset(5, 202)
				hue.Size = UDim2.new(1, -10, 0, 14)
				hue.Image = "rbxassetid://3570695787"
				hue.ScaleType = Enum.ScaleType.Slice
				hue.SliceScale = 0.01
				hueGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(235, 7, 255)), ColorSequenceKeypoint.new(0.33, Color3:fromRGB(9, 189)), ColorSequenceKeypoint.new(0.5, Color3:fromRGB(193, 196)), ColorSequenceKeypoint.new(0.66, Color3:new(1)), ColorSequenceKeypoint.new(0.84, Color3.fromRGB(255, 247)), ColorSequenceKeypoint.new(1, Color3.new(1))})
				hueGradient.Name = generateRandomName()
				hueGradient.Parent = hue
				selectorHue.Name = generateRandomName()
				selectorHue.Parent = hue
				selectorHue.BackgroundColor3 = Color3:fromRGB(125, 255)
				selectorHue.BackgroundTransparency = 0.2
				selectorHue.BorderColor3 = Color3:fromRGB(84, 91)
				selectorHue.Position = UDim2.new(1 - (Color3.toHSV(startingColor)))
				selectorHue.Size = UDim2:new(2, 1)
				hexInput.Name = generateRandomName()
				hexInput.Parent = colorPickerHolderInner
				hexInput.Active = true
				hexInput.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {hexInput, "BackgroundColor3", "topGradient"}
				hexInput.BorderSizePixel = 0
				do
					local hexInputStroke = Instance_new("UIStroke")
					hexInputStroke.Name = generateRandomName()
					hexInputStroke.Parent = hexInput
					hexInputStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					hexInputStroke.Thickness = 1
					hexInputStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {hexInputStroke, "Color", "elementBorder"}
				end
				hexInput.Position = UDim2.fromOffset(5, 223)
				hexInput.Selectable = true
				hexInput.Size = UDim2.fromOffset(150, 18)
				hexInput.Image = "rbxassetid://2454009026"
				addCorner(hexInput, 3)
				hexInput.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {hexInput, "ImageColor3", "bottomGradient"}
				hexInputInner.Name = generateRandomName()
				hexInputInner.Parent = hexInput
				hexInputInner.Active = true
				hexInputInner.AnchorPoint = Vector2.new(0.5, 0.5)
				hexInputInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {hexInputInner, "BackgroundColor3", "topGradient"}
				hexInputInner.BorderSizePixel = 0
				do
					local hexInputInnerStroke = Instance_new("UIStroke")
					hexInputInnerStroke.Name = generateRandomName()
					hexInputInnerStroke.Parent = hexInputInner
					hexInputInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					hexInputInnerStroke.Thickness = 1
					hexInputInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {hexInputInnerStroke, "Color", "elementBorder"}
				end
				hexInputInner.Position = UDim2.fromScale(0.5, 0.5)
				hexInputInner.Selectable = true
				hexInputInner.Size = UDim2.new(1, -4, 1, -4)
				hexInputInner.Image = "rbxassetid://2454009026"
				addCorner(hexInputInner, 3)
				hexInputInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {hexInputInner, "ImageColor3", "bottomGradient"}
				hexInputBox.Name = generateRandomName()
				hexInputBox.Parent = hexInput
				hexInputBox.BackgroundColor3 = Color3.new(1, 1, 1)
				hexInputBox.BackgroundTransparency = 1
				hexInputBox.Size = UDim2.fromScale(1, 1)
				hexInputBox.ZIndex = 5
				hexInputBox.Font = Enum.Font.Code
				hexInputBox.PlaceholderText = "Hex Input"
				hexInputBox.Text = Color3ToHex(startingColor)
				hexInputBox.TextColor3 = library.colors.elementText
				colored[1 + #colored] = {hexInputBox, "TextColor3", "elementText"}
				hexInputBox.TextSize = 14
				hexInputBox.ClearTextOnFocus = false
				randomColor.Name = generateRandomName()
				randomColor.Parent = colorPickerHolderInner
				randomColor.Active = true
				randomColor.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {randomColor, "BackgroundColor3", "topGradient"}
				randomColor.BorderSizePixel = 0
				do
					local randomColorStroke = Instance_new("UIStroke")
					randomColorStroke.Name = generateRandomName()
					randomColorStroke.Parent = randomColor
					randomColorStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					randomColorStroke.Thickness = 1
					randomColorStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {randomColorStroke, "Color", "elementBorder"}
				end
				randomColor.Position = UDim2.fromOffset(158, 223)
				randomColor.Selectable = true
				randomColor.Size = UDim2.fromOffset(18, 18)
				randomColor.Image = "rbxassetid://2454009026"
				addCorner(randomColor, 3)
				randomColor.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {randomColor, "ImageColor3", "bottomGradient"}
				randomColorInner.Name = generateRandomName()
				randomColorInner.Parent = randomColor
				randomColorInner.Active = true
				randomColorInner.AnchorPoint = Vector2.new(0.5, 0.5)
				randomColorInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {randomColorInner, "BackgroundColor3", "topGradient"}
				randomColorInner.BorderSizePixel = 0
				do
					local randomColorInnerStroke = Instance_new("UIStroke")
					randomColorInnerStroke.Name = generateRandomName()
					randomColorInnerStroke.Parent = randomColorInner
					randomColorInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					randomColorInnerStroke.Thickness = 1
					randomColorInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {randomColorInnerStroke, "Color", "elementBorder"}
				end
				randomColorInner.Position = UDim2.fromScale(0.5, 0.5)
				randomColorInner.Selectable = true
				randomColorInner.Size = UDim2.new(1, -4, 1, -4)
				randomColorInner.Image = "rbxassetid://2454009026"
				addCorner(randomColorInner, 3)
				randomColorInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {randomColorInner, "ImageColor3", "bottomGradient"}
				randomColorButton.Name = generateRandomName()
				randomColorButton.Parent = randomColor
				randomColorButton.BackgroundColor3 = Color3.new(1, 1, 1)
				randomColorButton.BackgroundTransparency = 1
				randomColorButton.Size = UDim2.fromScale(1, 1)
				randomColorButton.ZIndex = 5
				randomColorButton.Image = "rbxassetid://7484765651"
				rainbow.Name = generateRandomName()
				rainbow.Parent = colorPickerHolderInner
				rainbow.Active = true
				rainbow.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {rainbow, "BackgroundColor3", "topGradient"}
				rainbow.BorderSizePixel = 0
				do
					local rainbowStroke = Instance_new("UIStroke")
					rainbowStroke.Name = generateRandomName()
					rainbowStroke.Parent = rainbow
					rainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					rainbowStroke.Thickness = 1
					rainbowStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {rainbowStroke, "Color", "elementBorder"}
				end
				rainbow.Position = UDim2.fromOffset(158 + 18 + 4, 223)
				rainbow.Selectable = true
				rainbow.Size = UDim2.fromOffset(18, 18)
				rainbow.Image = "rbxassetid://2454009026"
				addCorner(rainbow, 3)
				rainbow.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {rainbow, "ImageColor3", "bottomGradient"}
				rainbowInner.Name = generateRandomName()
				rainbowInner.Parent = randomColor
				rainbowInner.Active = true
				rainbowInner.AnchorPoint = Vector2.new(0.5, 0.5)
				rainbowInner.BackgroundColor3 = library.colors.topGradient
				colored[1 + #colored] = {rainbowInner, "BackgroundColor3", "topGradient"}
				rainbowInner.BorderSizePixel = 0
				do
					local rainbowInnerStroke = Instance_new("UIStroke")
					rainbowInnerStroke.Name = generateRandomName()
					rainbowInnerStroke.Parent = rainbowInner
					rainbowInnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					rainbowInnerStroke.Thickness = 1
					rainbowInnerStroke.Color = library.colors.elementBorder
					colored[1 + #colored] = {rainbowInnerStroke, "Color", "elementBorder"}
				end
				rainbowInner.Position = UDim2.fromScale(0.5, 0.5)
				rainbowInner.Selectable = true
				rainbowInner.Size = UDim2.new(1, -4, 1, -4)
				rainbowInner.Image = "rbxassetid://2454009026"
				addCorner(rainbowInner, 3)
				rainbowInner.ImageColor3 = library.colors.bottomGradient
				colored[1 + #colored] = {rainbowInner, "ImageColor3", "bottomGradient"}
				rainbowButton.Name = generateRandomName()
				rainbowButton.Parent = rainbow
				rainbowButton.BackgroundColor3 = Color3.new(1, 1, 1)
				rainbowButton.BackgroundTransparency = 1
				rainbowButton.Size = UDim2.fromScale(1, 1)
				rainbowButton.ZIndex = 5
				rainbowButton.Image = "rbxassetid://7484772919"
				local indexwith = (designers and "rainbows") or "rainbowsg"
				local function setrainbow(t, rainbowColorMod)
					if nil == rainbowColorMod and t ~= nil then
						rainbowColorMod = t
					end
					if rainbowColorMod == nil or type(rainbowColorMod) ~= "boolean" then
						rainbowColorMode = not rainbowColorMode
					else
						rainbowColorMode = rainbowColorMod
					end
					if colorInput then
						colorInput = (colorInput:Disconnect() and nil) or nil
					end
					if hueInput then
						hueInput = (hueInput:Disconnect() and nil) or nil
					end
					pcall(function()
						if destroyrainbows and library.rainbows <= 0 then
							destroyrainbows = nil
						end
						if destroyrainbowsg and library.rainbowsg <= 0 then
							destroyrainbowsg = nil
						end
					end)
					if rainbowColorMode then
						pcall(function()
							if not library.rainbowflags[flagName] then
								library[indexwith] = 1 + library[indexwith]
							end
							library.rainbowflags[flagName] = true
							oldImageColor = colorPickerInner.ImageColor3
							oldBackgroundColor = colorPickerInner.BackgroundColor3
							oldColor = color.BackgroundColor3
							pcall(function()
								local common_float = 1 / 255
								while wait_check() and rainbowColorMode and (options.Value == "rainbow" or ((not designers and not destroyrainbowsg) or (designers and not destroyrainbows))) do
									rainbowColorValue = common_float + rainbowColorValue
									if rainbowColorValue > 1 then
										rainbowColorValue = 0
									end
									colorH = rainbowColorValue
									UpdateColorPicker(Color3.fromHSV(rainbowColorValue, 1, 1), true)
								end
							end)
						end)
						pcall(function()
							rainbowColorMode = nil
							if library.rainbowflags[flagName] then
								library[indexwith] = library[indexwith] - 1
							end
							library.rainbowflags[flagName] = nil
						end)
					end
					UpdateColorPicker(library_flags[flagName])
				end
				library.signals[1 + #library.signals] = randomColorButton.MouseButton1Click:Connect(function()
					if rainbowColorMode then
						setrainbow(false)
					end
					UpdateColorPicker(Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
				end)
				library.signals[1 + #library.signals] = rainbowButton.MouseButton1Click:Connect(setrainbow)
				sectionFunctions:Update()
				library.signals[1 + #library.signals] = newColorPicker.MouseEnter:Connect(function()
					tweenService:Create(colorPicker, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
						BackgroundColor3 = darkenColor(library.colors.main, 1.5),
						ImageColor3 = darkenColor(library.colors.main, 2.5)
					}):Play()
					colored_colorPicker_BackgroundColor3[3] = "main"
					colored_colorPicker_BackgroundColor3[4] = 1.5
					colored_colorPicker_ImageColor3[3] = "main"
					colored_colorPicker_ImageColor3[4] = 2.5
				end)
				library.signals[1 + #library.signals] = newColorPicker.MouseLeave:Connect(function()
					if not colorPickerEnabled then
						tweenService:Create(colorPicker, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {
							BackgroundColor3 = library.colors.topGradient,
							ImageColor3 = library.colors.bottomGradient
						}):Play()
						colored_colorPicker_BackgroundColor3[3] = "topGradient"
						colored_colorPicker_BackgroundColor3[4] = nil
						colored_colorPicker_ImageColor3[3] = "bottomGradient"
						colored_colorPicker_ImageColor3[4] = nil
					end
				end)
				hexInputBox.FocusLost:Connect(function()
					if #hexInputBox.Text > 5 then
						local last_vv = library_flags[flagName]
						local not_fucked, clr = pcall(Color3FromHex, hexInputBox.Text)
						UpdateColorPicker((not_fucked and clr) or last_vv)
					end
				end)
				colorH = 1 - (math.clamp(selectorHue.AbsolutePosition.X - hue.AbsolutePosition.X, 0, hue.AbsoluteSize.X) / hue.AbsoluteSize.X)
				colorS = (math.clamp(selectorColor.AbsolutePosition.X - color.AbsolutePosition.X, 0, color.AbsoluteSize.X) / color.AbsoluteSize.X)
				colorV = 1 - (math.clamp(selectorColor.AbsolutePosition.Y - color.AbsolutePosition.Y, 0, color.AbsoluteSize.Y) / color.AbsoluteSize.Y)
				library.signals[1 + #library.signals] = color.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						isDraggingSomething = true
						colorInput = (colorInput and colorInput:Disconnect() and nil) or runService.RenderStepped:Connect(function()
							local colorX = (math.clamp(mouse.X - color.AbsolutePosition.X, 0, color.AbsoluteSize.X) / color.AbsoluteSize.X)
							local colorY = (math.clamp(mouse.Y - color.AbsolutePosition.Y, 0, color.AbsoluteSize.Y) / color.AbsoluteSize.Y)
							selectorColor.Position = UDim2.fromScale(colorX, colorY)
							colorS = colorX
							colorV = 1 - colorY
							UpdateColorPicker()
						end)
						library.signals[1 + #library.signals] = colorInput
					end
				end)
				library.signals[1 + #library.signals] = color.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if colorInput then
							isDraggingSomething = false
							colorInput:Disconnect()
						end
					end
				end)
				library.signals[1 + #library.signals] = hue.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if hueInput then
							hueInput:Disconnect()
						end
						isDraggingSomething = true
						hueInput = runService.RenderStepped:Connect(function()
							local hueX = math.clamp(mouse.X - hue.AbsolutePosition.X, 0, hue.AbsoluteSize.X) / hue.AbsoluteSize.X
							selectorHue.Position = UDim2.new(hueX)
							colorH = 1 - hueX
							UpdateColorPicker()
						end)
						library.signals[1 + #library.signals] = hueInput
					end
				end)
				library.signals[1 + #library.signals] = hue.InputEnded:Connect(function(input)
					if hueInput and input.UserInputType == Enum.UserInputType.MouseButton1 then
						isDraggingSomething = false
						hueInput:Disconnect()
					end
				end)
				if rainbowColorMode then
					spawn(function()
						rainbowColorMode = nil
						setrainbow(true)
					end)
				end
				local function Set(t, clr)
					if clr == nil and t ~= nil then
						clr = t
					end
					if clr == "rainbow" then
						if not rainbowColorMode then
							task.spawn(setrainbow, true)
						end
						return
					elseif clr == "random" then
						clr = Color3.new(math.random(), math.random(), math.random())
					elseif type(clr) == "string" and tonumber(clr, 16) then
						clr = Color3FromHex(clr)
					end
					task.spawn(setrainbow, false)
					local last_v = library_flags[flagName]
					library_flags[flagName] = clr
					if options.Location then
						options.Location[options.LocationFlag or flagName] = clr
					end
					color.BackgroundColor3 = clr
					selectorColor.Position = UDim2.new(clr and select(3, Color3.toHSV(clr)))
					selectorHue.Position = UDim2.new(1 - (Color3.toHSV(clr)))
					colorPickerInner.BackgroundColor3 = darkenColor(clr, 1.5)
					colorPickerInner.ImageColor3 = darkenColor(clr, 2.5)
					hexInputBox.Text = Color3ToHex(clr)
					colorH, colorS, colorV = Color3.toHSV(clr)
					if callback and (last_v ~= clr or options.AllowDuplicateCalls) then
						task.spawn(callback, clr, last_v)
					end
					return clr
				end
				if presetColor ~= nil then
					Set(presetColor)
				else
					library_flags[flagName] = startingColor
					if options.Location then
						options.Location[options.LocationFlag or flagName] = startingColor
					end
				end
				local default = options.Value or startingColor or library_flags[flagName]
				local function update()
					colorPickerName, callback = options.Name or colorPickerName, options.Callback
					local clr = library_flags[flagName]
					color.BackgroundColor3 = clr
					selectorColor.Position = UDim2.new(clr and select(3, Color3.toHSV(clr)))
					selectorHue.Position = UDim2.new(1 - (Color3.toHSV(clr)))
					colorPickerInner.BackgroundColor3 = darkenColor(clr, 1.5)
					colorPickerInner.ImageColor3 = darkenColor(clr, 2.5)
					hexInputBox.Text = Color3ToHex(clr)
					colorPickerHeadline.Text = colorPickerName or "???"
					return clr
				end
				local objectdata = {
					Options = options,
					Name = flagName,
					Flag = flagName,
					Type = "Colorpicker",
					Default = default,
					Parent = sectionFunctions,
					Instance = newColorPicker,
					Container = newColorPicker,
					DisplayName = colorPickerName,
					SetRainbow = setrainbow,
					Get = function()
						return library_flags[flagName]
					end,
					GetRainbow = function()
						return rainbowColorMode
					end,
					Set = Set,
					Remove = function()
						if newColorPicker then
							newColorPicker.Parent = nil
							sectionFunctions:Update()
						end
					end,
					RawSet = function(t, clr)
						if clr == nil and t ~= nil then
							clr = t
						end
						if clr == "rainbow" then
							if not rainbowColorMode then
								task.spawn(setrainbow, true)
							end
							return clr
						elseif clr == "random" then
							clr = Color3.new(math.random(), math.random(), math.random())
						elseif clr and type(clr) == "string" and tonumber(clr, 16) then
							clr = Color3FromHex(clr)
						end
						task.spawn(setrainbow, false)
						library_flags[flagName] = clr
						if options.Location then
							options.Location[options.LocationFlag or flagName] = clr
						end
						return clr
					end,
					Update = update,
					Reset = function()
						return Set(nil, default)
					end
				}
				tabFunctions.Flags[flagName], sectionFunctions.Flags[flagName], elements[flagName] = objectdata, objectdata, objectdata
				return objectdata
			end
			sectionFunctions.AddColorPicker = sectionFunctions.AddColorpicker
			sectionFunctions.NewColorpicker = sectionFunctions.AddColorpicker
			sectionFunctions.NewColorPicker = sectionFunctions.AddColorpicker
			sectionFunctions.CreateColorPicker = sectionFunctions.AddColorpicker
			sectionFunctions.CreateColorpicker = sectionFunctions.AddColorpicker
			sectionFunctions.ColorPicker = sectionFunctions.AddColorpicker
			sectionFunctions.Colorpicker = sectionFunctions.AddColorpicker
			sectionFunctions.Cp = sectionFunctions.AddColorpicker
			sectionFunctions.CP = sectionFunctions.AddColorpicker
			return sectionFunctions
		end
		tabFunctions.AddSection = tabFunctions.CreateSection
		tabFunctions.NewSection = tabFunctions.CreateSection
		tabFunctions.Section = tabFunctions.CreateSection
		tabFunctions.Sec = tabFunctions.CreateSection
		tabFunctions.S = tabFunctions.CreateSection
		function tabFunctions:UpdateAll()
			local target = self or tabFunctions
			if target and type(target) == "table" and target.Flags then
				for _, e in next, target.Flags do
					if e and type(e) == "table" and e.Update then
						pcall(e.Update)
					end
				end
			end
		end
		
		
		
		
		
		
		
		
		
		
		return tabFunctions
	end
	windowFunctions.AddTab = windowFunctions.CreateTab
	windowFunctions.NewTab = windowFunctions.CreateTab
	windowFunctions.Tab = windowFunctions.CreateTab
	windowFunctions.T = windowFunctions.CreateTab
	function windowFunctions:CreateDesigner(options, ...)
		options = (options and type(options) == "string" and resolvevararg("Tab", options, ...)) or options
		assert(shared.bypasstablimit or (library.Designer == nil), "Designer already exists")
		options = options or {}
		options.Name = options.Name or "Settings"
		options.LastTab = true
		local designer = windowFunctions:CreateTab(options)
		local colorsection = designer:CreateSection({
			Name = "Colors"
		})
		local backgroundsection = designer:CreateSection({
			Name = "Background",
			Side = "right"
		})
		local detailssection = designer:CreateSection({
			Name = "More Info"
		})
		local filessection = designer:CreateSection({
			Name = "Profiles",
			Side = "right"
		})
		local settingssection = designer:CreateSection({
			Name = "Settings",
			Side = "right"
		})
		local designerelements = {}
		library.designerelements = designerelements
		for _, v in next, {{"Main", "main"}, {"Background", "background"}, {"Outer Border", "outerBorder"}, {"Inner Border", "innerBorder"}, {"Top Gradient", "topGradient"}, {"Bottom Gradient", "bottomGradient"}, {"Section Background", "sectionBackground"}, {"Section", "section"}, {"Element Text", "elementText"}, {"Other Element Text", "otherElementText"}, {"Tab Text", "tabText"}, {"Element Border", "elementBorder"}, {"Selected Option", "selectedOption"}, {"Unselected Option", "unselectedOption"}, {"Hovered Option Top", "hoveredOptionTop"}, {"Unhovered Option Top", "unhoveredOptionTop"}, {"Hovered Option Bottom", "hoveredOptionBottom"}, {"Unhovered Option Bottom", "unhoveredOptionBottom"}} do
			local nam, codename = v[1], v[2]
			local cflag = "__Designer.Colors." .. codename
			designerelements[codename] = {
				Return = colorsection:AddColorpicker({
					Name = nam,
					Flag = cflag,
					Value = library.colors[codename],
					Callback = function(v, y)
						library.colors[codename] = v or y
					end,
					__designer = 1
				}),
				Flag = cflag
			}
		end
		local flags = {}
		local persistoptions = {
			Name = "Config Profile",
			Flag = "__Designer.Background.WorkspaceProfile",
			Flags = true,
			Suffix = "Config",
			Workspace = library.WorkspaceName or "Unnamed Workspace",
			Desginer = true
		}
		local daaata = {{"AddTextbox", "__Designer.Textbox.ImageAssetID", backgroundsection, {
			Name = "Image Asset ID",
			Placeholder = "rbxassetid://133158046147209",
			Flag = "__Designer.Background.ImageAssetID",
			Value = "rbxassetid://133158046147209",
			Callback = updatecolorsnotween
		}}, {"AddColorpicker", "__Designer.Colorpicker.ImageColor", backgroundsection, {
			Name = "Image Color",
			Flag = "__Designer.Background.ImageColor",
			Value = Color3.new(1, 1, 1),
			Callback = updatecolorsnotween,
			__designer = 1
		}}, {"AddSlider", "__Designer.Slider.ImageTransparency", backgroundsection, {
			Name = "Image Transparency",
			Flag = "__Designer.Background.ImageTransparency",
			Value = 50,
			Min = 0,
			Max = 100,
			Format = "Image Transparency: %s%%",
			Textbox = true,
			Callback = updatecolorsnotween
		}}, {"AddToggle", "__Designer.Toggle.UseBackgroundImage", backgroundsection, {
			Name = "Use Background Image",
			Flag = "__Designer.Background.UseBackgroundImage",
			Value = true,
			Callback = updatecolorsnotween
		}}, {"AddToggle", "__Designer.Toggle.CursorToggle", backgroundsection, {
			Name = "Custom Cursor",
			Flag = "__Designer.Cursor.Enabled",
			Value = true,
			Callback = function(value)
				if value then
					CursorModule:Enable()
				else
					CursorModule:Disable()
				end
			end
		}}, {"AddToggle", "__Designer.Toggle.KeystrokesToggle", backgroundsection, {
			Name = "Show Keystrokes",
			Flag = "__Designer.Keystrokes.Enabled",
			Value = false,
			Callback = function(value)
				if value then
					pcall(function()
						KeystrokesModule:Show()
					end)
				else
					pcall(function()
						KeystrokesModule:Hide()
					end)
				end
			end
		}}, {"AddToggle", "__Designer.Toggle.WatermarkToggle", backgroundsection, {
			Name = "Show Watermark",
			Flag = "__Designer.Watermark.Enabled",
			Value = true,
			Callback = function(value)
				if value then
					if not WatermarkModule.WatermarkOuter then
						pcall(function()
							WatermarkModule:Create()
						end)
					else
						pcall(function()
							WatermarkModule:Show()
						end)
					end
				else
					if WatermarkModule.WatermarkOuter then
						pcall(function()
							WatermarkModule:Hide()
						end)
					end
				end
			end
		}}, {"AddToggle", "__Designer.Toggle.KeybindsListToggle", backgroundsection, {
			Name = "Show Keybinds List",
			Flag = "__Designer.KeybindsList.Enabled",
			Value = true,
			Callback = function(value)
				if value then
					pcall(function()
						KeybindsListModule:Show()
					end)
				else
					pcall(function()
						KeybindsListModule:Hide()
					end)
				end
			end
		}}, {"AddPersistence", "__Designer.Persistence.ThemeFile", filessection, {
			Name = "Theme Profile",
			Flag = "__Designer.Files.ThemeFile",
			Workspace = "D3v1lHub Lib Themes",
			Flags = flags,
			Suffix = "Theme",
			Desginer = true
		}}, {"AddTextbox", "__Designer.Textbox.WorkspaceName", filessection, {
			Name = "Workspace Name",
			Value = library.WorkspaceName or "Unnamed Workspace",
			Flag = "__Designer.Files.WorkspaceFile",
			Callback = function(n, o)
				persistoptions.Workspace = n or o
			end
		}}, {"AddPersistence", "__Designer.Persistence.WorkspaceProfile", filessection, persistoptions}, {"AddButton", "__Designer.Button.TerminateGUI", settingssection, {{
			Name = "Terminate GUI",
			Callback = function()
				pcall(terminateGui)
			end
		}, {
			Name = "Reset GUI",
			Callback = resetall
		}, {
			Name = "Reset Designer",
			Callback = function()
				destroyrainbows = true
				pcall(function()
					for k, v in next, elements do
						if v and k and v.Set and (v.Default ~= nil) and (library_flags[k] ~= v.Default) and (string.sub(k, 1, 11) == "__Designer.") then
							v:Set(v.Default)
						end
					end
				end)
			end
		}}}, {"AddKeybind", "__Designer.Keybind.ShowHideKey", settingssection, {
			Name = "Show/Hide Key",
			Location = library.configuration,
			Flag = "__Designer.Settings.ShowHideKey",
			LocationFlag = "hideKeybind",
			Value = library.configuration.hideKeybind,
			CoreBinding = true,
			Callback = function()
				lasthidebing = os.clock()
			end
		}}, {"AddLabel", "__Designer.Label.Version", settingssection, {
			Name = "Library Version: " .. tostring(library.Version or "?")
		}}}
		if setclipboard and daaata[8] then
			local common_table = daaata[8][4]
			if common_table then
				common_table[1 + #common_table] = {
					Name = "Copy Theme",
					Callback = function()
						local working_with = {}
						if #flags > 0 then
							for k, cflag in next, flags do
								if k > 0 then
									local data = elements[cflag]
									if data and (data.Type ~= "Persistence") and (string.sub(cflag, 1, 11) == "__Designer.") then
										working_with[cflag] = data
									end
								end
							end
						end
						local saving = {}
						for cflag in next, working_with do
							local value = library_flags[cflag]
							local good, jval = nil, nil
							if value ~= nil then
								good, jval = JSONEncode(value)
							else
								good, jval = true, "null"
							end
							if not good or ((jval == "null") and (value ~= nil)) then
								local typ = typeof(value)
								if typ == "Color3" then
									value = (library.rainbowflags[cflag] and "rainbow") or Color3ToHex(value)
								end
								value = tostring(value)
								good, jval = JSONEncode(value)
								if not good or ((jval == "null") and (value ~= nil)) then
									warn("Could not save value:", value, debug.traceback(""))
								end
							end
							if good and jval then
								saving[cflag] = value
							end
						end
						local good, content = JSONEncode(saving)
						if good and content then
							setclipboard(content)
						end
					end
				}
				common_table = nil
			end
		end
		if options.Credit ~= false then
			daaata[1 + #daaata] = {"AddLabel", "__Designer.Label.Creator", detailssection, {
				Text = "Library by d3v1lhub2222 "
			}}
		elseif "Gee, thanks for your support." then
		end
		if options.Info then
			local typ = type(options.Info)
			if typ == "string" then
				daaata[1 + #daaata] = {"AddLabel", "__Designer.Label.Creator", detailssection, {
					Text = options.Info
				}}
			elseif typ == "table" and #options.Info > 0 then
				for _, v in next, options.Info do
					daaata[1 + #daaata] = {"AddLabel", "__Designer.Label.Creator", detailssection, {
						Text = tostring(v)
					}}
				end
			end
		end
		for _, v in next, daaata do
			designerelements[v[2]] = v[3][v[1]](v[3], v[4])
		end
		designerelements["__Designer.Textbox.WorkspaceName"]:Set(library.WorkspaceName or "Unnamed Workspace")
		for k, v in next, elements do
			if v and k and string.sub(k, 1, 11) == "__Designer." and v.Type and v.Type ~= "Persistence" then
				flags[1 + #flags] = k
			end
		end
		if library.Backdrop then
			library.Backdrop.Image = resolveid(library_flags["__Designer.Background.ImageAssetID"], "__Designer.Background.ImageAssetID") or ""
			library.Backdrop.Visible = library_flags["__Designer.Background.UseBackgroundImage"] and true
			library.Backdrop.ImageTransparency = (library_flags["__Designer.Background.ImageTransparency"] or 50) / 100
			library.Backdrop.ImageColor3 = library_flags["__Designer.Background.ImageColor"] or Color3.new(1, 1, 1)
		end
		local function setbackground(t, Asset, Transparency, Visible)
			if Visible == nil and t ~= nil and type(t) ~= "table" then
				Asset, Transparency, Visible = t, Transparency, Visible
			end
			if Visible == 0 or ((Asset == 0 or Asset == false) and Visible == nil and Transparency == nil) then
				Visible = false
			elseif Visible == 1 or ((Asset == 1 or Asset == true) and Visible == nil and Transparency == nil) then
				Visible = true
			elseif Asset == nil and Transparency == nil and Visible == nil then
				Visible = not library_flags["__Designer.Background.UseBackgroundImage"]
			end
			local temp = Asset and type(Asset)
			if Transparency == nil and Visible == nil and temp == "number" and ((Asset ~= 1 and Asset ~= 0) or (Asset > 0 and Asset <= 100)) then
				Transparency, Asset, temp = Asset, nil
			end
			if temp and ((temp == "number" and Asset > 1) or temp == "string") then
				designerelements["__Designer.Textbox.ImageAssetID"]:Set(Asset)
			end
			temp = tonumber(Transparency)
			temp = (temp >= 0 and temp <= 1 and temp * 100) or temp
			if temp then
				designerelements["__Designer.Slider.ImageTransparency"]:Set(temp)
			end
			if Visible ~= nil then
				designerelements["__Designer.Toggle.UseBackgroundImage"]:Set(Visible and true)
			end
			return Asset, Transparency, Visible
		end
		local bk = options.Background or options.Backdrop or options.Grahpic
		if bk then
			if type(bk) == "table" then
				setbackground(bk.Asset or bk[1], bk.Transparency or bk[2], bk.Visible or bk[3])
			else
				setbackground(bk, 0, 1)
			end
		end
		library.Designer = {
			Options = options,
			Parent = windowFunctions,
			Name = "Designer",
			Flag = "Designer",
			Type = "Designer",
			Instance = designer,
			SetBackground = setbackground,
			Remove = designer.Remove
		}
		library.SetBackground = setbackground
		local savestuff = library.elements["__Designer.Background.WorkspaceProfile"]
		if savestuff then
			library.LoadFile = savestuff.LoadFile
			library.LoadFileRaw = savestuff.LoadFileRaw
			library.LoadJSON = savestuff.LoadJSON
			library.LoadJSONRaw = savestuff.LoadJSONRaw
			library.SaveFile = savestuff.SaveFile
			library.GetJSON = savestuff.GetJSON
		end
		spawn(updatecolorsnotween)
		local dorlod = nil
		if options.HideTheme then
			designer.Remove()
			dorlod = true
		elseif options.LockTheme then
			if colorsection then
				colorsection.Remove()
				dorlod = true
			end
			if backgroundsection then
				backgroundsection.Remove()
				dorlod = true
			end
			if designerelements then
				local thing = designerelements["__Designer.Persistence.ThemeFile"]
				if thing then
					thing.Remove()
					dorlod = true
				end
				thing = designerelements["__Designer.Button.TerminateGUI"]
				thing = thing and thing[3]
				if thing then
					thing.Remove()
					dorlod = true
				end
			end
		end
		if dorlod then
			windowFunctions:UpdateAll()
		end
		return library.Designer
	end
	windowFunctions.AddDesigner = windowFunctions.CreateDesigner
	windowFunctions.NewDesigner = windowFunctions.CreateDesigner
	windowFunctions.Designer = windowFunctions.CreateDesigner
	windowFunctions.D = windowFunctions.CreateDesigner
	function windowFunctions:UpdateAll()
		local target = self or windowFunctions
		if target and type(target) == "table" and target.Flags then
			for _, e in next, target.Flags do
				if e and type(e) == "table" then
					if e.Update then
						pcall(e.Update)
					end
					if e.UpdateAll then
						pcall(e.Update)
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
	end
	library.UpdateAll = windowFunctions.UpdateAll
	if options.Themeable or options.DefaultTheme or options.Theme then
		spawn(function()
			local os_clock = os.clock
			local starttime = os_clock()
			while os_clock() - starttime < 12 do
				if homepage then
					windowFunctions.GoHome = homepage
					local x, e = pcall(homepage)
					if not x and e then
						warn("Error going to Homepage:", e)
					end
					x, e = nil
					break
				end
				task.wait()
			end
			local whatDoILookLike = options.Themeable or options.DefaultTheme or options.Theme
			if type(whatDoILookLike) == "table" then
				whatDoILookLike.LockTheme = whatDoILookLike.LockTheme or options.LockTheme or nil
				whatDoILookLike.HideTheme = whatDoILookLike.HideTheme or options.HideTheme or nil
			else
				whatDoILookLike = nil
			end
			windowFunctions:CreateDesigner(whatDoILookLike)
			if options.DefaultTheme or options.Theme then
				spawn(function()
					local content = options.DefaultTheme or options.Theme or options.JSON or options.ThemeJSON
					if content and type(content) == "string" and #content > 1 then
						local good, jcontent = JSONDecode(content)
						if good and jcontent then
							for cflag, val in next, jcontent do
								local data = elements[cflag]
								if data and (data.Type ~= "Persistence") then
									if data.Set then
										data:Set(val)
									elseif data.RawSet then
										data:RawSet(val)
									else
										library.flags[cflag] = val
									end
								end
							end
						end
					end
				end)
			end
			os_clock, starttime = nil
		end)
	end
	return windowFunctions
end
library.NewWindow = library.CreateWindow
library.AddWindow = library.CreateWindow
library.Window = library.CreateWindow
library.W = library.CreateWindow
return library, library_flags, library.subs
