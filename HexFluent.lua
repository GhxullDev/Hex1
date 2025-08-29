local Fluent = loadstring(Game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua", true))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
    
    local Window = Fluent:CreateWindow({
        Title = "♻ Hex Hub | Cool Rarities 🍀 " .. Fluent.Version,
        SubTitle = "By Ghxull",
        Icon = "rbxassetid://124019644799794", -- The icon of the window, can be a URL or an asset ID
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
    })
    
    local Tabs = {
        Infos = Window:AddTab({ Title = "Infos", Icon = "book" }),
        LocalPlayer = Window:AddTab({ Title = "LocalPlayer", Icon = "user" }),
        Autofarm = Window:AddTab({ Title = "Autofarm", Icon = "clover" }),
        Teleport = Window:AddTab({ Title = "Teleport", Icon = "plane"}),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    }
    
    local Options = Fluent.Options
    
    do
        Fluent:Notify({
            Title = "Remember",
            Content = "Don't close the interface.",
            Duration = 3 -- Set to nil to make the notification not disappear
        })
    
        Tabs.Infos:AddParagraph({
            Title = "Infos about the script",
            Content = "The script was made by Ghxull. \nIt's a only Cool Rarities Script, have a nice play using the script."
        })
    
        Tabs.LocalPlayer:AddParagraph({
            Title = "LocalPlayer Tab",
            Content = "This is the Local Player tab of the script. \nHere you will find cool features about the game, in a specific way, all about Local Player."
        })
    
        Tabs.Autofarm:AddParagraph({
            Title = "Autofarm Tab",
            Content = "This is the Autofarm tab of the script. \nHere you will find cool features about the game, in a more spcific way, all about autofarms."
        })
    
        Tabs.Teleport:AddParagraph({
            Title = "Teleport Tab",
            Content = "This is the Teleport tab of the script. \nHere you will find cool features about the game, in a more specific way, all about teleport."
        })
    
        local Section = Tabs.LocalPlayer:AddSection("LocalPlayer","settings")

        local Slider = Tabs.LocalPlayer:AddSlider("Walkspeed", {
            Title = "Walkspeed",
            Description = "Change your Walkspeed",
            Default = 16,
            Min = 1,
            Max = 100,
            Rounding = 1,
            Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
            end
        })

        local Slider = Tabs.LocalPlayer:AddSlider("JumpPower", {
            Title = "JumpPower",
            Description = "Change your JumpPower",
            Default = 50,
            Min = 0,
            Max = 250,
            Rounding = 1,
            Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
            end
        })

        local Toggle = Tabs.LocalPlayer:AddToggle("NoClip", {Title = "NoClip", Default = false })
    
            Toggle:OnChanged(function()
                game.Players.LocalPlayer.Character.Humanoid.CanCollide = false
        end)
    
        Options.MyToggle:SetValue(false)
    

        local Toggle = Tabs.LocalPlayer:AddToggle("InfJump", {Title = "InfJump", Default = false })
    
            Toggle:OnChanged(function(Value)
                if Value then
                    game:GetService("UserInputService").JumpRequest:connect(function()
                        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                    end)
                end
        end)


        Options.MyToggle:SetValue(false)


        local Toggle = Tabs.LocalPlayer:AddToggle("Fly", {Title = "Fly", Default = false })
    
            Toggle:OnChanged(function(Value)
                if Value then
                    local T = game.Players.LocalPlayer.Character.HumanoidRootPart
                    local CONTROL = {F = 0, B = 0, L = 0, R = 0}
                    local SPEED = 50
                    
                    function FLY()
                        local BG = Instance.new('BodyGyro', T)
                        local BV = Instance.new('BodyVelocity', T)
                        BG.P = 9e4
                        BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                        BG.cframe = T.CFrame
                        BV.velocity = Vector3.new(0, 0, 0)
                        BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
                        repeat wait()
                            T.CFrame = T.CFrame * CFrame.new(0, 0, (CONTROL.F + CONTROL.B) * SPEED / 10) * CFrame.Angles(0, math.rad((CONTROL.L + CONTROL.R) * SPEED), 0)
                            if CONTROL.F + CONTROL.B ~= 0 or CONTROL.L + CONTROL.R ~= 0 then
                                BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * .2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                            else
                                BV.velocity = Vector3.new(0, 0, 0)
                            end
                            BG.cframe = workspace.CurrentCamera.CoordinateFrame
                        until not Value
                        CONTROL = {F = 0, B = 0, L = 0, R = 0}
                        SPEED = 50
                        BG:Destroy()
                        BV:Destroy()
                    end
                    
                    FLY()
                    
                    game:GetService('UserInputService').InputBegan:Connect(function(KEY)
                        if KEY.KeyCode == Enum.KeyCode.W then
                            CONTROL.F = 1
                        elseif KEY.KeyCode == Enum.KeyCode.S then
                            CONTROL.B = -1
                        elseif KEY.KeyCode == Enum.KeyCode.A then
                            CONTROL.L = -1
                        elseif KEY.KeyCode == Enum.KeyCode.D then
                            CONTROL.R = 1 
                        end
                    end)
                end
            end)

        Options.MyToggle:SetValue(false)



        local Section = Tabs.Autofarm:AddSection("Autofarm","code-xml")

        Tabs.Autofarm:AddButton({
            Title = "CollectChest",
            Description = "It collect every chest of the game",
            Callback = function()
                local player = game.Players.LocalPlayer
                local chestFolder = workspace:FindFirstChild("Chests")
                if chestFolder then
                    for _, chest in ipairs(chestFolder:GetChildren()) do
                        if chest:IsA("BasePart") then
                            firetouchinterest(player.Character.HumanoidRootPart, chest, 0)
                            firetouchinterest(player.Character.HumanoidRootPart, chest, 1)
                        end
                    end
                end
            end
        })

    local Section = Tabs.Teleport:AddSection("Teleport","plane")
        
    
        local Dropdown = Tabs.Teleport:AddDropdown("Dropdown", {
            Title = "Teleport to Zone",
            Values = {"CloverRune", "RollRarity", "CloverUpg", "BaseLuckZone2", "Prestige Rune", "BaseLuck Rune"},
            Multi = false,
            Default = nil,
        })
    
        Dropdown:OnChanged(function(Value)
            print("Dropdown changed:", Value)
        end)
    
    
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("FluentScriptHub")
    SaveManager:SetFolder("FluentScriptHub/specific-game")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)
    Window:SelectTab(1)
    Fluent:Notify({
        Title = "Hex Hub",
        Content = "The script has been loaded correctly.",
        Duration = 5
    })
    SaveManager:LoadAutoloadConfig()

end
