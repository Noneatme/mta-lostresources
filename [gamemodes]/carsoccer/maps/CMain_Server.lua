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

addEvent("onCarballPlayerJoin", true)
addEvent("onCarballPlayerLeave", true)
addEvent("onCarballBallInsAus", true)

local cFunc = {}
local cSetting = {}

cSetting["ball_spawns"] = {
	[1] = {3810.4748535156, -2085.0490722656, 2.8843860626221},
	[3] = {1876.380859375, -3361.4797363281, 26.433347702026},
	[5] = {5206.04296875, -1730.0821533203, 2.7954013347626},
}

cSetting["training_ball_spawns"] = {
	[2] = {
		{3751.8579101563, -2012.8604736328, 2.884349822998},
		{3824.9270019531, -2058.2028808594, 2.884349822998},
		{3817.6376953125, -2077.353515625, 2.8843898773193},
		{3790.8806152344, -2111.0544433594, 2.8843898773193},
		{3804.8083496094, -2127.6264648438, 2.8843898773193},
	},
	[4] = {
		{1876.380859375, -3361.4797363281, 26.433347702026},
		{1857.1375732422, -3414.7214355469, 26.445293426514},
		{1759.1866455078, -3458.3413085938, 26.420238494873},
		{1893.4578857422, -3295.3176269531, 26.412256240845},
		{1965.1912841797, -3231.4899902344, 26.452169418335},
		{1983.0437011719, -3302.0124511719, 26.431715011597},
	},
	[6] = {
		{5206.04296875, -1730.0821533203, 2.7954013347626},
		{5161.037109375, -1745.2205810547, 2.7954001426697},
		{5119.1967773438, -1715.3834228516, 2.7954001426697},
		{5059.9946289063, -1743.9526367188, 2.7954001426697},
		{5282.4814453125, -1714.1374511719, 2.7954001426697},
		{5310.5522460938, -1736.4473876953, 2.7954001426697},
	},
}

cSetting["player_spawns"] = {
	[1] = {
		{3856.7131347656, -2150.8022460938, 3.2029230594635},
		{3776.9372558594, -2071.203125, 3.1899795532227},
		{3769.7758789063, -2157.2788085938, 3.2000300884247},
		{3859.0600585938, -2207.5112304688, 3.1856904029846},
		{3905.4970703125, -2114.40625, 3.1489202976227},
		{3828.5827636719, -2056.3852539063, 3.1429982185364},
	},
	[3] = {
		{1876.380859375, -3361.4797363281, 26.433347702026},
		{1857.1375732422, -3414.7214355469, 26.445293426514},
		{1759.1866455078, -3458.3413085938, 26.420238494873},
		{1893.4578857422, -3295.3176269531, 26.412256240845},
		{1965.1912841797, -3231.4899902344, 26.452169418335},
		{1983.0437011719, -3302.0124511719, 26.431715011597},
	},
	[5] = {
		{5321.533203125, -1752.3553466797, 2.7954001426697},
		{5228.6958007813, -1714.9202880859, 2.7954001426697},
		{5137.2255859375, -1749.1663818359, 2.7954001426697},
		{5083.783203125, -1707.9898681641, 2.7954001426697},
		{5050.9438476563, -1740.8708496094, 2.7954001426697},
	},

}
cSetting["player_spawns"][2] = cSetting["player_spawns"][1]
cSetting["player_spawns"][4] = cSetting["player_spawns"][3]
cSetting["player_spawns"][6] = cSetting["player_spawns"][5]
cSetting["visitor_spawns"] = {
	[1] = {
		{3930.7004394531, -2058.42578125, 6.7892551422119},
		{3929.6120605469, -2150.8134765625, 6.359375},
		{3929.6120605469, -2150.8134765625, 6.359375},
		{3929.6120605469, -2150.8134765625, 6.359375},
		{3693.5261230469, -2227.3081054688, 6.359375},
	},
	[3] = {
		{1976.3942871094, -3391.8103027344, 28.4921875},
		{2071.4675292969, -3321.3364257813, 28.937484741211},
		{1942.0793457031, -3173.7021484375, 28.4921875},
		{1770.8227539063, -3332.7685546875, 28.937484741211},
		{1686.8990478516, -3341.3642578125, 27.625},
		{1801.2679443359, -3551.4946289063, 28.4921875},
	},
	[5] = {
		{5304.9526367188, -1802.2082519531, 14.198187828064},
		{5098.994140625, -1799.1435546875, 13.338479042053},
		{5074.7661132813, -1659.8059082031, 13.893271446228},
		{5278.212890625, -1658.6470947266, 14.323187828064},
		{5384.8295898438, -1724.9443359375, 12.828499794006},
	},
}
cSetting["visitor_spawns"][2] = cSetting["visitor_spawns"][1]
cSetting["visitor_spawns"][4] = cSetting["visitor_spawns"][3]
cSetting["visitor_spawns"][6] = cSetting["visitor_spawns"][5]



cSetting["player_vehicles"] = {}

cSetting["area_players"] = {}

cSetting["ball"] = {}
cSetting["training_balls"] = {}

cSetting["jump_timer"] = {}

cSetting["respawn_timer"] = {}
-- FUNCTIONS --

