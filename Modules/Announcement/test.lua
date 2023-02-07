-- local W, F, E, L = unpack(select(2, ...))
-- local A = W:GetModule("Announcement")

-- -- Create a frame
-- local f = CreateFrame("Frame")

-- -- Register to monitor events
-- f:RegisterEvent("CHAT_MSG_YELL")
-- f:RegisterEvent("CHAT_MSG_SAY")

-- -- Handle the events as they happen
-- f:SetScript("OnEvent", function(self, event, ...)
-- 	if (event == "CHAT_MSG_YELL") then
-- 		print("Argh, stop with the yelling!")
-- 	elseif (event == "CHAT_MSG_SAY") then
--         print("Argh, stop with the yelling!")
--     	A:Interrupt(UnitGUID("player"), "Player", "destName", 58659, 58659)
-- 	end
-- end)