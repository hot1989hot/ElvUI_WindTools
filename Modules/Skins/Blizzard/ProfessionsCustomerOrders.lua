local W, F, E, L = unpack(select(2, ...))
if not E.Retail then return end
local S = W.Modules.Skins

local _G = _G

local next = next

function S:Blizzard_ProfessionsCustomerOrders()
    if not self:CheckDB("tradeskill", "professionsCustomerOrders") then
        return
    end

    self:CreateShadow(_G.ProfessionsCustomerOrdersFrame)

    for _, tab in next, _G.ProfessionsCustomerOrdersFrame.Tabs do
        self:ReskinTab(tab)
    end
end

S:AddCallbackForAddon("Blizzard_ProfessionsCustomerOrders")
