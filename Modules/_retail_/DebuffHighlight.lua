local _, addonTable = ...
local addon = addonTable.addon

--local speed teferences
local AuraUtil_ForEachAura = AuraUtil.ForEachAura
local C_UnitAuras_IsAuraFilteredOutByInstanceID = C_UnitAuras.IsAuraFilteredOutByInstanceID
local C_UnitAuras_GetAuraDispelTypeColor = C_UnitAuras.GetAuraDispelTypeColor
local next = next
local pairs = pairs

local module = addon:NewModule("DebuffHighlight")
local eventFrame = nil
local Player = nil
local auraMap = {}

local dispelCurve = nil

local function updateColor()
  for auraInstanceID in next, auraMap do
    local color = C_UnitAuras_GetAuraDispelTypeColor("player", auraInstanceID, dispelCurve)
    if color then
      Player:SetHealthBarToDebuffColor(color)
    end
    return
  end
  Player:BlockHealthBarColorUpdate(false)
  Player.updateFullCallbacks["update_health_bar_color"]()
end

local function updateAurasFull()
  local function handleAura(aura)
    auraMap[aura.auraInstanceID] = true
  end
  AuraUtil_ForEachAura("player", "HARMFUL|RAID_PLAYER_DISPELLABLE", nil, handleAura, true)
  updateColor()
end

local function updateAurasIncremental(updateInfo)
  if updateInfo.addedAuras then
    for _, aura in pairs(updateInfo.addedAuras) do
      if not C_UnitAuras_IsAuraFilteredOutByInstanceID("player", aura.auraInstanceID, "HARMFUL|RAID_PLAYER_DISPELLABLE") then
        auraMap[aura.auraInstanceID] = true
      end
    end
  end
  if updateInfo.removedAuraInstanceIDs then
    for _, auraInstanceID in pairs(updateInfo.removedAuraInstanceIDs) do
      if auraMap[auraInstanceID] then
        auraMap[auraInstanceID] = nil
      end
    end
  end
  updateColor()
end

function module:OnEnable()
  local debuffColors = CopyTable(addon.db.profile.addonColors.debuffColors)
  local magicColor = debuffColors.Magic.debuffColor
  local curseColor = debuffColors.Curse.debuffColor
  local diseaseColor = debuffColors.Disease.debuffColor
  local poisonColor = debuffColors.Poison.debuffColor
  -- Setup te color curve.
  if not dispelCurve then
    dispelCurve = C_CurveUtil.CreateColorCurve()
    dispelCurve:SetType(Enum.LuaCurveType.Step)
  end
  dispelCurve:ClearPoints()
  dispelCurve:AddPoint(1, CreateColor(magicColor.r, magicColor.g, magicColor.b, 1))  -- MAGIC
  dispelCurve:AddPoint(2, CreateColor(curseColor.r, curseColor.g, curseColor.b, 1))  -- CURSE
  dispelCurve:AddPoint(3, CreateColor(diseaseColor.r, diseaseColor.g, diseaseColor.b, 1))  -- DISEASE
  dispelCurve:AddPoint(4, CreateColor(poisonColor.r, poisonColor.g, poisonColor.b, 1))  -- POISON
  dispelCurve:AddPoint(11, CreateColor(0.8, 0, 0, 1))  -- BLEED
  -- Get the hbc unit.
  Player = addon:GetUnit("player")
  if not eventFrame then
    eventFrame = CreateFrame("Frame")
  end
  eventFrame:SetScript("OnEvent", function(_, _, _, updateInfo)
    if updateInfo.isFullUpdate then
      updateAurasFull()
    else
      updateAurasIncremental(updateInfo)
    end
  end)
  eventFrame:RegisterUnitEvent("UNIT_AURA", "player")
  if Player.updateFullCallbacks["update_health_bar_color"] then
    updateAurasFull()
  end
end

function module:OnDisable()
  if eventFrame then
    eventFrame:UnregisterAllEvents()
  end
  auraMap = {}
  Player.updateFullCallbacks["update_health_bar_color"]()
end
