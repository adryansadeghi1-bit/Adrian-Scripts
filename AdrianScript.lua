--========================================================
-- ADR MOBILE ALL-IN-ONE
-- Roblox Studio / LocalScript
-- StarterPlayer > StarterPlayerScripts
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--========================================================
-- SETTINGS
--========================================================

local Settings = {
	-- AIMBOT
	AimbotEnabled = false,
	AimbotWallCheck = true,
	AimbotFOV = 140,
	AimbotBodyFollow = true,
	TeamCheck = true,

	-- MOVEMENT
	Noclip = false,
	JumpBoost = false,
	JumpPower = 90,
	Speed = false,
	WalkSpeed = 40,
	Fly = false,
	FlySpeed = 55,

	-- ESP
	ESPName = false,
	ESPDistance = false,
	ESPHighlight = false,
	ESPTracer = false
}

--========================================================
-- CHARACTER
--========================================================

local Character = nil
local Humanoid = nil
local RootPart = nil

local function GetCamera()
	return Workspace.CurrentCamera
end

local function SetupCharacter(Char)
	Character = Char

	Humanoid = Char:WaitForChild("Humanoid")
	RootPart = Char:WaitForChild("HumanoidRootPart")

	Humanoid.UseJumpPower = true

	if Settings.JumpBoost then
		Humanoid.JumpPower = Settings.JumpPower
	else
		Humanoid.JumpPower = 50
	end

	if Settings.Speed then
		Humanoid.WalkSpeed = Settings.WalkSpeed
	else
		Humanoid.WalkSpeed = 16
	end
end

if LocalPlayer.Character then
	SetupCharacter(LocalPlayer.Character)
end

--========================================================
-- CLEAN OLD GUI
--========================================================

local OldGui = PlayerGui:FindFirstChild("ADR_MobilePanel")

if OldGui then
	OldGui:Destroy()
end

--========================================================
-- SCREEN GUI
--========================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ADR_MobilePanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = PlayerGui

--========================================================
-- MAIN PANEL
--========================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(250, 510)
Main.Position = UDim2.new(0.5, -125, 0.5, -255)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(85, 85, 85)
MainStroke.Thickness = 1
MainStroke.Parent = Main

--========================================================
-- TOP BAR
--========================================================

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 44)
TopBar.BackgroundTransparency = 1
TopBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -55, 1, 0)
Title.Position = UDim2.fromOffset(12, 0)
Title.BackgroundTransparency = 1
Title.Text = "ADR MOBILE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.fromOffset(36, 30)
CloseButton.Position = UDim2.new(1, -42, 0, 7)
CloseButton.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

--========================================================
-- CONTENT
--========================================================

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -12, 1, -52)
Content.Position = UDim2.fromOffset(6, 48)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 6)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Content

--========================================================
-- BUTTON CREATOR
--========================================================

local function MakeButton(Text)
	local Button = Instance.new("TextButton")

	Button.Size = UDim2.new(1, -10, 0, 36)
	Button.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	Button.BorderSizePixel = 0
	Button.Text = Text
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.TextSize = 11
	Button.Font = Enum.Font.GothamSemibold
	Button.AutoButtonColor = true
	Button.Parent = Content

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 9)
	Corner.Parent = Button

	return Button
end

local function SetToggle(Button, Name, State)
	if State then
		Button.Text = Name .. " : ON"
		Button.BackgroundColor3 = Color3.fromRGB(55, 90, 65)
	else
		Button.Text = Name .. " : OFF"
		Button.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	end
end

--========================================================
-- AIMBOT BUTTONS
--========================================================

local AimbotWallButton =
	MakeButton("Aimbot With Wall Check : OFF")

local AimbotNoWallButton =
	MakeButton("Aimbot Without Wall Check : OFF")

local TeamCheckButton =
	MakeButton("Team Check : ON")

local BodyFollowButton =
	MakeButton("Body Follow : ON")

local FOVPlusButton =
	MakeButton("AIM FOV +")

local FOVMinusButton =
	MakeButton("AIM FOV -")

--========================================================
-- ESP BUTTONS
--========================================================

local NameButton =
	MakeButton("ESP Name : OFF")

local DistanceButton =
	MakeButton("ESP Distance : OFF")

local HighlightButton =
	MakeButton("ESP Highlight : OFF")

local TracerButton =
	MakeButton("ESP Tracer : OFF")

--========================================================
-- MOVEMENT BUTTONS
--========================================================

local SpeedButton =
	MakeButton("Speed : OFF")

local SpeedPlusButton =
	MakeButton("Speed +  |  40")

local SpeedMinusButton =
	MakeButton("Speed -  |  40")

local FlyButton =
	MakeButton("Fly : OFF")

