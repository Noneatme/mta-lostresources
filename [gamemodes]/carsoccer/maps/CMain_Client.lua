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

addEvent("onCarballBallRespawn", true)

-- FUNCTIONS --

for i = 1, 16000, 1 do engineSetModelLODDistance(i, 10000) end


cSetting["arena_cuboids"] = {
	[1] = createColCuboid(3715.857421875, -2254.599609375, 1.084349822998, 197.5166015625, 313.0791015625, 100),
	[2] = createColCuboid(3715.857421875, -2254.599609375, 1.084349822998, 197.5166015625, 313.0791015625, 100),
	[3] = createColCuboid(1683.513671875, -3550.396484375, 1, 383.4794921875, 374.712890625, 100),
	[4] = createColCuboid(1683.513671875, -3550.396484375, 1, 383.4794921875, 374.712890625, 100),
	[5] = createColCuboid(5018.73828125, -1770.1298828125, 0.57954001426697, 340.0888671875, 80.90625, 100),
	[6] = createColCuboid(5018.73828125, -1770.1298828125, 0.57954001426697, 340.0888671875, 80.90625, 100),
}

_GS["arena_cuboids"] = cSetting["arena_cuboids"]

for index, col in pairs(cSetting["arena_cuboids"]) do
	setElementDimension(col, index)
end

cFunc["respawn_ball"] = function(ball)
	respawnObject(ball)
end
-- EVENT HANDLERS --

addEventHandler("onCarballBallRespawn", getLocalPlayer(), cFunc["respawn_ball"])
