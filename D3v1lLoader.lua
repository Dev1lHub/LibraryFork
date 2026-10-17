--[[
	D3v1lHub Loader (D3v1lLoader.lua)
	Das Erste, was erscheint: dein Loader (Yes/No, HWID, Asset-Bild, Ladebalken).
	Er erkennt dabei, worauf gespielt wird, und lädt NUR die passende GUI-Datei:
	  PC / Laptop      -> PCGUILib.lua
	  Handy / Tablet   -> MobileGUILib.lua
	Danach gibt er die Library an dein Script zurück und es geht ganz normal weiter.

	Benutzung im Script (wie bisher, nur dieser Link):
	  local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/D3v1lLoader.lua"))()
	  library:ShowLoadingScreen({ OnAccept = function() ... end, OnDecline = function() ... end })
	  -> OnAccept läuft sofort (der Loader wurde ja schon angezeigt), bei "No" läuft OnDecline.

	Optional VOR dem Laden setzen:
	  getgenv().D3v1lHubMobileMode = true / false      -- Gerät erzwingen (zum Testen)
	  getgenv().D3v1lLoaderOptions = { TitlePart1 = "...", ConfirmText = "...", ShowHWID = false, ... }
]]

-- >>> Links zu deinen Dateien auf GitHub <<<
local BASE_URL = "https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/"
local PC_URL = BASE_URL .. "PCGUILib.lua"
local MOBILE_URL = BASE_URL .. "MobileGUILib.lua"

local playersservice = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LP = playersservice.LocalPlayer
local genv = (typeof(getgenv) == "function" and getgenv()) or {}

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

-- Farben/Parent wie in der Library (Standard-Theme)
local library = {
	colors = {
		main = Color3.fromRGB(168, 85, 247),
		topGradient = Color3.fromRGB(28, 24, 38),
		bottomGradient = Color3.fromRGB(20, 17, 27)
	},
	gui_parent = (function()
		local ok, coreGui = pcall(function()
			return game:GetService("CoreGui")
		end)
		if ok and coreGui then
			return coreGui
		end
		return LP:WaitForChild("PlayerGui")
	end)()
}
local library_flags = {}

-- ============================================================
-- Geräte-Erkennung
-- ============================================================
local function readInput(prop)
	local ok, value = pcall(function()
		return UserInputService[prop]
	end)
	return ok and value == true
