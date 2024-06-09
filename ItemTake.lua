-- Clone item from others
-- Credits to Awes955

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- Create GUI
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local textBox = Instance.new("TextBox")
local button = Instance.new("TextButton")
local minimizeButton = Instance.new("TextButton")

-- GUI properties
screenGui.Name = "ItemGrabberGUI"
screenGui.Parent = game.CoreGui

frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 150, 0, 80)
frame.Position = UDim2.new(0.5, -75, 0.5, -40)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

textBox.Name = "TextBox"
textBox.Size = UDim2.new(1, -10, 0, 30)
textBox.Position = UDim2.new(0, 5, 0, 5)
textBox.PlaceholderText = "Enter Player Name"
textBox.Parent = frame

button.Name = "GetItemButton"
button.Size = UDim2.new(1, -10, 0, 30)
button.Position = UDim2.new(0, 5, 0, 40)
button.Text = "Get Items"
button.Parent = frame

minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 20, 0, 20)
minimizeButton.Position = UDim2.new(1, -25, 0, 5)
minimizeButton.Text = "-"
minimizeButton.Parent = frame

-- Function to handle button click
button.MouseButton1Click:Connect(function()
    local input = textBox.Text:lower()
    local targetPlayer

    -- Find player by display name or shortened name
    for _, player in pairs(Players:GetPlayers()) do
        if player.DisplayName:lower():sub(1, #input) == input then
            targetPlayer = player
            break
        end
    end

    if targetPlayer then
        local player = Players.LocalPlayer
        local targetBackpack = targetPlayer:FindFirstChild("Backpack")

        if targetBackpack then
            for _, item in pairs(targetBackpack:GetChildren()) do
                local clone = item:Clone()
                clone.Parent = player.Backpack
            end
            warn("Items successfully copied.")
        else
            warn("Target player has no backpack.")
        end
    else
        warn("Player not found.")
    end
end)

-- Minimize functionality
local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        frame.Size = UDim2.new(0, 150, 0, 30)
        button.Visible = false
        textBox.Visible = false
    else
        frame.Size = UDim2.new(0, 150, 0, 80)
        button.Visible = true
        textBox.Visible = true
    end
end)
