local _, addonTable = ...
local addon = addonTable.addon

local module = addon:NewModule("Overabsorb")
local applicableUnits =
{
  "player",
  "target",
}
local healPredictionCalculator = CreateUnitHealPredictionCalculator()
healPredictionCalculator:SetDamageAbsorbClampMode(Enum.UnitDamageAbsorbClampMode.MaximumHealth)
local overAbsorbBarTexture = "Interface\\RaidFrame\\Shield-Overlay"
local overAbsorbBarColor =
{
  r = 1,
  g = 1,
  b = 1,
  a = 1,
}

function module:OnEnable()
  for _, unit in pairs(applicableUnits) do
    local hbc_unit = addon:GetUnit(unit)
    self:SetupOverabsorbBar(hbc_unit)
    hbc_unit.eventFrame:RegisterUnitEvent("UNIT_HEALTH", unit)
    hbc_unit.eventFrame:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", unit)

    local function callback()

      -- The max should mathematically be maxHealth + missingHealth (so max-min == maxHealth),
      -- but the API exposes no such value and arithmetic on secret values is forbidden.
      -- Result: the bar is scaled by currentHealth instead of maxHealth, so the overabsorb
      -- is drawn too wide by a factor of maxHealth/currentHealth (= 1/HP%), independent of
      -- shield size. Exact at full HP; only large at low HP, which in turn needs a huge shield
      -- to produce any overabsorb at all -- so the bad cases are rare. Close enough in practice.
      --
      --   HP%  | factor
      --   -----+--------
      --   100% | x1.00   (exact)
      --    90% | x1.11
      --    75% | x1.33
      --    50% | x2.00
      --    25% | x4.00

      hbc_unit.overabsorbBar:SetMinMaxValues(hbc_unit.missingHealth, hbc_unit.maxHealth)
      UnitGetDetailedHealPrediction(hbc_unit.UnitId, nil, healPredictionCalculator)
      local amount, _ = healPredictionCalculator:GetDamageAbsorbs()
      hbc_unit.overabsorbBar:SetValue(amount)
    end
    hbc_unit.updateHealthCallbacks["Overabsorb"] = callback
    hbc_unit.updateFullCallbacks["Overabsorb"] = callback
    callback()
  end
end

function module:SetupOverabsorbBar(hbc_unit)
  if not hbc_unit.overabsorbBar then
    hbc_unit.overabsorbBar = CreateFrame("StatusBar", nil, hbc_unit.healthBar)
  end

  local bar = hbc_unit.overabsorbBar
  bar:SetAllPoints(hbc_unit.healthBar)
  bar:SetStatusBarTexture(overAbsorbBarTexture)
  bar:Show()

  local texture = bar:GetStatusBarTexture()
  texture:SetTexture(overAbsorbBarTexture, "REPEAT", "REPEAT")
  texture:SetHorizTile(true)
  texture:SetVertTile(true)
  bar:SetStatusBarColor(overAbsorbBarColor.r, overAbsorbBarColor.g, overAbsorbBarColor.b, overAbsorbBarColor.a)

  local glow = hbc_unit.overAbsorbGlow
  glow:ClearAllPoints()
  glow:SetPoint("TOPLEFT", texture, "TOPRIGHT", -3, 0)
  glow:SetPoint("BOTTOMLEFT", texture, "BOTTOMRIGHT", -3, 0)

  if not hbc_unit.textOverlay then
    hbc_unit.textOverlay = CreateFrame("Frame", nil, hbc_unit.healthBar)
  end
  local overlay = hbc_unit.textOverlay
  overlay:SetAllPoints(hbc_unit.healthBar)
  overlay:SetFrameLevel(bar:GetFrameLevel() + 1)
  for _, fontString in ipairs({hbc_unit.healthTextLeft, hbc_unit.healthTextMiddle, hbc_unit.healthTextRight}) do
    if fontString then
      fontString:SetParent(hbc_unit.textOverlay)
    end
  end
end

function module:OnDisable()
  for _, unit in pairs(applicableUnits) do
    local hbc_unit = addon:GetUnit(unit)

    if hbc_unit.overabsorbBar then
      hbc_unit.overabsorbBar:Hide()
    end

    local glow = hbc_unit.overAbsorbGlow
		glow:ClearAllPoints()
		glow:SetPoint("TOPLEFT", hbc_unit.healthBar, "TOPRIGHT", -7, 0)
		glow:SetPoint("BOTTOMLEFT", hbc_unit.healthBar, "BOTTOMRIGHT", -7, 0)
  end
end
