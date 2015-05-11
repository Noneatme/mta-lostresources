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
cSetting["debug"] = false
cSetting["starttick"] = nil
cSetting["frames"] = 0
cSetting["ticks"] = 0

local sx, sy = guiGetScreenSize()
local aesx, aesy = 1600, 900

-- FUNCTIONS --


cFunc["toggle_debug"] = function()
	cSetting["debug"] = not cSetting["debug"]

	setDevelopmentMode(cSetting["debug"])
end

cFunc["render_debug"] = function()
	if(cSetting["debug"] or isDebugViewActive ()) then
		if not(cSetting["starttick"]) then
			cSetting["starttick"] = getTickCount()
		end
		if(getTickCount()-cSetting["starttick"] > 1000) then
			cSetting["frames"] = cSetting["ticks"]
			cSetting["ticks"] = 0
			cSetting["starttick"] = nil
		else
			cSetting["ticks"] = cSetting["ticks"]+1
		end
	
		dxDrawText("FPS: #00FFFF"..cSetting["frames"].."#FFFFFF, Tickcount: #00FFFF"..getTickCount(), 5/aesx*sx, sy-(15/aesy*sy), 70/aesx*sx, 50/aesy*sy, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, false, true)
		dxDrawText("Collected Garbage: #00FFFF"..collectgarbage("count"), 5/aesx*sx, sy-(30/aesy*sy), 100/aesx*sx, 50/aesy*sy, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, false, true)
		
		dxDrawText("Peds: #00FFFF"..#getElementsByType("ped", getRootElement(), true).."#FFFFFF, Players: #00FFFF"..#getElementsByType("player", getRootElement(), true).."#FFFFFF, Vehicles: #00FFFF"..#getElementsByType("vehicle", getRootElement(), true).."#FFFFFF, Objects: #00FFFF"..#getElementsByType("object", getRootElement(), true), 5/aesx*sx, sy-(45/aesy*sy), 100/aesx*sx, 50/aesy*sy, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, false, true)
		dxDrawText("Blips: #00FFFF"..#getElementsByType("blip", getRootElement(), true).."#FFFFFF, Colshapes: #00FFFF"..#getElementsByType("colshape", getRootElement(), true), 5/aesx*sx, sy-(60/aesy*sy), 100/aesx*sx, 50/aesy*sy, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, false, true)
		local x, y, z = getElementPosition(localPlayer)
		dxDrawText("X: #00FFFF"..math.round(x, 2, "round").."#FFFFFF, Y: #00FFFF"..math.round(y, 2, "round").."#FFFFFF, Z: #00FFFF"..math.round(z, 2, "round").."#FFFFFF, Interior: #00FFFF"..getElementInterior(localPlayer).."#FFFFFF, Dimension: #00FFFF"..getElementDimension(localPlayer), 5/aesx*sx, sy-(75/aesy*sy), 100/aesx*sx, 50/aesy*sy, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, false, true)
		
		local hour, min = getTime()
		dxDrawText("Skin ID: #00FFFF"..getElementModel(localPlayer).."#FFFFFF, Ingame-Time: #00FFFF"..hour..":"..min.."#FFFFFF, Location: #00FFFF"..getZoneName(x, y, z, false).."#FFFFFF, #00FFFF"..getZoneName(x, y, z, true), 2050/aesx*sx, sy-(15/aesy*sy), 70/aesx*sx, 50/aesy*sy, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "top", false, false, false, true)
		
		local hit, x, y, z, elementHit, normalX, normalY, normalZ, material, lighting, piece, worldModelID, wx, wy, wz, wLOD = processLineOfSight ( x, y, z, x, y, z-30, true, true, false)
		dxDrawText("Lighting Level: #00FFFF"..(lighting or "-").."#FFFFFF, Material: #00FFFF"..(material or "-").."#FFFFFF, World Model ID: #00FFFF"..(worldModelID or "-").."#FFFFFF, World Model LOD: #00FFFF"..(wLOD or "-"), 2050/aesx*sx, sy-(30/aesy*sy), 70/aesx*sx, 50/aesy*sy, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "top", false, false, false, true)
		
	end
end

-- EVENT HANDLERS --

--addCommandHandler("debug", cFunc["toggle_debug"])
addEventHandler("onClientRender", getRootElement(), cFunc["render_debug"])