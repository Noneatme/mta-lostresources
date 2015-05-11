addEvent("onMultistuntNeonSet", true)
addEvent("onMultistuntNeonRemove", true)



local vehneon = {}
addEventHandler("onMultistuntNeonSet", getRootElement(), function(typ, distance)
	local id
	if not(distance) then return end
	if(typ == 1) then id = 2053 end
	if(typ == 2) then id = 2052 end
	if(typ == 3) then id = 2054 end
	if(typ == 4) then id = 2371 end
	if(typ == 5) then id = 2373	end
	if not(id) then return end
	local veh = getPedOccupiedVehicle(source)
	if not(veh) then return end
	if(isElement(vehneon[veh])) then destroyElement(vehneon[veh]) end
	vehneon[veh] = createObject(id, 0, 0, 0)
	setElementCollisionsEnabled(vehneon[veh], false)
	attachElements(vehneon[veh], veh, 0, 0, 0-distance+0.2)
	sendInfoMessage("Neon succesfull created!", source, "green")
end)

addEventHandler("onElementDestroy", getRootElement(), function()
	if(getElementType(source) == "vehicle") then
		if(isElement(vehneon[source])) then destroyElement(vehneon[source]) end
	end
end)

addEventHandler("onMultistuntNeonRemove", getRootElement(), function()
	if not(isPedInVehicle(source)) then return end
	local veh = getPedOccupiedVehicle(source)
	if not(isElement(vehneon[veh])) then
		sendInfoMessage("This vehicle don't have neon!", source, "red")
	return end
	sendInfoMessage("Neon sucessfull deleted!", source, "green")
	destroyElement(vehneon[veh])
end)