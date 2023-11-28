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
		path = "Interface\\AddOns\\HealthBarColor\\Textures\\UnitFrames\\Boss\\UIUnitFrameBoss_small.png",
		coords = {0.3984375, 0.84765625, 0.00390625, 0.22265625},
	},
	FrameFlash = {
		path = "Interface\\AddOns\\HealthBarColor\\Textures\\UnitFrames\\Boss\\UIUnitFrameBoss_small.png",
		coords = {0.32421875, 0.66015625, 0.328125, 0.328125},
	},
}

local function replaceTextures(hbc_unit)
	hbc_unit.FrameTexture:SetTexture(Textures.FrameTexture.path)
	hbc_unit.FrameTexture:SetTexCoord(unpack(Textures.FrameTexture.coords))
	hbc_unit.FrameFlash:SetTexture(Textures.FrameFlash.path)
	hbc_unit.FrameFlash:SetTexCoord(unpack(Textures.FrameFlash.coords))
end

local function resizeHealthBar(hbc_unit)
	hbc_unit.Skull:SetAlpha(0)
	hbc_unit.Glow:Hide()
	hbc_unit.HealthBar.HealthBarMask:SetAtlas("UI-HUD-UnitFrame-Party-PortraitOff-Bar-Health-Mask")
	hbc_unit.HealthBar.HealthBarMask:SetPoint("TOPLEFT",hbc_unit.HealthBar,-23,10)
	hbc_unit.HealthBar.HealthBarMask:SetPoint("BOTTOMRIGHT",hbc_unit.HealthBar,23,-10)
	hbc_unit.HealthBar:SetHeight(22)
	hbc_unit.Name:ClearAllPoints()
	hbc_unit.Name:SetPoint("CENTER", hbc_unit.Glow, "CENTER",0,14)
	hbc_unit.Name:SetJustifyH("CENTER")
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

