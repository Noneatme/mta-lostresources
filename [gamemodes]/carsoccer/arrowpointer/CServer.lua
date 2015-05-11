--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MT-RPG' - Resoruce for MTA: San Andreas PROJECT X          ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]


local cFunc = {}
local cSetting = {}

fx.arrowpointer = {}

-- FUNCTIONS --


fx.arrowpointer.setWayPoint = function(thePlayer, x, y, z, element)
	triggerClientEvent(thePlayer, "onMTArrowPointerStart", thePlayer, x, y, z, element)
end

fx.arrowpointer.disable = function(thePlayer)
	triggerClientEvent(thePlayer, "onMTArrowPointerStop", thePlayer)
end