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

local leaved = false


cFunc["col_leave"] = function(hitElement, dimension)
	if(leaved == false) then
		if(isBall(hitElement)) then
			if(getElementData(hitElement, "syncher") == localPlayer) then
				triggerServerEvent("onCarballBallInsAus", localPlayer, hitElement)
				leaved = true
				setTimer(function()
					leaved = false
				end, 100, 1)
			end
		end
	end
end

-- FUNCTIONS --

for dimension, cuboid in pairs(_GS["arena_cuboids"]) do
	addEventHandler("onClientColShapeLeave", cuboid, cFunc["col_leave"])
end



-- EVENT HANDLERS --