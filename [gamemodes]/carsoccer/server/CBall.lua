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

local G_ball = {}
local last_id = 1

addEvent("onClientCarballsGet", true)
addEvent("onCarballBallUpdate", true)

setModelHandling(557, "maxVelocity", 230)
setModelHandling(557, "engineAcceleration", 18)
setModelHandling(getVehicleModelFromName("Sandking"), "tractionMultiplier", 1)

-- FUNCTIONS --


cFunc["hit_ball"] = function(hitElement)
	
	local x, y, z = getElementVelocity(hitElement)
	setElementVelocity(G_ball[getElementData(source, "last_id")], x, y, z)
end

cFunc["create_ball"] = function()

	G_ball[last_id] = createObject(2912, -1378.4273681641, -122.171875, 14.1484375)
	setElementData(G_ball[last_id], "ball", true)

--[[
	local col = createColSphere(-1378.4273681641, -122.171875, 14.1484375, 3)
	attachElements(col, G_ball[last_id])
	setElementData(col, "last_id", last_id)
	
	addEventHandler("onColShapeHit", col, cFunc["hit_ball"])]]
	
	
	 last_id = last_id+1
end


cFunc["carballs_get"] = function()
	triggerClientEvent(source, "onClientCarballsGetB", source, G_ball)
end

cFunc["carball_update"] = function(ball, x, y, z, x2, y2, z2)
	--setElementPosition(ball, x, y, z)
	triggerClientEvent("onCarballPosUpdate", getRootElement(), source, ball, x, y, z, x2, y2, z2)
	fx.ballsync.setNewBallSyncher(ball, source)
end
-- EVENT HANDLERS --

cFunc["create_ball"]()
addEventHandler("onClientCarballsGet", getRootElement(), cFunc["carballs_get"])
addEventHandler("onCarballBallUpdate", getRootElement(), cFunc["carball_update"])