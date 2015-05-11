function triggerSpeedBoost()
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			if(math.ceil(getElementSpeed(veh)) < 5) or (math.ceil(getElementSpeed(veh)) > 500000) then return end
			setElementSpeed(veh, "kmh", getElementSpeed(veh)+20)
			--triggerServerEvent("onMultistuntSpeedboostStart", gMe)
		end
	end
end


bindKey("mouse2", "down", triggerSpeedBoost)
addCommandHandler("rebind", function() bindKey("mouse2", "down", triggerSpeedBoost) end)

local boost = {}

addEventHandler("onClientRender", getRootElement(), function()
	for i, car in pairs(boost) do
		local x, y, z = getElementPosition(car)
		fxAddTyreBurst(x, y, z, 0, 0, 5)
	end
end)
addEvent("onMultistuntSpeedboostBack", true)
addEventHandler("onMultistuntSpeedboostBack", getRootElement(), function()
	boost[source] = true
	setTimer(function() boost[source] = false end, 500, 1)
end)