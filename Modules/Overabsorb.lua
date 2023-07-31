--[[
    Created by Slothpala 
	Based on https://www.curseforge.com/wow/addons/derangement-shieldmeters.
--]]
local Overabsorb = HealthBarColor:NewModule("Overabsorb")
local whitelistedUnit = {
	["player"] = true,
	["target"] = true,
	--["focus"] = true,
}
local donothing = function() end
local UnitFrame_Update_Callback 
local UnitFrameHealPredictionBars_Update_Callback
local hooked = {}


function Overabsorb:OnEnable()
	local glowColor
	local overlayColor
	UnitFrame_Update_Callback = function(frame)
		if not whitelistedUnit[frame.unit] then 
			return
		end
		local absorbOverlay = frame.totalAbsorbBarOverlay;
		if not absorbOverlay then
			return
		end
		absorbOverlay:ClearAllPoints()	
		local absorbGlow = frame.overAbsorbGlow
		if absorbGlow then
			absorbGlow:ClearAllPoints()
			absorbGlow:SetPoint("TOPLEFT", absorbOverlay, "TOPLEFT", -5, 0)
			absorbGlow:SetPoint("BOTTOMLEFT", absorbOverlay, "BOTTOMLEFT", -5, 0)
		end
	end
	if not hooked["UnitFrame_Update"] then
		hooksecurefunc("UnitFrame_Update",function(frame) UnitFrame_Update_Callback(frame) end)
		hooked["UnitFrame_Update"] = true
	end
	UnitFrameHealPredictionBars_Update_Callback = function(frame)
		if not whitelistedUnit[frame.unit] then 
			return
		end
		local absorbOverlay = frame.totalAbsorbBarOverlay;
		if not absorbOverlay or absorbOverlay:IsForbidden() then
			return
		end
		local absorbBar = frame.totalAbsorbBar
		local healthBar = frame.healthbar
		local _, maxHealth = healthBar:GetMinMaxValues()
		if maxHealth <= 0 then
			return
		end
		local totalAbsorb = UnitGetTotalAbsorbs(frame.unit) or 0
		if totalAbsorb > maxHealth then
			totalAbsorb = maxHealth
		end
		if totalAbsorb > 0 then 
			if absorbBar:IsShown() then 
				absorbOverlay:SetPoint("TOPRIGHT", absorbBar, "TOPRIGHT", 0, 0);
				absorbOverlay:SetPoint("BOTTOMRIGHT", absorbBar, "BOTTOMRIGHT", 0, 0);
			else
				absorbOverlay:SetPoint("TOPRIGHT", healthBar, "TOPRIGHT", 0, 0);
				absorbOverlay:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", 0, 0);
			end
            local width = healthBar:GetWidth()			
            local barSize = totalAbsorb / maxHealth * width
            absorbOverlay:SetWidth(barSize)
            absorbOverlay:Show()
		end
	end
	if not hooked["UnitFrameHealPredictionBars_Update"] then
		hooksecurefunc("UnitFrameHealPredictionBars_Update",function(frame) UnitFrameHealPredictionBars_Update_Callback(frame) end)
		hooked["UnitFrameHealPredictionBars_Update"] = true
	end
end

function Overabsorb:OnDisable()
	UnitFrame_Update_Callback = donothing
	UnitFrameHealPredictionBars_Update_Callback = donothing
end

