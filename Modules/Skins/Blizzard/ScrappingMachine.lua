local W, F, E, L = unpack(select(2, ...))
if not E.Retail then return end
local S = W.Modules.Skins

local _G = _G
local pairs = pairs

function S:Blizzard_ScrappingMachineUI()
    if not self:CheckDB("scrapping", "scrappingMachine") then
        return
    end

    self:CreateShadow(_G.ScrappingMachineFrame)
end

S:AddCallbackForAddon("Blizzard_ScrappingMachineUI")