--[[
    Created by Slothpala 
	Based on https://www.curseforge.com/wow/addons/derangement-shieldmeters.
--]]

local Overabsorb = HealthBarColor:NewModule("Overabsorb")
local donothing = function() end
local UnitFrameHealPredictionBars_Update_Callback = nil
local hooked = nil
local Player = nil

local function anchorGlowToOverlay(HBC_Unit)
	HBC_Unit.TotalAbsorbBarOverlay:ClearAllPoints()
	HBC_Unit.OverAbsorbGlow:ClearAllPoints()
	HBC_Unit.OverAbsorbGlow:SetPoint("TOPLEFT", HBC_Unit.TotalAbsorbBarOverlay, "TOPLEFT", -5, 0)
	HBC_Unit.OverAbsorbGlow:SetPoint("BOTTOMLEFT", HBC_Unit.TotalAbsorbBarOverlay, "BOTTOMLEFT", -5, 0)
end

function Overabsorb:OnEnable()
	Player = HealthBarColor:GetUnit("Player")
	local units = {
		["player"] = Player,
		--["target"] = Target,
		--["focus"] = Focus,
	}
	for _,HBC_Unit in pairs (units) do
		HBC_Unit:AddAbsorbVariables()
		anchorGlowToOverlay(HBC_Unit)
	end
	UnitFrameHealPredictionBars_Update_Callback = function(unit)
		if not units[unit] then 
			return
		end
		HBC_Unit = units[unit]
		local _, maxHealth = HBC_Unit.HealthBar:GetMinMaxValues()
		if maxHealth <= 0 then
			return
		end
		local totalAbsorb = UnitGetTotalAbsorbs(unit) or 0
		if totalAbsorb > maxHealth then
			totalAbsorb = maxHealth
		end
		if totalAbsorb > 0 then 
			local width = HBC_Unit.HealthBar:GetWidth()	
			local health = UnitHealth(unit)	
			local missingHealth = maxHealth - health
            local barSize = width * (totalAbsorb/maxHealth) 
			if HBC_Unit.TotalAbsorbBar:IsShown() and totalAbsorb <= missingHealth then 
				HBC_Unit.TotalAbsorbBarOverlay:SetPoint("TOPRIGHT", HBC_Unit.TotalAbsorbBar, "TOPRIGHT", 0, 0)
				HBC_Unit.TotalAbsorbBarOverlay:SetPoint("BOTTOMRIGHT", HBC_Unit.TotalAbsorbBar, "BOTTOMRIGHT", 0, 0)
			else
				if missingHealth > 0 then
					barSize = width * ( (totalAbsorb/maxHealth) - (missingHealth/maxHealth) )
				end
				HBC_Unit.TotalAbsorbBarOverlay:SetPoint("TOPRIGHT", HBC_Unit.HealthBar, "TOPRIGHT", 0, 0)
				HBC_Unit.TotalAbsorbBarOverlay:SetPoint("BOTTOMRIGHT", HBC_Unit.HealthBar, "BOTTOMRIGHT", 0, 0)
			end
            HBC_Unit.TotalAbsorbBarOverlay:SetWidth(barSize)
			HBC_Unit.TotalAbsorbBarOverlay:Show()
		end
	end
	UnitFrameHealPredictionBars_Update_Callback("player")
	if not hooked then
		hooksecurefunc("UnitFrameHealPredictionBars_Update",function(frame) 
			UnitFrameHealPredictionBars_Update_Callback(frame.unit) 
		end)
		hooked = true
	end
end

function Overabsorb:OnDisable()
	local function restore(HBC_Unit)
		HBC_Unit.TotalAbsorbBarOverlay:ClearAllPoints()
		HBC_Unit.TotalAbsorbBarOverlay:SetPoint("TOPLEFT", HBC_Unit.TotalAbsorbBar, "TOPLEFT", 0, 0)
		HBC_Unit.TotalAbsorbBarOverlay:SetPoint("BOTTOMRIGHT", HBC_Unit.TotalAbsorbBar, "BOTTOMRIGHT", 0, 0)
		HBC_Unit.TotalAbsorbBarOverlay:SetWidth(HBC_Unit.TotalAbsorbBar:GetWidth())
	end
	restore(Player)
	UnitFrame_Update_Callback = donothing
	UnitFrameHealPredictionBars_Update_Callback = donothing
end

