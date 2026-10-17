--[[
	D3v1lHub Loader
	Erkennt, worauf gespielt wird, und lädt NUR die passende Library:
	  PC / Laptop      -> PCGUILib.lua      (normales PC-Menü + PC-Loader)
	  Handy / Tablet   -> MobileGUILib.lua  (alter Loader + leichtes Mobile-GUI)

	Benutzung im Script (statt der Library direkt):
	  local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/D3v1lLoader.lua"))()

	Gerät erzwingen (VOR dem Laden setzen, z.B. zum Testen):
	  getgenv().D3v1lHubMobileMode = true   -- immer Mobile
	  getgenv().D3v1lHubMobileMode = false  -- immer PC
]]

-- >>> Hier die Links zu deinen Dateien auf GitHub eintragen <<<
local BASE_URL = "https://raw.githubusercontent.com/Dev1lHub/LibraryFork/refs/heads/main/"
local PC_URL = BASE_URL .. "PCGUILib.lua"
local MOBILE_URL = BASE_URL .. "MobileGUILib.lua"

local UserInputService = game:GetService("UserInputService")
local genv = (typeof(getgenv) == "function" and getgenv()) or {}

-- Eigenschaften sicher lesen (manche Executor-Umgebungen werfen hier Fehler)
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

-- Lädt eine Library-Datei und führt sie aus. Gibt (library, flags, subs) oder (nil, Fehlertext) zurück.
local function loadLibrary(url)
	local okGet, source = pcall(function()
		return game:HttpGet(url)
	end)
	if not okGet or type(source) ~= "string" or #source < 100 then
		return nil, "Download fehlgeschlagen (" .. url .. "): " .. tostring(source)
	end
	local chunk, compileError = loadstring(source)
	if not chunk then
		return nil, "Datei fehlerhaft (" .. url .. "): " .. tostring(compileError)
	end
	local okRun, library, flags, subs = pcall(chunk)
	if not okRun then
		return nil, "Fehler beim Starten (" .. url .. "): " .. tostring(library)
	end
	if type(library) ~= "table" then
		return nil, "Datei hat keine Library zurückgegeben (" .. url .. ")"
	end
	return library, flags, subs
end

local isMobile = false
do
	local ok, result = pcall(DetectMobile)
	isMobile = (ok and result == true) and true or false
end

local library, flags, subs = loadLibrary(isMobile and MOBILE_URL or PC_URL)
if not library and not isMobile then
	-- PC-Version nicht erreichbar -> Mobile-Version als Notlösung (läuft auch am PC)
	warn("[D3v1lHub Loader] " .. tostring(flags) .. " -> versuche Mobile-Version")
	library, flags, subs = loadLibrary(MOBILE_URL)
	isMobile = library ~= nil
end
if not library then
	error("[D3v1lHub Loader] Library konnte nicht geladen werden: " .. tostring(flags), 0)
end

library.IsMobile = isMobile
library.LoadedVersion = isMobile and "Mobile" or "PC"
if isMobile then
	-- damit der Loader-Text ("Device: Mobile Detected") auch beim Erzwingen stimmt
	library.MobileMode = true
end
return library, flags, subs
