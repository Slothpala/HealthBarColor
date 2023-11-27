--[[
    Created by Slothpala 
--]]
local _, addonTable = ...
local HealthBarColor = addonTable.HealthBarColor

local SetTexCoord = SetTexCoord
local unpack = unpack
local _G = _G

local BetterBossFrames = HealthBarColor:NewModule("BetterBossFrames")
local texture = {
	path = "Interface\\AddOns\\HealthBarColor\\Textures\\UnitFrames\\Boss\\UIUnitFrameBoss_small.png",
	coords = {0.3984375, 0.84765625, 0.00390625, 0.22265625},
}

function BetterBossFrames:OnEnable()
	for i=1,5 do 
		local frameTexture = _G["Boss" ..i.. "TargetFrame"].TargetFrameContainer.FrameTexture
		frameTexture:SetTexture(texture.path)
		frameTexture:SetTexCoord(unpack(texture.coords))
	end
end

function BetterBossFrames:OnDisable()

end

