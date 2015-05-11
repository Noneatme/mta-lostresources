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

addEvent("onCBPlayerJoin", true)

-- FUNCTIONS --

cFunc["on_join"] = function()
	spawnPlayer(source, -1378.4273681641, -127.171875, 14.1484375, 0, 60)
end



-- EVENT HANDLERS --

addEventHandler("onCBPlayerJoin", getRootElement(), cFunc["on_join"])
