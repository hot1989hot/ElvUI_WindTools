local W, F, E, L = unpack(select(2, ...))
if not E.Retail then return end
local S = W.Modules.Skins

local _G = _G

function S:Blizzard_ChallengesUI()
    if not self:CheckDB("lfg", "challenges") then
        return
    end

    self:CreateShadow(_G.ChallengesKeystoneFrame)
end

S:AddCallbackForAddon("Blizzard_ChallengesUI")
