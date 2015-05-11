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


local devmode = true

-- FUNCTIONS --

_createObject = createObject

local objSpawn = {}

-- Overwrite the existing functions --
function createObject(id, x, y, z, rx, ry, rz, ...)
	if not(rx) then
		rx, ry, rz = 0, 0, 0
	end
	local veh = _createObject(id, x, y, z, rx, ry, rz, ...)
	if(veh) then
		objSpawn[veh] = {x, y, z, rx, ry, rz}
		return veh
	else
		return false
	end
end

function respawnObject(object)
	if(objSpawn[object]) then
		setElementRotation(object, objSpawn[object][4], objSpawn[object][5], objSpawn[object][6])
		return setElementPosition(object, objSpawn[object][1], objSpawn[object][2], objSpawn[object][3])
	else
		return false
	end
end


function isDevMode()
	return devmode
end

getPlayersInArea = function(area)
	local tbl = {}
	for index, p in pairs(getElementsByType("player")) do
		if(getElementDimension(p) == area) then
			table.insert(tbl, p)
		end
	end
	return tbl
end

-- EVENT HANDLERS --