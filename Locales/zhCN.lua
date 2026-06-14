local addonName = ...

local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")
if not L then return end

--Drpopdown Color Options
L["colorMode"] = "着色方式："
L["optionClass"] = "职业"
L["optionBlizzard"] = "暴雪绿色"
L["optionCustom"] = "自定义"
L["optionClassReaction"] = "职业/声望"
L["optionReaction"] = "声望"
L["optionClassCustom"] = "职业/自定义"
L["optionClassBlizzard"] = "职业/暴雪绿色"
L["optionHealthValue"] = "生命数值"
L["optionPower"] = "能量类型"
L["hideOption"] = "隐藏"
--Color Tab Labels & Color Picker names
L["classColors"] = "职业颜色"
L["reactionColors"] = "声望颜色"
L["powerColors"] = "能量颜色"
L["debuffColors"] = "减益颜色"
L["healthColors"] = "生命颜色"
L["gradientStart_name"] = "渐变起始色"
L["gradientStart_desc"] = "此颜色用于状态条的起始端。"
L["gradientEnd_name"] = "渐变结束色"
L["gradientEnd_desc"] = "此颜色用于状态条的末端。"
L["colorPicker_name"] = "颜色"
L["colorPicker_desc"] = "颜色选择器"
L["classColor_name"] = "职业颜色"
L["singleColor_desc"] = "无法使用渐变颜色时将使用此颜色。"
L["powerColor_name"] = "能量颜色"
L["reactionColor_name"] = "声望颜色"
L["debuffColor_name"] = "减益颜色"
L["colorResetButton_name"] = "重置"
L["colorResetButton_desc"] = "仅恢复此项的默认设置。"
--Options Frame Tab labels
L["healthBars_tab_label"] = "生命条"
L["fonts_tab_label"] = "字体"
L["colors_tab_label"] = "插件颜色"
L["modules_tab_label"] = "模块"
L["profiles_tab_label"] = "配置文件"
--Font Options
L["nameFont"] = "名称字体"
L["healthFont"] = "生命字体"
L["powerFont"] = "能量字体"
L["outlineMode"] = "描边模式"
L["nameFontSize"] = "名称字体大小"
L["healthFontSize"] = "生命字体大小"
L["powerFontSize"] = "能量字体大小"
L["alternatePowerFontSize"] = "备用能量大小"
L["alterNatePowerFontColor"] = "备用能量颜色"
--Units
L["player"] = "玩家"
L["target"] = "目标"
L["targettarget"] = "目标的目标"
L["focus"] = "焦点目标"
L["focustarget"] = "焦点的目标"
L["pet"] = "宠物"
L["boss1"] = "首领1"
L["boss2"] = "首领2"
L["boss3"] = "首领3"
L["boss4"] = "首领4"
L["boss5"] = "首领5"
L["party1"] = "队伍1"
L["party2"] = "队伍2"
L["party3"] = "队伍3"
L["party4"] = "队伍4"
--Powers
L["MANA"] = "法力值"
L["RAGE"] = "怒气值"
L["FOCUS"] = "专注值"
L["ENERGY"] = "能量"
L["RUNIC_POWER"] = "符文能量"
L["LUNAR_POWER"] = "日月能"
L["MAELSTROM"] = "漩涡值"
L["FURY"] = "狂怒值"
L["INSANITY"] = "疯狂值"
--Classes
L["DEATHKNIGHT"] = "死亡骑士"
L["DEMONHUNTER"] = "恶魔猎手"
L["DRUID"] = "德鲁伊"
L["EVOKER"] = "唤魔师"
L["HUNTER"] = "猎人"
L["MAGE"] = "法师"
L["MONK"] = "武僧"
L["PALADIN"] = "圣骑士"
L["PRIEST"] = "牧师"
L["ROGUE"] = "潜行者"
L["SHAMAN"] = "萨满祭司"
L["WARLOCK"] = "术士"
L["WARRIOR"] = "战士"
--Reactions
L["Friendly"] = "友好"
L["Neutral"] = "中立"
L["Hostile"] = "敌对"
-- Health
L["HIT_POINT"] = "生命数值"
L["maxHealth"] = "最大生命"
L["midHealth"] = "中等生命"
L["lowHealth"] = "低生命"
--Modules
L["enabledModules"] = "已启用模块："
--Textures module
L["Textures_name"] = "材质"
L["Textures_desc"] = "为生命条和能量条使用自定义SharedMedia材质，更多材质请下载SharedMedia插件。"
L["Health Bar"] = "生命条"
L["Power Bar"] = "能量条"
L["excludePowerBar_name"] = "排除"
L["excludePowerBar_desc"] = "排除能量条，不应用材质效果。"
--Dark Frames
L["DarkFrames_name"] = "深色框体"
L["DarkFrames_desc"] = "使用深色单位框体材质。"
--BetterBossFrames
L["BetterBossFrames_name"] = "优化首领框体"
L["BetterBossFrames_desc"] = "移除首领框体装饰并调整生命条大小，提升清晰度。"
--Glow
L["Glow_name"] = "光晕"
L["Glow_desc"] = "隐藏或重新着色单位名称下方的声望光晕。"
--BiggerHealthBar for retail
L["BiggerHealthBar_name"] = "增大生命条"
L["BiggerHealthBar_desc"] = "调整玩家生命条尺寸，覆盖整个内部框体。"
--BiggerHealthBars for classic the plural is not a typo
L["BiggerHealthBars_name"] = "增大生命条"
L["BiggerHealthBars_desc"] = "为玩家和目标使用更大的生命条。"
--PartyColor
L["PartyColor_name"] = "队伍颜色"
L["PartyColor_desc"] = "为队伍框体启用职业颜色（非团队样式）。"
--HideClassPowerBar
L["HideClassPowerBar_name"] = "隐藏职业能量条"
L["HideClassPowerBar_desc"] = "隐藏职业能量条（真气、灵魂碎片、连击点等）。"
--HideTotemFrame
L["HideTotemFrame_name"] = "隐藏图腾框"
L["HideTotemFrame_desc"] = "隐藏玩家框体周围的图腾指示器。"
--BackgroundTextures
L["BackgroundTextures_name"] = "背景材质"
L["BackgroundTextures_desc"] = "在生命条下方创建背景材质。"
L["Texture"] = "材质"
--DebuffColor
L["DebuffColor_name"] = "减益高亮"
L["DebuffColor_desc"] = "受到可驱散减益时，按减益颜色着色生命条。"
--Fonts
L["font_module_name"] = "字体设置"
L["font_module_desc"] = "使用自定义SharedMedia字体，并调整大小与颜色。"
--Overabsorbs
L["Overabsorbs_name"] = "过量吸收"
L["Overabsorbs_desc"] = "超出最大生命的吸收盾会让吸收条从右向左填充。"
--MinimapButton
L["MinimapButton_name"] = "小地图按钮"
L["MinimapButton_desc"] = "创建小地图按钮以快速打开设置。"
--PartyColor
L["PartyColor"] = "队伍颜色"
--PersonalResourceDisplay
L["PersonalResourceDisplay_name"] = "个人资源显示"
L["PersonalResourceDisplay_name_short"] = "个人资源"
L["PersonalResourceDisplay_desc"] = "待开发"
--Profile Management:
L["profile_management_group_name"] = "配置文件管理"
L["share_profile_title"] = "导入/导出配置"
L["share_profile_header"] = "分享或导入配置文件"
L["share_profile_desc_row1"] = "复制下方代码导出当前配置"
L["share_profile_desc_row2"] = "替换代码并点击确认导入配置"
L["share_profile_input_name"] = "导入/导出当前配置"
L["share_profile_input_desc"] = "注意：导入会覆盖当前配置！"
--Porfile import error handling:
L["import_empty_string_error"] = "未提供导入字符串，已中止"
L["import_decoding_failed_error"] = "解码失败，已中止"
L["import_uncompression_failed_error"] = "解压失败，已中止"
L["invalid_profile_error"] = "无效配置文件，已中止"
