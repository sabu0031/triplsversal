local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()

local placeId = tostring(game.PlaceId)

local Window = Luna:CreateWindow({
	Name = "Triplversal",
	Subtitle = "Game ID: " .. placeId,
	LogoID = nil,
	LoadingEnabled = true,
	LoadingTitle = "Triplsversal",
	LoadingSubtitle = "by Sortworks Suite",

	ConfigSettings = {
		RootFolder = "LunaUniversal",
		ConfigFolder = placeId
	},

	KeySystem = false,
	KeySettings = {
		Title = "Luna Universal Key",
		Subtitle = "HWID Protected Key",
		Note = "Use Pelican or Luarmor for secure keys",
		SaveInRoot = false,
		SaveKey = true,
		Key = {"ExampleKey"},
		SecondAction = {
			Enabled = true,
			Type = "Link",
			Parameter = "https://yourkeysystem.com"
		}
	}
})

local Tab = Window:CreateTab({
	Name = "Tab Example",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})

Tab:CreateSection("Section Example")
