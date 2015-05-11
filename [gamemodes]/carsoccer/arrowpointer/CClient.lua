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

cSetting["current_point"] = {0, 0, 0}
cSetting["enabled"] = false
cSetting["element"] = nil

addEvent("onMTArrowPointerStart", true)
addEvent("onMTArrowPointerStop", true)

-- FUNCTIONS --

fx.arrowpointer = {}


cFunc["draw_arrow"] = function()
	local x1, y1, z1 = getElementPosition(localPlayer)
	if(isPedInVehicle(localPlayer)) then
		x1, y1, z1 = getElementPosition(getPedOccupiedVehicle(localPlayer))
	end
	local x2, y2, z2 = cSetting["current_point"][1], cSetting["current_point"][2], cSetting["current_point"][3]
	if(isElement(cSetting["element"])) then
		x2, y2, z2 = getElementPosition(cSetting["element"])
	end
	local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
	local rot2 = getPedRotation(localPlayer)
	local z = 1.5
	if(isPedInVehicle(localPlayer)) then
		z = 1.5
		z = z+getElementDistanceFromCentreOfMassToBaseOfModel(getPedOccupiedVehicle(localPlayer))
	end
	setElementAttachedOffsets(cSetting["arrow"], 0, 0, z, 0, 270, rot-rot2)
	if(isPedInVehicle(localPlayer)) then
		setElementDimension(cSetting["arrow"], getElementDimension(getPedOccupiedVehicle(localPlayer)))
	end
	setElementAlpha(cSetting["arrow"], 125)
end

fx.arrowpointer.setWayPoint = function(x, y, z, element)
	if(cSetting["enabled"] == true) then
		removeEventHandler("onClientRender", getRootElement(), cFunc["draw_arrow"])
		destroyElement(cSetting["arrow"])
	end
	
	cSetting["enabled"] = true
	if(x ~= "last") then
		cSetting["current_point"] = {x, y, z}
		cSetting["element"] = element
	end
	local x, y, z = getElementPosition(element)
	cSetting["arrow"] = createObject(1318, x, y, z)
	setElementDimension(cSetting["arrow"], getElementDimension(localPlayer))
	local s = attachElements(cSetting["arrow"], getPedOccupiedVehicle(localPlayer), 0, 0, 1.5, 0, 270, 90)
	addEventHandler("onClientRender", getRootElement(), cFunc["draw_arrow"])
end
	
fx.arrowpointer.disable = function()
	if(cSetting["enabled"] == true) then
		cSetting["enabled"] = false
		removeEventHandler("onClientRender", getRootElement(), cFunc["draw_arrow"])
		destroyElement(cSetting["arrow"])
	end
end


addEventHandler("onClientPlayerWasted", localPlayer, fx.arrowpointer.disable)
addEventHandler("onMTArrowPointerStart", localPlayer, fx.arrowpointer.setWayPoint)
addEventHandler("onMTArrowPointerStop", localPlayer, fx.arrowpointer.disable)