--========================================================
-- X UNDER FLY
--========================================================

local PanelCloseButton =
	MakeButton("X")

PanelCloseButton.BackgroundColor3 =
	Color3.fromRGB(48, 48, 48)

PanelCloseButton.TextColor3 =
	Color3.fromRGB(255, 255, 255)

PanelCloseButton.TextSize = 17
PanelCloseButton.Font = Enum.Font.GothamBold

--========================================================
-- FLY SPEED
--========================================================

local FlySpeedPlusButton =
	MakeButton("Fly Speed +  |  55")

local FlySpeedMinusButton =
	MakeButton("Fly Speed -  |  55")

local NoclipButton =
	MakeButton("Noclip : OFF")

local JumpButton =
	MakeButton("Jump Boost : OFF")

--========================================================
-- FOV CIRCLE
--========================================================

local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "AimbotFOV"
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.fromScale(0.5, 0.5)
FOVCircle.Size = UDim2.fromOffset(
	Settings.AimbotFOV * 2,
	Settings.AimbotFOV * 2
)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false
FOVCircle.ZIndex = 100
FOVCircle.Parent = ScreenGui

local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(1, 0)
FOVCorner.Parent = FOVCircle

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Color = Color3.fromRGB(255, 255, 255)
FOVStroke.Thickness = 2
FOVStroke.Parent = FOVCircle

--========================================================
-- SMALL ADR BUTTON
--========================================================

local Floating = Instance.new("TextButton")

Floating.Name = "ADR_Floating"
Floating.Size = UDim2.fromOffset(54, 54)
Floating.Position = UDim2.new(0, 15, 0.5, -27)

Floating.BackgroundColor3 =
	Color3.fromRGB(255, 255, 255)

Floating.BorderSizePixel = 0

Floating.Text = "adr"

Floating.TextColor3 =
	Color3.fromRGB(0, 0, 0)

Floating.TextSize = 14

Floating.Font =
	Enum.Font.Fondamento

Floating.AutoButtonColor = false
Floating.Visible = false
Floating.ZIndex = 150
Floating.Parent = ScreenGui

local FloatingCorner =
	Instance.new("UICorner")

FloatingCorner.CornerRadius =
	UDim.new(1, 0)

FloatingCorner.Parent =
	Floating

local FloatingStroke =
	Instance.new("UIStroke")

FloatingStroke.Color =
	Color3.fromRGB(0, 0, 0)

FloatingStroke.Thickness = 1

FloatingStroke.Parent =
	Floating

--========================================================
-- FLY BUTTONS
--========================================================

local FlyUpButton =
	Instance.new("TextButton")

FlyUpButton.Name = "FlyUp"
FlyUpButton.Size = UDim2.fromOffset(50, 50)
FlyUpButton.Position =
	UDim2.new(1, -70, 0.5, -135)

FlyUpButton.BackgroundColor3 =
	Color3.fromRGB(20, 20, 20)

FlyUpButton.BorderSizePixel = 0
FlyUpButton.Text = "▲"

FlyUpButton.TextColor3 =
	Color3.fromRGB(255, 255, 255)

FlyUpButton.TextSize = 22
FlyUpButton.Font = Enum.Font.GothamBold
FlyUpButton.Visible = false
FlyUpButton.ZIndex = 160
FlyUpButton.Parent = ScreenGui

local FlyUpCorner =
	Instance.new("UICorner")

FlyUpCorner.CornerRadius =
	UDim.new(1, 0)

FlyUpCorner.Parent =
	FlyUpButton

local FlyDownButton =
	Instance.new("TextButton")

FlyDownButton.Name = "FlyDown"
FlyDownButton.Size = UDim2.fromOffset(50, 50)

FlyDownButton.Position =
	UDim2.new(1, -70, 0.5, -75)

FlyDownButton.BackgroundColor3 =
	Color3.fromRGB(20, 20, 20)

FlyDownButton.BorderSizePixel = 0
FlyDownButton.Text = "▼"

FlyDownButton.TextColor3 =
	Color3.fromRGB(255, 255, 255)

FlyDownButton.TextSize = 22
FlyDownButton.Font = Enum.Font.GothamBold
FlyDownButton.Visible = false
FlyDownButton.ZIndex = 160
FlyDownButton.Parent = ScreenGui

local FlyDownCorner =
	Instance.new("UICorner")

FlyDownCorner.CornerRadius =
	UDim.new(1, 0)

FlyDownCorner.Parent =
	FlyDownButton

--========================================================
-- FLY VERTICAL
--========================================================

local FlyVertical = 0

