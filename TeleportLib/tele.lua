local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotShanks/backups/main/TeleportLib/noti.lua"))()
local TweenService = game:GetService("TweenService")
local Teleport = {}
Teleport.TweenAnim = nil
Teleport.TweenAnimFinished = true
Teleport.Style = {
	Linear = 1,
	Instant = 2,
}
Teleport.Type = {
	Regular = 1,
	Mouse = 2
}
Teleport.Settings = {
	CustomStudSpeed = 200,
	MinimumInstantTeleport = 0,
	MaximumInstantTeleport = 500,
}

local function Tween(part, info, props)
	if (Teleport.TweenAnim ~= nil) then Teleport.TweenAnim:Cancel(); Teleport.TweenAnimFinished = true end 
	Teleport.TweenAnim = TweenService:Create(part, info, props); Teleport.TweenAnim:Play(); Teleport.TweenAnimFinished = false
	Teleport.TweenAnim.Completed:Wait(); Teleport.TweenAnimFinished = true; Teleport.TweenAnim = nil
end
local function Fastcall(v, type--[[reserved]]) 
	local r = Vector3.new(0, 0, 0)
	if (typeof(v) == "CFrame") then       r = Vector3.new(v.X, v.Y, v.Z)
	elseif (typeof(v) == "Instance") then r = Vector3.new(v.CFrame.X, v.CFrame.Y, v.CFrame.Z) 
	elseif (typeof(v) == "Vector3") then  r = v 
	else Notification:Create("an obstruction has occured", "sorry, we have no current support for type ".. typeof(v).. " . We only support cframe, instance, and vector3 at this time.", 1, 5)
	end	

	return r
end

function Teleport:Distance(v)
	return (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Fastcall(v)).Magnitude
end

function Teleport:Advanced(...)
	local lp = game.Players.LocalPlayer
	local Mouse = lp:GetMouse()
	local params = {...}

	if (lp.Character == nil) then 
		Notification:Create("an obstruction has occured", "sorry, we cannot locate the localplayer try again", 1, 5)
		return
	end
	if (params[1] == nil) then 
		Notification:Create("an obstruction has occured", "sorry, you need to provide teleport type", 1, 5)
		return
	end
	if (params[1] == Teleport.Type.Mouse) then
		local Hit = Mouse.Hit.p + Vector3.new(0, 5, 0)

		if (params[2] == Teleport.Style.Instant) then 
			lp.Character.HumanoidRootPart.CFrame = CFrame.new(Hit)
		else
			local Speed = Teleport:Distance(Hit) / Teleport.Settings.CustomStudSpeed
			Tween(
				lp.Character.HumanoidRootPart,
				TweenInfo.new(Speed, Enum.EasingStyle.Linear),
				{ CFrame = CFrame.new(Hit) }
			)
		end
	else
		if (params[2] == nil) then 
			Notification:Create("an obstruction has occured", "sorry, you need to provide a cframe, instance, or a vector3 in paramater #2", 1, 5)
			return
		end

		local t = Fastcall(params[2])

		if (params[2] == Teleport.Style.Instant) then 
			lp.Character.HumanoidRootPart.CFrame = CFrame.new(t)
		else
			local Speed = Teleport:Distance(t) / Teleport.Settings.CustomStudSpeed
			Tween(
				lp.Character.HumanoidRootPart,
				TweenInfo.new(Speed, Enum.EasingStyle.Linear),
				{ CFrame = CFrame.new(t) }
			)
		end
	end
end

function Teleport:Smart(...)
	local lp = game.Players.LocalPlayer
	local Mouse = lp:GetMouse()
	local params = {...}

	if (lp.Character == nil) then 
		Notification:Create("an obstruction has occured", "sorry, we cannot locate the localplayer try again", 1, 5)
		return
	end
	if (params[1] == nil) then 
		Notification:Create("an obstruction has occured", "sorry, you need to provide teleport type", 1, 5)
		return
	end
	if (params[1] == Teleport.Type.Mouse) then
		local Hit = Mouse.Hit.p + Vector3.new(0, 5, 0)

		if (Teleport:Distance(Hit) >= Teleport.Settings.MinimumInstantTeleport and Teleport:Distance(Hit) <= Teleport.Settings.MaximumInstantTeleport) then
			lp.Character.HumanoidRootPart.CFrame = CFrame.new(Hit)
			return
		end

		local Speed = Teleport:Distance(Hit) / Teleport.Settings.CustomStudSpeed
		Tween(
			lp.Character.HumanoidRootPart,
			TweenInfo.new(Speed, Enum.EasingStyle.Linear),
			{ CFrame = CFrame.new(Hit) }
		)
	else
		if (params[2] == nil) then 
			Notification:Create("an obstruction has occured", "sorry, you need to provide a cframe, instance, or a vector3 in paramater #2", 1, 5)
			return
		end

		local t = Fastcall(params[2])

		if (Teleport:Distance(t) >= Teleport.Settings.MinimumInstantTeleport and Teleport:Distance(t) <= Teleport.Settings.MaximumInstantTeleport) then
			lp.Character.HumanoidRootPart.CFrame = CFrame.new(t)
			return
		end

		local Speed = Teleport:Distance(t) / Teleport.Settings.CustomStudSpeed
		Tween(
			lp.Character.HumanoidRootPart,
			TweenInfo.new(Speed, Enum.EasingStyle.Linear),
			{ CFrame = CFrame.new(t) }
		)
	end
end
return Teleport
--[[
	// API Below

	local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotShanks/backups/main/TeleportLib/tele.lua"))()

	-- Teleport:Advanced() Arguments
	Teleport:Advanced(<teleport.type>(Regular or Mouse), <teleport.style>(Linear, Instant), <object>(CFrame, Instance, Vector3))

	-- Teleport:Advanced() Mouse Arguments
	Teleport:Advanced(<teleport.type>(Mouse), <teleport.style>(Linear, Instant))

	-- Teleport:Smart() Arguments
	Teleport:Smart(<teleport.type>(Regular or Mouse), <object>(CFrame, Instance, Vector3))

	-- Teleport:Smart() Mouse Arguments
	Teleport:Smart(<teleport.type>(Mouse), <object>(CFrame, Instance, Vector3))

	-- Teleport.Settings Items
	Teleport.Settings.CustomStudSpeed = 200 -- The limit of studs you will travel per second
	Teleport.Settings.MinimumInstantTeleport = 0 -- The minimum activation distance of instant teleport inside of the smart teleport function
	Teleport.Settings.MaximumInstantTeleport = 500 -- The maximum activation distance of instant teleport inside of the smart teleport function
]]
