local BASE_URL = "https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/"
local PC_URL = BASE_URL .. "PCGUILib.lua"
local MOBILE_URL = BASE_URL .. "MobileGUILib.lua"

local playersservice = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
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
		if gui.Parent then
			return true
		end
	end
	pcall(function()
		gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 5)
	end)
	return gui.Parent ~= nil
end

local library = {
	colors = {
		main = Color3.fromRGB(128, 0, 255),
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

local function readInput(prop)
	local ok, value = pcall(function()
		return UserInputService[prop]
	end)
	return ok and value == true
end
local function DetectMobile()

	if genv.D3v1lHubMobileMode ~= nil then
		return genv.D3v1lHubMobileMode == true
	end
	local touchEnabled = readInput("TouchEnabled")
	local mouseEnabled = readInput("MouseEnabled")
	local keyboardEnabled = readInput("KeyboardEnabled")

	local okPlat, platform = pcall(function()
		return UserInputService:GetPlatform()
	end)
	if okPlat and platform then
		if platform == Enum.Platform.Android or platform == Enum.Platform.IOS then
			return true
		end
		if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX
			or platform == Enum.Platform.Linux or platform == Enum.Platform.UWP then

			return touchEnabled and not mouseEnabled
		end
	end

	if touchEnabled and not keyboardEnabled then
		return true
	end
	return touchEnabled and not mouseEnabled
end

local function startAmbience()
	local amb = {Stop = function() end}
	pcall(function()
		local gui = Instance.new("ScreenGui")
		gui.Name = generateRandomName()
		gui.IgnoreGuiInset = true
		gui.DisplayOrder = 0
		gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		gui.ResetOnSpawn = false
		if not protectAndParentGui(gui, library.gui_parent) then
			gui.Parent = library.gui_parent
		end
		local dim = Instance.new("Frame")
		dim.Name = generateRandomName()
		dim.BackgroundColor3 = Color3.fromRGB(4, 3, 10)
		dim.BackgroundTransparency = 1
		dim.BorderSizePixel = 0
		dim.Size = UDim2.new(1, 0, 1, 0)
		dim.Active = true
		dim.Parent = gui
		tweenService:Create(dim, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.22}):Play()
		local edges = {}
		for _, edge in ipairs({{UDim2.new(1, 0, 0.3, 0), UDim2.new(0, 0, 0, 0), 90}, {UDim2.new(1, 0, 0.3, 0), UDim2.new(0, 0, 0.7, 0), -90}, {UDim2.new(0.22, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0}, {UDim2.new(0.22, 0, 1, 0), UDim2.new(0.78, 0, 0, 0), 180}}) do
			local shade = Instance.new("Frame")
			shade.Name = generateRandomName()
			shade.BackgroundColor3 = dim.BackgroundColor3
			shade.BorderSizePixel = 0
			shade.Size, shade.Position = edge[1], edge[2]
			local fade = Instance.new("UIGradient")
			fade.Rotation = edge[3]
			fade.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1)})
			fade.Parent = shade
			shade.Parent = gui
			edges[1 + #edges] = shade
		end
		local rng = (typeof(Random) == "table" or typeof(Random) == "userdata") and Random.new() or {
			NextNumber = function()
				return math.random()
			end,
			NextInteger = function(_, low, high)
				return math.random(low, high)
			end
		}
		local theme = (library.colors and library.colors.main) or Color3.fromRGB(170, 90, 255)
		dim.BackgroundColor3 = theme:Lerp(Color3.new(0, 0, 0), 0.94)
		local layers = {
			{size = {2, 3}, tint = 0.1, alpha = 0.62, speed = 0.55, depth = 0.25, share = 0.4},
			{size = {3, 5}, tint = 0.22, alpha = 0.4, speed = 1, depth = 0.6, share = 0.4},
			{size = {6, 9}, tint = 0.4, alpha = 0.22, speed = 1.7, depth = 1.2, share = 0.2}
		}
		local total = UserInputService.TouchEnabled and 16 or 30
		local flakes = {}
		for _, layer in ipairs(layers) do
			for i = 1, math.max(1, math.floor(total * layer.share + 0.5)) do
				local size = rng:NextInteger(layer.size[1], layer.size[2])
				local frame = Instance.new("Frame")
				frame.Name = generateRandomName()
				frame.BackgroundColor3 = Color3.new(1, 1, 1):Lerp(theme, layer.tint)
				frame.BackgroundTransparency = layer.alpha + rng:NextNumber() * 0.12
				frame.BorderSizePixel = 0
				frame.Size = UDim2.fromOffset(size, size)
				frame.ZIndex = 2
				local round = Instance.new("UICorner")
				round.CornerRadius = UDim.new(1, 0)
				round.Parent = frame
				if layer.depth > 1 then
					local halo = Instance.new("UIStroke")
					halo.Color = theme
					halo.Thickness = 1.5
					halo.Transparency = 0.65
					halo.Parent = frame
				end
				frame.Parent = gui
				flakes[1 + #flakes] = {frame = frame, x = rng:NextNumber(), y = rng:NextNumber() * 720, depth = layer.depth, speed = (28 + size * 9 + rng:NextNumber() * 14) * layer.speed, amp = (rng:NextNumber() * 14 + 5) * layer.depth, freq = rng:NextNumber() * 1.2 + 0.6, phase = rng:NextNumber() * 6.28}
			end
		end
		local clock = 0
		local conn = runService.Heartbeat:Connect(function(dt)
			clock = clock + dt
			local wind = math.sin(clock * 0.35) * 40 + math.sin(clock * 1.3) * 12
			local area = gui.AbsoluteSize
			if area.X < 10 then
				area = Vector2.new(1280, 720)
			end
			for _, flake in ipairs(flakes) do
				flake.y = flake.y + flake.speed * dt
				if flake.y > area.Y + 10 then
					flake.y, flake.x = -10, rng:NextNumber()
				end
				flake.frame.Position = UDim2.fromOffset(flake.x * area.X + math.sin(clock * flake.freq + flake.phase) * flake.amp + wind * flake.depth, flake.y)
			end
		end)
		local stopped = false
		amb.Stop = function()
			if stopped then
				return
			end
			stopped = true
			conn:Disconnect()
			for _, shade in ipairs(edges) do
				pcall(function()
					shade:Destroy()
				end)
			end
			tweenService:Create(dim, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
			for _, flake in ipairs(flakes) do
				tweenService:Create(flake.frame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
			end
			task.delay(0.7, function()
				pcall(function()
					gui:Destroy()
				end)
			end)
		end
	end)
	return amb
end

function library:ShowLoadingScreen(options)
	options = options or {}
	local onAccept = options.OnAccept or options.Callback
	local onDecline = options.OnDecline
	local ambience = startAmbience()
	local rawAccept, rawDecline = onAccept, onDecline
	onAccept = function()
		ambience.Stop()
		if rawAccept then
			rawAccept()
		end
	end
	onDecline = function()
		ambience.Stop()
		if rawDecline then
			rawDecline()
		end
	end
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
	ScreenGui.DisplayOrder = 1
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

	if type(options.ExecutorStatus) == "table" then
		local status = options.ExecutorStatus
		local statusColor = status.Color or Color3.fromRGB(255, 80, 80)
		local ExecLabel = Instance.new("TextLabel")
		ExecLabel.Name = generateRandomName()
		ExecLabel.BackgroundTransparency = 1
		ExecLabel.Position = UDim2.new(0, 20, 0, 134)
		ExecLabel.Size = UDim2.new(1, -40, 0, 20)
		ExecLabel.Font = Enum.Font.Code
		ExecLabel.TextColor3 = Color3.fromRGB(150, 140, 170)
		ExecLabel.TextSize = 13
		ExecLabel.RichText = true
		ExecLabel.TextXAlignment = Enum.TextXAlignment.Center
		ExecLabel.ZIndex = 303
		ExecLabel.Text = 'Executor: <font color="rgb(' .. math.floor(statusColor.R * 255) .. ',' .. math.floor(statusColor.G * 255) .. ',' .. math.floor(statusColor.B * 255) .. ')">' .. tostring(status.Text) .. '</font>'
		ExecLabel.Parent = InnerFrame
		addTextStroke(ExecLabel)

		if status.Note then
			local NoteLabel = Instance.new("TextLabel")
			NoteLabel.Name = generateRandomName()
			NoteLabel.BackgroundTransparency = 1
			NoteLabel.Position = UDim2.new(0, 20, 0, 158)
			NoteLabel.Size = UDim2.new(1, -40, 0, 36)
			NoteLabel.Font = Enum.Font.Code
			NoteLabel.TextColor3 = statusColor
			NoteLabel.TextSize = 12
			NoteLabel.TextWrapped = true
			NoteLabel.TextXAlignment = Enum.TextXAlignment.Center
			NoteLabel.TextYAlignment = Enum.TextYAlignment.Top
			NoteLabel.ZIndex = 303
			NoteLabel.Text = tostring(status.Note)
			NoteLabel.Parent = InnerFrame
			addTextStroke(NoteLabel)
		end
	end

	task.spawn(function()
		local shine = Instance.new("UIGradient")
		shine.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, MainColor),
			ColorSequenceKeypoint.new(0.5, MainColor:Lerp(Color3.new(1, 1, 1), 0.8)),
			ColorSequenceKeypoint.new(1, MainColor)
		})
		shine.Offset = Vector2.new(-1, 0)
		TitlePart2Label.TextColor3 = Color3.new(1, 1, 1)
		shine.Parent = TitlePart2Label
		tweenService:Create(shine, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false, 1.6), {Offset = Vector2.new(1, 0)}):Play()
		local full = SubLabel.Text
		SubLabel.Text = ""
		task.wait(0.35)
		local total = utf8.len(full) or #full
		for i = 1, total do
			if not SubLabel.Parent then
				return
			end
			SubLabel.Text = string.sub(full, 1, (utf8.offset(full, i + 1) or (#full + 1)) - 1)
			task.wait(0.018)
		end
		SubLabel.Text = full
	end)

	local function createButton(text, posX, parent, zb)
		zb = zb or 303
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
		btnOuter.ZIndex = zb
		btnOuter.Parent = parent or InnerFrame

		local btnInner = Instance.new("Frame")
		btnInner.Name = generateRandomName()
		btnInner.BackgroundColor3 = library.colors.topGradient
		btnInner.BorderSizePixel = 0
		btnInner.Position = UDim2.new(0, 1, 0, 1)
		btnInner.Size = UDim2.new(1, -2, 1, -2)
		btnInner.ZIndex = zb + 1
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
		btnText.ZIndex = zb + 2
		btnText.Parent = btnInner
		addTextStroke(btnText)

		local pop = Instance.new("UIScale")
		pop.Scale = 0.6
		pop.Parent = btnOuter
		btnOuter.Visible = false
		task.delay(0.3 + posX / 1500, function()
			btnOuter.Visible = true
			tweenService:Create(pop, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
		end)
		local function ease(scale, textColor, borderColor, dur)
			tweenService:Create(pop, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = scale}):Play()
			tweenService:Create(btnText, TweenInfo.new(dur), {TextColor3 = textColor}):Play()
			tweenService:Create(btnOuter, TweenInfo.new(dur), {BackgroundColor3 = borderColor}):Play()
		end
		local hoverBorder = MainColor:Lerp(Color3.new(1, 1, 1), 0.35)
		btnOuter.MouseEnter:Connect(function()
			ease(1.05, Color3.new(1, 1, 1), hoverBorder, 0.15)
		end)
		btnOuter.MouseLeave:Connect(function()
			ease(1, Color3.fromRGB(200, 190, 220), MainColor, 0.2)
		end)
		btnOuter.MouseButton1Down:Connect(function()
			ease(0.94, Color3.new(1, 1, 1), hoverBorder, 0.08)
			pcall(function()
				local mouse = UserInputService:GetMouseLocation()
				local origin = btnOuter.AbsolutePosition
				local size = btnOuter.AbsoluteSize
				local px = math.clamp(mouse.X - origin.X, 0, size.X)
				local py = math.clamp(mouse.Y - origin.Y, 0, size.Y)
				local ripple = Instance.new("Frame")
				ripple.Name = generateRandomName()
				ripple.AnchorPoint = Vector2.new(0.5, 0.5)
				ripple.BackgroundColor3 = Color3.new(1, 1, 1)
				ripple.BackgroundTransparency = 0.6
				ripple.BorderSizePixel = 0
				ripple.Position = UDim2.fromOffset(px, py)
				ripple.Size = UDim2.fromOffset(0, 0)
				ripple.ZIndex = zb + 3
				local round = Instance.new("UICorner")
				round.CornerRadius = UDim.new(1, 0)
				round.Parent = ripple
				ripple.Parent = btnOuter
				local reach = math.max(size.X, size.Y) * 2.2
				tweenService:Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(reach, reach), BackgroundTransparency = 1}):Play()
				task.delay(0.55, function()
					ripple:Destroy()
				end)
			end)
		end)
		btnOuter.MouseButton1Up:Connect(function()
			ease(1.05, Color3.new(1, 1, 1), hoverBorder, 0.12)
		end)

		return btnOuter
	end

	local YesBtn = createButton("Yes", 20)
	local NoBtn = createButton("No", 187)

	task.spawn(function()
		playSound(openSoundId)
		tweenService:Create(Outer, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 360, 0, 360)}):Play()
		task.wait(0.3)
		local glow = Instance.new("UIStroke")
		glow.Color = MainColor
		glow.Thickness = 1.5
		glow.Transparency = 0.8
		glow.Parent = Outer
		tweenService:Create(glow, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.2}):Play()
		local sweep = Instance.new("UIGradient")
		sweep.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, MainColor),
			ColorSequenceKeypoint.new(0.5, MainColor:Lerp(Color3.new(1, 1, 1), 0.7)),
			ColorSequenceKeypoint.new(1, MainColor)
		})
		sweep.Parent = glow
		tweenService:Create(sweep, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Rotation = 360}):Play()
		task.wait(0.5)
		if Outer.Parent then
			tweenService:Create(Outer, TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Position = UDim2.new(0.5, 0, 0.5, -4)}):Play()
		end
	end)

	local function startLoadingSequence()
		local closeTween = tweenService:Create(Outer, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
		closeTween:Play()
		closeTween.Completed:Wait()
		ScreenGui:Destroy()

		local LoadGui = Instance.new("ScreenGui")
		LoadGui.Name = generateRandomName()
		LoadGui.IgnoreGuiInset = true
		LoadGui.DisplayOrder = 1
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
			addTextStroke(HwidStaticLabel, 1)

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

		local PercentLabel = Instance.new("TextLabel")
		PercentLabel.Name = generateRandomName()
		PercentLabel.BackgroundTransparency = 1
		PercentLabel.AnchorPoint = Vector2.new(1, 0)
		PercentLabel.Position = UDim2.new(1, -15, 0, 84)
		PercentLabel.Size = UDim2.new(0, 50, 0, 14)
		PercentLabel.Font = Enum.Font.Code
		PercentLabel.TextColor3 = Color3.fromRGB(200, 190, 220)
		PercentLabel.TextSize = 11
		PercentLabel.TextXAlignment = Enum.TextXAlignment.Right
		PercentLabel.ZIndex = 303
		PercentLabel.Text = "0%"
		PercentLabel.Parent = LoadInnerFrame

		local BarShine = Instance.new("Frame")
		BarShine.Name = generateRandomName()
		BarShine.BackgroundColor3 = Color3.new(1, 1, 1)
		BarShine.BorderSizePixel = 0
		BarShine.Position = UDim2.new(-0.25, 0, 0, 0)
		BarShine.Size = UDim2.new(0.25, 0, 1, 0)
		BarShine.ZIndex = 305
		BarShine.Parent = BarBg
		local ShineGrad = Instance.new("UIGradient")
		ShineGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.55), NumberSequenceKeypoint.new(1, 1)})
		ShineGrad.Parent = BarShine
		tweenService:Create(BarShine, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {Position = UDim2.new(1, 0, 0, 0)}):Play()

		task.spawn(function()
			local openLoad = tweenService:Create(LoadOuter, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 380, 0, 138)})
			openLoad:Play()
			openLoad.Completed:Wait()

			local success, thumbUrl = pcall(function()
				return playersservice:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)

			local loadTween = tweenService:Create(BarFill, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(1, 0, 1, 0)})
			loadTween:Play()
			local percentConn = runService.Heartbeat:Connect(function()
				local percent = math.floor(BarFill.Size.X.Scale * 100 + 0.5)
				PercentLabel.Text = percent .. "%"
				if not options.LoadingSubText then
					LoadSub.Text = (percent < 35 and "Preparing environment...") or (percent < 75 and "Loading scripts and assets...") or "Almost done..."
				end
			end)
			loadTween.Completed:Wait()
			percentConn:Disconnect()
			PercentLabel.Text = "100%"

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

			PercentLabel:Destroy()
			BarShine:Destroy()
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

			if onAccept then
				task.spawn(onAccept)
			end
		end)
	end

	local promptDecided = false
	local function acceptNow()
		if options.OnYes then
			task.spawn(options.OnYes)
		end
		startLoadingSequence()
	end
	local warningShown = false
	local function showWarning(bodyText, onContinue)
		warningShown = true
		local Overlay = Instance.new("Frame")
		Overlay.Name = generateRandomName()
		Overlay.BackgroundColor3 = Color3.fromRGB(14, 11, 20)
		Overlay.BorderSizePixel = 0
		Overlay.Size = UDim2.new(1, 0, 1, 0)
		Overlay.Active = true
		Overlay.ZIndex = 310
		Overlay.Parent = InnerFrame

		local WarnTitle = Instance.new("TextLabel")
		WarnTitle.Name = generateRandomName()
		WarnTitle.BackgroundTransparency = 1
		WarnTitle.Position = UDim2.new(0, 20, 0, 40)
		WarnTitle.Size = UDim2.new(1, -40, 0, 26)
		WarnTitle.Font = Enum.Font.Code
		WarnTitle.TextColor3 = Color3.fromRGB(255, 190, 70)
		WarnTitle.TextSize = 18
		WarnTitle.Text = "Warning"
		WarnTitle.ZIndex = 311
		WarnTitle.Parent = Overlay
		addTextStroke(WarnTitle)

		local WarnBody = Instance.new("TextLabel")
		WarnBody.Name = generateRandomName()
		WarnBody.BackgroundTransparency = 1
		WarnBody.Position = UDim2.new(0, 20, 0, 80)
		WarnBody.Size = UDim2.new(1, -40, 0, 170)
		WarnBody.Font = Enum.Font.Code
		WarnBody.TextColor3 = Color3.fromRGB(200, 190, 220)
		WarnBody.TextSize = 14
		WarnBody.TextWrapped = true
		WarnBody.TextXAlignment = Enum.TextXAlignment.Left
		WarnBody.TextYAlignment = Enum.TextYAlignment.Top
		WarnBody.ZIndex = 311
		WarnBody.Text = bodyText
		WarnBody.Parent = Overlay
		addTextStroke(WarnBody)

		local ContinueBtn = createButton("Continue", 20, Overlay, 312)
		local CancelBtn = createButton("Cancel", 187, Overlay, 312)
		ContinueBtn.MouseButton1Click:Connect(function()
			if promptDecided then
				return
			end
			Overlay:Destroy()
			warningShown = false
			onContinue()
		end)
		CancelBtn.MouseButton1Click:Connect(function()
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
	end

	YesBtn.MouseButton1Click:Connect(function()
		if promptDecided or warningShown then
			return
		end
		local queue = {}
		if options.MobileWarning then
			queue[1 + #queue] = options.MobileWarningText or "Mobile device detected.\n\nThis script was not really made for mobile. It needs heavy functions that can make the game crash on phones and tablets.\n\nDo you want to continue anyway?"
		end
		if type(options.ExecutorWarningText) == "string" then
			queue[1 + #queue] = options.ExecutorWarningText
		end
		local index = 0
		local function nextStep()
			index = index + 1
			if queue[index] then
				showWarning(queue[index], nextStep)
				return
			end
			promptDecided = true
			acceptNow()
		end
		nextStep()
	end)

	NoBtn.MouseButton1Click:Connect(function()
		if promptDecided or warningShown then
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

local isMobile = false
do
	local ok, result = pcall(DetectMobile)
	isMobile = (ok and result == true) and true or false
end

local source, downloadError, downloadDone = nil, nil, false
local function download(url)
	local ok, res = pcall(function()
		return game:HttpGet(url)
	end)
	if ok and type(res) == "string" and #res > 100 then
		return res
	end
	return nil, "Download failed (" .. url .. "): " .. tostring(res)
end
task.spawn(function()
	source, downloadError = download(isMobile and MOBILE_URL or PC_URL)
	if not source and not isMobile then

		warn("[D3v1lHub Loader] " .. tostring(downloadError) .. " -> trying Mobile version")
		source, downloadError = download(MOBILE_URL)
		if source then
			isMobile = true
		end
	end
	downloadDone = true
end)

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
			loadError = "Invalid file: " .. tostring(compileError)
		else
			local okRun, lib, flags, subs = pcall(chunk)
			if not okRun then
				loadError = "Failed to start: " .. tostring(lib)
			elseif type(lib) ~= "table" then
				loadError = "File did not return a library"
			else
				loadedLibrary, loadedFlags, loadedSubs = lib, flags, subs
			end
		end
	end
	source = nil
	libraryDone = true
end


local ExecutorCheck = {}
do
	local function executorName()
		local name, version = nil, nil
		if typeof(identifyexecutor) == "function" then
			local ok, a, b = pcall(identifyexecutor)
			if ok and a ~= nil then
				name, version = tostring(a), b ~= nil and tostring(b) or nil
			end
		end
		if not name and typeof(getexecutorname) == "function" then
			local ok, a = pcall(getexecutorname)
			if ok and a ~= nil then
				name = tostring(a)
			end
		end
		return name or "Unknown", version
	end

	local function lookup(fnName)
		local value = nil
		pcall(function()
			value = getfenv(0)[fnName]
		end)
		if value == nil and typeof(getgenv) == "function" then
			pcall(function()
				value = getgenv()[fnName]
			end)
		end
		return value
	end

	local function isUsable(fnName)
		for alternative in string.gmatch(fnName, "[^|]+") do
			local value = lookup(alternative)
			if alternative == "Drawing" then
				if type(value) == "table" and type(value.new) == "function" then
					return true
				end
			elseif type(value) == "function" then
				return true
			end
		end
		return false
	end

	ExecutorCheck.LibraryNeeds = {
		{"writefile", "saving configs and the debug log"},
		{"readfile", "loading configs"},
		{"isfile", "config files"},
		{"isfolder", "config folders"},
		{"makefolder", "config folders"},
		{"listfiles", "listing saved configs"},
		{"delfile", "deleting configs"},
		{"gethui", "hidden GUI parent (falls back to CoreGui/PlayerGui)"},
		{"cloneref", "safe service access"},
		{"setclipboard", "copy buttons"},
		{"getcustomasset|getsynasset", "custom background and sounds"},
	}

	function ExecutorCheck.Run(extra, known)
		local name, version = executorName()
		local missing, supported = {}, {}
		local seen = {}
		local function test(fnName, why)
			if seen[fnName] then
				return
			end
			seen[fnName] = true
			if isUsable(fnName) then
				supported[1 + #supported] = fnName
			else
				missing[1 + #missing] = {Name = fnName, Reason = why}
			end
		end
		for _, entry in ipairs(ExecutorCheck.LibraryNeeds) do
			test(entry[1], entry[2])
		end
		if type(extra) == "table" then
			for key, value in pairs(extra) do
				if type(key) == "number" then
					test(tostring(value), "used by this script")
				else
					test(tostring(key), tostring(value))
				end
			end
		end
		local lowered = string.lower(name)
		if type(known) == "table" then
			for executor, list in pairs(known) do
				if string.find(lowered, string.lower(tostring(executor)), 1, true) and type(list) == "table" then
					for _, fnName in ipairs(list) do
						if not seen[fnName .. "#known"] then
							seen[fnName .. "#known"] = true
							missing[1 + #missing] = {Name = tostring(fnName), Reason = "known to be unsupported or buggy on this executor"}
						end
					end
				end
			end
		end
		return {Name = name, Version = version, Missing = missing, Supported = supported}
	end

	ExecutorCheck.StatusList = {
		{"wave", "supported"},
		{"madium", "partial"},
		{"medium", "partial"},
		{"volt", "supported"},
		{"synapse z", "untested"},
		{"synapsez", "untested"},
		{"real", "supported"},
		{"potassium", "supported"},
	}
	ExecutorCheck.Colors = {
		supported = Color3.fromRGB(80, 220, 120),
		partial = Color3.fromRGB(255, 205, 70),
		untested = Color3.fromRGB(255, 80, 80),
	}
	ExecutorCheck.Labels = {
		supported = "Supported",
		partial = "Partially supported",
		untested = "Not tested",
	}

	function ExecutorCheck.Status(result, overrides)
		local lowered = string.lower(result.Name)
		local level = "untested"
		local function scan(list)
			for _, entry in ipairs(list) do
				if string.find(lowered, entry[1], 1, true) then
					level = entry[2]
					return true
				end
			end
			return false
		end
		local found = false
		if type(overrides) == "table" then
			local list = {}
			for key, value in pairs(overrides) do
				list[1 + #list] = {string.lower(tostring(key)), tostring(value)}
			end
			found = scan(list)
		end
		if not found then
			scan(ExecutorCheck.StatusList)
		end
		if not ExecutorCheck.Colors[level] then
			level = "untested"
		end
		local text = result.Name .. (result.Version and (" " .. result.Version) or "") .. " - " .. ExecutorCheck.Labels[level]
		local note = nil
		if level ~= "supported" then
			note = "Some features may not work properly because of the lack of UNC/sUNC."
		end
		return {Level = level, Text = text, Color = ExecutorCheck.Colors[level], Note = note}
	end

	function ExecutorCheck.Text(result)
		if #result.Missing == 0 then
			return nil
		end
		local lines = {"Your executor (" .. result.Name .. (result.Version and (" " .. result.Version) or "") .. ") does not support:"}
		for index, entry in ipairs(result.Missing) do
			if index > 8 then
				lines[1 + #lines] = "... and " .. (#result.Missing - 8) .. " more"
				break
			end
			lines[1 + #lines] = "- " .. entry.Name .. " (" .. entry.Reason .. ")"
		end
		lines[1 + #lines] = ""
		lines[1 + #lines] = "These features may be buggy or not work. Continue anyway?"
		return table.concat(lines, "\n")
	end
end

local decision = nil
local loaderOptions = {}
if type(genv.D3v1lLoaderOptions) == "table" then
	for k, v in pairs(genv.D3v1lLoaderOptions) do
		loaderOptions[k] = v
	end
end
loaderOptions.DeviceText = isMobile and "Mobile" or "PC"
local executorResult = ExecutorCheck.Run(loaderOptions.RequiredFunctions, loaderOptions.KnownUnsupported)
executorResult.Status = ExecutorCheck.Status(executorResult, loaderOptions.ExecutorStatusList)
loaderOptions.ExecutorStatus = executorResult.Status
if loaderOptions.ExecutorWarning ~= false then
	loaderOptions.ExecutorWarningText = loaderOptions.ExecutorWarningText or ExecutorCheck.Text(executorResult)
else
	loaderOptions.ExecutorWarningText = nil
end
if loaderOptions.MobileWarning == nil then
	loaderOptions.MobileWarning = isMobile
end
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

while decision == nil do
	task.wait(0.05)
end

if decision == false then

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
	error("[D3v1lHub Loader] Could not load library: " .. tostring(loadError), 0)
end

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
loadedLibrary.Executor = executorResult
loadedLibrary.CheckExecutor = function(self, list)
	if list == nil and type(self) == "table" and self ~= loadedLibrary then
		list = self
	end
	return ExecutorCheck.Run(list)
end
loadedLibrary.__ld = string.char(unpack({68,51,86,49,76,45,79,87,78,45,50,48,50,54,45,56,70,50,65,45,67,52,49,68,45,76,68}))
loadedLibrary.__ldid = "D3v1lHub​‌​​​‌​​​​‌‌​​‌‌​‌​‌​‌‌​​​‌‌​​​‌​‌​​‌‌​​​​‌​‌‌​‌​‌​​‌‌‌‌​‌​‌​‌‌‌​‌​​‌‌‌​​​‌​‌‌​‌​​‌‌​​‌​​​‌‌​​​​​​‌‌​​‌​​​‌‌​‌‌​​​‌​‌‌​‌​​‌‌‌​​​​‌​​​‌‌​​​‌‌​​‌​​‌​​​​​‌​​‌​‌‌​‌​‌​​​​‌‌​​‌‌​‌​​​​‌‌​​​‌​‌​​​‌​​​​‌​‌‌​‌​‌​​‌‌​​​‌​​​‌​​"
loadedLibrary.IsMobile = isMobile
loadedLibrary.LoadedVersion = isMobile and "Mobile" or "PC"
return loadedLibrary, loadedFlags, loadedSubs
