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

local throws = {}
local throwTimer = {}

-- FUNCTIONS --

cFunc["render_balls"] = function()
	for index, ball in pairs(throws) do
		local hitX, hitY, hitZ = getElementPosition(index)
		for i = 1, 5, 1 do
			fxAddPunchImpact(hitX, hitY, hitZ, 0, 0, 0)
			fxAddSparks(hitX, hitY, hitZ, 0, 0, 0, 1, 15, 0, 0, 0, true, 3, 10)
		end
	end
end


-- EVENT HANDLERS --
addEventHandler("onClientRender", getRootElement(), cFunc["render_balls"])


cFunc["remove_throw"] = function(ball)
	throws[ball] = nil
	setElementData(ball, "throw", false, false)
end

function addBigThrow(ball)
	if(throws[ball] ~= nil) then
		killTimer(throwTimer[ball])
	end
	setElementData(ball, "throw", true, false)
	throws[ball] = true
	throwTimer[ball] = setTimer(cFunc["remove_throw"], 1000, 1, ball)
end