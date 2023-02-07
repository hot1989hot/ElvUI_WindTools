local W, F, E, L = unpack(select(2, ...))
if not E.Retail then return end
local S = W.Modules.Skins

local _G = _G

function S:Blizzard_AnimaDiversionUI()
    if not self:CheckDB("animaDiversion") then
        return
    end

    self:CreateShadow(_G.AnimaDiversionFrame)
end

S:AddCallbackForAddon("Blizzard_AnimaDiversionUI")
