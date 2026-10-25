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
local function protectAndParentGui(gui, fallbackParent)
	local CoreGui = game:GetService("CoreGui")
	local syn = (typeof(getgenv) == "function" and getgenv().syn) or nil
	local gethui = (typeof(gethui) == "function" and gethui) or nil
	if syn and syn.protect_gui then
		local ok = pcall(function()
			syn.protect_gui(gui)
			gui.Parent = CoreGui
		end)
		if ok then return true end
	end
	if gethui then
		local ok = pcall(function() gui.Parent = gethui() end)
		if ok then return true end
	end
	local ok = pcall(function() gui.Parent = CoreGui end)
	if ok then return true end
	if fallbackParent then
		pcall(function() gui.Parent = fallbackParent end)
		if gui.Parent then return true end
	end
	pcall(function() gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 5) end)
	return gui.Parent ~= nil
end
local function addCorner(instance, radius)
	local ok, corner = pcall(function()
		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, radius or 4)
		c.Parent = instance
		return c
	end)
	if ok then return corner end
	return nil
end
local library = {
	Version = "0.95 Mobile",
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
        main = Color3.fromRGB(128, 0, 255),
        background = Color3.fromRGB(18, 16, 24),
        outerBorder = Color3.fromRGB(10, 8, 15),
        innerBorder = Color3.fromRGB(59, 43, 76),
        topGradient = Color3.fromRGB(28, 24, 38),
        bottomGradient = Color3.fromRGB(20, 17, 27),
        sectionBackground = Color3.fromRGB(24, 21, 33),
        section = Color3.fromRGB(216, 180, 254),
        otherElementText = Color3.fromRGB(156, 145, 175),
        elementText = Color3.fromRGB(230, 220, 245),
        elementBorder = Color3.fromRGB(12, 10, 18),
        selectedOption = Color3.fromRGB(50, 38, 70),
        unselectedOption = Color3.fromRGB(24, 21, 33),
        hoveredOptionTop = Color3.fromRGB(70, 52, 98),
        unhoveredOptionTop = Color3.fromRGB(38, 32, 52),
        hoveredOptionBottom = Color3.fromRGB(55, 40, 78),
        unhoveredOptionBottom = Color3.fromRGB(28, 23, 38),
        tabText = Color3.fromRGB(200, 190, 220)
    },
	gui_parent = (function()
		local x, c = pcall(function() return game:GetService("CoreGui") end)
		if x and c then return c end
		x, c = pcall(function() return (game:IsLoaded() or (game.Loaded:Wait() or 1)) and game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end)
		if x and c then return c end
		x, c = pcall(function() return game:GetService("StarterGui") end)
		if x and c then return c end
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
local destroyrainbowsg = nil
function darkenColor(clr, intensity)
	if not intensity or (intensity == 1) then return clr end
	if clr and ((typeof(clr) == "Color3") or (type(clr) == "table")) then return Color3.new(clr.R / intensity, clr.G / intensity, clr.B / intensity) end
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
function library.IsGuiValid() return __runscript end
local lasthidebing = 0
local temp = game:FindService("MarketplaceService") or game:GetService("MarketplaceService")
local Marketplace = (temp and (cloneref and cloneref(temp))) or temp
local resolvevararg, temp = nil
do
	local lwr = string.lower
	function library.defaultSort(a, b) return lwr(tostring(b)) > lwr(tostring(a)) end
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
		if data then for index, value in next, {...} do t[data[index]] = value end end
		return t
	end
end
library.resolvercache = {}
local tweenService = game:GetService("TweenService")
local MainScreenGui = nil
local elements = library.elements
library.__AllSections = library.__AllSections or {}
library.__SearchQuery = ""
local function sectionHasVisibleChild(holder)
	for _, child in next, holder:GetChildren() do if child:IsA("GuiObject") and child.Visible then return true end end
	return false
end
local function updateSectionVisibility()
	for _, entry in next, library.__AllSections do
		local frame, holder, functions = entry.Frame, entry.Holder, entry.Functions
		if frame and holder and frame.Parent and functions then
			if sectionHasVisibleChild(holder) then
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
	for _, obj in next, elements do if type(obj) == "table" and obj.Container and obj.Container.Visible then obj.Container.Visible = false end end
	for _, obj in next, elements do
		if type(obj) == "table" and obj.Container and not obj.__DepHidden then
			local show = true
			if searching then
				local name = tostring(obj.DisplayName or (obj.Options and obj.Options.Name) or obj.Name or "")
				show = string.find(string.lower(name), query, 1, true) ~= nil
			end
			if show then obj.Container.Visible = true end
		end
	end
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
local function resolveDependencyFlag(ref)
	if type(ref) == "table" and ref.Flag ~= nil then return ref.Flag end
	return ref
end
local warnedDependencyFns = setmetatable({}, {__mode = "k"})
local evaluateDependency
function evaluateDependency(dep, depth)
	depth = (depth or 0) + 1
	if dep == nil or depth > 16 then return true end
	local t = type(dep)
	if t == "function" then
		local ok, res = pcall(dep, library_flags)
		if not ok then
			if not warnedDependencyFns[dep] then
				warnedDependencyFns[dep] = true
				warn("[DependsOn] Error in condition:", res)
			end
			return true
		end
		return res and true or false
	elseif t == "string" then
		return library_flags[dep] and true or false
	elseif t == "table" then
		if dep.Flag ~= nil then
			if dep.Value ~= nil then return library_flags[dep.Flag] == dep.Value end
			return library_flags[dep.Flag] and true or false
		end
		local first = dep[1]
		if type(first) == "string" or (type(first) == "table" and first.Flag ~= nil and type(first[1]) == "nil" and dep[2] ~= nil and type(dep[2]) ~= "table") then
			local flag = resolveDependencyFlag(first)
			if dep[2] == nil then return library_flags[flag] and true or false end
			return library_flags[flag] == dep[2]
		end
		for _, sub in ipairs(dep) do if not evaluateDependency(sub, depth) then return false end end
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
	if changed then refreshElementVisibility() end
end
task.spawn(function()
	local warnedLoopError = false
	while wait_check(0.25) do
		local ok, err = pcall(scanDependencies)
		if not ok and not warnedLoopError then
			warnedLoopError = true
			warn("[DependsOn] Error while checking dependencies:", err)
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
			if cache[v] then continue end
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
		if not x and e then task.spawn(error, e, 2) end
	end
	for cflag, data in next, elements do
		if data.Type ~= "Persistence" then
			if data.Set and data.Options.UnloadValue ~= nil then data.Set(data.Options.UnloadValue) end
			if data.Options.UnloadFunc then
				local y, u = pcall(data.Options.UnloadFunc)
				if not y and u then warn(debug.traceback("Error unloading '" .. tostring(cflag) .. "'\n" .. u)) end
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
					for k in next, v do v[k] = nil end
				end
				if shared.libraries then
					pcall(function() table.remove(shared.libraries, 1) end)
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
				for k in next, table.remove(shared.libraries or {}, k) do v[k] = nil end
				break
			end
		end
		if shared.libraries and (#shared.libraries == 0) then shared.libraries = nil end
	end
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
	if x[1] then library.objects[1 + #library.objects] = x[1] end
	return unpack(x)
end
library.subs.Instance_new = Instance_new
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
				if x and e then g = e end
				hardtype = typeof(g)
			end
			if hardtype == "Instance" then
				local lastg = g
				if method == nil and listt == playersservice then g = listt:GetPlayers() end
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
						local y, u = pcall(function() return listt[method](listt, unpack(args)) end)
					else
						warn("Idk how to handle method type of", metype, debug.traceback(""))
					end
					if u then if y then g = u else warn("Error trying method", method, "on", listt, debug.traceback(u)) end end
				end
				if g == lastg then g = listt:GetChildren() end
			end
			if hardtype == "Enum" then g = listt:GetEnumItems() end
			hardtype = typeof(g)
			if hardtype == "table" then break end
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
					if x and e then accept[1 + #accept] = (e == true and v) or e end
				end
				g = accept
			elseif huo == "string" then
				local accept = {}
				for _, v in next, g do if tostring(v):lower():find(huo) then accept[1 + #accept] = v end end
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
		for k, v in next, elements do if v and k and v.Set and (v.Default ~= nil) and (library_flags[k] ~= v.Default) and (string.sub(k, 1, 11) ~= "__Designer.") then v:Set(v.Default) end end
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
	local bigv2 = Vector2.new(100000, 100000)
	function textToSize(object)
		local ok, size = pcall(textService.GetTextSize, textService, object.Text, object.TextSize, object.Font, bigv2)
		if ok and typeof(size) == "Vector2" then return size end
		return Vector2.new(#tostring(object.Text) * (object.TextSize or 14) * 0.6, object.TextSize or 14)
	end
end
library.subs.textToSize = textToSize
local function makeDraggable(topBarObject, object)
	local dragging, dragInput, dragStart, startPosition = nil, nil, nil, nil
	library.signals[1 + #library.signals] = topBarObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging, dragStart, startPosition = true, input.Position, object.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	library.signals[1 + #library.signals] = topBarObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	library.signals[1 + #library.signals] = userInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			local pos = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
			if library.configuration.smoothDragging then tweenService:Create(object, TweenInfo.new(0.25, library.configuration.easingStyle, library.configuration.easingDirection), {Position = pos}):Play() else object.Position = pos end
		end
	end)
end
library.subs.makeDraggable = makeDraggable
local function resolveid(image, flag)
	local function apply(value) local thing = flag and library.elements[flag] if thing and thing.Set then task.spawn(thing.Set, thing, value) end end
	if not image then return image end
	if type(image) == "string" and ((#image > 14 and string.sub(image, 1, 13) == "rbxassetid://") or (#image > 12 and string.sub(image, 1, 11) == "rbxasset://") or (#image > 12 and string.sub(image, 1, 11) ~= "rbxthumb://")) then apply(image) return image end
	local cached = library.resolvercache[image]
	if cached then apply(cached) return cached end
	local orig = image
	image = tonumber(image) or image
	local ok = pcall(function()
		if type(image) == "string" then
			if getsynasset and #image > 11 and string.sub(image, 1, 11) == "synasset://" then image = getsynasset(string.sub(image, 12)) return end
			if #image < 11 or (string.sub(image, 1, 13) ~= "rbxassetid://" and string.sub(image, 1, 11) ~= "rbxasset://" and string.sub(image, 1, 11) ~= "rbxthumb://") then image = tonumber((image:gsub("%D", "")), 10) or image end
		end
		if type(image) == "number" and image > 0 then
			local id = tostring(image)
			pcall(function() local info = Marketplace and Marketplace:GetProductInfo(image) if info and info.AssetTypeId == 1 then id = "rbxassetid://" .. id elseif info and info.AssetTypeId == 13 then id = "rbxthumb://type=Asset&id=" .. id .. "&w=420&h=420" end end)
			image = id
		elseif type(image) ~= "string" then image = nil end
	end)
	if ok and image then library.resolvercache[orig], library.resolvercache[image] = image, image apply(image) end
	return image
end
library.subs.ResolveID = resolveid
library.subs.updatecolors = function() end
library.AddToolTip = function() return nil end library.subs.AddToolTip = library.AddToolTip
local function toLogical(v)
	local s = library.__MenuScale
	if type(s) ~= "number" or s <= 0 then return v end
	return v / s
end
library.subs.ToLogical = toLogical
local function safeFillRatio(value, minV, maxV)
	value, minV, maxV = tonumber(value), tonumber(minV), tonumber(maxV)
	if not value or not minV or not maxV then return 0 end
	local range = maxV - minV
	if range == 0 or range ~= range then return 0 end
	local r = (value - minV) / range
	if r ~= r then return 0 end
	return math.clamp(r, 0, 1)
end
library.subs.SafeFillRatio = safeFillRatio
local function DetectMobile()
	if library.MobileMode ~= nil then return library.MobileMode == true end
	local function readInput(prop)
		local ok, value = pcall(function() return userInputService[prop] end)
		return ok and value == true
	end
	local touchEnabled = readInput("TouchEnabled")
	local mouseEnabled = readInput("MouseEnabled")
	local keyboardEnabled = readInput("KeyboardEnabled")
	local okPlat, platform = pcall(function() return userInputService:GetPlatform() end)
	if okPlat and platform then
		if platform == Enum.Platform.Android or platform == Enum.Platform.IOS then return true end
		if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX
			or platform == Enum.Platform.Linux or platform == Enum.Platform.UWP then
			return touchEnabled and not mouseEnabled
		end
	end
	if touchEnabled and not keyboardEnabled then return true end
	return touchEnabled and not mouseEnabled
end
library.DetectMobile = DetectMobile
local MobileUI = nil
local DebugLog = {Started = false, Lines = {}, File = "D3v1lHub Lib/debug_log.txt", PrevFile = "D3v1lHub Lib/debug_log_prev.txt", ErrorLines = 0}
library.__DebugLog = DebugLog
local debugLogMobileCache = nil
function DebugLog:IsEnabled()
	if library.DebugLog == false then return false end
	if library.DebugLog == true then return true end
	if debugLogMobileCache == nil then
		local ok, res = pcall(DetectMobile)
		debugLogMobileCache = (ok and res == true) and true or false
	end
	return debugLogMobileCache
end
function DebugLog:Flush()
	if self.Started then pcall(function() writefile(self.File, table.concat(self.Lines, "\n") .. "\n") end) end
end
function DebugLog:Add(text)
	self.Lines[1 + #self.Lines] = string.format("[%7.2f] ", os.clock() - (self.StartClock or os.clock())) .. tostring(text)
	while #self.Lines > 400 do table.remove(self.Lines, 2) end
end
function DebugLog:Start()
	if self.Started then return true end
	if not self:IsEnabled() or type(writefile) ~= "function" then return false end
	self.Started = true
	self.StartClock = os.clock()
	pcall(function() if isfolder and makefolder and not isfolder("D3v1lHub Lib") then makefolder("D3v1lHub Lib") end end)
	pcall(function() if isfile and readfile and isfile(self.File) then writefile(self.PrevFile, readfile(self.File)) end end)
	local executorName = "?"
	pcall(function() if typeof(identifyexecutor) == "function" then executorName = table.concat({identifyexecutor()}, " ") end end)
	self.Lines = {"D3v1lHub Debug Log | " .. tostring(os.date("%Y-%m-%d %H:%M:%S")) .. " | Executor: " .. executorName}
	pcall(function()
		library.signals[1 + #library.signals] = game:GetService("LogService").MessageOut:Connect(function(message, messageType)
			if messageType ~= Enum.MessageType.MessageError and messageType ~= Enum.MessageType.MessageWarning then return end
			if self.ErrorLines >= 100 then return end
			self.ErrorLines = self.ErrorLines + 1
			self:Add(((messageType == Enum.MessageType.MessageError) and "ERROR: " or "WARNING: ") .. string.sub(tostring(message), 1, 300))
			self:Flush()
		end)
	end)
	return true
end
function DebugLog:Mark(text)
	if not self.Started and not self:Start() then return end
	self:Add(">> " .. tostring(text))
	self:Flush()
end
library.DebugMark = function(text) pcall(DebugLog.Mark, DebugLog, text) end
function library:ShowLoadingScreen(options)
	options = options or {}
	pcall(DebugLog.Mark, DebugLog, "Loader: showing Yes/No window")
	local onAccept = options.OnAccept or options.Callback
	local onDecline = options.OnDecline
	local soundService = game:GetService("SoundService")
	local backgroundTransparency = tonumber(options.BackgroundTransparency)
	if not backgroundTransparency then
		local menuValue = tonumber(library_flags["__Designer.Background.ImageTransparency"])
		backgroundTransparency = (menuValue and math.clamp(menuValue / 100, 0, 1)) or 0.5
	end
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
			BgAsset.BackgroundTransparency, BgAsset.ImageTransparency, BgAsset.Image, BgAsset.Size = 1, backgroundTransparency, backgroundAsset, UDim2.new(1, 0, 1, 0)
			BgAsset.ScaleType, BgAsset.ZIndex = Enum.ScaleType.Crop, 302
			BgAsset.Parent = parentFrame
		end
	end
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = generateRandomName()
	ScreenGui.IgnoreGuiInset, ScreenGui.ZIndexBehavior, ScreenGui.ResetOnSpawn = true, Enum.ZIndexBehavior.Sibling, false
	if not protectAndParentGui(ScreenGui, library.gui_parent) then ScreenGui.Parent = library.gui_parent end
	local Outer = Instance.new("Frame")
	Outer.Name = generateRandomName()
	Outer.BackgroundColor3, Outer.BorderColor3, Outer.BorderSizePixel, Outer.AnchorPoint = Color3.new(0, 0, 0), Color3.new(0, 0, 0), 1, Vector2.new(0.5, 0.5)
	Outer.Position, Outer.Size, Outer.BackgroundTransparency, Outer.ClipsDescendants = UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0, 0, 0, 0), 1, true
	Outer.ZIndex = 300
	Outer.Parent = ScreenGui
	local Inner = Instance.new("Frame")
	Inner.Name = generateRandomName()
	Inner.BackgroundColor3, Inner.BorderColor3, Inner.BorderSizePixel, Inner.BorderMode = MainColor, Color3.new(0, 0, 0), 1, Enum.BorderMode.Inset
	Inner.Size, Inner.ClipsDescendants, Inner.ZIndex = UDim2.new(1, 0, 1, 0), true, 301
	Inner.Parent = Outer
	local InnerFrame = Instance.new("Frame")
	InnerFrame.Name = generateRandomName()
	InnerFrame.BackgroundColor3, InnerFrame.BorderSizePixel, InnerFrame.Position, InnerFrame.Size = Color3.new(1, 1, 1), 0, UDim2.new(0, 1, 0, 1), UDim2.new(1, -2, 1, -2)
	InnerFrame.ClipsDescendants, InnerFrame.ZIndex = true, 302
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
	TitleContainer.BackgroundTransparency, TitleContainer.AnchorPoint, TitleContainer.Position, TitleContainer.Size = 1, Vector2.new(0.5, 0), UDim2.new(0.5, 0, 0, 55), UDim2.new(0, 0, 0, 25)
	TitleContainer.ZIndex = 303
	TitleContainer.Parent = InnerFrame
	local TitleLayout = Instance.new("UIListLayout")
	TitleLayout.FillDirection, TitleLayout.SortOrder, TitleLayout.HorizontalAlignment, TitleLayout.VerticalAlignment = Enum.FillDirection.Horizontal, Enum.SortOrder.LayoutOrder, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center
	TitleLayout.Parent = TitleContainer
	local TitlePart1Label = Instance.new("TextLabel")
	TitlePart1Label.Name = generateRandomName()
	TitlePart1Label.BackgroundTransparency, TitlePart1Label.Size, TitlePart1Label.AutomaticSize, TitlePart1Label.Font = 1, UDim2.new(0, 0, 1, 0), Enum.AutomaticSize.X, Enum.Font.Code
	TitlePart1Label.TextColor3, TitlePart1Label.TextSize, TitlePart1Label.ZIndex, TitlePart1Label.Text = Color3.new(1, 1, 1), 15, 303, titlePart1
	TitlePart1Label.LayoutOrder = 1
	TitlePart1Label.Parent = TitleContainer
	addTextStroke(TitlePart1Label)
	local TitlePart2Label = Instance.new("TextLabel")
	TitlePart2Label.Name = generateRandomName()
	TitlePart2Label.BackgroundTransparency, TitlePart2Label.Size, TitlePart2Label.AutomaticSize, TitlePart2Label.Font = 1, UDim2.new(0, 0, 1, 0), Enum.AutomaticSize.X, Enum.Font.Code
	TitlePart2Label.TextColor3, TitlePart2Label.TextSize, TitlePart2Label.ZIndex, TitlePart2Label.Text = MainColor, 15, 303, titlePart2
	TitlePart2Label.LayoutOrder = 2
	TitlePart2Label.Parent = TitleContainer
	addTextStroke(TitlePart2Label)
	local SubLabel = Instance.new("TextLabel")
	SubLabel.Name = generateRandomName()
	SubLabel.BackgroundTransparency, SubLabel.Position, SubLabel.Size, SubLabel.Font = 1, UDim2.new(0, 20, 0, 85), UDim2.new(1, -40, 0, 25), Enum.Font.Code
	SubLabel.TextColor3, SubLabel.TextSize, SubLabel.TextXAlignment, SubLabel.ZIndex = Color3.fromRGB(200, 190, 220), 14, Enum.TextXAlignment.Center, 303
	SubLabel.Text = confirmText
	SubLabel.Parent = InnerFrame
	addTextStroke(SubLabel)
	local function createButton(text, posX)
		local btnOuter = Instance.new("TextButton")
		btnOuter.Name = generateRandomName()
		btnOuter.AutoButtonColor, btnOuter.BackgroundColor3, btnOuter.BorderColor3, btnOuter.BorderSizePixel = false, MainColor, Color3.new(0, 0, 0), 1
		btnOuter.BorderMode, btnOuter.Position, btnOuter.Size, btnOuter.Text = Enum.BorderMode.Inset, UDim2.new(0, posX, 0, 265), UDim2.new(0, 153, 0, 34), ""
		btnOuter.ClipsDescendants, btnOuter.ZIndex = true, 303
		btnOuter.Parent = InnerFrame
		local btnInner = Instance.new("Frame")
		btnInner.Name = generateRandomName()
		btnInner.BackgroundColor3, btnInner.BorderSizePixel, btnInner.Position, btnInner.Size = library.colors.topGradient, 0, UDim2.new(0, 1, 0, 1), UDim2.new(1, -2, 1, -2)
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
		btnText.BackgroundTransparency, btnText.Size, btnText.Font, btnText.TextColor3 = 1, UDim2.new(1, 0, 1, 0), Enum.Font.Code, Color3.fromRGB(200, 190, 220)
		btnText.TextSize, btnText.Text, btnText.ZIndex = 14, text, 305
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
		LoadGui.IgnoreGuiInset, LoadGui.ZIndexBehavior, LoadGui.ResetOnSpawn = true, Enum.ZIndexBehavior.Sibling, false
		if not protectAndParentGui(LoadGui, library.gui_parent) then LoadGui.Parent = library.gui_parent end
		local LoadOuter = Instance.new("Frame")
		LoadOuter.Name = generateRandomName()
		LoadOuter.BackgroundColor3, LoadOuter.BorderColor3, LoadOuter.BorderSizePixel, LoadOuter.AnchorPoint = Color3.new(0, 0, 0), Color3.new(0, 0, 0), 1, Vector2.new(0.5, 0.5)
		LoadOuter.Position, LoadOuter.Size, LoadOuter.BackgroundTransparency, LoadOuter.ClipsDescendants = UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0, 0, 0, 0), 1, true
		LoadOuter.ZIndex = 300
		LoadOuter.Parent = LoadGui
		local LoadInner = Instance.new("Frame")
		LoadInner.Name = generateRandomName()
		LoadInner.BackgroundColor3, LoadInner.BorderColor3, LoadInner.BorderSizePixel, LoadInner.BorderMode = MainColor, Color3.new(0, 0, 0), 1, Enum.BorderMode.Inset
		LoadInner.Size, LoadInner.ClipsDescendants, LoadInner.ZIndex = UDim2.new(1, 0, 1, 0), true, 301
		LoadInner.Parent = LoadOuter
		local LoadInnerFrame = Instance.new("Frame")
		LoadInnerFrame.Name = generateRandomName()
		LoadInnerFrame.BackgroundColor3, LoadInnerFrame.BorderSizePixel, LoadInnerFrame.Position, LoadInnerFrame.Size = Color3.new(1, 1, 1), 0, UDim2.new(0, 1, 0, 1), UDim2.new(1, -2, 1, -2)
		LoadInnerFrame.ClipsDescendants, LoadInnerFrame.ZIndex = true, 302
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
		AvatarImage.BackgroundTransparency, AvatarImage.ImageTransparency, AvatarImage.Position, AvatarImage.Size = 1, 1, UDim2.new(0, -50, 0, 15), UDim2.new(0, 48, 0, 48)
		AvatarImage.ZIndex = 303
		AvatarImage.Parent = LoadInnerFrame
		local LoadTitle = Instance.new("TextLabel")
		LoadTitle.Name = generateRandomName()
		LoadTitle.BackgroundTransparency, LoadTitle.Position, LoadTitle.Size, LoadTitle.Font = 1, UDim2.new(0, 15, 0, 16), UDim2.new(1, -30, 0, 20), Enum.Font.Code
		LoadTitle.TextColor3, LoadTitle.TextSize, LoadTitle.TextXAlignment, LoadTitle.ZIndex = MainColor, 14, Enum.TextXAlignment.Left, 303
		LoadTitle.Text = loadingTitle
		LoadTitle.Parent = LoadInnerFrame
		addTextStroke(LoadTitle)
		local LoadSub = Instance.new("TextLabel")
		LoadSub.Name = generateRandomName()
		LoadSub.BackgroundTransparency, LoadSub.Position, LoadSub.Size, LoadSub.Font = 1, UDim2.new(0, 15, 0, 42), UDim2.new(1, -30, 0, 20), Enum.Font.Code
		LoadSub.TextColor3, LoadSub.TextSize, LoadSub.TextXAlignment, LoadSub.ZIndex = Color3.fromRGB(200, 190, 220), 13, Enum.TextXAlignment.Left, 303
		LoadSub.Text = loadingSubText
		LoadSub.Parent = LoadInnerFrame
		addTextStroke(LoadSub)
		local HwidContainer, HwidValueLabel
		if showHWID then
			local HwidStaticLabel = Instance.new("TextLabel")
			HwidStaticLabel.Name = generateRandomName()
			HwidStaticLabel.BackgroundTransparency, HwidStaticLabel.Position, HwidStaticLabel.Size, HwidStaticLabel.Font = 1, UDim2.new(0, 75, 0, 64), UDim2.new(0, 85, 0, 20), Enum.Font.Code
			HwidStaticLabel.TextColor3, HwidStaticLabel.TextSize, HwidStaticLabel.TextXAlignment, HwidStaticLabel.ZIndex = Color3.fromRGB(150, 140, 170), 12, Enum.TextXAlignment.Left, 303
			HwidStaticLabel.Text = "Your HWID: "
			HwidStaticLabel.Parent = LoadInnerFrame
			addTextStroke(HwidStaticLabel, 1)
			HwidContainer = Instance.new("Frame")
			HwidContainer.Name = generateRandomName()
			HwidContainer.BackgroundTransparency, HwidContainer.Position, HwidContainer.Size, HwidContainer.ClipsDescendants = 1, UDim2.new(0, 160, 0, 64), UDim2.new(1, -175, 0, 20), true
			HwidContainer.ZIndex = 303
			HwidContainer.Parent = LoadInnerFrame
			HwidValueLabel = Instance.new("TextLabel")
			HwidValueLabel.Name = generateRandomName()
			HwidValueLabel.BackgroundTransparency, HwidValueLabel.Size, HwidValueLabel.Font, HwidValueLabel.TextColor3 = 1, UDim2.new(2, 0, 1, 0), Enum.Font.Code, Color3.fromRGB(200, 180, 240)
			HwidValueLabel.TextSize, HwidValueLabel.TextXAlignment, HwidValueLabel.ZIndex, HwidValueLabel.Text = 12, Enum.TextXAlignment.Left, 303, getHWID()
			HwidValueLabel.Parent = HwidContainer
			addTextStroke(HwidValueLabel, 1)
			local HwidNoteLabel = Instance.new("TextLabel")
			HwidNoteLabel.Name = generateRandomName()
			HwidNoteLabel.BackgroundTransparency, HwidNoteLabel.Position, HwidNoteLabel.Size, HwidNoteLabel.Font = 1, UDim2.new(0, 75, 0, 82), UDim2.new(1, -90, 0, 14), Enum.Font.Code
			HwidNoteLabel.TextColor3, HwidNoteLabel.TextSize, HwidNoteLabel.TextXAlignment, HwidNoteLabel.ZIndex = Color3.fromRGB(110, 100, 130), 9, Enum.TextXAlignment.Left, 303
			HwidNoteLabel.Text = "HWID is used to identify the Owner."
			HwidNoteLabel.Parent = LoadInnerFrame
			addTextStroke(HwidNoteLabel, 1)
		end
		local BarBg = Instance.new("Frame")
		BarBg.Name = generateRandomName()
		BarBg.BackgroundColor3, BarBg.BorderColor3, BarBg.BorderSizePixel, BarBg.BorderMode = Color3.fromRGB(10, 8, 15), Color3.new(0, 0, 0), 1, Enum.BorderMode.Inset
		BarBg.Position, BarBg.Size, BarBg.ClipsDescendants, BarBg.ZIndex = UDim2.new(0, 15, 0, 102), UDim2.new(1, -30, 0, 8), true, 303
		BarBg.Parent = LoadInnerFrame
		local BarFill = Instance.new("Frame")
		BarFill.Name = generateRandomName()
		BarFill.BackgroundColor3, BarFill.BorderSizePixel, BarFill.Size, BarFill.ZIndex = Color3.new(1, 1, 1), 0, UDim2.new(0, 0, 1, 0), 304
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
			pcall(DebugLog.Mark, DebugLog, "Loader finished -> OnAccept (building menu)")
			if onAccept then task.spawn(onAccept) end
		end)
	end
	local promptDecided = false
	YesBtn.MouseButton1Click:Connect(function()
		if promptDecided then return end
		promptDecided = true
		pcall(DebugLog.Mark, DebugLog, "Loader: Yes pressed")
		startLoadingSequence()
	end)
	NoBtn.MouseButton1Click:Connect(function()
		if promptDecided then return end
		promptDecided = true
		pcall(DebugLog.Mark, DebugLog, "Loader: No pressed")
		playSound(closeSoundId)
		local closeTween = tweenService:Create(Outer, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
		closeTween:Play()
		closeTween.Completed:Wait()
		ScreenGui:Destroy()
		if onDecline then task.spawn(onDecline) end
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
	if typeof(hex) == "Color3" then return hex end
	if type(hex) ~= "string" then return nil end
	hex = (string.gsub(hex, "%s", ""))
	hex = (string.gsub(hex, "^#", ""))
	hex = (string.gsub(hex, "^0[xX]", ""))
	if #hex == 3 then hex = string.rep(string.sub(hex, 1, 1), 2) .. string.rep(string.sub(hex, 2, 2), 2) .. string.rep(string.sub(hex, 3, 3), 2) end
	if #hex ~= 6 or string.find(hex, "[^%x]") then return nil end
	return Color3.fromRGB(tonumber(string.sub(hex, 1, 2), 16), tonumber(string.sub(hex, 3, 4), 16), tonumber(string.sub(hex, 5, 6), 16))
end
library.subs.Color3FromHex = Color3FromHex
local floor = math.floor
local function Color3ToHex(color)
	local function channel(v)
		if type(v) ~= "number" or v ~= v then return 0 end
		return math.clamp(floor(v * 255 + 0.5), 0, 255)
	end
	return string.format("%02X%02X%02X", channel(color.R), channel(color.G), channel(color.B))
end
if Color3.ToHex and not shared.overridecolortohex then
	local x, e = pcall(Color3.ToHex, Color3.new())
	if x and type(e) == "string" and #e == 6 then Color3ToHex = Color3.ToHex end
end
library.subs.Color3ToHex = Color3ToHex
local JSONEncode, JSONDecode = nil, nil
do
	local temp_http = game:FindService("HttpService") or game:GetService("HttpService")
	local httpservice = temp_http
	if cloneref and (type(cloneref) == "function") then httpservice, temp_http = cloneref(httpservice), nil end
	library.Http = httpservice
	local JSONEncodeFunc = httpservice.JSONEncode
	function JSONEncode(...) return pcall(JSONEncodeFunc, httpservice, ...) end
	library.JSONEncode = JSONEncode
	local JSONDecodeFunc = httpservice.JSONDecode
	function JSONDecode(...) return pcall(JSONDecodeFunc, httpservice, ...) end
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
local sanitizeConfigName
do
	local reservedNames = {CON = true, PRN = true, AUX = true, NUL = true}
	for i = 1, 9 do
		reservedNames["COM" .. i] = true
		reservedNames["LPT" .. i] = true
	end
	function sanitizeConfigName(str)
		if type(str) == "number" then str = tostring(str) end
		if type(str) ~= "string" then return "" end
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
		if reservedNames[string.upper(str)] then str = str .. "_" end
		return str
	end
	library.subs.SanitizeConfigName = sanitizeConfigName
end
local function extractConfigName(path)
	if type(path) ~= "string" then return nil end
	local name = string.match(path, "([^/\\]+)$") or path
	return string.match(name, "^(.+)%.[Tt][Xx][Tt]$")
end
library.subs.ExtractConfigName = extractConfigName
local configIgnoredFlags = {
	["__Designer.Files.WorkspaceFile"] = true
}
library.subs.ConfigIgnoredFlags = configIgnoredFlags
local function serializeFlagValue(cflag, value, elementType)
	if value == nil then
		if elementType == "Keybind" then return true, "NONE" end
		return false
	end
	local typ = typeof(value)
	if typ == "boolean" or typ == "string" then
		return true, value
	elseif typ == "number" then
		if value ~= value or value == math.huge or value == -math.huge then return false end
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
			if ok and sv ~= nil and type(sv) ~= "table" then arr[1 + #arr] = sv end
		end
		return true, arr
	end
	local good, jval = JSONEncode(value)
	if good and jval and jval ~= "null" then return true, value end
	return true, tostring(value)
end
library.subs.SerializeFlagValue = serializeFlagValue
local function deserializeFlagValue(val, data)
	if val == nil then return nil, false end
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
				warn("[Config] Could not convert '" .. val .. "' to an EnumItem - skipped")
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
		if type(val) == "string" then val = tonumber(val) end
		if type(val) ~= "number" or val ~= val then return nil, false end
		if type(opts.Min) == "number" and type(opts.Max) == "number" and not opts.IllegalInput then val = math.clamp(val, math.min(opts.Min, opts.Max), math.max(opts.Min, opts.Max)) end
	elseif etype == "Dropdown" or etype == "SearchBox" then
		local isMulti = opts.MultiSelect or opts.Multi or opts.Multiple
		if isMulti then
			if type(val) ~= "table" then val = {val} end
		elseif type(val) == "table" then
			val = val[1]
			if val == nil then return nil, false end
		end
	elseif etype == "Colorpicker" then
		if type(val) ~= "string" and typeof(val) ~= "Color3" then return nil, false end
	end
	return val, true
end
library.subs.DeserializeFlagValue = deserializeFlagValue
do
	local alive, holder = {}, nil
	library.Notifications = alive
	local function getHolder()
		if holder and holder.Parent then return holder end
		if not MainScreenGui then return nil end
		holder = Instance_new("Frame")
		holder.Name = generateRandomName()
		holder.BackgroundTransparency, holder.AnchorPoint, holder.Position, holder.Size, holder.ZIndex = 1, Vector2.new(1, 0), UDim2.new(1, -8, 0, 8), UDim2.new(0, 230, 1, -16), 50
		holder.Parent = MainScreenGui
		library.NotificationsFrame = holder
		library.NotifyLayout = holder
		return holder
	end
	local pool, counter = {}, 0
	local function glide(slot, pos, fade, dur, style)
		if slot.tween then slot.tween:Cancel() end
		slot.tween = tweenService:Create(slot.frame, TweenInfo.new(dur, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = pos, GroupTransparency = fade})
		slot.tween:Play()
	end
	local function release(slot, obj)
		if slot.obj ~= obj or not obj.Active then return end
		obj.Active, slot.obj = false, nil
		glide(slot, slot.hidden, 1, 0.28)
		local i = table.find(alive, obj)
		if i then table.remove(alive, i) end
		pcall(DebugLog.Mark, DebugLog, "Notify hidden")
	end
	function library.Notify(self, data, ...)
		if not rawequal(self, library) then data, self = self, library end
		if type(data) ~= "table" then data = {Text = data} end
		local text = data.Text or data.String or data.Value or data.Message or data.Msg
		text = (text == nil and "No text given") or tostring(text)
		pcall(DebugLog.Mark, DebugLog, "Notify: " .. string.sub(text, 1, 60))
		local obj = {Text = text, Active = true, Arguments = data}
		local parent = getHolder()
		if not parent then return obj end
		local slot
		for _, s in ipairs(pool) do if not s.obj then slot = s break end end
		if not slot and #pool < 4 then
			slot = {}
			slot.frame = Instance_new("CanvasGroup")
			slot.frame.Name = generateRandomName()
			slot.frame.BackgroundColor3, slot.frame.BorderSizePixel = library.colors.background, 0
			slot.shown, slot.hidden = UDim2.fromOffset(0, #pool * 45), UDim2.fromOffset(260, #pool * 45)
			slot.frame.Position, slot.frame.Size = slot.hidden, UDim2.new(1, 0, 0, 40)
			addCorner(slot.frame, 8)
			local function part(class, props)
				local o = Instance_new(class)
				o.Name = generateRandomName()
				for k, v in next, props do o[k] = v end
				o.Parent = slot.frame
				return o
			end
			slot.stroke = part("UIStroke", {Thickness = 1, Transparency = 0.7, ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
			slot.bar = part("Frame", {BorderSizePixel = 0, Size = UDim2.new(0, 3, 1, -12), Position = UDim2.new(0, 6, 0, 6)})
			addCorner(slot.bar, 2)
			slot.prog = part("Frame", {BorderSizePixel = 0, BackgroundTransparency = 0.5, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, 0)})
			slot.lbl = part("TextLabel", {BackgroundTransparency = 1, Position = UDim2.new(0, 18, 0, 0), Size = UDim2.new(1, -24, 1, -2), Font = Enum.Font.GothamMedium, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = library.colors.elementText})
			slot.frame.Parent = parent
			pool[1 + #pool] = slot
		end
		if not slot then
			slot = pool[1]
			for _, s in ipairs(pool) do if s.stamp < slot.stamp then slot = s end end
			release(slot, slot.obj)
		end
		counter = counter + 1
		local kind = data.Type
		local accent = (kind == "success" and Color3.fromRGB(80, 200, 120)) or (kind == "error" and Color3.fromRGB(220, 80, 80)) or (kind == "warning" and Color3.fromRGB(240, 180, 60)) or library.colors.main
		slot.bar.BackgroundColor3, slot.prog.BackgroundColor3, slot.stroke.Color = accent, accent, accent
		slot.lbl.Text = text
		slot.stamp, slot.obj = counter, obj
		local life = tonumber(data.Time) or 4
		slot.frame.GroupTransparency, slot.frame.Position = 1, UDim2.fromOffset(260, slot.shown.Y.Offset)
		glide(slot, slot.shown, 0, 0.4)
		slot.prog.Size = UDim2.new(1, 0, 0, 2)
		tweenService:Create(slot.prog, TweenInfo.new(life, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 2)}):Play()
		alive[1 + #alive] = obj
		obj.Object, obj.TextLabel = slot.frame, slot.lbl
		function obj.SetText(a, b)
			if b == nil then b = a end
			obj.Text = tostring(b)
			if slot.obj == obj then slot.lbl.Text = obj.Text end
		end
		function obj.Destroy() release(slot, obj) end
		task.delay(life, obj.Destroy)
		return obj, slot.frame, slot.lbl
	end
	function library.Prompt(self, data, ...)
		if not rawequal(self, library) then data, self = self, library end
		data = (type(data) == "table" and data) or {Description = tostring(data)}
		local event = Instance_new("BindableEvent")
		local obj = {OnSelect = event.Event, SelectedEvent = event, Active = true, Buttons = {}}
		if not MainScreenGui then return obj end
		local frame = Instance_new("Frame")
		frame.Name = generateRandomName()
		frame.AnchorPoint, frame.Position, frame.Size, frame.AutomaticSize = Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0, 260, 0, 0), Enum.AutomaticSize.Y
		frame.BackgroundColor3, frame.BorderSizePixel, frame.ZIndex = library.colors.background, 0, 60
		frame.Parent = MainScreenGui
		addCorner(frame, 8)
		local layout = Instance_new("UIListLayout")
		layout.Padding = UDim.new(0, 6)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Parent = frame
		local pad = Instance_new("UIPadding")
		pad.PaddingTop, pad.PaddingBottom = UDim.new(0, 10), UDim.new(0, 10)
		pad.PaddingLeft, pad.PaddingRight = UDim.new(0, 10), UDim.new(0, 10)
		pad.Parent = frame
		local function addText(text, size, color, order)
			local l = Instance_new("TextLabel")
			l.Name = generateRandomName()
			l.BackgroundTransparency = 1
			l.Size = UDim2.new(1, 0, 0, 0)
			l.AutomaticSize = Enum.AutomaticSize.Y
			l.Font = Enum.Font.GothamBold
			l.TextSize, l.TextWrapped, l.LayoutOrder = size, true, order
			l.TextColor3, l.Text = color, text
			l.TextXAlignment = Enum.TextXAlignment.Left
			l.ZIndex = 61
			l.Parent = frame
		end
		addText(tostring(data.Name or "Prompt"), 15, library.colors.section, 1)
		local desc = data.Description or data.Text or data.String or data.Message or data.Value
		if desc ~= nil then addText(tostring(desc), 13, library.colors.elementText, 2) end
		local function close(method)
			if obj.Active then
				obj.Active = false
				frame.Visible = false
				event:Fire("Close", method == "timeout_")
			end
		end
		obj.Close, obj.FrameInstance = close, frame
		local options = data.Options or data.Buttons or data.Choices
		if type(options) ~= "table" then options = {OK = options} end
		local order = 10
		for key, opt in next, options do
			if type(opt) ~= "table" then opt = {Name = (type(opt) == "string" and type(key) == "number" and opt) or key, Callback = (type(opt) == "function" and opt) or nil} end
			order += 1
			local b = Instance_new("TextButton")
			b.Name = generateRandomName()
			b.Size, b.LayoutOrder, b.AutoButtonColor = UDim2.new(1, 0, 0, 30), order, false
			b.BackgroundColor3, b.BorderSizePixel, b.Font, b.TextSize = library.colors.selectedOption, 0, Enum.Font.GothamMedium, 13
			b.TextColor3, b.Text, b.ZIndex = library.colors.elementText, tostring(opt.Name or opt.Text or key), 61
			b.Parent = frame
			addCorner(b, 6)
			obj.Buttons[key] = {Name = b.Text, Callback = opt.Callback, ButtonObject = b}
			b.Activated:Connect(function()
				local fn = opt.Callback or opt.OnPressed or opt.Function
				if fn then task.spawn(fn) end
				event:Fire(b.Text)
				if not data.KeepOpen then close() end
			end)
		end
		if tonumber(data.Timeout) then task.delay(tonumber(data.Timeout), close, "timeout_") end
		return obj, frame
	end
end
library.__fp = string.char(unpack({68,51,86,49,76,45,79,87,78,45,50,48,50,54,45,56,70,50,65,45,67,52,49,68,45,77,66}))
library.__id = "D3v1lHub​‌​​​‌​​​​‌‌​​‌‌​‌​‌​‌‌​​​‌‌​​​‌​‌​​‌‌​​​​‌​‌‌​‌​‌​​‌‌‌‌​‌​‌​‌‌‌​‌​​‌‌‌​​​‌​‌‌​‌​​‌‌​​‌​​​‌‌​​​​​​‌‌​​‌​​​‌‌​‌‌​​​‌​‌‌​‌​​‌‌‌​​​​‌​​​‌‌​​​‌‌​​‌​​‌​​​​​‌​​‌​‌‌​‌​‌​​​​‌‌​​‌‌​‌​​​​‌‌​​​‌​‌​​​‌​​​​‌​‌‌​‌​‌​​‌‌​‌​‌​​​​‌​"
library.TermsSections = {{"Copyright", "Copyright (c) 2026 D3v1lHub (GitHub: Dev1lHub). All rights reserved."}, {"1. Ownership", "D3v1lHub - the loader, the PC and Mobile libraries, the examples and the documentation - is the exclusive property of its owner."},
	{"2. Permitted use", "You may run the script exactly as provided for personal, non-commercial use. This permission is revocable and gives you no rights to the source code."}, {"3. Prohibited", "Without written permission of the owner you may not copy, modify, adapt, translate, decompile, deobfuscate, extract, re-upload, redistribute, resell, host or create derivative works of this script or any part of it."},
	{"4. Third-party code", "Parts of the libraries derive from Pepsi's UI Library (Apache License 2.0). Those parts stay under their original license."}, {"5. No warranty", "The script is provided \"as is\" without warranty of any kind. Use it at your own risk. The owner is not liable for any damage, loss or account action."},
	{"6. Violations", "Any violation ends all permissions and may be reported, removed (e.g. DMCA takedown) and pursued legally."}, {"Acceptance", "By using this script you accept these terms.\n\nLast updated: October 25, 2026, 01:27 (CEST, UTC+2)"}}
function library:ShowTerms()
	if library.__TermsRoot and library.__TermsRoot.Parent then return library.__TermsRoot end
	local parentGui = library.MainScreenGui
	if not parentGui then return nil end
	local mc, parts = library.colors.main, {}
	for _, e in ipairs(library.TermsSections) do
		parts[1 + #parts] = string.format('<font color="rgb(%d,%d,%d)"><b>%s</b></font>\n%s', math.floor(mc.R * 255), math.floor(mc.G * 255), math.floor(mc.B * 255), e[1], e[2])
	end
	local function make(class, props, parent)
		local o = Instance_new(class)
		o.Name = generateRandomName()
		for k, v in next, props do o[k] = v end
		o.Parent = parent
		return o
	end
	local function tween(t, time, goal) pcall(function() tweenService:Create(t, TweenInfo.new(time, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), goal):Play() end) end
	local root = make("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Active = true, ZIndex = 900}, parentGui)
	library.__TermsRoot = root
	local okGroup, panel = pcall(Instance_new, "CanvasGroup")
	if not okGroup or not panel then panel = Instance_new("Frame") end
	panel.Name = generateRandomName()
	for k, v in next, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.92, 0, 0.86, 0), BackgroundColor3 = library.colors.background, BorderSizePixel = 0, ZIndex = 901} do panel[k] = v end
	pcall(function() panel.GroupTransparency = 1 end)
	panel.Parent = root
	make("UISizeConstraint", {MaxSize = Vector2.new(440, 410), MinSize = Vector2.new(240, 220)}, panel)
	local scale = make("UIScale", {Scale = 0.94}, panel)
	addCorner(panel, 8)
	make("UIStroke", {Color = library.colors.outerBorder, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, panel)
	make("Frame", {Size = UDim2.new(1, 0, 0, 3), BackgroundColor3 = mc, BorderSizePixel = 0, ZIndex = 902}, panel)
	local function text(content, size, color, y)
		make("TextLabel", {BackgroundTransparency = 1, Position = UDim2.new(0, 18, 0, y), Size = UDim2.new(1, -36, 0, size + 6), Font = Enum.Font.GothamMedium, Text = content, TextSize = size, TextColor3 = color, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 902}, panel)
	end
	text("Terms of Use", 17, library.colors.elementText, 14)
	text("D3v1lHub - Copyright & License", 12, library.colors.otherElementText, 38)
	make("Frame", {Position = UDim2.new(0, 18, 0, 62), Size = UDim2.new(1, -36, 0, 1), BackgroundColor3 = library.colors.outerBorder, BorderSizePixel = 0, ZIndex = 902}, panel)
	local scroller = make("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0, 18, 0, 72), Size = UDim2.new(1, -36, 1, -132), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3, ScrollBarImageColor3 = mc, ScrollingDirection = Enum.ScrollingDirection.Y, ZIndex = 902}, panel)
	make("TextLabel", {BackgroundTransparency = 1, Size = UDim2.new(1, -10, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Font = Enum.Font.GothamMedium, RichText = true, Text = table.concat(parts, "\n\n"), TextSize = 13, TextColor3 = library.colors.elementText, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 903}, scroller)
	local closeButton = make("TextButton", {AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 18, 1, -16), Size = UDim2.new(1, -36, 0, 36), AutoButtonColor = false, BackgroundColor3 = library.colors.topGradient, BorderSizePixel = 0, Font = Enum.Font.GothamMedium, Text = "I understand", TextSize = 14, TextColor3 = library.colors.elementText, ZIndex = 903}, panel)
	addCorner(closeButton, 6)
	make("UIStroke", {Color = mc, Transparency = 0.5, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, closeButton)
	tween(root, 0.3, {BackgroundTransparency = 0.45})
	tween(panel, 0.3, {GroupTransparency = 0})
	tween(scale, 0.35, {Scale = 1})
	local closing = false
	function library.CloseTerms()
		if closing then return end
		closing = true
		tween(root, 0.22, {BackgroundTransparency = 1})
		tween(panel, 0.22, {GroupTransparency = 1})
		tween(scale, 0.22, {Scale = 0.94})
		task.delay(0.25, function() library.__TermsRoot = nil root:Destroy() end)
	end
	closeButton.Activated:Connect(library.CloseTerms)
	return root
end
MobileUI = {}
library.MobileUI = MobileUI
do
	local FONT_MEDIUM = Enum.Font.GothamMedium
	local FONT_BOLD = Enum.Font.GothamBold
	local ROW_H = 34
	local function C(name) return library.colors[name] end
	local function colorHex(c)
		return string.format("#%02X%02X%02X", math.clamp(math.floor(c.R * 255 + 0.5), 0, 255), math.clamp(math.floor(c.G * 255 + 0.5), 0, 255), math.clamp(math.floor(c.B * 255 + 0.5), 0, 255))
	end
	local function new(className, props, parent)
		local obj = Instance_new(className)
		obj.Name = generateRandomName()
		if props then for k, v in next, props do obj[k] = v end end
		if parent then obj.Parent = parent end
		return obj
	end
	local function corner(parent, radius) return new("UICorner", {CornerRadius = (radius == "full" and UDim.new(1, 0)) or UDim.new(0, radius or 6)}, parent) end
	local function label(parent, props)
		props = props or {}
		props.BackgroundTransparency = 1
		props.BorderSizePixel = 0
		props.Font = props.Font or FONT_MEDIUM
		props.TextSize = props.TextSize or 13
		props.TextColor3 = props.TextColor3 or C("elementText")
		props.TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Left
		if props.TextTruncate == nil and not props.TextWrapped then props.TextTruncate = Enum.TextTruncate.AtEnd end
		return new("TextLabel", props, parent)
	end
	local function button(parent, props)
		props = props or {}
		props.AutoButtonColor = false
		props.BorderSizePixel = 0
		props.Font = props.Font or FONT_MEDIUM
		props.TextSize = props.TextSize or 13
		props.TextColor3 = props.TextColor3 or C("elementText")
		if props.Text == nil then props.Text = "" end
		local btn = new("TextButton", props, parent)
		local squish = new("UIScale", {Scale = 1}, btn)
		btn.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then tweenService:Create(squish, TweenInfo.new(0.08), {Scale = 0.95}):Play() end
		end)
		btn.InputEnded:Connect(function() tweenService:Create(squish, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play() end)
		return btn
	end
	local function pickArg(obj, a, b)
		if b == nil and a ~= obj then return a end
		return b
	end
	local function isPress(input) return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch end
	local function unnamed(counterKey, prefix)
		library[counterKey] = 1 + (library[counterKey] or 0)
		return prefix .. tostring(library[counterKey])
	end
	local function warnReused(flag) if elements[flag] ~= nil then warn(debug.traceback("Warning! Re-used flag '" .. tostring(flag) .. "'", 3)) end end
	local function fireCallback(fn, ...) if type(fn) == "function" then task.spawn(fn, ...) end end
	local Pace = {count = 0, built = 0, token = 0}
	local function pace(weight)
		local delay = tonumber(library.MobileBuildDelay) or 0.06
		if delay <= 0 then return end
		Pace.built = Pace.built + 1
		Pace.count = Pace.count + (weight or 1)
		if Pace.label then
			Pace.label.Text = "loading… " .. Pace.built
			Pace.label.Visible = true
			Pace.token = Pace.token + 1
			local mine = Pace.token
			task.delay(delay + 0.8, function() if Pace.token == mine and Pace.label then Pace.label.Visible = false end end)
		end
		if Pace.count >= (tonumber(library.MobileBuildBatch) or 2) then
			Pace.count = 0
			task.wait(delay)
		end
	end
	local function attachBarDrag(hitArea, onPosition)
		local active, startPos, decided, isTouch = nil, nil, false, false
		local function finish(input)
			if not active then return end
			local wasTouch, wasDecided, cur = isTouch, decided, active
			active, startPos, decided, isTouch = nil, nil, false, false
			if wasTouch and not wasDecided and input == cur then onPosition(input.Position.X) end
		end
		library.signals[1 + #library.signals] = hitArea.InputBegan:Connect(function(input)
			if not isPress(input) then return end
			if active then
				local st = active.UserInputState
				if st ~= Enum.UserInputState.End and st ~= Enum.UserInputState.Cancel then return end
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
			if not active then return end
			if isTouch then
				if input ~= active then return end
				if not decided then
					local dx = math.abs(input.Position.X - startPos.X)
					local dy = math.abs(input.Position.Y - startPos.Y)
					if dx >= 6 and dx >= dy then
						decided = true
					elseif dy >= 10 then
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
			if active and (input == active or (not isTouch and input.UserInputType == Enum.UserInputType.MouseButton1)) then finish(input) end
		end)
	end
	local function ratioOnBar(bar, x)
		local w = bar.AbsoluteSize.X
		if not (w > 0) then return nil end
		local r = (x - bar.AbsolutePosition.X) / w
		if r ~= r then return nil end
		return math.clamp(r, 0, 1)
	end
	local hasFiles = (type(writefile) == "function") and (type(readfile) == "function")
	local function workspaceFolder()
		local folderName = sanitizeConfigName(tostring(library.WorkspaceName or ""))
		if #folderName == 0 then folderName = "Unnamed Workspace" end
		return "D3v1lHub Lib/" .. folderName
	end
	local function ensureFolder()
		pcall(function()
			if isfolder and makefolder then
				if not isfolder("D3v1lHub Lib") then makefolder("D3v1lHub Lib") end
				local folder = workspaceFolder()
				if not isfolder(folder) then makefolder(folder) end
			end
		end)
	end
	local function listConfigs()
		local names, seen = {}, {}
		if not (hasFiles and type(listfiles) == "function") then return names end
		local folder = workspaceFolder()
		if isfolder then
			local okf, exists = pcall(isfolder, folder)
			if not (okf and exists) then return names end
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
		table.sort(names, function(a, b) return string.lower(a) < string.lower(b) end)
		return names
	end
	local function persistable(cflag, data)
		return data and type(cflag) == "string" and data.Type ~= "Persistence" and data.Type ~= "Button" and data.Type ~= "Label" and not configIgnoredFlags[cflag] and string.sub(cflag, 1, 11) ~= "__Designer." and string.sub(cflag, 1, 9) ~= "__Mobile."
	end
	local function buildConfig()
		local saving = {}
		for cflag, data in next, elements do
			if persistable(cflag, data) then
				local ok, sv = serializeFlagValue(cflag, library_flags[cflag], data.Type)
				if ok and sv ~= nil then saving[cflag] = sv end
			end
		end
		saving.__meta = {savedAt = os.time(), version = 1}
		return saving
	end
	local function applyConfig(data)
		local applied = 0
		for cflag, val in next, data do
			local element = (type(cflag) == "string") and elements[cflag]
			if element and persistable(cflag, element) then
				local converted, usable = deserializeFlagValue(val, element)
				if usable and converted ~= nil then
					local ok = pcall(function() if element.Set then element:Set(converted) else library_flags[cflag] = converted end end)
					if ok then applied = applied + 1 end
				end
			end
		end
		return applied
	end
	local function saveConfig(name)
		name = sanitizeConfigName(name or "")
		if #name == 0 then return false, "Invalid name" end
		if not hasFiles then return false, "Executor cannot save files" end
		local good, content = JSONEncode(buildConfig())
		if not (good and content) then return false, "Encode error" end
		ensureFolder()
		local okw = pcall(writefile, workspaceFolder() .. "/" .. name .. ".txt", content)
		return okw, (okw and name) or "Write error"
	end
	local function loadConfig(name)
		name = sanitizeConfigName(name or "")
		if #name == 0 or not hasFiles then return false, "Invalid name" end
		local path = workspaceFolder() .. "/" .. name .. ".txt"
		if isfile then
			local okf, exists = pcall(isfile, path)
			if not (okf and exists) then return false, "Not found" end
		end
		local okr, content = pcall(readfile, path)
		if not okr or type(content) ~= "string" or #content < 2 then return false, "Not found" end
		local good, data = JSONDecode(content)
		if not (good and type(data) == "table") then return false, "Broken file" end
		return true, applyConfig(data)
	end
	local function deleteConfig(name)
		name = sanitizeConfigName(name or "")
		if #name == 0 or type(delfile) ~= "function" then return false end
		return (pcall(delfile, workspaceFolder() .. "/" .. name .. ".txt"))
	end
	local function readAutoload()
		if not hasFiles then return nil end
		local path = workspaceFolder() .. "/__autoload.json"
		if isfile then
			local okf, exists = pcall(isfile, path)
			if not (okf and exists) then return nil end
		end
		local okr, content = pcall(readfile, path)
		if not okr or type(content) ~= "string" then return nil end
		local good, data = JSONDecode(content)
		if good and type(data) == "table" and type(data.name) == "string" then
			local n = sanitizeConfigName(data.name)
			if #n > 0 then return n end
		end
		return nil
	end
	local function writeAutoload(name)
		if not hasFiles then return false end
		ensureFolder()
		local good, content = JSONEncode({name = name})
		if not (good and content) then return false end
		return (pcall(writefile, workspaceFolder() .. "/__autoload.json", content))
	end
	MobileUI.SaveConfig, MobileUI.LoadConfig, MobileUI.DeleteConfig, MobileUI.ListConfigs = saveConfig, loadConfig, deleteConfig, listConfigs
	local function notify(text, kind)
		pcall(function() library:Notify({Text = text, Time = 3, Type = kind}) end)
	end
	local vipRefresh = {}
	local function vipUnlocked(o)
		if library.VIP == true then return true end
		if type(o.VIPCheck) == "function" then
			local ok, v = pcall(o.VIPCheck)
			return ok and v and true or false
		end
		return false
	end
	function library.SetVIP(a, b)
		library.VIP = (pickArg(library, a, b) and true) or false
		for _, f in ipairs(vipRefresh) do pcall(f) end
		return library.VIP
	end
	local function addVIP(o, parent, element, onChange, x)
		if not o.VIP then return function() return false end end
		local badge = label(parent, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, x, 0.5, 0), Size = UDim2.fromOffset(34, 16), BackgroundColor3 = Color3.fromRGB(255, 200, 60), TextColor3 = Color3.fromRGB(40, 28, 0), Text = (type(o.VIP) == "string" and o.VIP) or "VIP", TextSize = 10, Font = FONT_BOLD, TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 3})
		badge.BackgroundTransparency = 0
		corner(badge, "full")
		local locked = not vipUnlocked(o)
		local function refresh()
			locked = not vipUnlocked(o)
			badge.BackgroundTransparency = locked and 0.35 or 0
			onChange()
		end
		vipRefresh[1 + #vipRefresh] = refresh
		element.IsVIPLocked = function() return locked end
		element.SetVIPLocked = function(t, state)
			if type(t) ~= "table" then state = t end
			locked = state and true or false
			badge.BackgroundTransparency = locked and 0.35 or 0
			onChange()
			return locked
		end
		badge.BackgroundTransparency = locked and 0.35 or 0
		return function(silent)
			if locked and not silent then notify("VIP only feature", "error") end
			return locked
		end
	end
	local function addMode(element, mode)
		local function norm(m) m = type(m) == "string" and string.lower(m) or "toggle" return (m == "hold" and "Hold") or (m == "always" and "Always") or "Toggle" end
		element.Mode = norm(mode)
		element.GetMode = function() return element.Mode end
		element.SetMode = function(a, b) element.Mode = norm(pickArg(element, a, b)) return element.Mode end
	end
	function MobileUI.CreateWindow(options)
		options = options or {}
		local windowName = options.Name or "Unnamed Window"
		options.Name = windowName
		pcall(DebugLog.Mark, DebugLog, "Mobile-GUI: CreateWindow startet")
		if windowName and #windowName > 0 and library.WorkspaceName == "D3v1lHub Lib" then library.WorkspaceName = convertfilename(windowName, "D3v1lHub Lib") end
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
			pcall(function() gui.Parent = library.gui_parent end)
		end
		library.MainScreenGui, MainScreenGui = gui, gui
		local main = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(480, 300), BackgroundColor3 = C("background"), BorderSizePixel = 0, Active = true}, gui)
		local function copyFooter() return new("TextLabel", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 1, 4), Size = UDim2.new(1, 0, 0, 12), BackgroundTransparency = 1, Font = FONT_MEDIUM, Text = "\u{A9} 2026 D3v1lHub | All rights reserved", TextSize = 11, TextColor3 = C("otherElementText"), TextTransparency = 0.45, ZIndex = 50}, main) end
		local copyLabel = copyFooter()
		task.spawn(function() while wait_check(6) and library.objects do if not copyLabel.Parent then copyLabel = copyFooter() end end end)
		corner(main, 10)
		local rim = new("UIStroke", {Color = C("main"), Thickness = 1, Transparency = 0.25, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, main)
		tweenService:Create(rim, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.7}):Play()
		local decal = options.BackgroundAsset
		if decal == nil then decal = "rbxassetid://133158046147209" elseif type(decal) == "number" then decal = "rbxassetid://" .. tostring(decal) end
		if type(decal) == "string" and decal ~= "" then
			corner(new("ImageLabel", {BackgroundTransparency = 1, Image = decal, ScaleType = Enum.ScaleType.Crop, ImageTransparency = tonumber(options.BackgroundTransparency) or 0.5, Size = UDim2.fromScale(1, 1), ZIndex = 0}, main), 10)
			corner(new("Frame", {BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0}, main), 10)
		end
		library.MobileMain = main
		local mainPop = new("UIScale", {Scale = 1}, main)
		library.signals[1 + #library.signals] = main:GetPropertyChangedSignal("Visible"):Connect(function()
			if main.Visible then mainPop.Scale = 0.9 tweenService:Create(mainPop, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play() end
		end)
		local topBar = new("Frame", {Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = C("sectionBackground"), BorderSizePixel = 0, Active = true}, main)
		corner(topBar, 10)
		new("Frame", {Position = UDim2.new(0, 0, 1, -10), Size = UDim2.new(1, 0, 0, 10), BackgroundColor3 = C("sectionBackground"), BorderSizePixel = 0}, topBar)
		local titleText = tostring(windowName)
		if string.sub(titleText, -3) == "Hub" and #titleText > 3 then titleText = string.sub(titleText, 1, -4) .. '<font color="' .. colorHex(C("main")) .. '">Hub</font>' end
		label(topBar, {Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -60, 1, 0), Font = FONT_BOLD, TextSize = 15, RichText = true, Text = titleText})
		Pace.built, Pace.count = 0, 0
		Pace.label = label(topBar, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -42, 0.5, 0), Size = UDim2.fromOffset(90, 16), TextSize = 11, TextColor3 = C("otherElementText"), TextXAlignment = Enum.TextXAlignment.Right, Text = "", Visible = false})
		local hideButton = button(topBar, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0), Size = UDim2.fromOffset(30, 26), BackgroundColor3 = C("topGradient"), Text = "–", Font = FONT_BOLD, TextSize = 16})
		corner(hideButton, 6)
		local body = new("Frame", {Position = UDim2.fromOffset(0, 36), Size = UDim2.new(1, 0, 1, -36), BackgroundTransparency = 1}, main)
		local tabList = new("ScrollingFrame", {Position = UDim2.fromOffset(6, 6), Size = UDim2.new(0, 104, 1, -12), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y}, body)
		new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, tabList)
		new("Frame", {Position = UDim2.fromOffset(115, 8), Size = UDim2.new(0, 1, 1, -16), BackgroundColor3 = C("innerBorder"), BorderSizePixel = 0}, body)
		local pages = new("Frame", {Position = UDim2.fromOffset(122, 6), Size = UDim2.new(1, -128, 1, -12), BackgroundTransparency = 1, ClipsDescendants = true}, body)
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
				pcall(function() overlayContent:Destroy() end)
				overlayContent = nil
			end
			overlay.Visible = false
			if cb then pcall(cb) end
		end
		local function openOverlay(onClose)
			closeOverlay()
			overlayContent = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 52}, overlayPanel)
			overlayOnClose = onClose
			overlay.Visible = true
			return overlayContent
		end
		overlay.Activated:Connect(closeOverlay)
		library.signals[1 + #library.signals] = main:GetPropertyChangedSignal("Visible"):Connect(function() if not main.Visible then closeOverlay() end end)
		local function fitToScreen()
			local cam = workspace.CurrentCamera
			local vp = cam and cam.ViewportSize
			if not vp or vp.X < 50 or vp.Y < 50 then return end
			local inset = Vector2.new(0, 0)
			pcall(function() inset = game:GetService("GuiService"):GetGuiInset() end)
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
				if queued then return end
				queued = true
				task.delay(0.25, function()
					queued = false
					local cam = workspace.CurrentCamera
					local vp = cam and cam.ViewportSize
					if not vp or not main.Parent then return end
					if lastViewport and math.abs(vp.X - lastViewport.X) < 4 and math.abs(vp.Y - lastViewport.Y) < 4 then return end
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
		do
			local dragInput, dragStart, startPos = nil, nil, nil
			library.signals[1 + #library.signals] = topBar.InputBegan:Connect(function(input)
				if isPress(input) and not dragInput then dragInput, dragStart, startPos = input, input.Position, main.Position end
			end)
			library.signals[1 + #library.signals] = userInputService.InputChanged:Connect(function(input)
				if not dragInput then return end
				local same = (input == dragInput) or (dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement)
				if same then
					local delta = input.Position - dragStart
					main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end
			end)
			library.signals[1 + #library.signals] = userInputService.InputEnded:Connect(function(input)
				if dragInput and (input == dragInput or (dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseButton1)) then dragInput = nil end
			end)
		end
		local toggleGui = Instance_new("ScreenGui")
		toggleGui.Name, toggleGui.ResetOnSpawn, toggleGui.DisplayOrder, toggleGui.ZIndexBehavior = generateRandomName(), false, 11, Enum.ZIndexBehavior.Sibling
		if not protectAndParentGui(toggleGui, library.gui_parent) then
			pcall(function() toggleGui.Parent = library.gui_parent end)
		end
		library.__MobileToggleGui = toggleGui
		do
			local buttonImage = options.MobileButtonImage or options.MobileButtonDecal or "rbxassetid://133158046147209"
			if type(buttonImage) == "number" then buttonImage = "rbxassetid://" .. tostring(buttonImage) end
			local buttonSize = tonumber(options.MobileButtonSize) or 54
			local toggleButton = new("ImageButton", {AutoButtonColor = false, BackgroundColor3 = C("background"), BorderSizePixel = 0, Image = buttonImage, ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromOffset(buttonSize, buttonSize), Position = UDim2.new(0, 16, 0.3, 0), ZIndex = 10}, toggleGui)
			corner(toggleButton, "full")
			new("UIStroke", {ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2, Color = C("main")}, toggleButton)
			library.MobileToggleButton = toggleButton
			local pop = new("UIScale", {Scale = 1}, toggleButton)
			local ring = toggleButton:FindFirstChildOfClass("UIStroke")
			local function springTo(scale, dur, style)
				tweenService:Create(pop, TweenInfo.new(dur, style or Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = scale}):Play()
			end
			local function stateFx(open)
				tweenService:Create(ring, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Color = open and library.colors.main or Color3.fromRGB(110, 110, 120), Thickness = open and 2 or 1}):Play()
				toggleButton.Rotation = open and -25 or 25
				tweenService:Create(toggleButton, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0, ImageTransparency = open and 0 or 0.35}):Play()
			end
			library.signals[1 + #library.signals] = main:GetPropertyChangedSignal("Visible"):Connect(function() stateFx(main.Visible) end)
			local dragInput, dragStart, buttonStart, moved = nil, nil, nil, false
			library.signals[1 + #library.signals] = toggleButton.InputBegan:Connect(function(input)
				if dragInput then
					local st = dragInput.UserInputState
					if st ~= Enum.UserInputState.End and st ~= Enum.UserInputState.Cancel then return end
					dragInput = nil
				end
				if isPress(input) then
					dragInput, dragStart, buttonStart, moved = input, input.Position, toggleButton.AbsolutePosition, false
					springTo(0.86, 0.12, Enum.EasingStyle.Quad)
				end
			end)
			library.signals[1 + #library.signals] = userInputService.InputChanged:Connect(function(input)
				if not dragInput then return end
				local same = (input == dragInput) or (dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement)
				if not same then return end
				local delta = input.Position - dragStart
				if not moved and (math.abs(delta.X) > 8 or math.abs(delta.Y) > 8) then moved = true end
				if moved then
					local area, size = toggleGui.AbsoluteSize, toggleButton.AbsoluteSize
					toggleButton.Position = UDim2.fromOffset(math.clamp(buttonStart.X + delta.X - toggleGui.AbsolutePosition.X, 0, math.max(0, area.X - size.X)), math.clamp(buttonStart.Y + delta.Y - toggleGui.AbsolutePosition.Y, 0, math.max(0, area.Y - size.Y)))
				end
			end)
			library.signals[1 + #library.signals] = userInputService.InputEnded:Connect(function(input)
				if not dragInput then return end
				local same = (input == dragInput) or (dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseButton1)
				if not same then return end
				dragInput = nil
				springTo(1, 0.4)
				if not moved then main.Visible = not main.Visible end
			end)
		end
		hideButton.Activated:Connect(function() main.Visible = false end)
		local terminated = false
		local function terminateGui()
			if terminated then return end
			terminated = true
			pcall(closeOverlay)
			pcall(function() toggleGui:Destroy() end)
			library.__MobileToggleGui = nil
			pcall(function() gui:Destroy() end)
			library.MainScreenGui, MainScreenGui = nil, nil
			pcall(library.unload)
		end
		library.__MobileTerminate = terminateGui
		if typeof(getgenv) == "function" then getgenv().D3v1lHub_ActiveTerminate = terminateGui end
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
			if x == nil then main.Visible = not main.Visible else main.Visible = x and true end
			return main.Visible
		end
		function windowFunctions:SetSize()
			fitToScreen()
			return main.Size.X.Offset, main.Size.Y.Offset
		end
		function windowFunctions:GetSize() return main.Size.X.Offset, main.Size.Y.Offset end
		function windowFunctions:ResetSize() fitToScreen() end
		function windowFunctions:MoveTabSlider()
		end
		function windowFunctions:UpdateAll() for _, element in next, elements do if type(element) == "table" and element.Update then pcall(element.Update) end end end
		library.UpdateAll = windowFunctions.UpdateAll
		local tabs = {}
		local selectedTab = nil
		local function selectTab(tab)
			if selectedTab == tab then return end
			closeOverlay()
			for _, t in ipairs(tabs) do
				local active = (t == tab)
				t.Page.Visible = active
				tweenService:Create(t.Button, TweenInfo.new(0.2), {BackgroundColor3 = active and darkenColor(C("main"), 2.2) or C("topGradient"), TextColor3 = active and C("elementText") or C("tabText")}):Play()
				t.Accent.Visible = active
				if active then
					t.Accent.Size = UDim2.new(0, 3, 0, 0)
					tweenService:Create(t.Accent, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 3, 1, -14)}):Play()
					t.Page.Position = t.Base + UDim2.fromOffset(20, 0)
					tweenService:Create(t.Page, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = t.Base}):Play()
				end
			end
			selectedTab = tab
			windowFunctions.LastTab = tab.Functions
		end
		function windowFunctions:CreateTab(tabOptions, ...)
			tabOptions = (tabOptions and type(tabOptions) == "string" and resolvevararg("Tab", tabOptions, ...)) or tabOptions or {Name = "Tab"}
			local tabName = tabOptions.Name or "Unnamed Tab"
			tabOptions.Name = tabName
			pcall(DebugLog.Mark, DebugLog, "Mobile-Tab: " .. tostring(tabName))
			pace(99)
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
			local badge = nil
			local function setBadge(text, color)
				text = (text ~= nil and text ~= "") and tostring(text) or nil
				if not text then
					if badge then badge.Visible = false end
					return
				end
				if not badge then
					badge = label(tabButton, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -5, 0.5, 0), TextSize = 9, Font = FONT_BOLD, TextXAlignment = Enum.TextXAlignment.Center, TextColor3 = Color3.new(1, 1, 1), ZIndex = 3})
					badge.BackgroundTransparency = 0
					corner(badge, "full")
				end
				badge.Text, badge.Size, badge.BackgroundColor3, badge.Visible = text, UDim2.fromOffset(math.max(24, 6 * #text + 10), 14), color or C("main"), true
			end
			function tabFunctions.SetBadge(t, text, color)
				if type(t) ~= "table" then text, color = t, text end
				setBadge(text, color)
			end
			if tabOptions.Badge then setBadge(tabOptions.Badge, tabOptions.BadgeColor) end
			local tabEntry = {Button = tabButton, Accent = accent, Page = page, Functions = tabFunctions, Base = page.Position}
			tabs[1 + #tabs] = tabEntry
			tabButton.Activated:Connect(function() selectTab(tabEntry) end)
			function tabFunctions:Select() selectTab(tabEntry) end
			tabFunctions.Remove = function()
				tabButton.Parent = nil
				page.Parent = nil
			end
			if not selectedTab then selectTab(tabEntry) end
			function tabFunctions:CreateSection(sectionOptions, ...)
				sectionOptions = (sectionOptions and type(sectionOptions) == "string" and resolvevararg("Tab", sectionOptions, ...)) or sectionOptions or {}
				local sectionName = sectionOptions.Name or "Unnamed Section"
				sectionOptions.Name = sectionName
				pcall(DebugLog.Mark, DebugLog, "Mobile-Section: " .. tostring(sectionName))
				pace(2)
				sectionCount = sectionCount + 1
				local sectionFrame = new("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = C("sectionBackground"), BackgroundTransparency = 0.2, BorderSizePixel = 0, LayoutOrder = sectionCount}, page)
				corner(sectionFrame, 8)
				new("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, sectionFrame)
				new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, sectionFrame)
				label(sectionFrame, {Size = UDim2.new(1, 0, 0, 18), Font = FONT_BOLD, TextSize = 14, TextColor3 = C("section"), Text = tostring(sectionName), LayoutOrder = 0})
				local holder = new("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 1}, sectionFrame)
				new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, holder)
				local elementCount = 0
				local function nextOrder()
					pace(1)
					elementCount = elementCount + 1
					return elementCount
				end
				local sectionFunctions = {Flags = {}, Name = sectionName}
				function sectionFunctions:Update() if not sectionFrame.Visible then sectionFrame.Visible = true end end
				function sectionFunctions:UpdateAll() for _, element in next, sectionFunctions.Flags do if type(element) == "table" and element.Update then pcall(element.Update) end end end
				sectionFunctions.Remove = function() sectionFrame.Parent = nil end
				library.__AllSections = library.__AllSections or {}
				library.__AllSections[1 + #library.__AllSections] = {Frame = sectionFrame, Holder = holder, Functions = sectionFunctions}
				local function register(flag, element) tabFunctions.Flags[flag], sectionFunctions.Flags[flag], elements[flag] = element, element, element end
				local function makeRow(height)
					local row = new("Frame", {Size = UDim2.new(1, 0, 0, height or ROW_H), BackgroundColor3 = C("topGradient"), BorderSizePixel = 0, LayoutOrder = nextOrder()}, holder)
					corner(row, 6)
					return row
				end
				local function removeRow(row) return function() if row then row.Parent = nil end end end
				local function addLocking(element, getLocked, setLocked)
					element.SetLocked = function(t, state)
						if type(t) ~= "table" then state = t end
						if state == nil then setLocked(not getLocked()) else setLocked(state and true or false) end
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
				function sectionFunctions:AddToggle(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Tab", o, ...)) or o
					local name = assert(o.Name, "Missing Name for new toggle.")
					local flag = o.Flag or unnamed("unnamedtoggles", "Toggle")
					warnReused(flag)
					local locked = (o.Locked or o.Disabled) and true or false
					local row = makeRow()
					local hit = button(row, {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 2})
					local nameLabel = label(row, {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, o.VIP and -102 or -66, 1, 0), Text = tostring(name)})
					local track = new("Frame", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(40, 20), BackgroundColor3 = C("innerBorder"), BorderSizePixel = 0}, row)
					corner(track, "full")
					local knob = new("Frame", {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 2, 0.5, 0), Size = UDim2.fromOffset(16, 16), BackgroundColor3 = C("elementText"), BorderSizePixel = 0}, track)
					corner(knob, "full")
					local element
					local vipBlock = function() return false end
					local function render(animate)
						local on = library_flags[flag] and true or false
						local dim = locked or vipBlock(true)
						local info = TweenInfo.new(animate and 0.15 or 0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						tweenService:Create(knob, info, {Position = on and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}):Play()
						track.BackgroundColor3 = on and C("main") or C("innerBorder")
						nameLabel.Text = tostring(o.Name or name)
						nameLabel.TextTransparency = dim and 0.55 or 0
						track.BackgroundTransparency = dim and 0.5 or 0
					end
					local function apply(value, fire)
						local last = library_flags[flag]
						value = value and true or false
						library_flags[flag] = value
						if o.Location then o.Location[o.LocationFlag or flag] = value end
						render(true)
						if fire and o.Callback and (last ~= value or o.AllowDuplicateCalls) then fireCallback(o.Callback, value) end
						return value
					end
					local function Set(a, b) return apply(pickArg(element, a, b), true) end
					hit.Activated:Connect(function()
						if locked or vipBlock() then return end
						local newValue = not library_flags[flag]
						if type(o.Condition) == "function" then
							local ok, allowed = pcall(o.Condition, newValue, not newValue)
							if ok and not allowed then return end
						end
						apply(newValue, true)
					end)
					local initial = o.Value
					if initial == nil then initial = o.Enabled end
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = "Toggle",
						Parent = sectionFunctions,
						Instance = nameLabel,
						Container = row,
						DisplayName = name,
						Get = function() return library_flags[flag] end,
						Set = Set,
						RawSet = function(a, b) return apply(pickArg(element, a, b), false) end,
						Update = function()
							render(false)
							return library_flags[flag]
						end,
						Remove = removeRow(row),
						SetCondition = function(t, condition)
							if type(t) ~= "table" and condition == nil then condition = t end
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
					vipBlock = addVIP(o, row, element, function() render(false) end, -52)
					addMode(element, o.KeybindMode)
					if initial ~= nil then
						apply(initial, true)
					else
						library_flags[flag] = false
						render(false)
					end
					element.Default = library_flags[flag] and true or false
					element.Reset = function() return Set(nil, element.Default) end
					register(flag, element)
					return element
				end
				function sectionFunctions:AddSlider(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Slider", o, ...)) or o
					local name = assert(o.Name, "Missing Name for new slider.")
					assert(o.Max, "Missing Max for new slider.")
					assert(o.Min, "Missing Min for new slider.")
					local flag = o.Flag or unnamed("unnamedsliders", "Slider")
					warnReused(flag)
					local decimals = tonumber(o.Decimals or o.Precision or o.Precise)
					if not decimals and (o.Max - o.Min) <= 1 then decimals = 1 end
					if decimals then
						decimals = math.clamp(decimals, 0, 99)
						if decimals <= 0 then decimals = nil end
					end
					local function display(val, was)
						local str = (decimals and string.format("%0." .. tostring(decimals) .. "f", val)) or tostring(val)
						local formatType = o.Format and type(o.Format)
						if formatType == "string" then
							local ok, res = pcall(string.format, o.Format, val)
							return ok and res or str
						elseif formatType == "function" then
							local ok, res = pcall(o.Format, val, was)
							if ok and res ~= nil then return tostring(res) end
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
						if box and not box:IsFocused() then box.Text = tostring(v) end
					end
					local function normalize(v)
						v = tonumber(v)
						if not v or v ~= v then return nil end
						if not o.IllegalInput then v = math.clamp(v, math.min(o.Min, o.Max), math.max(o.Min, o.Max)) end
						if decimals then v = tonumber(string.format("%0." .. tostring(decimals) .. "f", v)) or v end
						return v
					end
					local function apply(value, fire)
						value = normalize(value)
						if value == nil then return library_flags[flag] end
						local last = library_flags[flag]
						library_flags[flag] = value
						if o.Location then o.Location[o.LocationFlag or flag] = value end
						render(last)
						if fire and o.Callback and (last ~= value or o.AllowDuplicateCalls) then fireCallback(o.Callback, value, last) end
						return value
					end
					attachBarDrag(hit, function(x)
						local r = ratioOnBar(bar, x)
						if r == nil then return end
						local raw = o.Min + r * (o.Max - o.Min)
						if not decimals then raw = math.floor(raw + 0.5) end
						apply(raw, true)
					end)
					if box then
						box.FocusLost:Connect(function()
							local n = tonumber(box.Text)
							if n then apply(n, true) else render() end
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
						Get = function() return library_flags[flag] end,
						Set = function(a, b) return apply(pickArg(element, a, b), true) end,
						RawSet = function(a, b) return apply(pickArg(element, a, b), false) end,
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
							if type(t) ~= "table" then t, minV, maxV = nil, t, minV end
							o.Min = tonumber(minV) or o.Min
							o.Max = tonumber(maxV) or o.Max
							apply(library_flags[flag], false)
						end
					}
					if o.Value ~= nil and normalize(o.Value) ~= nil then
						apply(o.Value, true)
					else
						library_flags[flag] = o.Min
						if o.Location then o.Location[o.LocationFlag or flag] = o.Min end
						render()
					end
					element.Default = library_flags[flag]
					element.Reset = function() return element.Set(element.Default) end
					register(flag, element)
					return element
				end
				function sectionFunctions:AddButton(...)
					local args
					if ... and not select(2, ...) and type(...) == "table" and #... > 0 and type((...)[1]) == "table" and (...)[1].Name then args = ... else args = {...} end
					local list = {}
					for _, bo in ipairs(args) do
						bo = (bo and bo[1] and type(bo[1]) == "string" and resolvevararg("Button", unpack(bo))) or bo
						if type(bo) == "table" then list[1 + #list] = bo end
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
						local vipBlock = function() return false end
						local confirmText = bo.Confirm and ((type(bo.Confirm) == "string" and bo.Confirm) or "Click again to confirm") or nil
						local confirming, cooling, coolLeft = 0, false, 0
						local btn = button(container, {Size = UDim2.new(1 / count, -((count - 1) * 6) / count, 1, 0), BackgroundColor3 = C("topGradient"), Text = tostring(name), TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = index})
						corner(btn, 6)
						local stroke = new("UIStroke", {Color = C("main"), Thickness = 1, Transparency = 0.6, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, btn)
						local element
						local function render()
							local dim = locked or cooling or vipBlock(true)
							btn.Text = (confirming > 0 and confirmText) or (cooling and (tostring(bo.Name or name) .. " (" .. math.ceil(coolLeft) .. "s)")) or tostring(bo.Name or name)
							btn.TextTransparency = dim and 0.55 or 0
							stroke.Transparency = dim and 0.85 or 0.6
						end
						local function press()
							if type(bo.Condition) == "function" then
								local ok, allowed = pcall(bo.Condition)
								if ok and not allowed then return end
							end
							fireCallback(callback)
						end
						btn.Activated:Connect(function()
							if locked or cooling or vipBlock() then return end
							if confirmText and confirming == 0 then
								local mine = os.clock()
								confirming = mine
								render()
								task.delay(3, function() if confirming == mine and btn.Parent then confirming = 0 render() end end)
								return
							end
							confirming = 0
							tweenService:Create(btn, TweenInfo.new(0.08), {BackgroundColor3 = darkenColor(C("main"), 2)}):Play()
							task.delay(0.12, function() if not btn.Parent then return end tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = C("topGradient")}):Play() end)
							press()
							local seconds = tonumber(bo.Cooldown)
							if seconds and seconds > 0 then
								cooling, coolLeft = true, seconds
								task.spawn(function()
									local endAt = os.clock() + seconds
									while btn.Parent and endAt - os.clock() > 0 do
										coolLeft = endAt - os.clock()
										render()
										task.wait(math.min(1, coolLeft))
									end
									cooling = false
									render()
								end)
							else
								render()
							end
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
							Get = function() return nil end,
							Press = function() if not locked then press() end end,
							RawPress = press,
							SetText = function(a, b)
								bo.Name = tostring(pickArg(element, a, b))
								render()
								return bo.Name
							end,
							SetCallback = function(a, b)
								local fn = pickArg(element, a, b)
								if type(fn) == "function" then callback = fn end
								return callback
							end,
							SetCondition = function(t, condition)
								if type(t) ~= "table" and condition == nil then condition = t end
								bo.Condition = condition
								return condition
							end,
							Update = function() render() end,
							Remove = function() btn.Parent = nil end
						}
						addLocking(element, function()
							return locked
						end, function(v)
							locked = v
							render()
						end)
						vipBlock = addVIP(bo, btn, element, render, -6)
						render()
						register(name, element)
						buttons[1 + #buttons] = element
					end
					function buttons.PressAll() for _, b in ipairs(buttons) do b.Press() end end
					function buttons.UpdateAll() for _, b in ipairs(buttons) do b.Update() end end
					buttons.Update = buttons.UpdateAll
					function buttons.RemoveAll() container.Parent = nil end
					buttons.Remove = buttons.RemoveAll
					if #buttons == 1 then for k, v in next, buttons[1] do if buttons[k] == nil then buttons[k] = v end end end
					return buttons
				end
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
						Get = function() return lbl.Text, lbl end,
						Set = set,
						SetText = set,
						RawSet = set,
						Update = function() return lbl.Text end,
						Remove = function() lbl.Parent = nil end
					}
					element.Reset = function() return set(nil, element.Default) end
					register(flag, element)
					return element
				end
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
						if o.Location then o.Location[o.LocationFlag or flag] = value end
						if box.Text ~= value then box.Text = value end
						if fire and o.Callback and (last ~= value or o.AllowDuplicateCalls) then fireCallback(o.Callback, value, last, box) end
						return value
					end
					box.FocusLost:Connect(function() apply(box.Text, true) end)
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = "Textbox",
						Parent = sectionFunctions,
						Instance = box,
						Container = row,
						DisplayName = name,
						Get = function() return library_flags[flag] end,
						Set = function(a, b) return apply(pickArg(element, a, b), true) end,
						RawSet = function(a, b) return apply(pickArg(element, a, b), false) end,
						Update = function()
							nameLabel.Text = tostring(o.Name or name)
							return library_flags[flag]
						end,
						Remove = removeRow(row)
					}
					if o.Value ~= nil then apply(o.Value, true) else library_flags[flag] = nil end
					element.Default = library_flags[flag]
					element.Reset = function() return element.Set(element.Default) end
					register(flag, element)
					return element
				end
				function sectionFunctions:AddKeybind(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Keybind", o, ...)) or o
					local name = assert(o.Name, "Missing Name for new keybind.")
					local flag = o.Flag or unnamed("unnamedkeybinds", "Keybind")
					warnReused(flag)
					local preset = (typeof(o.Value) == "EnumItem") and o.Value or nil
					library_flags[flag] = preset
					local element
					local function apply(key) library_flags[flag] = key if o.Location then o.Location[o.LocationFlag or flag] = key end return key end
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = "Keybind",
						Parent = sectionFunctions,
						DisplayName = name,
						Default = preset,
						Get = function() return library_flags[flag] end,
						Set = function(a, b) return apply(pickArg(element, a, b)) end,
						RawSet = function(a, b) return apply(pickArg(element, a, b)) end,
						Update = function() return library_flags[flag] end,
						Reset = function() return apply(preset) end,
						Remove = function() end
					}
					addMode(element, o.Mode or o.KeybindMode)
					register(flag, element)
					return element
				end
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
							for _, plr in ipairs(playersservice:GetPlayers()) do if not (exclude and plr == playersservice.LocalPlayer) then names[1 + #names] = plr.Name end end
							table.sort(names, function(a, b) return a:lower() < b:lower() end)
							return names
						end
					elseif o.SpecialType == "Team" then
						listSource = function()
							local names = {}
							for _, team in ipairs(game:GetService("Teams"):GetTeams()) do names[1 + #names] = team.Name end
							table.sort(names, function(a, b) return a:lower() < b:lower() end)
							return names
						end
					end
					local resolve = getresolver(listSource, o.Filter, o.Method)
					local list = {}
					local function refreshList()
						local ok, res = pcall(resolve)
						list = (ok and type(res) == "table") and res or {}
						if not next(list) and o.EmptyValue ~= nil then table.insert(list, 1, o.EmptyValue) end
						return list
					end
					refreshList()
					local disabledValues = (type(o.DisabledValues) == "table" and o.DisabledValues) or {}
					local function isDisabled(v) return table.find(disabledValues, tostring(v)) ~= nil end
					local function formatValue(v)
						if v ~= nil and type(o.FormatDisplayValue) == "function" then
							local ok, res = pcall(o.FormatDisplayValue, v)
							if ok and res ~= nil then return tostring(res) end
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
					local overlayRebuild = nil
					local function displayText()
						local v = library_flags[flag]
						if multi then
							if type(v) == "table" and #v > 0 then
								local parts = {}
								for i, item in ipairs(v) do parts[i] = formatValue(item) end
								return table.concat(parts, ", ")
							end
							return (type(multi) == "string" and multi) or tostring(blank or "Select Item(s)")
						end
						if v == nil then return tostring(blank or "None") end
						return formatValue(v)
					end
					local function render()
						nameLabel.Text = tostring(o.Name or name)
						valueLabel.Text = displayText()
					end
					local function applySingle(value, fire)
						local last = library_flags[flag]
						library_flags[flag] = value
						if o.Location then o.Location[o.LocationFlag or flag] = value end
						render()
						if fire and o.Callback and (last ~= value or o.AllowDuplicateCalls) then fireCallback(o.Callback, value, last) end
						return value
					end
					local function applyMulti(values, fire)
						local current = library_flags[flag]
						if type(current) ~= "table" then
							current = {}
							library_flags[flag] = current
						end
						local before = {unpack(current)}
						table.clear(current)
						if type(values) == "table" then
							for _, v in ipairs(values) do if v ~= nil and not table.find(current, v) then current[1 + #current] = v end end
						elseif values ~= nil then
							current[1] = values
						end
						if o.Location then o.Location[o.LocationFlag or flag] = current end
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
						if fire and o.Callback and (changed or o.AllowDuplicateCalls) then fireCallback(o.Callback, current, before) end
						return current
					end
					local function apply(value, fire)
						if multi then return applyMulti(value, fire) end
						if type(value) == "table" then value = value[1] end
						return applySingle(value, fire)
					end
					local function openList()
						refreshList()
						local content = openOverlay(function() overlayRebuild = nil end)
						label(content, {Position = UDim2.fromOffset(12, 8), Size = UDim2.new(1, -24, 0, 20), Font = FONT_BOLD, TextSize = 14, Text = tostring(o.Name or name), ZIndex = 53})
						local top = 32
						local searchBox = nil
						if o.Searchable or elementType == "SearchBox" then
							searchBox = new("TextBox", {Position = UDim2.fromOffset(10, top), Size = UDim2.new(1, -20, 0, 28), BackgroundColor3 = C("bottomGradient"), BorderSizePixel = 0, ClearTextOnFocus = false, Font = FONT_MEDIUM, TextSize = 13, TextColor3 = C("elementText"), PlaceholderColor3 = C("otherElementText"), PlaceholderText = "Search...", Text = "", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 53}, content)
							corner(searchBox, 5)
							new("UIPadding", {PaddingLeft = UDim.new(0, 8)}, searchBox)
							top = top + 34
						end
						local showSelect = multi and o.SelectButtons ~= false
						local bottomSpace = multi and 46 or 8
						local function visibleValues()
							local term, out = searchBox and string.lower(searchBox.Text) or "", {}
							for _, v in ipairs(list) do
								local text = formatValue(v)
								if not isDisabled(v) and (term == "" or string.find(string.lower(text), term, 1, true) or string.find(string.lower(tostring(v)), term, 1, true)) then out[1 + #out] = v end
							end
							return out
						end
						local scroller = new("ScrollingFrame", {Position = UDim2.fromOffset(10, top), Size = UDim2.new(1, -20, 1, -(top + bottomSpace)), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 4, ScrollBarImageColor3 = C("main"), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 53}, content)
						new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, scroller)
						if multi then
							local bar = new("Frame", {AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -8), Size = UDim2.new(1, -20, 0, 32), BackgroundTransparency = 1, ZIndex = 53}, content)
							new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, bar)
							local function barButton(text, order, color, fn)
								local count = showSelect and 3 or 1
								local b = button(bar, {Size = UDim2.new(1 / count, -((count - 1) * 6) / count, 1, 0), BackgroundColor3 = color, Text = text, Font = FONT_BOLD, TextSize = 14, TextColor3 = Color3.new(1, 1, 1), LayoutOrder = order, ZIndex = 53})
								corner(b, 6)
								b.Activated:Connect(fn)
							end
							if showSelect then
								barButton("Select All", 1, C("topGradient"), function()
									local values = {}
									local cur = library_flags[flag]
									if type(cur) == "table" then for _, x in ipairs(cur) do values[1 + #values] = x end end
									for _, v in ipairs(visibleValues()) do if not table.find(values, v) then values[1 + #values] = v end end
									applyMulti(values, true)
									if overlayRebuild then overlayRebuild() end
								end)
								barButton("Clear", 2, C("topGradient"), function()
									applyMulti({}, true)
									if overlayRebuild then overlayRebuild() end
								end)
							end
							barButton("Done", 3, C("main"), closeOverlay)
						end
						local function build()
							for _, child in ipairs(scroller:GetChildren()) do if child:IsA("GuiObject") then child:Destroy() end end
							local term = searchBox and string.lower(searchBox.Text) or ""
							local current = library_flags[flag]
							local items = {}
							if blank and not table.find(list, blank) then items[1] = blank end
							for _, v in ipairs(list) do items[1 + #items] = v end
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
										if disabled then return end
										if multi then
											local values = {}
											local cur = library_flags[flag]
											if type(cur) == "table" then for _, x in ipairs(cur) do values[1 + #values] = x end end
											local at = table.find(values, v)
											if at then table.remove(values, at) else values[1 + #values] = v end
											applyMulti(values, true)
											build()
										else
											applySingle(v, true)
											closeOverlay()
										end
									end)
								end
							end
							if shown == 0 then label(scroller, {Size = UDim2.new(1, -6, 0, 28), TextXAlignment = Enum.TextXAlignment.Center, TextColor3 = C("otherElementText"), Text = "No entries", ZIndex = 54}) end
						end
						build()
						overlayRebuild = build
						if searchBox then searchBox:GetPropertyChangedSignal("Text"):Connect(build) end
					end
					hit.Activated:Connect(openList)
					local function relistIfOpen() if overlayRebuild then pcall(overlayRebuild) end end
					element = {
						Options = o,
						Name = flag,
						Flag = flag,
						Type = elementType,
						Parent = sectionFunctions,
						Instance = valueLabel,
						Container = row,
						DisplayName = name,
						Get = function() return library_flags[flag] end,
						Set = function(a, b) return apply(pickArg(element, a, b), true) end,
						RawSet = function(a, b) return apply(pickArg(element, a, b), false) end,
						Update = function()
							render()
							return displayText()
						end,
						Remove = removeRow(row),
						resolvelist = function() return refreshList() end,
						SelectAll = function()
							if not multi then return library_flags[flag] end
							refreshList()
							local values = {}
							for _, v in ipairs(list) do if not isDisabled(v) then values[1 + #values] = v end end
							return applyMulti(values, true)
						end,
						Clear = function()
							if not multi then return library_flags[flag] end
							return applyMulti({}, true)
						end,
						UpdateList = function(t, newList, updateValues)
							if (newList == nil and t ~= nil and t ~= element) or (type(t) == "table" and t ~= element and type(newList) ~= "table") then newList, updateValues = t, newList end
							if newList == element then newList = nil end
							if newList ~= nil then
								listSource = newList
								o.List = newList
							end
							resolve = getresolver(listSource, o.Filter, o.Method)
							refreshList()
							if updateValues and not multi and library_flags[flag] ~= nil and not table.find(list, library_flags[flag]) then applySingle(list[1], true) end
							render()
							relistIfOpen()
							return list
						end,
						SetDisabledValues = function(t, values)
							if values == nil and t ~= element then values = t end
							if type(values) == "table" then disabledValues = values end
							relistIfOpen()
							return disabledValues
						end,
						AddDisabledValues = function(t, values)
							if values == nil and t ~= element then values = t end
							if type(values) == "table" then
								for _, v in ipairs(values) do disabledValues[1 + #disabledValues] = v end
							elseif values ~= nil then
								disabledValues[1 + #disabledValues] = tostring(values)
							end
							relistIfOpen()
							return disabledValues
						end
					}
					element.Refresh = element.UpdateList
					element.SetValues = element.UpdateList
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
					local initial = o.Value
					if blank and initial == nil then initial = blank end
					if multi then
						library_flags[flag] = {}
						if initial ~= nil then applyMulti((type(initial) == "table") and initial or {initial}, true) end
					else
						if initial == nil then initial = list[1] end
						if o.Value ~= nil or blank ~= nil then applySingle(initial, true) else library_flags[flag] = initial end
					end
					if o.Location and not multi then o.Location[o.LocationFlag or flag] = library_flags[flag] end
					render()
					element.Default = library_flags[flag]
					element.Reset = function() return element.Set(element.Default) end
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
				function sectionFunctions:AddColorpicker(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Colorpicker", o, ...)) or o
					local name = assert(o.Name, "Missing Name for new colorpicker.")
					local flag = o.Flag or unnamed("unnamedcolorpickers", "Colorpicker")
					warnReused(flag)
					local function toColor(v)
						if typeof(v) == "Color3" then return v end
						if v == "random" or o.Random == true then return Color3.new(math.random(), math.random(), math.random()) end
						if type(v) == "string" and v ~= "rainbow" then
							local ok, c = pcall(Color3FromHex, v)
							if ok and typeof(c) == "Color3" then return c end
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
						if typeof(c) == "Color3" then swatch.BackgroundColor3 = c end
						nameLabel.Text = tostring(o.Name or name)
					end
					local function apply(value, fire)
						local c = toColor(value)
						if not c then return library_flags[flag] end
						local last = library_flags[flag]
						library_flags[flag] = c
						if o.Location then o.Location[o.LocationFlag or flag] = c end
						render()
						if fire and o.Callback and (last ~= c or o.AllowDuplicateCalls) then fireCallback(o.Callback, c, last) end
						return c
					end
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
							for i = 0, 6 do keys[#keys + 1] = ColorSequenceKeypoint.new(i / 6, Color3.fromHSV(i / 6, 1, 1)) end
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
							if not hexBox:IsFocused() then hexBox.Text = "#" .. Color3ToHex(c) end
							if fire then apply(c, true) end
						end
						for index, bar in ipairs(bars) do
							attachBarDrag(bar.Hit, function(x)
								local r = ratioOnBar(bar.Frame, x)
								if r == nil or not content.Parent then return end
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
						Get = function() return library_flags[flag] end,
						Set = function(a, b) return apply(pickArg(element, a, b), true) end,
						RawSet = function(a, b) return apply(pickArg(element, a, b), false) end,
						Update = function()
							render()
							return library_flags[flag]
						end,
						Remove = removeRow(row),
						GetRainbow = function() return false end,
						SetRainbow = function() return false end
					}
					if o.Value ~= nil and toColor(o.Value) then
						apply(o.Value, true)
					else
						library_flags[flag] = Color3.new(1, 1, 1)
						if o.Location then o.Location[o.LocationFlag or flag] = library_flags[flag] end
						render()
					end
					element.Default = library_flags[flag]
					element.Reset = function() return element.Set(element.Default) end
					register(flag, element)
					return element
				end
				function sectionFunctions:AddPersistence(o, ...)
					o = (o and type(o) == "string" and resolvevararg("Tab", o, ...)) or o or {}
					local flag = o.Flag or unnamed("unnamedpersistence", "Persistence")
					local nameBox = sectionFunctions:AddTextbox({Name = "Config Name", Flag = "__Mobile.ConfigName." .. flag, Placeholder = "name"})
					local configList = sectionFunctions:AddDropdown({Name = "Configs", Flag = "__Mobile.ConfigList." .. flag, List = function()
						return listConfigs()
					end, Nothing = "None", Callback = function(v) if v and v ~= "None" then nameBox:RawSet(v) end end})
					local infoLabel = nil
					local function currentName()
						local n = library_flags["__Mobile.ConfigName." .. flag]
						if type(n) ~= "string" or #sanitizeConfigName(n) == 0 then n = library_flags["__Mobile.ConfigList." .. flag] end
						if n == "None" then return nil end
						return n
					end
					local function refreshInfo()
						if infoLabel then infoLabel:Set("Autoload: " .. tostring(readAutoload() or "none")) end
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
						SaveFile = function(a, b) return saveConfig(pickArg(element, a, b) or currentName()) end,
						LoadFile = function(a, b) return loadConfig(pickArg(element, a, b) or currentName()) end,
						Update = refreshInfo
					}
					elements[flag] = element
					return element
				end
				for alias, target in next, {
					AddColorPicker = "AddColorpicker", AddDropDown = "AddDropdown", AddTextBox = "AddTextbox", Bind = "AddKeybind", Box = "AddTextbox", Button = "AddButton", CP = "AddColorpicker", ColorPicker = "AddColorpicker", Colorpicker = "AddColorpicker", Cp = "AddColorpicker", CreateButton = "AddButton", CreateColorPicker = "AddColorpicker", CreateColorpicker = "AddColorpicker", CreateDropdown = "AddDropdown", CreateKeybind = "AddKeybind", CreateLabel = "AddLabel", CreatePersistence = "AddPersistence", CreateSaveLoad = "AddPersistence", CreateSearchBox = "AddSearchBox", CreateSearchbox = "AddSearchBox", CreateSlider = "AddSlider", CreateTextBox = "AddTextbox", CreateTextbox = "AddTextbox", CreateToggle = "AddToggle", DD = "AddDropdown", Dd = "AddDropdown", DropDown = "AddDropdown", Dropdown = "AddDropdown", Keybind = "AddKeybind", Label = "AddLabel", NewButton = "AddButton", NewColorPicker = "AddColorpicker", NewColorpicker = "AddColorpicker", NewDropDown = "AddDropdown", NewDropdown = "AddDropdown", NewKeybind = "AddKeybind", NewLabel = "AddLabel", NewPersistence = "AddPersistence", NewSearchBox = "AddSearchBox", NewSearchbox = "AddSearchBox", NewSlider = "AddSlider", NewTextBox = "AddTextbox", NewTextbox = "AddTextbox", NewToggle = "AddToggle", NumberConstraint = "AddSlider", Persistence = "AddPersistence", SBox = "AddSearchBox", SL = "AddPersistence", SaveLoad = "AddPersistence", Sbox = "AddSearchBox", SearchBox = "AddSearchBox", Searchbox = "AddSearchBox", Slide = "AddSlider", Slider = "AddSlider", Text = "AddLabel", TextBox = "AddTextbox", Textbox = "AddTextbox", Tog = "AddToggle", Toggle = "AddToggle"
				} do
					sectionFunctions[alias] = sectionFunctions[target]
				end
				return sectionFunctions
			end
			tabFunctions.AddSection, tabFunctions.NewSection, tabFunctions.Section, tabFunctions.Sec, tabFunctions.S = tabFunctions.CreateSection, tabFunctions.CreateSection, tabFunctions.CreateSection, tabFunctions.CreateSection, tabFunctions.CreateSection
			function tabFunctions:UpdateAll() for _, element in next, tabFunctions.Flags do if type(element) == "table" and element.Update then pcall(element.Update) end end end
			return tabFunctions
		end
		windowFunctions.AddTab, windowFunctions.NewTab, windowFunctions.Tab, windowFunctions.T = windowFunctions.CreateTab, windowFunctions.CreateTab, windowFunctions.CreateTab, windowFunctions.CreateTab
		function windowFunctions:CreateDesigner(designerOptions)
			designerOptions = (type(designerOptions) == "table" and designerOptions) or {}
			if library.MobileDesigner then return library.MobileDesigner end
			local settingsTab = windowFunctions:CreateTab({Name = designerOptions.Name or "Settings", LastTab = true})
			library.MobileDesigner = settingsTab
			local function mark(t) pcall(DebugLog.Mark, DebugLog, "Settings: " .. t) task.wait(0.2) end
			mark("Config-Section")
			local configSection = settingsTab:CreateSection({Name = "Config"})
			if hasFiles then
				mark("Persistence")
				configSection:AddPersistence({Flag = "__Mobile.Config"})
			else
				configSection:AddLabel({Text = "Your executor cannot save files."})
			end
			local infoSection = settingsTab:CreateSection({Name = "More Info"})
			infoSection:AddLabel({Text = "\u{A9} 2026 D3v1lHub | All rights reserved"}) infoSection:AddButton({Name = "View Terms Of Use", Callback = function() library:ShowTerms() end})
			local unloadSection = settingsTab:CreateSection({Name = "Menu"})
			unloadSection:AddButton({Name = "Unload", Confirm = true, Tooltip = "Closes the menu and unloads everything.", Callback = function()
				local terminate = library.__MobileTerminate
				if terminate then task.defer(terminate) end
			end})
			mark("fertig")
			return settingsTab
		end
		windowFunctions.AddDesigner, windowFunctions.NewDesigner, windowFunctions.Designer, windowFunctions.D = windowFunctions.CreateDesigner, windowFunctions.CreateDesigner, windowFunctions.CreateDesigner, windowFunctions.CreateDesigner
		local themeable = options.Themeable or options.DefaultTheme or options.Theme
		task.spawn(function()
			local function countElements()
				local c = 0
				for _ in next, elements do c = c + 1 end
				return c
			end
			local started = os.clock()
			local lastCount, stableSince = countElements(), os.clock()
			while os.clock() - started < 15 do
				task.wait(0.25)
				if terminated or not library.IsGuiValid() then return end
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
				if not ok then warn("[Mobile] Could not create Settings tab:", err) end
			end
			local autoName = readAutoload()
			if autoName then
				pcall(DebugLog.Mark, DebugLog, "Mobile-Autoload: " .. autoName)
				local ok, info = loadConfig(autoName)
				if ok then notify("Autoload: " .. autoName, "success") else warn("[Mobile] Autoload failed:", info) end
			end
			pcall(DebugLog.Mark, DebugLog, "Mobile GUI complete (" .. tostring(countElements()) .. " elements)")
		end)
		pcall(DebugLog.Mark, DebugLog, "Mobile-GUI: CreateWindow fertig")
		pace(99)
		return windowFunctions
	end
end
function library:CreateWindow(options, ...)
	options = (options and type(options) == "string" and resolvevararg("Window", options, ...)) or options or {}
	return MobileUI.CreateWindow(options)
end
library.NewWindow, library.AddWindow, library.Window, library.W = library.CreateWindow, library.CreateWindow, library.CreateWindow, library.CreateWindow
pcall(DebugLog.Mark, DebugLog, "Library loaded")
return library, library_flags, library.subs
