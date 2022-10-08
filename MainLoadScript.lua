if shared.Matrix then
    return
    error("Matrix is executed!")
else
    shared.Matrix = true
end
local LibraryUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/codernocook/MatrixClient-Roblox-/main/LibraryUI"))()
local uis = game:GetService("UserInputService")

local library = LibraryUI.CreateLib("Matrix", "no")

local MovementTab = library:NewTab("Movement")
local PlayerTab = library:NewTab("Player")
local RenderTab = library:NewTab("Render")
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded

local flyloop = nil
local userinputget1 = nil
local userinputget2 = nil

MovementTab:NewToggle("Fly", "There nothing", function(state)
    if state then
            local floatName = "Fly"
            local Tpwalkspeed = 50
            local Float = Instance.new("Part", plr.Character)
            Float.Name = floatName
            Float.Transparency = 1
            Float.Size = Vector3.new(2,0.2,1.5)
            Float.Anchored = true
            local FloatValue = -3.1
            local BodyVelocityValue = 0
            Float.CFrame = getRoot(plr.Character).CFrame * CFrame.new(0, FloatValue, 0)
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.Parent = getRoot(plr.Character)
            BodyVelocity.MaxForce = Vector3.new(500, 500, 500)
            BodyVelocity.Name = "Body"
            flyloop = game:GetService("RunService").Heartbeat:Connect(function()
                if Float then
                    Float.CFrame = getRoot(plr.Character).CFrame * CFrame.new(0, FloatValue, 0)
                    BodyVelocity.Velocity = Vector3.new(plr.Character:FindFirstChild("Humanoid").MoveDirection.X * 1000, 0, plr.Character:FindFirstChild("Humanoid").MoveDirection.Z * 1000)
                else
                    if plr.Character and getRoot(plr.Character) then
                        local Float1 = Instance.new("Part", plr.Character)
                        Float1.Name = floatName
                        Float1.Transparency = 1
                        Float1.Size = Vector3.new(2,0.2,1.5)
                        Float1.Anchored = true
                        local FloatValue = -3.1
                        Float1.CFrame = getRoot(plr.Character).CFrame * CFrame.new(0, FloatValue, 0)
                    end
                end
            end)
                task.spawn(function()
                        userinputget1 = uis.InputBegan:Connect(function(key)
                            if state == true then
                                if key.KeyCode == Enum.KeyCode.LeftShift then
                                    FloatValue -= 0.5
                                    BodyVelocityValue -= 1
                                end
                            end
                        end)

                        userinputget2 = uis.InputEnded:Connect(function(key)
                            if state == true then
                                if key.KeyCode == Enum.KeyCode.LeftShift then
                                    FloatValue += 0.5
                                    BodyVelocityValue += 1
                                end
                            end
                        end)
                end)
    else
        if plr.Character:FindFirstChild("Fly") then
            plr.Character:FindFirstChild("Fly"):Destroy()
        end

        if flyloop then
            flyloop:Disconnect()
        end
        if userinputget1 then
            userinputget1:Disconnect()
        end

        if userinputget2 then
            userinputget2:Disconnect()
        end
    end
end)

local callbackspeed = 0
local speedconnection = nil

local speed = MovementTab:NewToggle("Speed", "There nothing", function(state)
    local plr = game:GetService("Players").LocalPlayer
    local char = plr.Character or plr.CharacterAdded
    if state then
        if char and char:FindFirstChildWhichIsA("Humanoid") then
            speedconnection = game:GetService("RunService").Heartbeat:Connect(function()
                char:FindFirstChildWhichIsA("Humanoid").WalkSpeed = callbackspeed
            end)
        end
    else
        if char and char:FindFirstChildWhichIsA("Humanoid") then
            char:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
            if speedconnection then
                speedconnection:Disconnect()
            end
        end
    end
end)

speed:NewDropDown("Speed", 0, 100, 0, function(callback)
    if callback then
        callbackspeed = tonumber(callback)
    end
end)
--
PlayerTab:NewToggle("Backtrack", "There nothing", function(state)
    if state then
        settings():GetService("NetworkSettings").IncomingReplicationLag = 10
    else
        settings():GetService("NetworkSettings").IncomingReplicationLag = 0
    end
end)
--

local EspConnection = nil

