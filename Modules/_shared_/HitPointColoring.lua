local _, addonTable = ...
local addon = addonTable.addon

local module = addon:NewModule("HitPointColoring")

function module:OnEnable()
  local dbObj = CopyTable(addon.db.profile.HitPointColoring)
  local startColorMediumHP = addonTable.healthColors.MediumHealth.healthColorStart
  local endColorMediumHP = addonTable.healthColors.MediumHealth.healthColorEnd
  local startColorLowHP = addonTable.healthColors.LowHealth.healthColorStart
  local endColorLowHP = addonTable.healthColors.LowHealth.healthColorEnd
  local hbc_units = addon:GetAllUnits()

  for _, hbc_unit in pairs(hbc_units) do
    hbc_unit.updateHealthCallbacks["update_hp_threshold_color"] = function()
      if hbc_unit.percentHealth <= dbObj.lowThreshold then
        hbc_unit:SetHealthBarToCustomColor(startColorLowHP, endColorLowHP)
      elseif hbc_unit.percentHealth <= dbObj.mediumThreshold then
        hbc_unit:SetHealthBarToCustomColor(startColorMediumHP, endColorMediumHP)
      else
        hbc_unit.updateFullCallbacks["update_health_bar_color"]()
      end
    end
  end

  local eventFrame = addon:GetEventFrame()
  eventFrame:RegisterUnitEvent("UNIT_HEALTH", "player", "pet", "target", "focus")
end

function module:OnDisable()
  local eventFrame = addon:GetEventFrame()
  eventFrame:UnregisterEvent("UNIT_HEALTH")

  local hbc_units = addon:GetAllUnits()
  for _, hbc_unit in pairs(hbc_units) do
    hbc_unit.updateFullCallbacks["update_health_bar_color"]()
  end
end
