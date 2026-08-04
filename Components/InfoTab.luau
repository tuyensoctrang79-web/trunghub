return function(Window)
    local LatestChangelog = {
        "11/7/2026",
        "<font color='rgb(0, 255, 0)'>+ Added Entity ESP Selection</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Item Notifier</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Remove Surge</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Death Farm</font>",
        "<font color='rgb(0, 255, 0)'>+ Fixed Some Broken Features (Bypass Eyes, etc)</font>",
    }

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

    local LocalPlayer = Services.Players.LocalPlayer
    local InfoTab = Window:AddTab("Info", "user")

    local User = InfoTab:AddLeftGroupbox("User Info")

    local ImageSize = Enum.ThumbnailSize.Size420x420
    local ImageType = Enum.ThumbnailType.HeadShot

    local Content = Services.Players:GetUserThumbnailAsync(LocalPlayer.UserId, ImageType, ImageSize)

    User:AddImage("UserIcon", {
        Image = Content
    })

    User:AddLabel("ID: " .. LocalPlayer.Name, true)
    User:AddLabel("Total Executions: " .. (TrungHub.TotalExecutions and TrungHub.TotalExecutions or "N/A"), true)

    local Changelog = InfoTab:AddRightGroupbox("Changelog")
    for Index, Change in pairs(LatestChangelog) do
        Changelog:AddLabel(Change, true)
    end

    local Name, Version = "Unknown", "N/A"
    if TrungHub.Environment and TrungHub.Environment.identifyexecutor then
        Name, Version = TrungHub.Environment.identifyexecutor()
    end

    local Executor = InfoTab:AddRightGroupbox("Executor Info")
    Executor:AddLabel("Name: " .. tostring(Name), true)
    Executor:AddLabel("Version: " .. tostring(Version and Version or "N/A"), true)
    Executor:AddDivider()
    Executor:AddLabel("Test Result: ", true)

    if TrungHub.Environment and TrungHub.Environment.Results then
        for Index, Result in pairs(TrungHub.Environment.Results) do
            Result = Result:gsub("<", "(")
            Result = Result:gsub(">", ")")
            Executor:AddLabel(Result, true)
        end
    end

    local Community = InfoTab:AddLeftGroupbox("Community")
    Community:AddButton("Copy Discord Invite", function()
        -- Bạn có thể đổi link Discord này thành link Discord server của bạn
        if setclipboard or toclipboard then
            (setclipboard or toclipboard)("https://discord.gg/YOUR_DISCORD_INVITE")
            Library:Notify("Discord invite copied.")
        else
            Library:Notify("Clipboard function not supported.")
        end
    end)
end