cFunc["reset_ball"] = function(area)
	if(isElement(cSetting["ball"][area])) then
		destroyElement(cSetting["ball"][area])
	end
	if(cSetting["ball_spawns"][area]) then
		cSetting["ball"][area] = createObject(2912, cSetting["ball_spawns"][area][1], cSetting["ball_spawns"][area][2], cSetting["ball_spawns"][area][3])
		setElementData(cSetting["ball"][area], "ball", true)
		setElementDimension(cSetting["ball"][area], area)
		setElementVelocity(cSetting["ball"][area], 0, 0, 0.2)
	end
end


cFunc["join_player"] = function(area, visitor)
	triggerClientEvent(source, "onClientCarballStadiumEnter", source)
	toggleControl(source, "enter_exit", false)
	fadeCamera(source, true)
	setCameraTarget(source, source)
	if(visitor ~= true) then
		local rnd = math.random(1, #cSetting["player_spawns"][area])
		
		if(isElement(cSetting["player_vehicles"][source])) then
			destroyElement(cSetting["player_vehicles"][source])
		end
		cSetting["player_vehicles"][source] = createVehicle(557, cSetting["player_spawns"][area][rnd][1], cSetting["player_spawns"][area][rnd][2], cSetting["player_spawns"][area][rnd][3])
		setElementFrozen(cSetting["player_vehicles"][source], true)
		setTimer(setElementFrozen, 2000, 1, cSetting["player_vehicles"][source], false)
		warpPedIntoVehicle(source, cSetting["player_vehicles"][source])
		setElementDimension(source, area)
		setElementDimension(cSetting["player_vehicles"][source], area)
		if not(cSetting["area_players"][area]) then
			cSetting["area_players"][area] = 0
			cFunc["reset_ball"](area)
		end
		cSetting["area_players"][area] = cSetting["area_players"][area]+1
		if not(isTrainingArea(area)) then
			fx.arrowpointer.setWayPoint(source, 0, 0, 0, getBallFromArea(area))
		end
	else
		local rnd = math.random(1, #cSetting["visitor_spawns"][area])
		setElementPosition(source, cSetting["visitor_spawns"][area][rnd][1], cSetting["visitor_spawns"][area][rnd][2], cSetting["visitor_spawns"][area][rnd][3])
		 
	end
	setElementData(source, "area", area)
end

cFunc["check_vehicle"] = function()
	if(isElement(cSetting["player_vehicles"][source])) then
		local area = getElementDimension(source)
		cSetting["area_players"][area] = cSetting["area_players"][area]-1
		destroyElement(cSetting["player_vehicles"][source])
	end
end

cFunc["create_training_balls"] = function()
	for area, positions in pairs(cSetting["training_ball_spawns"]) do
		cSetting["training_balls"][area] = {}
		for index, tbl in pairs(cSetting["training_ball_spawns"][area]) do
			local x, y, z = tbl[1], tbl[2], tbl[3]
			cSetting["training_balls"][area][index] = createObject(2912, x, y, z)
			setElementData(cSetting["training_balls"][area][index], "ball", true)
			setElementDimension(cSetting["training_balls"][area][index], area)
		end
	end
end

cFunc["respawn_ball"] = function(ball)
	local area = getElementDimension(ball)
	if(not (isTrainingArea(area))) then
		setElementPosition(ball, cSetting["ball_spawns"][area][1], cSetting["ball_spawns"][area][2], cSetting["ball_spawns"][area][3])
	else
		respawnObject(ball)
	end
end

cFunc["ball_aus"] = function(ball)
	if not(isTimer(cSetting["respawn_timer"][ball])) then
		local arena = getElementDimension(ball)
		local players = getPlayersInArea(arena)
		for index, player in pairs(players) do
			outputInfobox(player, "The ball is out of the arena, respawning in 5 seconds!", 0, 255, 0, true)
		end
		cSetting["respawn_timer"][ball] = setTimer(cFunc["respawn_ball"], 5000, 1, ball)
	end
end

cFunc["create_training_balls"]()

isTrainingArea = function(area)
	if(cSetting["ball_spawns"][area]) then
		return false
	else
		return true
	end
end

getBallFromArea = function(area)
	return (cSetting["ball"][area] or false)
end

-- EVENT HANDLERS --

addEventHandler("onPlayerQuit", getRootElement(), cFunc["check_vehicle"])
addEventHandler("onCarballPlayerJoin", getRootElement(), cFunc["join_player"])
addEventHandler("onCarballPlayerLeave", getRootElement(), cFunc["check_vehicle"])

local x1, y1, x2, y2
local last
cFunc["gangzone_create"] = function(thePlayer)
	local x, y, z = getElementPosition(thePlayer)
	if not(x1) and not(y1) then
		x1 = x
		y1 = y
		outputChatBox("Pos 1 Saved", thePlayer, 0, 255, 0)
		
		return
	end
	if not(x2) and not(y2) then
		x2 = x
		y2 = y
		outputChatBox("Pos 2 Saved", thePlayer, 0, 255, 0)
		return
	end
	local _, _, z1 = getElementPosition(thePlayer)
	local xs = math.abs(x1-x2)
	local ys = math.abs(y1-y2)
	destroyElement(last)
	last = createColCuboid(x1, y1, z1, xs, ys, 100)
	local text = "createColCuboid("..x1..", "..y1..", "..(z1-1)..", "..xs..", "..ys..", 100)"
	outputChatBox(text, thePlayer, 0, 255, 0)
	outputConsole(text)
	x1 = nil
	x2 = nil
	y1 = nil
	y2 = nil
	
end
addCommandHandler("addgangzone", cFunc["gangzone_create"])

addEventHandler("onCarballBallInsAus", getRootElement(), cFunc["ball_aus"])