local function HoldFlyButton(Button, Value)

	Button.InputBegan:Connect(function(Input)

		if Input.UserInputType ==
			Enum.UserInputType.Touch
			or Input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			FlyVertical = Value
		end
	end)

	Button.InputEnded:Connect(function(Input)

		if Input.UserInputType ==
			Enum.UserInputType.Touch
			or Input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			if FlyVertical == Value then
				FlyVertical = 0
			end
		end
	end)
end

HoldFlyButton(FlyUpButton, 1)
HoldFlyButton(FlyDownButton, -1)

--========================================================
-- DRAG
--========================================================

local Dragging = false
local DragInput = nil
local DragStart = nil
local StartPosition = nil

TopBar.InputBegan:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or Input.UserInputType ==
		Enum.UserInputType.Touch then

		Dragging = true
		DragInput = Input
		DragStart = Input.Position
		StartPosition = Main.Position
	end
end)

TopBar.InputChanged:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseMovement
		or Input.UserInputType ==
		Enum.UserInputType.Touch then

		DragInput = Input
	end
end)

UserInputService.InputChanged:Connect(function(Input)

	if Dragging
		and Input == DragInput
		and DragStart
		and StartPosition then

		local Delta =
			Input.Position - DragStart

		Main.Position =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
	end
end)

UserInputService.InputEnded:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or Input.UserInputType ==
		Enum.UserInputType.Touch then

		Dragging = false
	end
end)

--========================================================
-- OPEN / CLOSE
--========================================================

local function ClosePanel()

	Main.Visible = false
	Floating.Visible = true

end

local function OpenPanel()

	Main.Visible = true
	Floating.Visible = false

end

CloseButton.MouseButton1Click:Connect(ClosePanel)

PanelCloseButton.MouseButton1Click:Connect(ClosePanel)

Floating.MouseButton1Click:Connect(OpenPanel)

--========================================================
-- SPEED
--========================================================

local function ApplySpeed()

	if not Humanoid then
		return
	end

	if Settings.Speed then
		Humanoid.WalkSpeed =
			Settings.WalkSpeed
	else
		Humanoid.WalkSpeed = 16
	end
end

local function UpdateSpeedTexts()

	SpeedPlusButton.Text =
		"Speed +  |  " ..
		tostring(Settings.WalkSpeed)

	SpeedMinusButton.Text =
		"Speed -  |  " ..
		tostring(Settings.WalkSpeed)

end

UpdateSpeedTexts()

--========================================================
-- NOCLIP
--========================================================

local NoclipCache = {}

local function ApplyNoclip()

	if not Character then
		return
	end

	for _, Object in ipairs(
		Character:GetDescendants()
	) do

		if Object:IsA("BasePart") then

			if NoclipCache[Object] == nil then
				NoclipCache[Object] =
					Object.CanCollide
			end

			Object.CanCollide = false
		end
	end
end

local function RemoveNoclip()

	for Object, OriginalValue in pairs(
		NoclipCache
	) do

		if Object
			and Object.Parent then

			Object.CanCollide =
				OriginalValue
		end
	end

	table.clear(NoclipCache)
end

--========================================================
-- FLY
--========================================================

local FlyVelocity = nil
local FlyGyro = nil

local function StopFly()

	if FlyVelocity then
		FlyVelocity:Destroy()
		FlyVelocity = nil
	end

	if FlyGyro then
		FlyGyro:Destroy()
		FlyGyro = nil
	end

	FlyVertical = 0

	FlyUpButton.Visible = false
	FlyDownButton.Visible = false

	if Humanoid then
		Humanoid.AutoRotate = true
		Humanoid.PlatformStand = false
	end
end

local function StartFly()

	if not RootPart
		or not Humanoid then
		return
	end

	StopFly()

	FlyVelocity =
		Instance.new("BodyVelocity")

	FlyVelocity.Name =
		"ADR_FlyVelocity"

	FlyVelocity.MaxForce =
		Vector3.new(
			math.huge,
			math.huge,
			math.huge
		)

	FlyVelocity.P = 10000
	FlyVelocity.Velocity = Vector3.zero
	FlyVelocity.Parent = RootPart

	FlyGyro =
		Instance.new("BodyGyro")

	FlyGyro.Name =
		"ADR_FlyGyro"

	FlyGyro.MaxTorque =
		Vector3.new(
			math.huge,
			math.huge,
			math.huge
		)

	FlyGyro.P = 10000
	FlyGyro.CFrame =
		RootPart.CFrame

	FlyGyro.Parent = RootPart

	Humanoid.AutoRotate = false

	FlyUpButton.Visible = true
	FlyDownButton.Visible = true
end

