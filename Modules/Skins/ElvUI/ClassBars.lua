local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule("Skins")
local UF = E:GetModule("UnitFrames")

local _G = _G

function S:ElvUI_UnitFrames_SkinClassBar(_, frame)
    local bar = frame[frame.ClassBar]
    if bar then
        bar.backdrop:SetTemplate("Transparent")
        self:CreateShadow(bar.backdrop)
    end
end

function S:ElvUI_ClassBars()
    if not E.private.unitframe.enable then
        return
    end
    if not (E.private.WT.skins.elvui.enable and E.private.WT.skins.elvui.classBars) then
        return
    end

    self:SecureHook(UF, "Configure_ClassBar", "ElvUI_UnitFrames_SkinClassBar")
end

S:AddCallback("ElvUI_ClassBars")
