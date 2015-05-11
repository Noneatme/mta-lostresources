--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Carball' - Gamemode for MTA: San Andreas PROJECT X         ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2013-2014, Noneatme
]]


local cFunc = {}
local cSetting = {}


-- FUNCTIONS --
fx = {}

_GS = {}

getFormatTime = function()
	local time = getRealTime()
	local hour, min, sek = time.hour, time.minute, time.second
	if(hour < 10) then
		hour = "0"..hour
	end
	if(min < 10) then
		min = "0"..min
	end
	if(sek < 10) then
		sek = "0"..sek
	end
	return hour..":"..min..":"..sek
end



-- GAMETEXT

addEvent("onCarballPlayerGametext", true)

local r_s = {}
r_s["enabled"] = false
r_s["text"] = ""
r_s["timer"] = nil

function outputGametext(text)
	if(isTimer(r_s["timer"])) then
		killTimer(r_s["timer"])
		removeEventHandler("onClientRender", getRootElement(), r_s.render_gametext)
	end
	addEventHandler("onClientRender", getRootElement(), r_s.render_gametext)
	r_s["text"] = (text or "-")
	r_s["enabled"]= true
	r_s["timer"] = setTimer(function()
		r_s["enabled"] = false
		removeEventHandler("onClientRender", getRootElement(), r_s.render_gametext)
	end, 10000, 1)
end


r_s.render_gametext = function()
	if(r_s["enabled"] == true) then
		local sx, sy = guiGetScreenSize()
		local aesx, aesy = 1600, 900
		dxDrawText(r_s["text"], 431/aesx*sx, 203/aesy*sy, 1183/aesx*sx, 270/aesy*sy, tocolor(255, 255, 255, 255), 2/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, true, false)
	end
end

addEventHandler("onCarballPlayerGametext", getLocalPlayer(), outputGametext)


function msToTimeStr(ms, b)
	if not ms then
		return ''
	end
	local centiseconds = tostring(math.floor(math.fmod(ms, 1000)/10))
	if #centiseconds == 1 then
		centiseconds = '0' .. centiseconds
	end
	local s = math.floor(ms / 1000)
	local seconds = tostring(math.fmod(s, 60))
	if #seconds == 1 then
		seconds = '0' .. seconds
	end
	local minutes = tostring(math.floor(s / 60))
	if(b == true) then
		return minutes .. ':' .. seconds
	else
		return minutes .. ':' .. seconds .. ':' .. centiseconds
	end
end
-- EVENT HANDLERS --