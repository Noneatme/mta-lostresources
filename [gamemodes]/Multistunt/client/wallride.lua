local state = false

addCommandHandler("wallride", function()
	state = not state
	local praefix = "enabled"
	if(state == false) then praefix = "disabled" end
	sendInfoMessage("Wallride has been "..praefix..". ", "green")
end)

local vehobject = {}
addEventHandler("onClientRender", getRootElement(), function()
	if(isPedInVehicle(gMe)) and (state == true) then
		local veh = getPedOccupiedVehicle(gMe)
		if not(vehobject[veh]) then 
			vehobject[veh] = createObject(1337, 0, 0, 0)
			setElementAlpha(vehobject[veh], 0)
			attachElements(vehobject[veh], veh, 0, 0, -getElementDistanceFromCentreOfMassToBaseOfModel(veh)-1)
			setElementCollisionsEnabled(vehobject[veh], false)
		end
		local x, y, z = getElementPosition(vehobject[veh])
		setVehicleGravityPoint(veh, x, y, z, 1)
	else
		if(isPedInVehicle(gMe) == true) then
			local veh = getPedOccupiedVehicle(gMe)
		end
	end
end)

addEventHandler("onClientElementDestroy", getRootElement(), function()
	if(getElementType(source) == "vehicle") then
		if(vehobject[veh]) then destroyElement(vehobject[veh]) end
	end
end)