end
local function DetectMobile()
	-- Manuelle Überschreibung hat Vorrang
	if genv.D3v1lHubMobileMode ~= nil then
		return genv.D3v1lHubMobileMode == true
	end
	local touchEnabled = readInput("TouchEnabled")
	local mouseEnabled = readInput("MouseEnabled")
	local keyboardEnabled = readInput("KeyboardEnabled")
	-- 1) Plattform direkt abfragen (funktioniert auch im Emulator)
	local okPlat, platform = pcall(function()
		return UserInputService:GetPlatform()
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

-- ============================================================
-- Dein Loader (1:1 aus der Library)
-- ============================================================
function library:ShowLoadingScreen(options)
	options = options or {}
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

	-- Erkanntes Gerät (vom Loader übergeben): "Detected device: Mobile" / "Detected device: PC"
	if options.DeviceText then
		local DeviceLabel = Instance.new("TextLabel")
		DeviceLabel.Name = generateRandomName()
		DeviceLabel.BackgroundTransparency = 1
		DeviceLabel.Position = UDim2.new(0, 20, 0, 112)
		DeviceLabel.Size = UDim2.new(1, -40, 0, 20)
		DeviceLabel.Font = Enum.Font.Code
		DeviceLabel.TextColor3 = Color3.fromRGB(150, 140, 170)
		DeviceLabel.TextSize = 13
		DeviceLabel.RichText = true
		DeviceLabel.TextXAlignment = Enum.TextXAlignment.Center
		DeviceLabel.ZIndex = 303
		DeviceLabel.Text = 'Detected device: <font color="rgb(' .. math.floor(MainColor.R * 255) .. ',' .. math.floor(MainColor.G * 255) .. ',' .. math.floor(MainColor.B * 255) .. ')">' .. tostring(options.DeviceText) .. '</font>'
		DeviceLabel.Parent = InnerFrame
		addTextStroke(DeviceLabel)
	end

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
			-- (Loader) warten, bis die passende GUI-Datei (PC/Mobile) fertig geladen ist
			if options.WaitUntil then
				options.WaitUntil(LoadSub)
			end

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

	-- Nur EINE Entscheidung zählen (Doppeltipp auf dem Handy startet sonst alles zweimal)
	local promptDecided = false
	YesBtn.MouseButton1Click:Connect(function()
		if promptDecided then
			return
		end
		promptDecided = true
		if options.OnYes then
			task.spawn(options.OnYes)
		end
		startLoadingSequence()
	end)

	NoBtn.MouseButton1Click:Connect(function()
		if promptDecided then
			return
		end
		promptDecided = true
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

-- ============================================================
-- Ablauf: Loader zeigen -> passende GUI-Datei laden -> Library zurückgeben
-- ============================================================
local isMobile = false
do
	local ok, result = pcall(DetectMobile)
	isMobile = (ok and result == true) and true or false
end

-- Download startet sofort im Hintergrund, während das Yes/No-Fenster offen ist
local source, downloadError, downloadDone = nil, nil, false
local function download(url)
	local ok, res = pcall(function()
		return game:HttpGet(url)
	end)
	if ok and type(res) == "string" and #res > 100 then
		return res
	end
	return nil, "Download fehlgeschlagen (" .. url .. "): " .. tostring(res)
end
task.spawn(function()
	source, downloadError = download(isMobile and MOBILE_URL or PC_URL)
	if not source and not isMobile then
		-- PC-Version nicht erreichbar -> Mobile-Version als Notlösung (läuft auch am PC)
		warn("[D3v1lHub Loader] " .. tostring(downloadError) .. " -> versuche Mobile-Version")
		source, downloadError = download(MOBILE_URL)
		if source then
			isMobile = true
		end
	end
	downloadDone = true
end)

-- Library ausführen (erst nach "Yes", damit bei "No" nichts gestartet wird)
local loadedLibrary, loadedFlags, loadedSubs, loadError = nil, nil, nil, nil
local libraryDone = false
local function runLibrary()
	while not downloadDone do
		task.wait(0.05)
	end
	if not source then
		loadError = downloadError
	else
		local chunk, compileError = loadstring(source)
		if not chunk then
			loadError = "Datei fehlerhaft: " .. tostring(compileError)
		else
			local okRun, lib, flags, subs = pcall(chunk)
			if not okRun then
				loadError = "Fehler beim Starten: " .. tostring(lib)
			elseif type(lib) ~= "table" then
				loadError = "Datei hat keine Library zurückgegeben"
			else
				loadedLibrary, loadedFlags, loadedSubs = lib, flags, subs
			end
		end
	end
	source = nil
	libraryDone = true
end

local decision = nil -- true = Yes, false = No
local loaderOptions = {}
if type(genv.D3v1lLoaderOptions) == "table" then
	for k, v in pairs(genv.D3v1lLoaderOptions) do
		loaderOptions[k] = v
	end
end
loaderOptions.DeviceText = isMobile and "Mobile" or "PC"
loaderOptions.OnYes = function()
	task.spawn(runLibrary)
end
loaderOptions.WaitUntil = function(statusLabel)
	while not libraryDone do
		task.wait(0.05)
	end
	if loadError and statusLabel then
		statusLabel.Text = "Loading failed - check the console (F9)."
	end
end
loaderOptions.OnAccept = function()
	decision = true
end
loaderOptions.OnDecline = function()
	decision = false
end
library:ShowLoadingScreen(loaderOptions)

-- warten, bis Yes (und Laden fertig) oder No gedrückt wurde
while decision == nil do
	task.wait(0.05)
end

if decision == false then
	-- "No": nichts wird geladen/erstellt. Das Script bekommt ein leeres Platzhalter-Objekt,
	-- dessen ShowLoadingScreen direkt OnDecline aufruft; alles andere tut nichts.
	local stub = {}
	local function noop()
		return stub
	end
	stub.flags = {}
	stub.Flags = stub.flags
	stub.subs = setmetatable({Wait = task.wait, wait = task.wait}, {__index = function()
		return noop
	end})
	stub.ShowLoadingScreen = function(self, options)
		if options == nil and type(self) == "table" and self ~= stub then
			options = self
		end
		if type(options) == "table" and type(options.OnDecline) == "function" then
			task.spawn(options.OnDecline)
		end
		return nil
	end
	setmetatable(stub, {__index = function()
		return noop
	end})
	return stub, stub.flags, stub.subs
end

if not loadedLibrary then
	error("[D3v1lHub Loader] Library konnte nicht geladen werden: " .. tostring(loadError), 0)
end

-- Der Loader wurde schon angezeigt -> ShowLoadingScreen im Script startet direkt OnAccept
local function passThroughLoadingScreen(self, options)
	if options == nil and type(self) == "table" and self ~= loadedLibrary then
		options = self
	end
	options = options or {}
	local onAccept = options.OnAccept or options.Callback
	if type(onAccept) == "function" then
		task.spawn(onAccept)
	end
	return nil
end
loadedLibrary.ShowLoadingScreen = passThroughLoadingScreen
if type(loadedLibrary.subs) == "table" then
	loadedLibrary.subs.ShowLoadingScreen = passThroughLoadingScreen
end
loadedLibrary.IsMobile = isMobile
loadedLibrary.LoadedVersion = isMobile and "Mobile" or "PC"
return loadedLibrary, loadedFlags, loadedSubs
