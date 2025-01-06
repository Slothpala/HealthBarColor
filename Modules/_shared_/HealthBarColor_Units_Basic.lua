--[[
  colorModes basic:
  1 = class
  2 = blizzard green (has no effect when also playing with custom textures and will then just default to 0,1,0)
  3 = custom
]]
local _, addonTable = ...
local addon = addonTable.addon

local units
if addonTable.isRetail then
  units = {"player", "pet", "boss1", "boss2", "boss3", "boss4", "boss5"}
else
  units = {"player", "pet"}
end

for _, unit in pairs(units) do
  local module = addon:NewModule("HealthBarColor_" .. unit)
  function module:OnEnable()
    local dbObj = CopyTable(addon.db.profile["HealthBarColor_" .. unit])
    local hbc_unit = addon:GetUnit(unit)
    if dbObj.colorMode == 1 then
      local classColorStart = addonTable.colorMixins.classColors[addonTable.playerClass].classColorStart
      local classColorEnd = addonTable.colorMixins.classColors[addonTable.playerClass].classColorEnd
      hbc_unit.updateFullCallbacks["update_health_bar_color"] = function()
        hbc_unit:SetHealthBarToCustomColor(classColorStart, classColorEnd)
      end
    elseif dbObj.colorMode == 2 then
      hbc_unit.updateFullCallbacks["update_health_bar_color"] = function()
        hbc_unit:RestoreHealthBarToDefault()
      end
    else
      local startColor = CreateColor(dbObj.customColorStart.r, dbObj.customColorStart.g, dbObj.customColorStart.b, dbObj.customColorStart.a)
      local endColor = CreateColor(dbObj.customColorEnd.r, dbObj.customColorEnd.g, dbObj.customColorEnd.b, dbObj.customColorEnd.a)
      hbc_unit.updateFullCallbacks["update_health_bar_color"] = function()
        hbc_unit:SetHealthBarToCustomColor(startColor, endColor)
      end
    end
    if addon:IsModuleEnabled("Textures") then
      addon:ReloadModule("Textures") --Textures will call update_health_bar_color
    else
      hbc_unit.updateFullCallbacks["update_health_bar_color"]()
    end
    if addonTable.isClassic then
      hbc_unit.healthBar.lockColor = true
    end
  end

  function module:OnDisable()
    local hbc_unit = addon:GetUnit(unit)
    hbc_unit.updateFullCallbacks["update_health_bar_color"] = function()

    end
    hbc_unit:RestoreHealthBarToDefault()
  end
end
