local W, F, E, L = unpack(select(2, ...))
local S = W.Modules.Skins

local _G = _G
local hooksecurefunc = hooksecurefunc

function S:WorldMapFrame()
    if not self:CheckDB("worldmap", "worldMap") then
        return
    end

    self:CreateBackdropShadow(_G.WorldMapFrame)

    local QuestScrollFrame = _G.QuestScrollFrame
    if E.Retail and QuestScrollFrame.Background then
        QuestScrollFrame.Background:Kill()
    end
    if E.Retail and QuestScrollFrame.DetailFrame and QuestScrollFrame.DetailFrame.backdrop then
        QuestScrollFrame.DetailFrame.backdrop:SetTemplate("Transparent")
    end

    local QuestMapFrame = _G.QuestMapFrame
    if E.Retail and QuestMapFrame.DetailsFrame then
        if QuestMapFrame.DetailsFrame.backdrop then
            QuestMapFrame.DetailsFrame.backdrop:SetTemplate("Transparent")
        end
        if QuestMapFrame.DetailsFrame.RewardsFrame.backdrop then
            QuestMapFrame.DetailsFrame.RewardsFrame.backdrop:SetTemplate("Transparent")
        elseif QuestMapFrame.DetailsFrame.RewardsFrame then
            QuestMapFrame.DetailsFrame.RewardsFrame:CreateBackdrop("Transparent")
        end
    end
    if E.Retail then
        hooksecurefunc(
            _G.QuestSessionManager,
            "NotifyDialogShow",
            function(_, dialog)
                self:CreateBackdropShadow(dialog)
            end
        )
    end
end

S:AddCallback("WorldMapFrame")
