local _, addonTable = ...
local HealthBarColor = addonTable.HealthBarColor
local DebuffColor = HealthBarColor:NewModule("DebuffColor")
local Player = HealthBarColor:GetUnit("Player")

local IsSpellKnown = IsSpellKnown

local debuffColor = {
    Curse   = {r=0.6,g=0.0,b=1.0},
    Disease = {r=0.6,g=0.4,b=0.0},
    Magic   = {r=0.2,g=0.6,b=1.0},
    Poison  = {r=0.0,g=0.6,b=0.0},
}
local canCure = {}

local function updateCurable(englishClass)
    canCure = {}
    local dispelAbilities = {
        ["DRUID"] = function()
            if IsSpellKnown(2782) then --Remove Corruption
                canCure.Curse = true
                canCure.Poison = true
            end
            if IsSpellKnown(88423) then --Nature's Cure
                canCure.Magic = true
                canCure.Curse = true
                canCure.Poison = true
            end
        end,
        ["MAGE"] = function()
            if IsSpellKnown(475) then --Remove Curse
                canCure.Curse = true
            end
        end,
        ["MONK"] = function()
            if IsSpellKnown(218164) then --Detox BM/WW
                canCure.Poison = true
                canCure.Disease = true
            end
            if IsSpellKnown(115450) or IsSpellKnown(115310) or IsSpellKnown(388615) then --Detox MW --Revival --Restoral
                canCure.Magic = true
                canCure.Poison = true
                canCure.Disease = true
            end
        end,
        ["PALADIN"] = function()
            if IsSpellKnown(213644) then --Cleanse Toxins
                canCure.Poison = true
                canCure.Disease = true
            end
            if IsSpellKnown(4987) then --Cleanse
                canCure.Magic = true
                canCure.Poison = true
                canCure.Disease = true
            end
        end,
        ["PRIEST"] = function()
            if IsSpellKnown(527) then --Purify
                canCure.Magic = true
                canCure.Disease = true
            end
            if IsSpellKnown(213634) then --Purify Disease
                canCure.Disease = true
            end
            if IsSpellKnown(32375) then --Mass Dispel
                canCure.Magic = true
            end
        end,
        ["SHAMAN"] = function()
            if IsSpellKnown(51886) then --Cleanse Spirit
                canCure.Curse = true
            end
            if IsSpellKnown(77130) then --Purify Spirit
                canCure.Magic = true
                canCure.Curse = true
            end
        end,
        ["WARLOCK"] = function()
            if IsSpellKnown(89808, true) then --Singe Magic
                canCure.Magic = true
            end
        end,
        ["EVOKER"] = function()
            if IsSpellKnown(374251) then --Cauterizing Flame
                canCure.Curse = true
                canCure.Poison = true
                canCure.Disease = true
            end
            if IsSpellKnown(365585) then --Expunge Dev/Aug 
                canCure.Poison = true
                if GetSpecialization() == 2 then --workaround see beloww
                    canCure.Magic = true
                end
            end
            --[[
            if IsSpellKnown(360823) then --Naturalize API bug i guess. IsSpellKnown(360823) will never return true but Expunge/365585 will.
                canCure.Magic = true
                canCure.Poison = true
            end
            ]]
        end,
        ["DEMONHUNTER"] = function()
            if IsSpellKnown(205604) then --Reverse Magic
                canCure.Magic = true
            end
        end,
        ["HUNTER"] = function()
            if IsSpellKnown(212640) then --Mending Bandage
                canCure.Poison = true
                canCure.Disease = true
            end
        end,
    }
    if dispelAbilities[englishClass] then
        dispelAbilities[englishClass]()
    end
    local hasDispel = false
    for k,v in pairs(canCure) do
        print(k..": "..tostring(v))
        hasDispel = v
    end
    return hasDispel
end

local function restoreColor()
    Player:SetStatusBarClassColored()
end

local function toDebuffColor(dispelName)
    print(dispelName)
    local r,g,b = debuffColor[dispelName].r, debuffColor[dispelName].g, debuffColor[dispelName].b
    Player.HealthBar:SetStatusBarColor(r,g,b)
end

local auraMap = {}

local function updateColor()
    for auraInstanceID, dispelName in next, auraMap do
        if auraInstanceID then
            toDebuffColor(dispelName)
            return
        end
    end
    restoreColor()
end

local auraFrame = CreateFrame("Frame")
auraFrame:SetScript("OnEvent",function(_,_,_,updateInfo)
    if updateInfo.isFullUpdate then
        auraMap = {} --clear table 
        local function HandleAura(aura)
            if canCure[aura.dispelName] then
                auraMap[aura.auraInstanceID] = aura.dispelName
            end
        end
        AuraUtil.ForEachAura("player", "HARMFUL|RAID", nil, HandleAura, true)  
        updateColor()
        return
    end
    if updateInfo.addedAuras then
        for _, aura in pairs(updateInfo.addedAuras) do
            if aura.isRaid and aura.isHarmful and canCure[aura.dispelName] then
                toDebuffColor(aura.dispelName)
                auraMap[aura.auraInstanceID] = aura.dispelName
            end
        end
    end
    if updateInfo.removedAuraInstanceIDs then
        for _, auraInstanceID in pairs(updateInfo.removedAuraInstanceIDs) do
            auraMap[auraInstanceID] = nil
            updateColor()
        end
    end
end)

function DebuffColor:OnEnable() 
    self:RegisterEvent("SPELLS_CHANGED", function()
        local hasDispel = updateCurable(Player.Class)
        if hasDispel then
            auraFrame:RegisterUnitEvent("UNIT_AURA", "player")
        else
            auraFrame:UnregisterEvent("UNIT_AURA")
        end
    end)
end

function DebuffColor:OnDisable()
    auraFrame:UnregisterEvent("UNIT_AURA")
    self:UnregisterEvent("SPELLS_CHANGED")
end