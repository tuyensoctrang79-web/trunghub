local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local function GetNotificationGui()
    local GUI = CoreGui:FindFirstChild("TrungHub_Notification")
    if not GUI then
        GUI = Instance.new("ScreenGui")
        GUI.Name = "TrungHub_Notification"
        GUI.Parent = CoreGui
        GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        GUI.ResetOnSpawn = false

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Name = "UIListLayout"
        UIListLayout.Parent = GUI
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    end
    return GUI
end

local Notification = {}

function Notification:Notify(nofdebug, middledebug, all)
    nofdebug = nofdebug or {}
    middledebug = middledebug or {}
    all = all or {}

    local GUI = GetNotificationGui()
    local SelectedType = string.lower(tostring(middledebug.Type or "default"))
    local NotificationTime = middledebug.Time or 5

    local ambientShadow = Instance.new("ImageLabel")
    local Window = Instance.new("Frame")
    local Outline_A = Instance.new("Frame")
    local WindowTitle = Instance.new("TextLabel")
    local WindowDescription = Instance.new("TextLabel")

    ambientShadow.Name = "ambientShadow"
    ambientShadow.Parent = GUI
    ambientShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    ambientShadow.BackgroundTransparency = 1.000
    ambientShadow.BorderSizePixel = 0
    ambientShadow.Position = UDim2.new(0.915, 0, 0.936, 0)
    ambientShadow.Size = UDim2.new(0, 0, 0, 0)
    ambientShadow.Image = "rbxassetid://1316045217"
    ambientShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    ambientShadow.ImageTransparency = 0.400
    ambientShadow.ScaleType = Enum.ScaleType.Slice
    ambientShadow.SliceCenter = Rect.new(10, 10, 118, 118)

    Window.Name = "Window"
    Window.Parent = ambientShadow
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 5, 0, 5)
    Window.Size = UDim2.new(0, 230, 0, 80)
    Window.ZIndex = 2

    Outline_A.Name = "Outline_A"
    Outline_A.Parent = Window
    Outline_A.BackgroundColor3 = middledebug.OutlineColor or Color3.fromRGB(0, 170, 255)
    Outline_A.BorderSizePixel = 0
    Outline_A.Position = UDim2.new(0, 0, 0, 25)
    Outline_A.Size = UDim2.new(0, 230, 0, 2)
    Outline_A.ZIndex = 5

    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WindowTitle.BackgroundTransparency = 1.000
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 8, 0, 2)
    WindowTitle.Size = UDim2.new(0, 222, 0, 22)
    WindowTitle.ZIndex = 4
    WindowTitle.Font = Enum.Font.GothamSemibold
    WindowTitle.Text = nofdebug.Title or "Trung Hub"
    WindowTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
    WindowTitle.TextSize = 12.000
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left

    WindowDescription.Name = "WindowDescription"
    WindowDescription.Parent = Window
    WindowDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WindowDescription.BackgroundTransparency = 1.000
    WindowDescription.BorderSizePixel = 0
    WindowDescription.Position = UDim2.new(0, 8, 0, 34)
    WindowDescription.Size = UDim2.new(0, 216, 0, 40)
    WindowDescription.ZIndex = 4
    WindowDescription.Font = Enum.Font.GothamSemibold
    WindowDescription.Text = nofdebug.Description or ""
    WindowDescription.TextColor3 = Color3.fromRGB(180, 180, 180)
    WindowDescription.TextSize = 12.000
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top

    -- Logic xử lý thông báo
    task.spawn(function()
        if SelectedType == "default" then
            ambientShadow:TweenSize(UDim2.new(0, 240, 0, 90), "Out", "Linear", 0.2)
            Window.Size = UDim2.new(0, 230, 0, 80)
            
            if typeof(NotificationTime) == "Instance" then
                NotificationTime.Destroying:Wait()
            else
                Outline_A:TweenSize(UDim2.new(0, 0, 0, 2), "Out", "Linear", NotificationTime)
                task.wait(NotificationTime)
            end

            ambientShadow:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Linear", 0.2)
            task.wait(0.2)
            ambientShadow:Destroy()

        elseif SelectedType == "image" then
            ambientShadow:TweenSize(UDim2.new(0, 240, 0, 90), "Out", "Linear", 0.2)
            Window.Size = UDim2.new(0, 230, 0, 80)
            WindowTitle.Position = UDim2.new(0, 24, 0, 2)

            local ImageButton = Instance.new("ImageButton")
            ImageButton.Parent = Window
            ImageButton.BackgroundTransparency = 1.000
            ImageButton.BorderSizePixel = 0
            ImageButton.Position = UDim2.new(0, 4, 0, 4)
            ImageButton.Size = UDim2.new(0, 18, 0, 18)
            ImageButton.ZIndex = 5
            ImageButton.AutoButtonColor = false
            ImageButton.Image = all.Image or ""
            ImageButton.ImageColor3 = all.ImageColor or Color3.fromRGB(255, 255, 255)

            if typeof(NotificationTime) == "Instance" then
                NotificationTime.Destroying:Wait()
            else
                Outline_A:TweenSize(UDim2.new(0, 0, 0, 2), "Out", "Linear", NotificationTime)
                task.wait(NotificationTime)
            end

            ambientShadow:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Linear", 0.2)
            task.wait(0.2)
            ambientShadow:Destroy()

        elseif SelectedType == "option" then
            ambientShadow:TweenSize(UDim2.new(0, 240, 0, 110), "Out", "Linear", 0.2)
            Window.Size = UDim2.new(0, 230, 0, 100)

            local Uncheck = Instance.new("ImageButton")
            local Check = Instance.new("ImageButton")

            Uncheck.Name = "Uncheck"
            Uncheck.Parent = Window
            Uncheck.BackgroundTransparency = 1.000
            Uncheck.BorderSizePixel = 0
            Uncheck.Position = UDim2.new(0, 7, 0, 76)
            Uncheck.Size = UDim2.new(0, 18, 0, 18)
            Uncheck.ZIndex = 5
            Uncheck.AutoButtonColor = false
            Uncheck.Image = "rbxassetid://6031094678"
            Uncheck.ImageColor3 = Color3.fromRGB(255, 84, 84)

            Check.Name = "Check"
            Check.Parent = Window
            Check.BackgroundTransparency = 1.000
            Check.BorderSizePixel = 0
            Check.Position = UDim2.new(0, 28, 0, 76)
            Check.Size = UDim2.new(0, 18, 0, 18)
            Check.ZIndex = 5
            Check.AutoButtonColor = false
            Check.Image = "rbxassetid://6031094667"
            Check.ImageColor3 = Color3.fromRGB(83, 230, 50)

            local StillThere = true

            local function CloseNotification(result)
                if not StillThere then return end
                StillThere = false
                if typeof(all.Callback) == "function" then
                    pcall(all.Callback, result)
                end
                ambientShadow:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Linear", 0.2)
                task.wait(0.2)
                ambientShadow:Destroy()
            end

            Uncheck.MouseButton1Click:Connect(function()
                CloseNotification(false)
            end)

            Check.MouseButton1Click:Connect(function()
                CloseNotification(true)
            end)

            Outline_A:TweenSize(UDim2.new(0, 0, 0, 2), "Out", "Linear", NotificationTime)
            task.wait(NotificationTime)

            if StillThere then
                CloseNotification(false)
            end
        end
    end)
end

return Notification
