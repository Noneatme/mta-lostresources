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

addEvent("onCarballSyncUpdateClient", true)

-- FUNCTIONS --


cFunc["sync_update"] = function(ball)
	local x, y, z = getElementPosition(ball)
	local x2, y2, z2 = getElementVelocity(ball)
	triggerServerEvent("onCarballSyncUpdateServer", localPlayer, ball, {x, y, z, x2, y2, z2})
end



-- EVENT HANDLERS --

addEventHandler("onCarballSyncUpdateClient", getLocalPlayer(), cFunc["sync_update"])