RenderTab:NewToggle("Esp", "There nothing", function(state)
    if state then
        EspConnection = game:GetService("RunService").Heartbeat:Connect(function()
            for allplrscount, allplrs in pairs(game:GetService("Players"):GetPlayers()) do
                if allplrs.Character and allplrs ~= game:GetService("Players").LocalPlayer then
                    if not allplrs.Character:FindFirstChild("EspPart") then
                        local EspPart = Instance.new("Part")
                        local Highlight = Instance.new("Highlight")
        
                        EspPart.Name = "EspPart"
                        EspPart.Transparency = 0
                        EspPart.BrickColor = BrickColor.new(tostring(allplrs.TeamColor))
                        EspPart.Size = Vector3.new(3, 5, 3)
                        EspPart.Parent = allplrs.Character
                        if allplrs.Character:FindFirstChild("HumanoidRootPart") then
                            EspPart.CFrame = allplrs.Character:FindFirstChild("HumanoidRootPart").CFrame
                        else
                            EspPart.CFrame = allplrs.Character:GetPivot()
                        end
                        EspPart.Anchored = true
                        EspPart.CanCollide = false
        
                        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        Highlight.FillColor = EspPart.Color
                        Highlight.FillTransparency = 0.5
                        Highlight.Parent = EspPart
                    else
                        local EspPart = allplrs.Character:FindFirstChild("EspPart")
                        local Highlight = EspPart:FindFirstChild("Highlight")
                        EspPart.Size = Vector3.new(3, 5, 3)
                        if allplrs.Character:FindFirstChild("HumanoidRootPart") then
                            EspPart.CFrame = allplrs.Character:FindFirstChild("HumanoidRootPart").CFrame
                        else
                            EspPart.CFrame = allplrs.Character:GetPivot()
                        end
                        EspPart.BrickColor = BrickColor.new(tostring(allplrs.TeamColor))
                        Highlight.FillColor = EspPart.Color
                    end
                end
            end
        end)
    else
        if EspConnection then
            EspConnection:Disconnect()
        end
    end
end)

RenderTab:NewToggle("LineEsp", "There nothing", function(state)
    if state then
        for allplrcount, allplrget in pairs(game:GetService("Players"):GetPlayers()) do
            if allplrget.Character and getRoot(allplrget.Character) and allplrget ~= plr then
                local vector, onscreen = Camera:WorldToScreenPoint(getRoot(allplrget.Character).Position)
                local drawline = Drawing.new("Line")
                drawline.Color = Color3.fromRGB(60, 200, 255)
                drawline.Thickness = 3
                drawline.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                drawline.To = Vector2.new(vector.X, vector.Y)
                drawline.Visible = true
                drawline.Transparency = 0
                local function runlinesp()
                    game:GetService("RunService").RenderStepped:Connect(function()
                        if allplrget.Character and getRoot(allplrget.Character) and allplrget ~= plr and onscreen == true then
                            if onscreen then
                                drawline.To = Vector2.new(vector.X, vector.Y)
                                drawline.Visible = true
                            else
                                drawline.Visible = false --hide when not looking
                            end
                        end
                    end)
                end
                coroutine.wrap(runlinesp)()
            end
            game:GetService("Players").PlayerAdded:Connect(function(plraddedline)
                plraddedline.CharacterAdded:Connect(function(charaddedline)
                    repeat task.wait() until plraddedline.Character ~= nil
                    repeat task.wait() until getRoot(plraddedline.Character)
                    if charaddedline and getRoot(charaddedline) and plraddedline ~= plr then
                        local vector, onscreen = Camera:WorldToScreenPoint(getRoot(charaddedline).Position)
                        local drawline = Drawing.new("Line")
                        drawline.Color = Color3.fromRGB(60, 200, 255)
                        drawline.Thickness = 3
                        drawline.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                        drawline.To = Vector2.new(vector.X, vector.Y)
                        drawline.Visible = true
                        drawline.Transparency = 0
                        local function runlinesp()
                            game:GetService("RunService").RenderStepped:Connect(function(step)
                                if plraddedline.Character and getRoot(charaddedline) and plraddedline ~= plr and onscreen == true then
                                    drawline.To = Vector2.new(vector.X, vector.Y)
                                end
                            end)
                        end
                        coroutine.wrap(runlinesp)()
                    end
                end)
            end)
        end
    else
        settings():GetService("NetworkSettings").IncomingReplicationLag = 0
    end
end)

uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        if library:GetWindowsToggle() == false then
            library:WindowsToggle(true)
        elseif library:GetWindowsToggle() == true then
            library:WindowsToggle(false)
        end
    end
end)
