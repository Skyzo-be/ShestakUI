﻿local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Pixel perfect script of custom ui Scale
----------------------------------------------------------------------------------------
if T.screenWidth <= 1440 then
	T.low_resolution = true
else
	T.low_resolution = false
end

if C.general.auto_scale == true then
	C.general.uiscale = min(2, max(0.20, 768 / T.screenHeight))
	if T.screenHeight >= 2400 then
		C.general.uiscale = C.general.uiscale * 3
	elseif T.screenHeight >= 1600 then
		C.general.uiscale = C.general.uiscale * 2
	end
	C.general.uiscale = tonumber(string.sub(C.general.uiscale, 0, 5)) -- 8.1 Fix scale bug
end

T.mult = 768 / T.screenHeight / C.general.uiscale
T.noscalemult = T.mult * C.general.uiscale

-- Old Scale function
-- T.Scale = function(x)
	-- return T.mult * math.floor(x / T.mult + 0.5)
-- end

-- New Scale function
T.Scale = function(x)
	local m = T.mult
	if m == 1 or x == 0 then
		return x
	else
		local y = m > 1 and m or -m
		return x - x % (x < 0 and y or -y)
	end
end

----------------------------------------------------------------------------------------
--	Pixel perfect fonts for high resolution
----------------------------------------------------------------------------------------
if T.screenHeight <= 1200 then return end
C.media.pixel_font_size = C.media.pixel_font_size * T.mult
C.font.chat_tabs_font_size = C.font.chat_tabs_font_size * T.mult
C.font.action_bars_font_size = C.font.action_bars_font_size * T.mult
C.font.threat_meter_font_size = C.font.threat_meter_font_size * T.mult
C.font.raid_cooldowns_font_size = C.font.raid_cooldowns_font_size * T.mult
C.font.unit_frames_font_size = C.font.unit_frames_font_size * T.mult
C.font.auras_font_size = C.font.auras_font_size * T.mult
C.font.filger_font_size = C.font.filger_font_size * T.mult
C.font.bags_font_size = C.font.bags_font_size * T.mult
C.font.loot_font_size = C.font.loot_font_size * T.mult
C.font.combat_text_font_size = C.font.combat_text_font_size * T.mult
C.font.stats_font_size = C.font.stats_font_size * T.mult
C.font.stylization_font_size = C.font.stylization_font_size * T.mult
C.font.cooldown_timers_font_size = C.font.cooldown_timers_font_size * T.mult