local function UpdateFly()

	if not Settings.Fly then
		return
	end

	if not RootPart
		or not Humanoid then
		return
	end

	if not FlyVelocity
		or not FlyGyro then
		StartFly()
	end

	if not FlyVelocity
		or not FlyGyro then
		return
	end

	local Camera =
		GetCamera()

	if not Camera then
		return
	end

	local MoveDirection =
		Humanoid.MoveDirection

	local CameraForward =
		Vector3.new(
			Camera.CFrame.LookVector.X,
			0,
			Camera.CFrame.LookVector.Z
		)

	local CameraRight =
		Vector3.new(
			Camera.CFrame.RightVector.X,
			0,
			Camera.CFrame.RightVector.Z
		)

	if CameraForward.Magnitude > 0 then
		CameraForward =
			CameraForward.Unit
	end

	if CameraRight.Magnitude > 0 then
		CameraRight =
			CameraRight.Unit
	end

	local ForwardAmount =
		MoveDirection:Dot(CameraForward)

	local RightAmount =
		MoveDirection:Dot(CameraRight)

	local Horizontal =
		(CameraForward * ForwardAmount)
		+
		(CameraRight * RightAmount)

	if Horizontal.Magnitude > 1 then
		Horizontal =
			Horizontal.Unit
	end

	local Vertical =
		Vector3.new(
			0,
			FlyVertical,
			0
		)

	FlyVelocity.Velocity =
		(
			Horizontal *
			Settings.FlySpeed
		)
		+
		(
			Vertical *
			Settings.FlySpeed
		)

	local LookVector =
		Camera.CFrame.LookVector

	if LookVector.Magnitude > 0.001 then

		FlyGyro.CFrame =
			CFrame.lookAt(
				RootPart.Position,
				RootPart.Position + LookVector
			)
	end
end

--========================================================
-- TEAM CHECK
--========================================================

local function IsSameTeam(Player)

	if Player == LocalPlayer then
		return true
	end

	if not Settings.TeamCheck then
		return false
	end

	if LocalPlayer.Team ~= nil
		and Player.Team ~= nil then

		return LocalPlayer.Team ==
			Player.Team
	end

	return false
end

local function IsValidEnemy(Player)

	if not Player
		or Player == LocalPlayer then

		return false
	end

	if IsSameTeam(Player) then
		return false
	end

	return true
end

--========================================================
-- TARGET DATA
--========================================================

local function GetTargetData(Player)

	if not Player then
		return nil
	end

	local Char =
		Player.Character

	if not Char then
		return nil
	end

	local Hum =
		Char:FindFirstChildOfClass(
			"Humanoid"
		)

	local Head =
		Char:FindFirstChild("Head")

	local HRP =
		Char:FindFirstChild(
			"HumanoidRootPart"
		)

	if not Hum
		or Hum.Health <= 0
		or not Head
		or not HRP then

		return nil
	end

	return Char, Head, HRP, Hum
end

--========================================================
-- WALL CHECK
--========================================================

local function CanSeeTarget(
	TargetCharacter,
	TargetHead
)

	if not Settings.AimbotWallCheck then
		return true
	end

	local Camera =
		GetCamera()

	if not Camera then
		return false
	end

	local Origin =
		Camera.CFrame.Position

	local Direction =
		TargetHead.Position - Origin

	if Direction.Magnitude <= 0.001 then
		return true
	end

	local RayParams =
		RaycastParams.new()

	RayParams.FilterType =
		Enum.RaycastFilterType.Exclude

	local IgnoreList = {}

	if Character then
		table.insert(
			IgnoreList,
			Character
		)
	end

	table.insert(
		IgnoreList,
		Camera
	)

	RayParams.FilterDescendantsInstances =
		IgnoreList

	RayParams.IgnoreWater = true

	local Result =
		Workspace:Raycast(
			Origin,
			Direction,
			RayParams
		)

	if not Result then
		return true
	end

	return Result.Instance:IsDescendantOf(
		TargetCharacter
	)
end

--========================================================
-- GET NEAREST TARGET
--========================================================

local function GetNearestTarget()

	local Camera =
		GetCamera()

	if not Camera
		or not RootPart then
		return nil
	end

	local Viewport =
		Camera.ViewportSize

	local Center =
		Vector2.new(
			Viewport.X / 2,
			Viewport.Y / 2
		)

	local BestPlayer = nil
	local BestWorldDistance = math.huge

	for _, Player in ipairs(
		Players:GetPlayers()
	) do

		if IsValidEnemy(Player) then

			local TargetCharacter,
				TargetHead,
				TargetHRP =
				GetTargetData(Player)

			if TargetCharacter
				and TargetHead
				and TargetHRP then

				local ScreenPosition,
					OnScreen =
					Camera:WorldToViewportPoint(
						TargetHead.Position
					)

				if OnScreen
					and ScreenPosition.Z > 0 then

					local ScreenPoint =
						Vector2.new(
							ScreenPosition.X,
							ScreenPosition.Y
						)

          
