local _, addonTable = ...
local addon = addonTable.addon

local module = addon:NewModule("HitPointColoring")

function module:OnEnable()
  local dbObj = CopyTable(addon.db.profile.HitPointColoring)
  local dbObjColors = CopyTable(addon.db.profile.addonColors.healthColors)
  local startColorMediumHP = dbObjColors.MediumHealth.healthColorStart
  local endColorMediumHP = dbObjColors.MediumHealth.healthColorEnd
  local startColorLowHP = dbObjColors.LowHealth.healthColorStart
  local endColorLowHP = dbObjColors.LowHealth.healthColorEnd
  local hbc_units = addon:GetAllUnits()

  ---Interpolate between two colors.
  ---@param color1 table {r,g,b}
  ---@param color2 table {r,g,b}
  ---@param t number percentage, normalized to a range of 0 to 1.
  local function lerp_color(color1, color2, t)
    local r = color1["r"] * (1 - t) + color2["r"] * t
    local g = color1["g"] * (1 - t) + color2["g"] * t
    local b = color1["b"] * (1 - t) + color2["b"] * t
    return r, g, b
  end

  local function lerp_gradient(percentHealth)
    -- Limit the percante in between medium and low.
    local t = ( 1 / (dbObj.mediumThreshold - dbObj.lowThreshold) ) * (percentHealth - dbObj.lowThreshold)
    -- Let the value never leave the range of 0 to 1.
    t = math.max(0, math.min(1, t))
    local startColor = CreateColor(lerp_color(startColorLowHP, startColorMediumHP , t))
    local endColor = CreateColor(lerp_color(endColorLowHP, endColorMediumHP, t))
    return startColor, endColor
  end


  for _, hbc_unit in pairs(hbc_units) do
    hbc_unit.updateHealthCallbacks["update_hp_threshold_color"] = function()
      if hbc_unit.percentHealth <= dbObj.mediumThreshold then
        hbc_unit:SetHealthBarToCustomColor(lerp_gradient(hbc_unit.percentHealth))
      else
        hbc_unit.updateFullCallbacks["update_health_bar_color"]()
      end
    end
    -- Apply the settings right away. The update_health_bar_color callback is sometimes not available on reloading.
    if hbc_unit.updateFullCallbacks["update_health_bar_color"] then
      hbc_unit.updateHealthCallbacks["update_hp_threshold_color"]()
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
    hbc_unit.updateHealthCallbacks["update_hp_threshold_color"] = nil
    hbc_unit.updateFullCallbacks["update_health_bar_color"]()
  end
end
