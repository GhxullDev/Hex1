local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local targetGameId = 13020029200

if game.PlaceId ~= targetGameId then
    return
end

local Window = Rayfield:CreateWindow({
    Name = "♻️ Hex Hub | Cool Rarities 🍀",
    LoadingTitle = "Loading the Hub",
    LoadingSubtitle = "by Ghxull",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "RayfieldConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelol",
        RememberJoins = true
    }
})

-- Create Tab
local MainTab = Window:CreateTab("Main", 4483362458) -- Tab ID is optional

-- Create Section 1
local Section1 = MainTab:CreateSection("Section 1")

-- Buttons in Section 1 with workspace.clova:GetChildren() functionality
Section1:CreateButton({
    Name = "Touch Clova Objects",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Workspace = game:GetService("Workspace")
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local clovaChildren = Workspace.clova:GetChildren()
            for _, object in pairs(clovaChildren) do
                if object:IsA("BasePart") then
                    firetouchinterest(Player.Character.HumanoidRootPart, object, 0)
                end
            end
            print("Touched all clova objects!")
        end
    end,
})

Section1:CreateButton({
    Name = "Check Clova Count",
    Callback = function()
        local Workspace = game:GetService("Workspace")
        local clovaCount = #Workspace.clova:GetChildren()
        print("Number of objects in clova: " .. clovaCount)
    end,
})

-- Create Section 2
local Section2 = MainTab:CreateSection("Section 2")

-- Buttons in Section 2 with workspace.clova:GetChildren() functionality
Section2:CreateButton({
    Name = "Clear Clova Touch",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Workspace = game:GetService("Workspace")
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local clovaChildren = Workspace.clova:GetChildren()
            for _, object in pairs(clovaChildren) do
                if object:IsA("BasePart") then
                    firetouchinterest(Player.Character.HumanoidRootPart, object, 1) -- Release touch
                end
            end
            print("Cleared touch from clova objects!")
        end
    end,
})

Section2:CreateButton({
    Name = "List Clova Names",
    Callback = function()
        local Workspace = game:GetService("Workspace")
        local clovaChildren = Workspace.clova:GetChildren()
        for _, object in pairs(clovaChildren) do
            print("Object name: " .. object.Name)
        end
    end,
})
