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

_GS = {}

fx = {}


-- FUNCTIONS --

setFPSLimit(60)
setMinuteDuration(10000000)
setTime(12, 00)


outputInfobox = function(player, msg, r, g, b, bo)
	return triggerClientEvent(player, "onMTInfoboxStart", player, msg, r, g, b, bo)
end

outputGametext = function(player, text)
	return triggerClientEvent(player, "onCarballPlayerGametext", player, text)
end
-- EVENT HANDLERS --