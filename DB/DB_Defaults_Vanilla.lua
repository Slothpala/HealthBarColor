--[[
    Created by Slothpala 
--]]
local _, addonTable = ...
local HealthBarColor = addonTable.HealthBarColor

local defaults = {
    profile = {
        HealthBars = {
            Player = {
                selected  = 1,
                color     = {r=0,g=1,b=0},
            },
            Target = {
                selected  = 1,
                color     = {r=0,g=1,b=0},
                reaction  = true,
            },
            ToT = {
                selected  = 1,
                color     = {r=0,g=1,b=0},
                reaction  = true,
            },
            Pet = {
                selected  = 1,
                color     = {r=0,g=1,b=0},
            },
        },
        Fonts = {
            General = {
                name              = "TeX Gyre Adventor Bold",
                name_outline      = 4,
                healthbar         = "Friz Quadrata TT",
                healthbar_outline = 1,
                powerbar          = "Friz Quadrata TT",
                powerbar_outline  = 1,
                name_size         = 10,
                healthbar_size    = 10,
                powerbar_size     = 10,
            },
            Player = {
                name_choice      = 1,
                name_color       = {r=0,g=1,b=0},
                healthbar_choice = 1,
                healthbar_color  = {r=0,g=1,b=0},
                powerbar_choice  = 2,
                powerbar_color   = {r=1,g=1,b=1}, 
            },
            Target = {
                name_choice      = 2,
                name_color       = {r=0,g=1,b=0},
                healthbar_choice = 2,
                healthbar_color  = {r=0,g=1,b=0},
                powerbar_choice  = 4,
                powerbar_color   = {r=1,g=1,b=1}, 
            },
        },
        Settings = {
            Modules = {
                Fonts            = false,
                DarkFrames       = false,
                ['*']            = true,
            },
            ClassColorOverwrites = {
                enabled       = false,
                deathknight   = {r=0.77,g=0.12,b=0.23},
                demonhunter   = {r=0.64,g=0.19,b=0.79},
                druid         = {r=1.00,g=0.49,b=0.04},
                evoker        = {r=0.20,g=0.58,b=0.50},
                hunter        = {r=0.67,g=0.83,b=0.45},
                mage          = {r=0.25,g=0.78,b=0.923},
                monk          = {r=0.00,g=1.00,b=0.60},
                paladin       = {r=0.96,g=0.55,b=0.73},
                priest        = {r=1.00,g=1.00,b=1.00},
                rogue         = {r=1.00,g=0.96,b=0.41},
                shaman        = {r=0.00,g=0.44,b=0.87},
                warlock       = {r=0.53,g=0.53,b=0.9},
                warrior       = {r=0.78,g=0.61,b=0.43},
            },
            ReactionColorOverwrites = {
                enabled  = false,
                hostile  = {r=1,g=0,b=0},
                neutral  = {r=1,g=1,b=0},
                friendly = {r=0,g=1,b=0},
            }
        },
    },
}

function HealthBarColor:LoadDataBase()
    self.db = LibStub("AceDB-3.0"):New("HealthBarColorDB", defaults, true) 
    --db callbacks
    self.db.RegisterCallback(self, "OnProfileChanged", "ReloadConfig")
    self.db.RegisterCallback(self, "OnProfileCopied", "ReloadConfig")
    self.db.RegisterCallback(self, "OnProfileReset", "ReloadConfig")
end

--getter/setter functions that will save and call settings into/from the db
--status
function HealthBarColor:GetStatus(info)
    return self.db.profile[info[#info-2]][info[#info-1]][info[#info]]
end
function HealthBarColor:SetStatus(info,value)
    self.db.profile[info[#info-2]][info[#info-1]][info[#info]] = value
    --will reload the config each time the settings have been adjusted
    self:ReloadConfig()
end
--color
function HealthBarColor:GetColor(info)
    return self.db.profile[info[#info-2]][info[#info-1]][info[#info]].r, self.db.profile[info[#info-2]][info[#info-1]][info[#info]].g, self.db.profile[info[#info-2]][info[#info-1]][info[#info]].b
end
function HealthBarColor:SetColor(info, r,g,b)
    self.db.profile[info[#info-2]][info[#info-1]][info[#info]].r = r 
    self.db.profile[info[#info-2]][info[#info-1]][info[#info]].g = g
    self.db.profile[info[#info-2]][info[#info-1]][info[#info]].b = b
    self:ReloadConfig()
end

