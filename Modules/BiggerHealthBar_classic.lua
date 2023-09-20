--[[
    Created by Slothpala 
--]]
local _, addonTable = ...
local HealthBarColor = addonTable.HealthBarColor

local BiggerHealthBar = HealthBarColor:NewModule("BiggerHealthBar")
--hook stuff
local hooked = {}
local callbacks = {}
local donothing = function() end
local Player = HealthBarColor:GetUnit("Player")
Player.FrameTexture = PlayerFrameTexture

--left, right, top, bottom
local textures = {
	Player = {
		FrameTexture = {
			path = "Interface\\AddOns\\HealthBarColor\\Textures\\UnitFrames\\classic\\BiggerClassic.tga",
			coords =  {1, 0, 1, 0.78125, 0.09375, 0, 0.09375, 0.78125},
		}
	}

} 

local function toPlayerArt() 
	Player.FrameTexture:SetTexture(textures.Player["FrameTexture"].path)
	Player.FrameTexture:SetTexCoord(unpack(textures.Player["FrameTexture"].coords))
	Player.HealthBar:SetPoint("TOPLEFT", Player.FrameTexture, 106, -21)
	Player.HealthBar:SetHeight(30)
end

local function toVehicelArt() 

end


function BiggerHealthBar:OnEnable()
	HealthBarColor:RegisterOnToPlayerArt(toPlayerArt)
	toPlayerArt() 
end

function BiggerHealthBar:OnDisable()
	Player.FrameTexture:SetTexture("Interface/TARGETINGFRAME/UI-TargetingFrame.blp")
	Player.FrameTexture:SetTexCoord(1, 0, 1, 0.78125, 0.09375, 0, 0.09375, 0.78125)
	Player.HealthBar:SetPoint("TOPLEFT", Player.FrameTexture, "TOPLEFT", 106, -41)
	Player.HealthBar:SetHeight(12.000005722046)
end

