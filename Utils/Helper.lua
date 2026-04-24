local _, addonTable = ...
local addon = addonTable.addon

function addon:ConvertDbNumberToOutlinemode(number)
  local outlinemodes = {
      [1] = "",
      [2] = "OUTLINE",
      [3] = "THICKOUTLINE",
      [4] = "MONOCHROME",
      [5] = "MONOCHROME,OUTLINE",
      [6] = "MONOCHROME,THICKOUTLINE",
  }
  return addon:NormalizeFontFlags(outlinemodes[number])
end

function addon:NormalizeFontFlags(flags)
  if flags == nil or flags == false or flags == "" or flags == "NONE" then
    return ""
  end

  if type(flags) ~= "string" then
    return ""
  end

  if flags == "MONOCHROMEOUTLINE" then
    return "MONOCHROME,OUTLINE"
  end

  if flags == "MONOCHROMETHICKOUTLINE" then
    return "MONOCHROME,THICKOUTLINE"
  end

  return flags
end
