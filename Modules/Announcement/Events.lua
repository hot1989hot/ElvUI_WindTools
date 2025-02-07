local W, F, E, L = unpack(select(2, ...))
local A = W:GetModule("Announcement")

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo

A.EventList = {
    "CHALLENGE_MODE_COMPLETED",
    "CHAT_MSG_ADDON",
    "CHAT_MSG_PARTY",
    "CHAT_MSG_PARTY_LEADER",
    "CHAT_MSG_GUILD",
    "CHAT_MSG_SYSTEM",
    "COMBAT_LOG_EVENT_UNFILTERED",
    "GROUP_ROSTER_UPDATE",
    "LFG_COMPLETION_REWARD",
    "PLAYER_ENTERING_WORLD",
    "QUEST_LOG_UPDATE",
}

A.EventListWrath = {
    "CHAT_MSG_ADDON",
    "CHAT_MSG_PARTY",
    "CHAT_MSG_PARTY_LEADER",
    "CHAT_MSG_GUILD",
    "CHAT_MSG_SYSTEM",
    "COMBAT_LOG_EVENT_UNFILTERED",
    "GROUP_ROSTER_UPDATE",
    "LFG_COMPLETION_REWARD",
    "PLAYER_ENTERING_WORLD",
    "QUEST_LOG_UPDATE",
}
-- CHAT_MSG_SYSTEM: text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, unused, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons
function A:CHAT_MSG_SYSTEM(event, text)
    local data = {}

    self:ResetInstance(text) -- 重置副本
end

function A:CHAT_MSG_PARTY(event, ...)
    self:KeystoneLink(event, ...)
end

function A:CHAT_MSG_PARTY_LEADER(event, ...)
    self:KeystoneLink(event, ...)
end

function A:CHAT_MSG_GUILD(event, ...)
    self:KeystoneLink(event, ...)
end

function A:CHAT_MSG_SAY(event)
    alert("Test")
end

function A:COMBAT_LOG_EVENT_UNFILTERED()
    -- 参数列表
    -- https://wow.gamepedia.com/COMBAT_LOG_EVENT#Base_Parameters
    local timestamp, event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, _, _, extraSpellId =
        CombatLogGetCurrentEventInfo()

    if event == "SPELL_CAST_SUCCESS" then
        self:ThreatTransfer(sourceGUID, sourceName, destGUID, destName, spellId)
        self:CombatResurrection(sourceGUID, sourceName, destName, spellId)
        self:Utility(event, sourceName, spellId)
        self:Thanks(sourceGUID, sourceName, destGUID, destName, spellId)
    elseif event == "SPELL_SUMMON" then
        self:Utility(event, sourceName, spellId)
    elseif event == "SPELL_CREATE" then
        self:Utility(event, sourceName, spellId)
    elseif event == "SPELL_INTERRUPT" then
        print("打断成功")
        self:Interrupt(sourceGUID, sourceName, destName, spellId, extraSpellId)
    elseif event == "SPELL_AURA_APPLIED" then
        self:Taunt(timestamp, event, sourceGUID, sourceName, destGUID, destName, spellId)
    elseif event == "SPELL_MISSED" then
        self:Taunt(timestamp, event, sourceGUID, sourceName, destGUID, destName, spellId)
    elseif event == "SPELL_DISPEL" then
        self:Dispel(sourceGUID, sourceName, destName, spellId, extraSpellId)
    elseif event == "SPELL_STOLEN" then
        self:Dispel(sourceGUID, sourceName, destName, spellId, extraSpellId)
    end
end

function A:LFG_COMPLETION_REWARD()
    self:Goodbye()
end

function A:PLAYER_ENTERING_WORLD()
    self.playerEnteredWorld = true
    self:Quest()
    E:Delay(2, self.Keystone, self, "PLAYER_ENTERING_WORLD")
    E:Delay(4, self.ResetAuthority, self)
    E:Delay(10, self.ResetAuthority, self)
end

function A:CHALLENGE_MODE_COMPLETED()
    self:Goodbye()
    E:Delay(2, self.Keystone, self, "CHALLENGE_MODE_COMPLETED")
end

-- TODO: SCENARIO_COMPLETED 场景完成事件

function A:QUEST_LOG_UPDATE()
    if not self.playerEnteredWorld then
        return
    end
    self:Quest()
end

-- 权限认证部分
function A:CHAT_MSG_ADDON(_, prefix, text)
    if prefix == self.prefix then
        self:ReceiveLevel(text)
    end
end

function A:GROUP_ROSTER_UPDATE()
    self:ResetAuthority()
end
