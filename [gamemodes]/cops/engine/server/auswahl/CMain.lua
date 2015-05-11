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

addEvent("onCPSelectionDone", true)
addEvent("onCPPlayerJoin", true)

cSetting["faction_spawns"] = {
	["POLICE"] = {1568.2449951172, -1694.2542724609, 5.890625},
	["MAFIA"] = {1114.8763427734, -1251.8577880859, 15.8203125},
}

cSetting["faction_weapons"] = {
	["MAFIA"] = {
		{4, 1},
		{24, 100},
		{27, 10},
		{29, 500},
		{30, 500},
		{34, 100},
	},
	["POLICE"] = {
		{23, 50},
		{25, 100},
		{29, 500},
		{31, 500},
		{17, 1},
		{3, 1},
	},
}


cFunc["give_weapons"] = function(thePlayer, faction)
	for index, wpn in pairs(cSetting["faction_weapons"][faction]) do
		giveWeapon(thePlayer, wpn[1], wpn[2], true)
	end
end
-- FUNCTIONS --

cFunc["selection_done"] = function(fraktion, modell)
	spawnPlayer(source, cSetting["faction_spawns"][fraktion][1], cSetting["faction_spawns"][fraktion][2], cSetting["faction_spawns"][fraktion][3], 0, modell)
	setCameraTarget(source, source)
	toggleAllControls(source, true)
	cFunc["give_weapons"](source, fraktion)
	showPlayerHudComponent(source, "radar", true)
	showPlayerHudComponent(source, "crosshair", true)
	setElementData(source, "team", fraktion)
	if(fraktion == "MAFIA") then
		setPlayerTeam(source, teamMafia)
	else
		setPlayerTeam(source, teamPolice)
	end
end

cFunc["join_func"] = function()
	spawnPlayer(source, 0, 0, 2)
end

-- EVENT HANDLERS --

addEventHandler("onCPSelectionDone", getRootElement(), cFunc["selection_done"])
addEventHandler("onCPPlayerJoin", getRootElement(), cFunc["join_func"])
