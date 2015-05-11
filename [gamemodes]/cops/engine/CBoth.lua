--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Bankrob' - Gamemode for MTA: San Andreas PROJECT X         ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]


local cFunc = {}
local cSetting = {}


-- FUNCTIONS --

function isPolice(thePlayer)
	return (getElementData(thePlayer, "team") == "POLICE")
end

function isMafia(thePlayer)
	return (getElementData(thePlayer, "team") == "MAFIA")
end

-- EVENT HANDLERS --