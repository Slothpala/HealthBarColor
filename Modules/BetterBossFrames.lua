--[[
    Created by Slothpala 
--]]
local _, addonTable = ...
local HealthBarColor = addonTable.HealthBarColor

local SetTexCoord = SetTexCoord
local unpack = unpack
local _G = _G


local BetterBossFrames = HealthBarColor:NewModule("BetterBossFrames")
Mixin(BetterBossFrames, addonTable.hooks)
local Textures = {
	FrameTexture = {
		path = "Interface\\AddOns\\HealthBarColor\\Textures\\UnitFrames\\Boss\\BetterBossFrames.png",
		coords = {0.3984375, 0.84765625, 0.00390625, 0.22265625},
	},
	FrameFlash = {
		path = "Interface\\AddOns\\HealthBarColor\\Textures\\UnitFrames\\Boss\\BetterBossFlash.png",
		coords = {0.3984375, 0.84765625, 0.00390625, 0.22265625},
	},
	Mask = {
		path = "Interface\\AddOns\\HealthBarColor\\Textures\\UnitFrames\\Boss\\MaskTextureBoss.png",
		coords = {22/128, 106/128, 21/64, 43/64},
	},
}



local function replaceTextures(hbc_unit)
	hbc_unit.FrameTexture:SetTexture(Textures.FrameTexture.path)
	hbc_unit.FrameTexture:SetTexCoord(unpack(Textures.FrameTexture.coords))
	hbc_unit.FrameFlash:SetTexture(Textures.FrameFlash.path)
	hbc_unit.FrameFlash:SetTexCoord(unpack(Textures.FrameFlash.coords))
	hbc_unit.FrameFlash:SetAllPoints(hbc_unit.FrameTexture)
end

local function resizeHealthBar(hbc_unit)
	hbc_unit.Skull:SetAlpha(0)
	hbc_unit.Glow:Hide()
	hbc_unit.HealthBar.HealthBarMask:SetTexture(Textures.Mask.path)
	hbc_unit.HealthBar.HealthBarMask:SetPoint("TOPLEFT",hbc_unit.HealthBar,-21,22)
	hbc_unit.HealthBar.HealthBarMask:SetPoint("BOTTOMRIGHT",hbc_unit.HealthBar,23,-22)
	hbc_unit.HealthBar:SetHeight(22)
	hbc_unit.Name:ClearAllPoints()
	hbc_unit.Name:SetWidth(65)
	hbc_unit.Name:SetPoint("TOPLEFT", hbc_unit.Glow, "TOPLEFT",2,14)
	hbc_unit.LevelText:ClearAllPoints()
	hbc_unit.LevelText:SetPoint("TOPRIGHT", hbc_unit.Glow, "TOPRIGHT",0,14)
end

function BetterBossFrames:OnEnable()
	for i=1,5 do 
		local hbc_unit = HealthBarColor:GetUnit("Boss"..i)
		replaceTextures(hbc_unit)
		resizeHealthBar(hbc_unit)
	end
end

function BetterBossFrames:OnDisable()

end

