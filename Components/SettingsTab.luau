return function(Window)
	local function CloneReference(Object)
		if TrungHub and TrungHub.Environment and TrungHub.Environment.cloneref then
			return TrungHub.Environment.cloneref(Object)
		else
			return Object
		end
	end
	
	local Services = setmetatable({}, {
		__index = function(self, Name)
			return CloneReference(game:GetService(Name))
		end
	})

	local Library = TrungHub.Interface.Library
	local SaveManager = TrungHub.Interface.SaveManager
	local ThemeManager = TrungHub.Interface.ThemeManager
	
	local Toggles = Library.Toggles
	local Options = Library.Options
	
	local SettingsTab = Window:AddTab("Settings", "settings")
	local MenuGroup = SettingsTab:AddLeftGroupbox("Menu")
	
	MenuGroup:AddToggle("KeybindMenuOpen", {
		Default = Library.KeybindFrame.Visible,
		Text = "Open Keybind Menu",
		Callback = function(value)
			Library.KeybindFrame.Visible = value
		end,
	})
	
	MenuGroup:AddToggle("ShowCustomCursor", {
		Text = "Custom Cursor",
		Default = false,
		Callback = function(Value)
			Library.ShowCustomCursor = Value
		end,
	})

	MenuGroup:AddDropdown("UILibrary", {
		Text = "UI Style",
		Values = {
			"Obsidian",
			"Linoria"
		},
		Default = (TrungHub.UILibrary == "Linoria" and 2 or 1),
		Callback = function(Value)
			if TrungHub.Environment and TrungHub.Environment.writefile and TrungHub.Environment.readfile then
				if not TrungHub.Environment.isfolder("TrungHub") then
					TrungHub.Environment.makefolder("TrungHub")
				end

				if not TrungHub.Environment.isfile("TrungHub/UserData.json") then
					local Data = {
						TotalExecutions = 0,
						UILibrary = "Obsidian"
					}
					TrungHub.Environment.writefile("TrungHub/UserData.json", Services.HttpService:JSONEncode(Data))
				end

				local UserData = TrungHub.Environment.readfile("TrungHub/UserData.json")
				local Decoded = Services.HttpService:JSONDecode(UserData)
				Decoded.UILibrary = Value

				if not Decoded.UILibrary then
					Decoded.UILibrary = "Obsidian"
				end

				TrungHub.TotalExecutions = Decoded.TotalExecutions
				TrungHub.UILibrary = Decoded.UILibrary

				TrungHub.Environment.writefile("TrungHub/UserData.json", Services.HttpService:JSONEncode(Decoded))
			end
		end
	})
	
	MenuGroup:AddDropdown("DPIDropdown", {
		Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
		Default = "100%",
	
		Text = "DPI Scale",
	
		Callback = function(Value)
			Value = Value:gsub("%%", "")
			local DPI = tonumber(Value)
	
			Library:SetDPIScale(DPI)
		end,
	})
	
	MenuGroup:AddDivider()
	MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
	
	MenuGroup:AddButton("Copy Discord Invite", function()
		if setclipboard or toclipboard then
			(setclipboard or toclipboard)("https://discord.gg/YOUR_DISCORD_INVITE")
			Library:Notify("Discord invite copied.")
		else
			Library:Notify("Clipboard function not supported.")
		end
	end)
	
	MenuGroup:AddButton("Unload", function()
		Library:Unload()
	end)
	
	Library.ToggleKeybind = Options.MenuKeybind
	
	ThemeManager:SetLibrary(Library)
	SaveManager:SetLibrary(Library)
	SaveManager:IgnoreThemeSettings()
	SaveManager:SetIgnoreIndexes({"UILibrary"})
	
	-- Thiết lập thư mục lưu Config & Theme riêng cho Trung Hub
	ThemeManager:SetFolder("TrungHub")
	SaveManager:SetFolder("TrungHub/" .. (TrungHub.SavePath or "Default"))
	
	SaveManager:BuildConfigSection(SettingsTab)
	ThemeManager:ApplyToTab(SettingsTab)
	SaveManager:LoadAutoloadConfig()
end
